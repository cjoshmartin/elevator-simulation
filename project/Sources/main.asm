            INCLUDE 'derivative.inc'
            
            XDEF _Startup, MAIN_2, stateofelevator
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY, CRGINT, RTICTL, stateofelevator, NEXT_FLOOR
            XDEF NEXT_FLOOR
            xdef direction
            XDEF TIME_INT, Count_1, Count_2
            XDEF is_open_or_closed, was_open_or_closed
            XDEF enable_admin
            xdef stepper_flag, stepper_delay
           	XDEF currentfloor,floor,state_of_load, max_value_of_pot
           	XREF stepper_motor	
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
WAIT: 	ds.b 		1
CARRY: 	ds.b 		1
disp:	ds.b 		33
NEXT_FLOOR: ds.b 	1
direction:  ds.b	1 ; 1 for up, 2 for down, 0 for none
;LEDS
currentfloor:           ds.b    1
stateofelevator         ds.b    1
floor:					ds.b    1
state_of_load:			ds.b	1
;stepper Motor
stepper_flag:			ds.b    1
stepper_delay:			ds.w    1
is_open_or_closed:		ds.b	1 ; if 0 then closed, if 1 then openned...
was_open_or_closed:     ds.b    1 ; stores the old value of is_open_or_closed
;POT_Motor
max_value_of_pot:		ds.b	1
; Interrupts
Count_1: 				ds.b    1
Count_2:				ds.b    1
; Keypad
enable_admin: 			ds.b	1  ; 0 is non-enable, 1 is enable


; code section
MyCode:     SECTION
_Startup: 
	movb #0, enable_admin
	
    lds #__SEG_END_SSTACK
    JSR INITIALIZE_PORTS
    JSR WELCOME
    JSR DATE_TIME
    JSR ADMIN
    JSR SECRET
    JSR MAIN_MENU
    
   movb #1, enable_admin
   clr currentfloor
   clr floor
   clr state_of_load
   clr stepper_flag
   
   movb #0, stepper_flag ;init state of the stepper
   movb #400,stepper_delay
   movb #$A7, max_value_of_pot
   movb #0, state_of_load
   movb #1, floor ; the highest or lowest floor 
   
   movb #2, direction ; tell the elevator wants to move upwards
   
 
 
MAIN_2:
   
   JSR keypadoutput
   JSR pot_meter 
   jsr dip_switches
   jsr LED
   jsr stepper_motor 

   CLI
   WELCOME_WAIT:
   ldaa CARRY
   cmpa #1
   BNE WELCOME_WAIT
   movb #0, CARRY
   movb #4, WAIT
   SEI
  
   bra MAIN_2 ; TODO: change this later
   

;--------------------------------------------------------------------------------
;INTERRUPTS

  
TIME_INT:
  ldaa WAIT
  deca
  staa WAIT
  cmpa #0
  BNE TIME_DONE
  movb #1, CARRY
  movb #0, WAIT
  
  TIME_DONE:
    bset CRGFLG, $80
    RTI
    


;CLOCK_INT:
  ;LDAA #Count_1
  ;inca
 ; staa Count_1
 ; CMPA #20
 ; BNE CLOCK_DONE
 ; movb #0, Count_1
  
 ; LDAA #Count_2
 ; inca
 ; staa Count_2
 ; cmpa #60
  ;BNE CLOCK_DONE
  ;movb #0, Count_2
  
 ; CLOCK_MINUTES_ONES:
 ; LDAA TIME_VAL+4
 ; inca
 ; staa TIME_VAL+4
 ; cmpa #10
 ; BNE CLOCK_DONE
 ; movb #0, TIME_VAL+4
  ;BRA CLOCK_MINUTES_TENS
  
  ;CLOCK_MINUTES_TENS:
  ;ldaa TIME_VAL+3
  ;inca
  ;staa TIME_VAL+3
  ;cmpa #6
  ;BNE CLOCK_DONE
  ;movb #0, TIME_VAL+3
  ;bra CLOCK_HOURS_ONES
  
  ;CLOCK_HOURS_ONES:
  ;ldaa TIME_VAL+2
  ;inca
  ;staa TIME_VAL+2
  ;cmpa #3
  ;BNE CLOCK_HOURS_ONES_CHECK
  
  ;CLOCK_HOURS_ONES_CONT:
  ;cmpa #10
  ;BNE CLOCK_DONE 
  ;movb #0, TIME_VAL+2
  ;bra CLOCK_MINUTE_TENS
  ;
  ;CLOCK_MINUTE_ONES_CHECK:
  ;psha
  ;LDAA TIME_VAL+1
  ;cmpa #1
  ;BNE CLOCK_HOURS_ONES_CONT
  ;movb #1, TIME_VAL+2
  ;movb #0, TIME_VAL+1
  ;bra CLOCK_DATE_DAYS
  ;CLOCK_MINUTE_TENS:
  
  ;ldaa TIME_VAL+1
  ;inca
  ;staa TIME_VAL+1
  ;cmpa #6
  
  

;IRQ_INT:



;DOOR_OPEN_INT:



;SECRET_MODE_INT: