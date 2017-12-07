            INCLUDE 'derivative.inc'
            
            XDEF _Startup, MAIN, stateofelevator, did_play
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY, CRGINT, RTICTL, stateofelevator, NEXT_FLOOR
            XDEF NEXT_FLOOR, Count
            xdef direction
            XDEF sound_flag
            XDEF sound_delay
            XDEF TIME_INT, Count_1, Count_2, flag
            XDEF is_open_or_closed, was_open_or_closed
            XDEF DC_flag,DC_delay
            xdef stepper_flag, stepper_delay
           	XDEF currentfloor,floor,state_of_load, max_value_of_pot
			XDEF to_play,done_playing
			
           	XDEF LED_flag,LED_delay, should_led
			XDEF number_in_sound_seq,repeats
			XREF speaker

           	XREF stepper_motor, ELEVATOR_FLOOR	
            XREF WELCOME, DATE_TIME, ADMIN, SECRET_1, MAIN_MENU, INITIALIZE_PORTS, pot_meter,
            XREF LED
            XREF dip_switches
            XREF keypadoutput, pressed, TIME_VAL, DATE_VAL,port_s
			XREF SendsChr,PlayTone
       		
            XREF __SEG_END_SSTACK     ; symbol defined by the linker for the end of the stack


My_Constant: 		section
going_up_sequence       dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence 			dc.b 	$FF, $00
lenghtofdelay	equ		50000
MONTH_DAYS: dc.b 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
	

My_Variable: 	section 
WAIT: 	ds.w 		2
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
should_led:				ds.b	1
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
; Sound
sound_flag:		    	ds.b    1
sound_delay:			ds.w	1
number_in_sound_seq:	ds.b	1
repeats:			    ds.b 	1
did_play:				ds.b 	1  ; has a sound already playe
to_play:				ds.b	1
done_playing:			ds.b	1
; code section
MyCode:     SECTION
_Startup:
    lds #__SEG_END_SSTACK
    JSR INITIALIZE_PORTS

    ;JSR WELCOME
    ;JSR DATE_TIME
    ;JSR ADMIN
    ;JSR SECRET_1
    CLI
    movb #99, flag
    clr sound_flag
    clr did_play
   
    movb #1,to_play
    JSR speaker

 JSR MAIN_MENU
 clr did_play
MAIN:

   JSR keypadoutput
   ldaa pressed
   cmpa #8
   BGT MAIN
   JSR ELEVATOR_FLOOR
   
   ;jsr dip_switches
   JSR pot_meter ; doesn't work right now 
 
 Motor:  
   jsr stepper_motor
   ldaa direction
   cmpa #0
   BNE Motor
   
    
    clr sound_flag

    ;movb #1,to_play
    ;JSR speaker
   movb #99, flag
   BRA MAIN
   ;lbra end_now


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

;	   ldaa port_t
;	   staa value_dip_switch 
;	   anda #%0000001 ; clear out all the other values except the 3 bit
;	   cmpa #1
;	   bne enter_private_mode
	   
;	   ldaa port_t ; secets mode
;	   anda #%10000000 ; clear out all the other values except the 3 bit
;	   cmpa #%10000000
;	   bne check_flags
	   
check_flags: ldaa flag
	 cmpa #0
	 	beq just_delay
	 cmpa #1
	 beq pot_meter_delay
	 cmpa #2
	 beq LED_delay_RTI
	 cmpa #3 
	 	beq stepper_delayer
	 cmpa #5
	 	lbeq sounds_RTI
	 	
	 lbra TIME_DONE
	 
just_delay:	;0     

	  	     ldx WAIT
	 	  	 dex
	  	  	 stx WAIT
	        cpx #0
	 	  	LBNE TIME_DONE
	      movb #1, CARRY
	      movb #0, WAIT
	  	  lbra  TIME_DONE

pot_meter_delay: ; 1
	   ldaa DC_flag
		    cmpa #0
		   	lbeq TIME_DONE
		    ldx DC_delay
		   	 dex
		  	 stx DC_delay
		    cpx #0
		   	LBNE TIME_DONE
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


	   movw #$6F, stepper_delay
	   
	   bra TIME_DONE

sounds_RTI:;5
	   ldaa sound_flag
	   cmpa #1
	   lbne TIME_DONE
	   
	   ldd sound_delay
	   addd #1
	   std sound_delay
	   ;jsr PlayTone
	   cpd #1953 ;#7812
	   BLO TIME_DONE
 	   movb #1, done_playing
 	   inc number_in_sound_seq
 	   movw #0,sound_delay
	 
	 bra TIME_DONE
	 

	   	   
	   
	   
; 99 or other unknown input	   

 TIME_DONE:
    ;JSR CLOCK_INT
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
  
  
  end_now: 
  end