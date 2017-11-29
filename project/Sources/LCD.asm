		XDEF WELCOME, DT_TI, ADMIN, SECRET, INPUT, MAIN_MENU
		XDEF disp, LCD_CUR, LCD_VAL
		XREF WAIT, keypadoutput, pressed, TIME_VAL, DATE_VAL  
    XREF display_string, disp_loc, TIME_SET, DATE_SET, ADMIN_SET, SECRET_SET
    XREF TIME_disp, DATE_disp, MAIN_MENU_SETUP,
    
LCD_RAM: section
disp: ds.b 33	  ;values to display the LCD
LCD_CUR: ds.b 1  ;Holds the current LCD display value
LCD_VAL: ds.b 1  ;Holds The value for flash on and off
NUM: ds.b 1
INPUT_BLOCK: ds.b 1



;----------------------------------------------------------------------
CODE_LCD: SECTION		
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
        	
        	ldd #disp
        	jsr display_string
        	
          ;WAI TIME_INT
		  RTS
		
;------------------------------------------------------------------------

DT_TI:
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
        	ldd #disp
        	jsr display_string
            ldy #0
        	
        	ENTER_DT:
             jsr keypadoutput
             ldaa pressed
             
             
             ldaa LCD_CUR
             jsr INPUT
             cpx #1
             BEQ DT_CONT
             
             cmpa LCD_CUR
             BEQ ENTER_DT
            
        KERNAL:     
             jsr disp_loc
             ldab LCD_CUR
             staa LCD_CUR
             movb #' ', LCD_VAL
             jsr disp_loc
             stab LCD_CUR
             movb #'>', LCD_VAL
             ldx #0
             bra ENTER_DT
             
          DT_CONT:
            ldaa LCD_CUR
            cmpa #0
            BNE TIME
            
          DATE:  
            JSR DATE_SET
            iny
            cpy #2
            BNE ENTER_DT
            bra END_DT
          
          TIME: 
            JSR TIME_SET
            iny
            cpy #2
            BNE ENTER_DT
            BRA END_DT
          
          
          END_DT:
              RTS

;------------------------------------------------------------------------
        
ADMIN:
    	   	movb #8, LCD_CUR
    		
    	    movb #15, WAIT
		      movb #0, LCD_VAL
			  
		     	movb #'E',disp
        	movb #'N',disp+1
          movb #'T',disp+2
        	movb #'E',disp+3
        	movb #'R',disp+4
        	movb #' ',disp+5
        	movb #'A',disp+6
        	movb #'D',disp+7
        	movb #'M',disp+8
        	movb #'I',disp+9
        	movb #'N',disp+10
        	movb #' ',disp+11
        	movb #'P',disp+12
        	movb #'A',disp+13
        	movb #'S',disp+14
        	movb #'S',disp+15
        	movb #'-',disp+16
        	movb #' ',disp+17
        	movb #' ',disp+18
        	movb #' ',disp+19
        	movb #' ',disp+20
        	movb #' ',disp+21
        	movb #' ',disp+22
        	movb #' ',disp+23
        	movb #' ',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #'-',disp+31
        	movb #0,disp+32      
        
        ldd #disp
        jsr display_string
        jsr ADMIN_SET
        RTS
           
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
		    
		    LDD #disp
		    jsr display_string
		    jsr SECRET_SET
		    RTS

;------------------------------------------------------------------
MAIN_MENU:
        
        JSR MAIN_MENU_SETUP
        JSR TIME_disp
        JSR DATE_disp
        
        movb #FLOOR_CUR, disp+15
        movb #FLOOR_DEST, disp+31
        ldd #disp
        jsr display_string
        
         
        RTS	    	
 
;------------------------------------------------------------------- 
 
 
 
  INPUT:
        
        psha			 ;saves value of A
        pshb
        ldaa LCD_CUR	 ;loads current location on LCD SCREEN
        ldab pressed
        BRSET INPUT_BLOCK, #$22, LEFT
        
  UP:     cmpb #$C		 ;checks if up pressed
        BNE DOWN		 ;if not continue
        cmpa #16		 ;check if LCD SCREEN is on upper 16 
        BLT INPUT_DONE	 ;if so then exit
        suba #16		 ;else add 16  store and exit
        staa LCD_CUR

        BRA INPUT_DONE
         
  DOWN:   cmpb #$E		 ;checks if down is pressed
        BNE LEFT		 ;if not then continue
        cmpa #16		 ;check if LCD SCREEN is on lower 16
        BGE INPUT_DONE	 ;if greater than then exit
        adda #16		 ;else subtract 16 save and exit 
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
        pulb      
	    pula 	
        RTS 
        