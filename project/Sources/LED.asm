; NEEDS A varable called `stateofelevator` to work right


    xdef LED
    xref direction 
    xref port_s, stateofelevator,currentfloor, floor, state_of_load
    xref is_open_or_closed 

going_up_sequence:	        dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence:		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence: 			dc.b 	$FF, $00

lenghtofdelay:	        equ		50000

LED: ldaa direction
	 cmpa #1
	 beq going_up_leds
	 cmpa #2
	 beq going_down_leds
	       
blink:       movb #$FF, port_s ; TODO fix this
 			 ;jsr Delay
 			 movb #$00, port_s
 			 ;jsr Delay
 			 movb #$FF, port_s
 			 ;jsr Delay
 			 movb #$00, port_s
 			 ;jsr Delay
 			 rts
 
;------------------------- LOOP 1 -------------------------------    
going_up_leds: 	 ldaa is_open_or_closed
				 cmpa #1
				 beq skip
				 ldaa state_of_load
				 cmpa #1
				 beq up_sec
				 
			   	 movb #0, stateofelevator
 				 movb #0,currentfloor
 				 movb #1, state_of_load
 				 
 up_sec:		ldaa stateofelevator ; else move through the array 
       			staa port_s  ; store the values of A to the LEDS 
                ROL stateofelevator
                inc currentfloor
                ldab currentfloor
                cmpb floor; checks to see if (B >= 6)
       			bne skip
       			movb #0,state_of_load
       	skip:	rts
 ;----------------------- LOOP 2 --------------------------------
     	  
going_down_leds: ldaa floor
				 cmpa #7
				 BLO skip_reset
				 movb #0,floor
skip_reset: 	 ldaa is_open_or_closed
				 cmpa #1
				 beq skip1
				 ldaa state_of_load
				 cmpa #1
				 beq down_sec
				 
				 movb #0, stateofelevator
 				 movb #8,currentfloor
 				 movb #1, state_of_load
 				 
 down_sec:		ldaa stateofelevator ; else move through the array 
       			staa port_s  ; store the values of A to the LEDS 
                ROR stateofelevator
                dec currentfloor
                ldab currentfloor
                cmpb floor; checks to see if (B >= 6)
       			bne skip1
       			movb #0,state_of_load
       	skip1:	rts
       	
       