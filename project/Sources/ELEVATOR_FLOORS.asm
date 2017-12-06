		XDEF ELEVATOR_FLOOR, Floors_Entered
		XREF floor, FLOOR_ENTRY, FLOOR_DEST, LCD_CUR, LCD_VAL, disp_loc, keypadoutput, pressed, currentfloor, disp, display_string
ELEVATOR_RAM: SECTION
Floors_Entered: ds.b 7
Floors_Sorted: ds.b 7
Floor_Flag: ds.b 1
Floor_Count: ds.b 1
ELEVATOR_CODE: SECTION

ELEVATOR_FLOOR:		
	     JSR FLOOR_ENTRY
	     movb #16, LCD_CUR
	     movb #0, Floor_Count
	     ldab #7
	     ldx #Floors_Entered
	     EF_1:
	       JSR keypadoutput
		   ldaa pressed
		   cmpa #$D
		   BEQ EF_2
		   cmpa currentfloor
		   BEQ EF_1
		   cmpa #8
		   BGT EF_1
		   staa 1, x+
		  EF_1_CONT:  
		   adda #48
		   staa LCD_VAL
		   jsr disp_loc
		   ldaa LCD_CUR
		   cmpa #30
		   BEQ EF_2
		   decb
		   adda #2
		   staa LCD_CUR
		   bra EF_1
	
	;After all desired floors are entered it then fills the rest with '-' and continues	   
		 EF_2:
		    cmpb #0
		    BEQ EF_3
		    cmpb #6
		    BNE EF_CON_1
		
		  EF_CON_1:
		    movb #'-', Floors_Entered+1
		    
		  EF_CON_2:
		    cmpb #5
		    BNE EF_CON_3
		    movb #'-', Floors_Entered+2
		    
		  EF_CON_3:
		    cmpb #4
		    BNE EF_CON_4
		    movb #'-', Floors_Entered+3
		    
		  EF_CON_4:
		    cmpb #3
		    BNE EF_CON_5
		    movb #'-', Floors_Entered+4
		    
		  EF_CON_5:
		    cmpb #2
		    BNE EF_CON_6
		    movb #'-', Floors_Entered+5
		    
		  EF_CON_6:
		    cmpb #1
		    BNE EF_3
		    movb #'-', Floors_Entered+6
	
	;It now sorts the values into a more concise array	    
		 
		 EF_3:
		   ldx #Floors_Entered
		   ldaa Floors_Entered
		   cmpa currentfloor
		   BGT SORT_up
		   ldaa #0
		   deca
		 SORT_DN:
		   ldab Floor_Count
		   cmpb #7
		   BEQ EF_4 
		   inca
		   cmpa #7
		   BEQ SORT_up
		   ldab 1, x+
		   cmpb #'-'
		   BEQ EF_4
		   cmpb currentfloor
		   BGT SORT_DN
		   JSR SORT_DOWN
		   BRA SORT_DN
		   
		 SORT_up:
		   ldx #Floors_Entered 			   
		   ldaa #0
		   deca
		   SORT_up_1:
		   ldab Floor_Count
		   cmpb #7
		   BEQ EF_4
		   inca
		   cmpa #7
		   BEQ SORT_DN
		   ldab 1, x+
		   cmpb #'-'
		   BEQ EF_4
		   cmpb currentfloor
		   BLT SORT_up_1
		   JSR SORT_UP
		   BRA SORT_up_1
		   
		 EF_4:
		   ldaa Floors_Sorted
		   adda #48
		   staa disp
		   
		   ldaa Floors_Sorted+1
		   adda #48
		   staa disp+1
		   
		   ldaa Floors_Sorted+2
		   adda #48
		   staa disp+2
		   
		   ldaa Floors_Sorted+3
		   adda #48
		   staa disp+3
		   
		   ldaa Floors_Sorted+4
		   adda #48
		   staa disp+4
		   
		   ldaa Floors_Sorted+5
		   adda #48
		   staa disp+5
		   ldaa Floors_Sorted+6
		   adda #48
		   staa disp+6
		   ldaa Floors_Sorted+7
		   adda #48
		   staa disp+7
		   
		   ldd #disp  
		   JSR display_string
		   RTS  





;--------------------------------------------------------------------------

SORT_UP:
  psha
  ldaa Floor_Count
  cmpa #0
  BNE SORT_UP_1
  stab Floors_Sorted
  jmp SORT_UP_END
  			    
SORT_UP_1:		    
  cmpa #1
  BNE SORT_UP_2
SORT_UP_1a:  
  cmpb Floors_Sorted
  BLT SORT_UP_1b
  ldy Floors_Sorted
  stab Floors_Sorted
  sty Floors_Sorted+1
  jmp SORT_UP_END

SORT_UP_1b:
  stab Floors_Sorted+1
  jmp SORT_UP_END
    
SORT_UP_2:
  cmpa #2
  BNE SORT_UP_3
SORT_UP_2a:  
  cmpb Floors_Sorted+1
  BLT SORT_UP_2b
  ldy Floors_Sorted+1
  stab Floors_Sorted+1
  sty Floors_Sorted+2
  BRA SORT_UP_1a
  
SORT_UP_2b:
  stab Floors_Sorted+2
  jmp SORT_UP_END  
  
SORT_UP_3:
  cmpa #3
  BNE SORT_UP_4
SORT_UP_3a:  
  cmpb Floors_Sorted+2
  BLT SORT_UP_3b
  ldy Floors_Sorted+2
  stab Floors_Sorted+2
  sty Floors_Sorted+3
  BRA SORT_UP_2a
  
