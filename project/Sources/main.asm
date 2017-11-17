;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup,port_s, ddr_s, port_t,stateofelevator
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY
            XREF LCD
            XREF __SEG_END_SSTACKblink      ; symbol defined by the linker for the end of the stack




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
Entry:
_Startup:
		lds #__SEG_END_SSTACK
    JSR INITIALIZE
    











INITIALIZE:
  JSR INITIALIZE_LCD
  ;JSR
  RTS
  
50_MS:

ISR  