	  xdef dip_switches,value_dip_switch 
	  xref port_t, SECRET_ID_SUBMENU
	  XREF sound_flag,did_play,to_play,speaker
	 	   
value_dip_switch ds.b 1	  
	  
	  
	  
	  
	  
dip_switches:	  
	   ldaa port_t
	   staa value_dip_switch 
	   anda #%0000001 ; clear out all the other values except the 3 bit
	   cmpa #1
	   beq enter_private_mode
	   
	   ldaa port_t
	   anda #%10000000 ; clear out all the other values except the 3 bit
	   cmpa #%10000000
	   beq enter_login_mode
	   rts
	   
;f switch 1 goes high, the elevator will freeze at the currently location. 
;the elevator is locked has no functionality until switch 1 goes low 
;(the elevator returns back to its previous function).

enter_private_mode: ;jsr to private mode
					;TODO need to freeze on current floor
				 	ldaa port_t
	   				staa value_dip_switch 
					anda #%0000001
					
					clr sound_flag
		                  clr did_play
		    		      movb #4,to_play
    		    		      JSR speaker
				      
				      cmpa #1
		   			beq enter_private_mode
		   			bra dip_switches
		   			
;Switch 8 is meant to represent the secret mode mechanism.
enter_login_mode: jsr SECRET_ID_SUBMENU ; TODO: need to fix	
			 	ldaa port_t
	   			staa value_dip_switch 
				andb #%1000000
				cmpb #80
		   		beq enter_login_mode
		   		bra dip_switches
									