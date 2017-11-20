		XDEF LCD, WELCOME, DT-TI, ADMIN, SECRET, LCD_FLOOR, LCD_MAIN
		XDEF disp, LCD_CUR, LCD_VAL
		XREF WAIT, keypad, pressed 
    XREF displayscreen, disp_loc
    

disp: ds.b 33	  ;values to display the LCD
LCD_CUR: ds.b 1  ;Holds the current LCD display value
LCD_VAL: ds.b 1  ;Holds The value for flash on and off

MY_VAR: SECTION
NUM: ds.b 1
INPUT_BLOCK: ds.b 1



;----------------------------------------------------------------------
		
WELCOME:
		      movb #40, WAIT		  ;Loads in value for interrupt
			
		   	  movb #'W',disp
       	 	movb #'e',disp+1
       	  movb #'l',disp+2
        	movb #'c',disp+3
        	movb #'o',disp+4
        	movb #'m',disp+5
        	movb #'e',disp+6
        	movb #' ',disp+7
        	movb #' ',disp+8
        	movb #'T',disp+9
        	movb #'o',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #'T',disp+13
        	movb #'h',disp+14
        	movb #'e',disp+15
        	movb #' ',disp+16
        	movb #' ',disp+17
        	movb #' ',disp+18
        	movb #' ',disp+19
        	movb #' ',disp+20
        	movb #'E',disp+21
        	movb #'l',disp+22
        	movb #'e',disp+23
        	movb #'v',disp+24
        	movb #'a',disp+25
        	movb #'t',disp+26
        	movb #'o',disp+27
        	movb #'r',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldx #disp
        	jsr display_string
        	
          WAI TIME_INT
		RTS
		
;------------------------------------------------------------------------

DT-TI:
			    movb #0, LCD_CUR
			    movb #15, WAIT
			    movb #'>', LCD_VAL
			    movb #0, NUM
			
		    	movb #'>',disp
       	 	movb #'D',disp+1
       	  movb #'A',disp+2
        	movb #'T',disp+3
        	movb #'E',disp+4
        	movb #':',disp+5
        	movb #' ',disp+6
        	movb #' ',disp+7
        	movb #'/',disp+8
        	movb #' ',disp+9
        	movb #' ',disp+10
        	movb #'/',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #' ',disp+16
        	movb #'T',disp+17
        	movb #'I',disp+18
        	movb #'M',disp+19
        	movb #'E',disp+20
        	movb #':',disp+21
        	movb #' ',disp+22
        	movb #' ',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #'A',disp+28
        	movb #'M',disp+29
        	movb #'P',disp+30
        	movb #'M',disp+31
        	movb #0,disp+32
        	
        	
          movb #$11, INPUT_BLOCK
        	
        	ENTER_DT:
        	  ldaa #LCD_CUR
        	  LDX #disp        
            JSR display_string
            JSR KEYPAD
            JSR INPUT
            CMPA #LCD_CUR
            BEQ ENTER_DT_CONT
            
            ldab #LCD_CUR
            staa LCD_CUR
            MOVB #' ', LCD_VAL
            jsr disp_loc
            stab LCD_CUR
            
          ENTER_DT_CONT
            JSR disp_loc
            cpx #0
            BEQ ENTER_DT
            movb #$22, INPUT_BLOCK
            BRSET LCD_CUR, #0, DATE
            
          TIME:
            LDAA #22
            STAA LCD_CUR
              
              
          TIME_IN:
            JSR keypad
            ldaa #pressed
            staa LCD_VAL
            cmpa #0
            BEQ TIME_IN
            
          TIME_CON:
              LDAA #LCD_CUR
              CMPA #21
              BGT TC_2
              movb #22, LCD_CUR
              
            TC_2:
              CMPA #24
              BNE TIME_IN
              movb #25, LCD_CUR
          
               
          JSR disp_loc
          ldx #disp
          JSR display_string      
          ldab #LCD_CUR
          incb
          stab LCD_CUR
          
          cmpb #32          
          
          END_DT:
              movb #0, CARRY
              movb #1, DT
              movb #$
              RTS

;------------------------------------------------------------------------
        
