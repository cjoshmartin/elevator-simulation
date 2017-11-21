	xdef keypad

var_a ds.b 1
var_b ds.b 1
pressed ds.b 1
MY_EXTENDED_ROM: SECTION
port_t equ $240
ddr_s equ $24A
port_s equ $248
port_u equ $268
ddr_port_u equ $26A
psr_port_u equ $26D
pde_port_u equ $26C
SEQ: dc.b $70,$B0,$D0, $E0
var1: dc.b $EB, $77, $7B, $7D, $B7, $BB, $BD, $D7, $DB, $DD, $E7, $ED, $7E, $BE, $DE,$EE, $00

keypad:
 bset ddr_s, #$FF ; used to intiliaze the LED display
 bset ddr_port_u, #$F0; used to intiliaze the hex keys
 bset psr_port_u, #$F0
 bset pde_port_u, #$0F
 bclr var_a, #$FF ; intiliaze the variables
 bclr var_b, #$FF
 bclr pressed, #$FF
 bclr port_s, #$00
 clr pressed
looop2: jsr looop1 ; subroutine for my loop.
 brclr var_a, #$FF, move;
 bclr var_b, #$F0
 stab pressed
 rts ; END OF PROGRAM

move: bclr var_b,#$0F
 orab var_b
 stab var_b
 bset var_a,#$FF
 bra looop2;

Delay: PSHX
 LDX #1000
DLoop: DEX
 BNE DLoop
 PULX
 RTS

looop1: ldx #SEQ ; load the sequence in to x

next: ldaa 1,x+ ; load one, and incrament it by x
 beq looop1 ; if equal then branch
 
 staa port_u ; display the value
 
 jsr Delay ; my delay counter
 ldaa port_u ; load value from port_u in to a
 staa pressed ; store that value in pressed
 anda #$0F ; checks if the button is pressed or not; uses logical anda to make check if

 cmpa #$0F ; compares whats in a to this memory value
 beq next ; if they are not eq

 
 ; look up table
 ldy #var1; ; load the look up table with the table
 ldab #0 ; set up incrament
redo: ldaa 1, y+ ; incrament after each time through
 beq looop1; ; if equal it loops up
 incb ; if not equal incrament b.
 cmpa pressed; ; compare if it is or isnt
 bne redo ; if not equal you redo
 decb ; decrement to set b back to orginial value
 rts