	xdef keypad
    xref port_p, port_u, port_s, port_t, pressed
KEYPAD_RAM: SECTION
var_a ds.b 1
var_b ds.b 1
comparepressedvalue ds.b 1
MY_EXTENDED_ROM: SECTION

SEQ: dc.b $70,$B0,$D0, $E0
var1: dc.b $EB, $77, $7B, $7D, $B7, $BB, $BD, $D7, $DB, $DD, $E7, $ED, $7E, $BE, $DE,$EE, $00

KEYPAD_CODE: section
keypad:
 bclr var_a, #$FF ; intiliaze the variables
 bclr var_b, #$FF
 bclr comparepressedvalue, #$FF
 bclr port_s, #$00
 
 
looop2: 
 jsr looop1 ; subroutine for my loop.
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
 LDX #4000
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
 BRSET port_p, #$20, next_1
held_P:
   ldaa port_p
   cmpa #0
   BEQ held_P
   
   ldab #$10
 RTS
next_1: 
 staa comparepressedvalue ; store that value in comparepressedvalue
 anda #$0F ; checks if the button is comparepressedvalue or not; uses logical anda to make check if
 cmpa #$0F ; compares whats in a to this memory value
 beq next ; if they are not eq

 
 ; look up table
 ldy #var1; ; load the look up table with the table
 ldab #0 ; set up incrament
 
redo: ldaa 1, y+ ; incrament after each time through
 beq looop1; ; if equal it loops up
 incb ; if not equal incrament b.
 cmpa comparepressedvalue; ; compare if it is or isnt
 bne redo ; if not equal you redo
 decb ; decrement to set b back to orginial value
 rts