ADMIN:
    			movb #8, LCD_CUR
			
			    movb #15, WAIT
			    movb #0, LCD_VAL
			    movb #0, NUM
			
		    	movb #'U',disp
       	 	movb #'S',disp+1
       	  movb #'E',disp+2
        	movb #'R',disp+3
        	movb #'N',disp+4
        	movb #'A',disp+5
        	movb #'M',disp+6
        	movb #'E',disp+7
        	movb #':',disp+8
        	movb #' ',disp+9
        	movb #' ',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #'P',disp+16
        	movb #'A',disp+17
        	movb #'S',disp+18
        	movb #'S',disp+19
        	movb #'W',disp+20
        	movb #'O',disp+21
        	movb #'R',disp+22
        	movb #'D',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32      
        
          A_USERNAME:
           ldab #LCD_CUR
           addb #1
           
          A_MOVE1: 
           JSR keypad
           JSR INPUT
           cpx #LCD_CUR
           BEQ A_PASSWORD
           cmpb #LCD_CUR
           BEQ A_MOVE1
           ldaa #pressed  
           cmpb #16
           BLE A_U1
           movb #8, LCD_CUR
           bra A_USERNAME
           
          A_U1:
           cmpb #8
           BGT A_UC
           movb #8, LCD_CUR
           bra A_USERNAME 
        
          A_UC:
           
           movb #pressed, A_USER+NUM
           ldab #NUM
           addb #1
           stab NUM
           ldab disp
           addb #LCD_CUR     
           movb #pressed, disp
           
           ldaa #LCD_CUR
           adda #1
           cmpa #16
           BEQ A_PASSWORD
           bra A_USERNAME
           
          A_PASSWORD: 
           clrx
           ldab #0
           stab NUM
          A_PASSWORD_1: 
           ldab #LCD_CUR
           addb #1
           
          A_MOVE2: 
           JSR keypad
           JSR INPUT
           cpx #LCD_CUR
           BEQ A_EXIT
           cmpb #LCD_CUR
           BEQ A_MOVE2
           ldaa #pressed  
           cmpb #15
           BGT A_P1
           movb #25, LCD_CUR
           bra A_PASSWORD1
           
          A_P1:
           cmpb #24
           BGT A_UC
           movb #25, LCD_CUR
           bra A_PASSWORD1 
        
          A_UC:
           movb #pressed, A_PASS+NUM
           ldab #NUM
           addb #1
           stab NUM
           movb #pressed, disp+LCD_CUR
           
           ldaa #LCD_CUR
           adda #1
           cmpa #32
           BEQ A_END
           bra A_PASSWORD1
        
          A_END:
           movb #0, CARRY
           movb #1, ADM
           
;----------------------------------------------------------------           

  SECRET:
  	      	movb #10, LCD_CUR
			
		    movb #15, WAIT
		    movb #0, NUM 
		    
		    movb #'S',disp
       	 	movb #'E',disp+1
       	    movb #'C',disp+2
        	movb #'R',disp+3
        	movb #'E',disp+4
        	movb #'T',disp+5
        	movb #' ',disp+6
        	movb #'I',disp+7
        	movb #'D',disp+8
        	movb #':',disp+9
        	movb #' ',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #'P',disp+16
        	movb #'A',disp+17
        	movb #'S',disp+18
        	movb #'S',disp+19
        	movb #'W',disp+20
        	movb #'O',disp+21
        	movb #'R',disp+22
        	movb #'D',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
		    
		    SECRET_ID:
		    	
 
 
 
 
 
 
 
  INPUT:
        
        psha			 ;saves value of A
        ldaa #LCD_CUR	 ;loads current location on LCD SCREEN
        ldab #pressed
        BRSET INPUT_BLOCK, #$22, LEFT
        
  UP:     cmpb #$C		 ;checks if up pressed
        BNE DOWN		 ;if not continue
        cmpa #16		 ;check if LCD SCREEN is on upper 16 
        BLE INPUT_DONE	 ;if so then exit
        adda #16		 ;else add 16  store and exit
        staa LCD_CUR
        BRA INPUT_DONE
         
  DOWN:   cmpb #$E		 ;checks if down is pressed
        BNE LEFT		 ;if not then continue
        cmpa #16		 ;check if LCD SCREEN is on lower 16
        BGE INPUT_DONE	 ;if greater than then exit
        suba #16		 ;else subtract 16 save and exit 
        staa LCD_CUR
        BRA INPUT_DONE
        
        BRSET INPUT_BLOCK, #$11, INPUT_DONE
           
  LEFT:   cmpb #$A		  ;checks and see if left
        BNE	 RIGHT		  ;if not then continue
        cmpa #0			  ;compare it to 0 and 16 to see if it is already all the way to the left if so then branch
        BEQ	 INPUT_DONE	  
        cmpa #16
        BEQ	 INPUT_DONE
        deca			  ;if not then decrement and store
        staa LCD_CUR
        bra INPUT_DONE
      
  RIGHT:  cmpb #$B		  ;check and see if right is pressed and if not continue
        BNE INPUT_DONE	  
        cmpa #15		  ;compare it to 15 and 31 to see if it is already all the way to the right if so then branch
        BEQ INPUT_DONE	  
        cmpa #31
        BEQ INPUT_DONE
        adda #1			  ;if not then add one to shift it right and save
        staa LCD_CUR
        bra INPUT_DONE
  
  INPUT_DONE:
  
  ENTER:
        cmpb #$0
        BNE INPUT_OVER
        ldx #1
  INPUT_OVER:      
	     	pula
        RTS 
        