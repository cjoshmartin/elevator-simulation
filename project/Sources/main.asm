            INCLUDE 'derivative.inc'
            
            XDEF _Startup, MAIN, port_s, ddr_s, port_t,stateofelevator
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY
            XREF WELCOME, DT_TI, ADMIN, SECRET, MAIN_MENU
            XREF init_LCD
            XREF keypad, pressed, TIME_VAL, DATE_VAL
            XREF __SEG_END_SSTACK,blink      ; symbol defined by the linker for the end of the stack


My_Constant: 		section
port_s          equ     $248
ddr_s           equ     $24A
port_t			equ		$240
going_up_sequence       dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence 			dc.b 	$FF, $00
lenghtofdelay	equ		50000
MONTH_DAYS: dc.b 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
	

My_Variable: 	section 
WAIT: ds.b $2
CARRY: ds.b $1
disp:	ds.b 33
stateofelevator ds.b 1
Count_1: ds.b 1
Count_2:ds.b 1


; code section
MyCode:     SECTION
_Startup:
    lds #__SEG_END_SSTACK
    JSR INITIALIZE
    JSR WELCOME
    JSR DT_TI
    JSR ADMIN
    JSR SECRET

MAIN:
 
   JSR MAIN_MENU
   JSR keypad
   LDAA #pressed
   CMPA #0
   BEQ MAIN
   










INITIALIZE:
  JSR init_LCD
  JSR  
  RTS
  
  








;--------------------------------------------------------------------------------
;INTERRUPTS

  
TIME_INT:
    


CLOCK_INT:
  LDAA #Count_1
  inca
  staa Count_1
  CMPA #20
  BNE CLOCK_DONE
  movb #0, Count_1
  
  LDAA #Count_2
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
  
  CLOCK_HOURS_ONES_CONT
  cmpa #10
  BNE CLOCK_DONE 
  movb #0, TIME_VAL+2
  bra CLOCK_MINUTE_TENS
  
  CLOCK_MINUTE_ONES_CHECK:
  psha
  LDAA TIME_VAL+1
  cmpa #1
  BNE CLOCK_HOURS_ONES_CONT
  movb #1, TIME_VAL+2
  movb #0, TIME_VAL+1
  bra CLOCK_DATE_DAYS
  CLOCK_MINUTE_TENS:
  
  ldaa TIME_VAL+1
  inca
  staa TIME_VAL+1
  cmpa #6
  
  

IRQ_INT:



DOOR_OPEN_INT:



SECRET_MODE_INT:


