            INCLUDE 'derivative.inc'
            
            XDEF _Startup, MAIN, port_s, ddr_s, port_t,stateofelevator
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY
            XREF WELCOME, DT_TI, ADMIN, SECRET
            XREF init_LCD
            XREF keypad, pressed
            XREF __SEG_END_SSTACK,blink      ; symbol defined by the linker for the end of the stack


My_Constant: 		section
port_s          equ     $248
ddr_s           equ     $24A
port_t			equ		$240
going_up_sequence       dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence 			dc.b 	$FF, $00
lenghtofdelay	equ		50000
	

My_Variable: 	section 
WAIT: ds.b $2
CARRY: ds.b $1

; variable/data section
my_variable: SECTION
disp:	ds.b 33
stateofelevator ds.b    1


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
 











INITIALIZE:
  JSR init_LCD
  JSR keypad
   
  RTS
  
  
  
TIME_INT:
    


