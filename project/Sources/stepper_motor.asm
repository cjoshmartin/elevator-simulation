					XDEF stepper_motor
					XREF port_p_ddr,port_t,port_p
					XREF direction
val ds.b 1
highorlow ds.w 2
DelayCount ds.w 1

vals: dc.b $0A, $12, $14, $0C, $0
vals1: dc.b $0C, $14, $12, $0A, $0
; code section
MyCode: SECTION
main:
_Startup:
Entry:
stepper_motor:
higher: movw #9000, highorlow ; since higher changes the delay counter to a lower value to spin faster
; bra skip ; skips over the lower branch
;lowest: movw #30000, highorlow ; since lower changes delay counter to higher value so it moves slower

 ldaa direction
 cmpa #$2 ; if equal to 2 it will send vals in to x
 beq clock
 cmpa #$1 ; if equal to 1 it will send vals1 into x
 beq counter
 rts

;alternate from clock wise to counter clock wise
clock: LDX #vals ;clock wise
 Bra again1
counter: LDX #vals1 ; counter clock wise
 BRA again1
again1:
again: LDAA 1,x+
 STAA port_p
 cmpa $0
 beq stepper_motor ; goes back to stepper_motor to check if it has changed
 jsr Delay
 bra again

nope: rts

Delay: PSHX ; my delay
 LDX highorlow ; depends on if bit 3 is high or low
LOOP DEX
 BNE LOOP
 PULX
 RTS