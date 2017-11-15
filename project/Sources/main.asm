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
            XDEF Entry, _Startup
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on
            XDEF WAIT, CARRY
            XREF LCD
            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack
            
          

WAIT: ds.b $2
CARRY: ds.b $1

; variable/data section
my_variable: SECTION
disp:	ds.b 33



; code section
MyCode:     SECTION
Entry:
_Startup:
		lds #__SEG_END_SSTACK
    JSR INITIALIZE
    











INITIALIZE:
  JSR INITIALIZE_LCD
  JSR
  RTS
  
50_MS:

ISR  