		XDEF LCD
		XREF WAIT, CARRY, KEY, KEYPAD


MY_VAR: SECTION
LCD_CUR: ds.b $1  ;Holds the current LCD display value
LCD_VAL: ds.b $1  ;Holds The value for flash on and off
disp: ds.b 33	  ;values to display the LCD
WEL: ds.b $1	  ;Welcome Subroutine value

LCD: 
		
		JSR WELCOME
		
		BEG_LCD:
		
		JSR DT-TI
		
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
        	
            ldaa #CARRY				;checks and sees if wait is done
            cmpa #1
            BNE WELCOME
            movb #0, CARRY
            movb #1, WEL			;turns off welcome loop
		RTS
		
		DT-TI:
			JSR INITIALIZE_LCD
			
			movb #15, WAIT
			movb #'>', LCD_VAL
			
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
        	
        	ENTER_DT:
        	  JSR KEYPAD
        	  ldaa #KEY
        	  cmpa #0
        	  BEQ FLASH
        	  JSR INPUT
        	  BRA DT_INPUT
        	  
            FLASH:
              ldaa CARRY
              cmpa #1
              BEQ LCD_ON
            
            LCD_OFF: 
              movb #178,disp+LCD_CUR
              bra ENTER_DT
            
            LCD_ON:
              ldaa #disp+LCD_CUR
              staa LCD_VAL
              movb #LCD_VAL,disp+LCD_CUR
              bra ENTER_DT
              
            DT_INPUT:
              ldaa #LCD_CUR
              cmpa #16
              
               
            TI:
        
        
        
        
        
        
        
        
        INPUT:
        psha			 ;saves value of A
        ldaa LCD_CUR	 ;loads current location on LCD SCREEN
UP:     cmpa #$C		 ;checks if up pressed
        BNE DOWN		 ;if not continue
        cmpa #16		 ;check if LCD SCREEN is on upper 16 
        BLE INPUT_DONE	 ;if so then exit
        adda #16		 ;else add 16  store and exit
        staa LCD_CUR	 
        BRA INPUT_DONE
         
DOWN:   cmpa #$E		 ;checks if down is pressed
        BNE LEFT		 ;if not then continue
        cmpa #16		 ;check if LCD SCREEN is on lower 16
        BGE INPUT_DONE	 ;if greater than then exit
        suba #16		 ;else subtract 16 save and exit 
        staa LCD_CUR
        BRA INPUT_DONE
           
LEFT:   cmpa #$A		  ;checks and see if left
        BNE	 RIGHT		  ;if not then continue
        cmpa #0			  ;compare it to 0 and 16 to see if it is already all the way to the left if so then branch
        BEQ	 INPUT_DONE	  
        cmpa #16
        BEQ	 INPUT_DONE
        deca			  ;if not then decrement and store
        staa LCD_CUR
        bra INPUT_DONE
      
RIGHT:  cmpa #$B		  ;check and see if right is pressed and if not continue
        BNE INPUT_DONE	  
        cmpa #15		  ;compare it to 15 and 31 to see if it is already all the way to the right if so then branch
        BEQ INPUT_DONE	  
        cmpa #31
        adda #1			  ;if not then add one to shift it right and save
        staa LCD_CUR
        bra INPUT_DONE
        
enter:  cmpa#$0
        BNE INPUT_DONE
        
INPUT_DONE:
		pula
        RTS   