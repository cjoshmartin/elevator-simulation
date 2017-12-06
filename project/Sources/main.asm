            INCLUDE 'derivative.inc'
            
            XDEF _Startup, MAIN, stateofelevator
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY, CRGINT, RTICTL, stateofelevator, NEXT_FLOOR
            XDEF NEXT_FLOOR, Count
            xdef direction
            XDEF TIME_INT, Count_1, Count_2, flag
            XDEF is_open_or_closed, was_open_or_closed
            XDEF DC_flag,DC_delay
            xdef stepper_flag, stepper_delay
           	XDEF currentfloor,floor,state_of_load, max_value_of_pot
           	XDEF LED_flag,LED_delay
           	XREF stepper_motor, ELEVATOR_FLOOR	
            XREF WELCOME, DATE_TIME, ADMIN, SECRET, MAIN_MENU, INITIALIZE_PORTS, pot_meter,
            XREF LED
            XREF dip_switches
            XREF keypadoutput, pressed, TIME_VAL, DATE_VAL,port_s
       
            XREF __SEG_END_SSTACK     ; symbol defined by the linker for the end of the stack


My_Constant: 		section
going_up_sequence       dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence 			dc.b 	$FF, $00
lenghtofdelay	equ		50000
MONTH_DAYS: dc.b 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
	

My_Variable: 	section 
WAIT: 	ds.b 		2
CARRY: 	ds.b 		1
disp:	ds.b 		33
NEXT_FLOOR: ds.b 	1
direction:  ds.b	1 ; 1 for up, 2 for down, 0 for none
;LEDS
currentfloor:           ds.b    1
stateofelevator         ds.b    1
floor:					ds.b    1
state_of_load:			ds.b	1
LED_flag:				ds.b 	1
LED_delay:				ds.b	1
;stepper Motor
stepper_flag:			ds.b    1
stepper_delay:			ds.w    1
;DC MOTOR
DC_flag:				ds.b 	1
DC_delay:				ds.b	1
;DOOR
is_open_or_closed:		ds.b	1 ; if 0 then closed, if 1 then openned...
was_open_or_closed:     ds.b    1 ; stores the old value of is_open_or_closed
;POT_Moter
max_value_of_pot:		ds.b	1
; Interrupts
Count_1: 				ds.b    2
Count_2:				ds.b    1
Count: 					ds.b    2
flag:					ds.b 	1


; code section
MyCode:     SECTION
_Startup:
    lds #__SEG_END_SSTACK
    JSR INITIALIZE_PORTS
    JSR WELCOME
    JSR DATE_TIME
    JSR ADMIN
    JSR SECRET
    movb #99, flag
    CLI
   
MAIN:
   JSR MAIN_MENU
   JSR keypadoutput
   ldaa pressed
   cmpa #9
   BGT MAIN
   JSR ELEVATOR_FLOOR
   BRA MAIN
   


;--------------------------------------------------------------------------------
;INTERRUPTS

  
TIME_INT:

; ---------------Instructions on flag----------------
; 0 - step up
; 1 - pot_meter
; 2 - LED
; 3 - stepper_motor 
; 4 - ERROR MESSAGE
; 5 - General Delay
; 99 - DO Nothing
;---------------------------------------------------- 
 ldaa flag
	 cmpa #0
	 	beq just_delay
	 cmpa #1
	 beq pot_meter_delay
	 cmpa #2
	 beq LED_delay_RTI
	 cmpa #3 
	 	beq stepper_delayer
	
	 bra TIME_DONE
	 
just_delay:	;0    
	  	     ldx WAIT
	 	  	 dex
	  	  	 stx WAIT
	        cpx #0
	 	  	BNE TIME_DONE
	      movb #1, CARRY
	      movb #0, WAIT
	  	  bra  TIME_DONE

pot_meter_delay: ; 1
	   ldaa DC_flag
		    cmpa #0
		   	beq TIME_DONE
		    ldx DC_delay
		   	 dex
		  	 stx DC_delay
		    cpx #0
		   	BNE TIME_DONE
		   movb #0,DC_flag
		   movb #10,DC_delay 
		    
		  bra TIME_DONE
		  
LED_delay_RTI: ; 2
	   ldaa LED_flag
		   cmpa #0
		   	beq TIME_DONE
		    ldab LED_delay
		   	 decb
		  	 stab LED_delay
		    cmpb #0
		   	BNE TIME_DONE
		   movb #0,LED_flag
		   movb #$FF,LED_delay
		     
  	    bra TIME_DONE
  	    	  
stepper_delayer: ; 3
	   ldaa stepper_flag
	   cmpa #0
	   beq TIME_DONE
	   
 	   ldx stepper_delay
	   dex
	   stx stepper_delay
 	   cpx #0
	   BNE TIME_DONE
	   movb #0, stepper_flag
	   movw #40, stepper_delay
	   
	   bra TIME_DONE	   
  	  
  TIME_DONE:
    JSR CLOCK_INT
    bset CRGFLG, #$80
    RTI
    


CLOCK_INT:
  LDX Count_1
  inx
  stx Count_1
  CPX #8000
  BNE CLOCK_DONE
  movb #0, Count_1
  
  LDAA Count_2
  inca
  staa Count_2
  cmpa #60
  BNE CLOCK_DONE
  movb #0, Count_2
  
  CLOCK_MINUTES_ONES:
  LDAA TIME_VAL+4
  inca
  staa TIME_VAL+4
  cmpa #10
  BNE CLOCK_DONE
  movb #0, TIME_VAL+4
  BRA CLOCK_MINUTES_TENS
  
  CLOCK_MINUTES_TENS:
  ldaa TIME_VAL+3
  inca
  staa TIME_VAL+3
  cmpa #6
  BNE CLOCK_DONE
  movb #0, TIME_VAL+3
  bra CLOCK_HOURS_ONES
  
  CLOCK_HOURS_ONES:
  ldaa TIME_VAL+2
  inca
  staa TIME_VAL+2
  cmpa #3
  BNE CLOCK_HOURS_ONES_CHECK
  
  CLOCK_HOURS_ONES_CONT:
  cmpa #10
  BNE CLOCK_DONE 
  movb #0, TIME_VAL+2
  bra CLOCK_MINUTE_TENS
  
  CLOCK_HOURS_ONES_CHECK:
  psha
  LDAA TIME_VAL+1
  cmpa #1
  BNE CLOCK_HOURS_ONES_CONT
  movb #1, TIME_VAL+2
  movb #0, TIME_VAL+1
  bra CLOCK_DONE
  CLOCK_MINUTE_TENS:
  
  ldaa TIME_VAL+1
  inca
  staa TIME_VAL+1
  cmpa #6
  
  CLOCK_DONE:
  RTS