SORT_UP_3b:
  stab Floors_Sorted+3
  jmp SORT_UP_END  
  
SORT_UP_4:
  cmpa #4
  BNE SORT_UP_5
SORT_UP_4a:  
  cmpb Floors_Sorted+3
  BLT SORT_UP_4b
  ldy Floors_Sorted+3
  stab Floors_Sorted+3
  sty Floors_Sorted+4
  BRA SORT_UP_3a
  
SORT_UP_4b:
  stab Floors_Sorted+4
  jmp SORT_UP_END  
  
SORT_UP_5:
  cmpa #5
  BNE SORT_UP_6
SORT_UP_5a:  
  cmpb Floors_Sorted+4
  BLT SORT_UP_5b
  ldy Floors_Sorted+4
  stab Floors_Sorted+4
  sty Floors_Sorted+5
  BRA SORT_UP_4a
  
SORT_UP_5b:
  stab Floors_Sorted+5
  jmp SORT_UP_END        
    
SORT_UP_6:
  cmpa #6
  BNE SORT_UP_7
SORT_UP_6a:  
  cmpb Floors_Sorted+5
  BLT SORT_UP_6b
  ldy Floors_Sorted+5
  stab Floors_Sorted+5
  sty Floors_Sorted+6
  BRA SORT_UP_5a
  
SORT_UP_6b:
  stab Floors_Sorted+6
  jmp SORT_UP_END  
  
SORT_UP_7:
  cmpa #7
  BNE SORT_UP_END  
  cmpb Floors_Sorted+6
  BLT SORT_UP_7b
  ldy Floors_Sorted+6
  stab Floors_Sorted+6
  sty Floors_Sorted+7
  BRA SORT_UP_6a
  
SORT_UP_7b:
  stab Floors_Sorted+7
  jmp SORT_UP_END  
  
SORT_UP_END:      
  inca
  staa Floor_Count
  pula
  RTS
  
;----------------------------------------------------------------------------

SORT_DOWN:
  psha
  ldaa Floor_Count
  cmpa #0
  BNE SORT_DOWN_1
  stab Floors_Sorted
  jmp SORT_DOWN_END
  			    
SORT_DOWN_1:		    
  cmpa #1
  BNE SORT_DOWN_2
SORT_DOWN_1a:  
  cmpb Floors_Sorted
  BGT SORT_DOWN_1b
  ldy Floors_Sorted
  stab Floors_Sorted
  sty Floors_Sorted+1
  jmp SORT_DOWN_END

SORT_DOWN_1b:
  stab Floors_Sorted+1
  jmp SORT_DOWN_END
    
SORT_DOWN_2:
  cmpa #2
  BNE SORT_DOWN_3
SORT_DOWN_2a:  
  cmpb Floors_Sorted+1
  BGT SORT_DOWN_2b
  ldy Floors_Sorted+1
  stab Floors_Sorted+1
  sty Floors_Sorted+2
  BRA SORT_DOWN_1a
  
SORT_DOWN_2b:
  stab Floors_Sorted+2
  jmp SORT_DOWN_END  
  
SORT_DOWN_3:
  cmpa #3
  BNE SORT_DOWN_4
SORT_DOWN_3a:  
  cmpb Floors_Sorted+2
  BGT SORT_DOWN_3b
  ldy Floors_Sorted+2
  stab Floors_Sorted+2
  sty Floors_Sorted+3
  BRA SORT_DOWN_2a
  
SORT_DOWN_3b:
  stab Floors_Sorted+3
  jmp SORT_DOWN_END  
  
SORT_DOWN_4:
  cmpa #4
  BNE SORT_DOWN_5
SORT_DOWN_4a:  
  cmpb Floors_Sorted+3
  BGT SORT_DOWN_4b
  ldy Floors_Sorted+3
  stab Floors_Sorted+3
  sty Floors_Sorted+4
  BRA SORT_DOWN_3a
  
SORT_DOWN_4b:
  stab Floors_Sorted+4
  jmp SORT_DOWN_END  
  
SORT_DOWN_5:
  cmpa #5
  BNE SORT_DOWN_6
SORT_DOWN_5a:  
  cmpb Floors_Sorted+4
  BGT SORT_DOWN_5b
  ldy Floors_Sorted+4
  stab Floors_Sorted+4
  sty Floors_Sorted+5
  BRA SORT_DOWN_4a
  
SORT_DOWN_5b:
  stab Floors_Sorted+5
  jmp SORT_DOWN_END        
    
SORT_DOWN_6:
  cmpa #6
  BNE SORT_DOWN_7
SORT_DOWN_6a:  
  cmpb Floors_Sorted+5
  BGT SORT_DOWN_6b
  ldy Floors_Sorted+5
  stab Floors_Sorted+5
  sty Floors_Sorted+6
  BRA SORT_DOWN_5a
  
SORT_DOWN_6b:
  stab Floors_Sorted+6
  jmp SORT_DOWN_END  
  
SORT_DOWN_7:
  cmpa #7
  BNE SORT_DOWN_END  
  cmpb Floors_Sorted+6
  BGT SORT_DOWN_7b
  ldy Floors_Sorted+6
  stab Floors_Sorted+6
  sty Floors_Sorted+7
  BRA SORT_DOWN_6a
  
SORT_DOWN_7b:
  stab Floors_Sorted+7
  jmp SORT_UP_END  
  
SORT_DOWN_END:      
  inca
  staa Floor_Count
  pula
  RTS    
    
     		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
    		    
		    
		 	  