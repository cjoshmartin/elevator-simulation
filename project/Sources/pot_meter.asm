			xdef pot_meter
			xref read_pot, pot_value
			xref WAIT,CARRY
			XREF DC_flag,DC_delay, is_open_or_closed,was_open_or_closed
			XREF flag
			XREF max_value_of_pot
			XREF ERROR_DOOR,MAIN_MENU
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
press     ds.b	  1
toff	  ds.b	  1
ton		  ds.b	  1
MY_CONSTANT_RAM: SECTION

port_t    equ $240
ddr_port_t equ $242
ddr_s     equ $24A
port_s    equ $248
port_u    equ $268


pot_meter:  ;movb #8, WAIT	
            ;movb #5, press
			movb #1, flag ; telling the RTI that it is in the pot_meter subroutine

getpotentiometer: 
		   jsr potentiometer ; gets the imput of the potentiometer 
		   ldab press ; loads the value into B
		   stab ton
		   ;rts ;temp
; UP TO HERE WORKS, if you step through it
		   
checkton: beq interruptdelay
		   bset port_t, #$08 ;turns the motor on 
		   rts
 hitloop:  jsr cpudelay
 		   dec ton
		   bne hitloop
		   	 

interruptdelay:	 ldab press
				 ldaa #$0f ; load A with 15
				 sba ; subtract b from a
				 staa toff
				 beq getpotentiometer ; branch to toff is equal to zero
				 bclr port_t, #$08 ; else clears the bit 3
				 
		looppy:  
				 movb #1,DC_flag
				 jsr cpudelay
				 ;dec toff
				 ;bne looppy
				 bra getpotentiometer
				 rts				 		   

potentiometer:  
			jsr  read_pot
			ldd  pot_value
			cmpb max_value_of_pot
  			bhs is_FF
  			cmpb #0
  			beq is_zero
  			ldab #0
  			stab press
  			
  			ldaa was_open_or_closed
	   		cmpa is_open_or_closed
	  		bne show_error_message
  			movb #1, is_open_or_closed 
return:     rts


; ------------------------------------------------------------------------------
is_FF: stab  press
	   ldaa was_open_or_closed
	   cmpa is_open_or_closed
	   bne show_main_menu
	   movb #0, is_open_or_closed  		;stores index into variable "keypress"
	   rts
show_main_menu:
	jsr MAIN_MENU
	;TODO: addd sound
	movb #0, is_open_or_closed 
	ldaa is_open_or_closed
	staa was_open_or_closed  
	rts

show_error_message:
 	jsr ERROR_DOOR
 	movb #1, is_open_or_closed
 	ldaa is_open_or_closed
	staa was_open_or_closed 
	rts   
	
is_zero: ldab #$80
		 stab press
		 movb #1, is_open_or_closed 
		 rts
;---------------------------------------------------------------------------------
cpudelay: 
		  ldaa DC_flag
		  cmpa #1
		  beq  cpudelay
          rts
          