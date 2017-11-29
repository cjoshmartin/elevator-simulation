; NEEDS A varable called `stateofelevator` to work right



    
    xdef blink,blinkloop
    xdef sec2, sec1
    xref stateofelevator, port_t, port_s


going_up_sequence       dc.b    $01, $02, $04, $08, $10, $20, $40, $80
going_down_sequence		dc.b	$80, $40, $20, $10, $08, $04, $02, $01
blink_sequence 			dc.b 	$FF, $00

lenghtofdelay	equ		50000
	
;	ldab #0	         
blink:       ldx #blink_sequence ; alternates between fully on and fully off
  			 ldab #0
  			 clr stateofelevator  ;Each time it goes to the blink sequence, it will clear the stateofelevator
  			   			 
blinkloop:	 cmpb #2
 			 bge blink ; resets the blinking
 			 ldaa 1,x+ ; moves through the blink_sequence
 			 staa port_s; displays it to the led
 			 jsr Delay
 			 incb
 			 ldy stateofelevator ; this will need to change beacuse this should be if a floor has been selected
 			 cpy #1
 			 bge state_of_t ; if greater then 1 check to see of it should move up or down
 			 bra blinkloop
 
state_of_t: ldaa stateofelevator 
			ldab #0    ; Loadx clears B which I use for counting
			cmpa #1 ; if stateofelevator is less or equal 1 it will start blinking
			blo blink
			cmpa #2 ; if stateofelevator is equal 2 it will start the going_up_sequence
			beq  sec1  			
sec2:    	ldx #going_down_sequence ; and reloads the sequence into x
 

;------------------------- LOOP 1 -------------------------------    
whi: cmpb #8; checks to see if (B >= 6)
       bge blink ; if true, go to "loadx"
       
       ldaa 1,x+ ; else move through the array 
       INCB     ; and increment B
       staa port_s  ; store the values of A to the LEDS
       jsr  Delay; adds a delay of 500 ms 
        ;cmpa port_t
        ;bne state_of_t 
       bra whi  ; LOOP
 ;----------------------- LOOP 2 --------------------------------
      
      sec1:ldx #going_up_sequence 
      whil: cmpb #8; checks to see if (B >= 5)
       bge blink ; if true, go to "loadx"
       
       ldaa 1,x+ ; else move through the array 
       INCB     ; and increment B
       staa port_s  ; store the values of A to the LEDS
        jsr  Delay; adds a delay of 500ms
       ; cmpa port_t
        ;bne state_of_t
       bra whil  ; LOOP
;------------------------- DELAY----------------------------------

Delay: pshb
	  pshx
	  ldab  #10
outer:ldx	#lenghtofdelay
loop: dex
	  bne loop
	  DBNE b,outer
	  pulx
	  pulb
	  rts