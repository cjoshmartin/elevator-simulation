; NEEDS A varable called `stateofelevator` to work right


    xdef LED
    
    XREF LED_flag,LED_delay, flag
    xref direction 
    xref port_s, stateofelevator,currentfloor, floor, state_of_load
    xref is_open_or_closed 

going_up_sequence:	        dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence:		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence: 			dc.b 	$FF, $00, $FF,$00,$FA ; FA is the end of the seqence

lenghtofdelay:	        equ		50000

LED: movb #2, flag 
	 movb #$00, port_s
	 ldaa direction
	 cmpa #1
	 beq going_up_leds
	 cmpa #2
	 beq going_down_leds
	       
blink:
			ldx #blink_sequence
			 
Delay:		 ldaa LED_flag
	  		 cmpa #1
	   		 beq Delay
     		 
     		 clr LED_flag
     		 
     		 ldaa 1,x+
			 cmpa #$FA
			 lbeq skip
			 staa port_s
			 movb #$FF, LED_delay
 			 movb #1, LED_flag
 			 bra Delay
 
;------------------------- LOOP 1 -------------------------------    
going_up_leds: 	 ldaa LED_flag
				 	cmpa #1
				 		beq skip
				 ldaa is_open_or_closed
				 	cmpa #1
				 		beq skip
				 ldaa state_of_load
				 	cmpa #1
				 		beq up_sec
			   	 movb #0, stateofelevator
 				 movb #0,currentfloor
 				 movb #1, state_of_load
 				 
 up_sec:  		ldaa stateofelevator ; else move through the array 
       			staa port_s  ; store the values of A to the LEDS 
                ROL stateofelevator
                inc currentfloor
       			bra shared_code
 ;----------------------- LOOP 2 --------------------------------
     	  
going_down_leds: ldaa LED_flag
				 	cmpa #1
				 		beq skip
				 ldaa floor
				 	cmpa #7
				 		BLO skip_reset
				 movb #0,floor
skip_reset: 	 ldaa is_open_or_closed
				 	cmpa #1
				 		beq skip
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

       			
;--------------------- END ------------------------------------
       	shared_code: 
       			  ldab currentfloor ; I have forgot what this was
       			  stab currentfloor
       			  ;movb #1, LED_flag
       			  cmpb floor; checks to see if (B >= 6)
       			  	bne skip
       			  movb #0,state_of_load
       	skip:	  rts
;--------------------- DELAY ----------------------------------

	  rts       	
       