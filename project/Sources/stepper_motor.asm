					XDEF stepper_motor
					
					XREF port_p_ddr,port_t,port_p
					XREF direction, is_open_or_closed, LED
					XREF flag
					XREF stepper_delay, stepper_flag, stepper_seq, current_step_in_seq
val ds.b 1
highorlow ds.w 2
DelayCount ds.w 1

clockwise_seq: dc.b $0A, $12, $14, $0C, $0
counterclockwise_seq: dc.b $0C, $14, $12, $0A, $0

stepper_motor:
		
		ldaa is_open_or_closed
		cmpa #1
		beq nope
		
		movb #3,flag

change_in_direction:
        ldaa direction
		cmpa #$2 ; if equal to 2 it will send vals in to x
        beq clock
        cmpa #$1 ; if equal to 1 it will send vals1 into x
        beq counter
        rts	
        

Delay:  ldaa stepper_flag
        CLI
		cmpa #1
		beq Delay
	    	
again: 
       LDAA 1,x+
 	   cmpa #$0
       beq nope
       beq increment
       STAA port_p
       
       movb #1, stepper_flag
       bra Delay

increment:  inc should_led
		    ldaa should_led
			cmpa #8
			bne nope
led_blink:   jsr LED
		    movb #0,should_led


nope:  rts



;alternate from clock wise to counter clock wise
clock: 
       ldx #clockwise_seq ;clock wise
       bra again
 
counter: 
       ldx #counterclockwise_seq ; counter clock wise
	   bra again
