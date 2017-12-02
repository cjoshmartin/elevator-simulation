		XDEF WELCOME, DATE_TIME, ADMIN, SECRET, INPUT, MAIN_MENU
		XDEF disp, LCD_CUR, LCD_VAL
		
		XREF WAIT, keypadoutput, pressed, TIME_VAL, DATE_VAL  
        XREF display_string, disp_loc, TIME_SET, DATE_SET, ADMIN_SET, SECRET_SET
        XREF TIME_disp, DATE_disp, MAIN_MENU_SETUP, display_DATE_TIME_SET
    
LCD_RAM: section
disp: ds.b 33	  ;values to display the LCD
LCD_CUR: ds.b 1  ;Holds the current LCD display value
LCD_VAL: ds.b 1  ;Holds The value for flash on and off




;----------------------------------------------------------------------
CODE_LCD: SECTION
;This segment of the code only occurs upon the start up of the elevator		
WELCOME:
            movb #40, WAIT		  ;Loads in value for interrupt
			
		    movb #'W',disp        ;remaining code loads in Welcome and startup
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
        	
          ;WAI TIME_INT              ;waits for interrupt to occur
		  RTS
		
;------------------------------------------------------------------------
;This section of code intializes the Date and Time for the elevator to
;reference and display. You can enter C and E from the keypad which will
;go into a subroutine to move the kernal up and down until the push button
;is pressed. It then jumps to either date or time and then you set it from 
;there

DATE_TIME:
		movb #0, LCD_CUR
		movb #'>', LCD_VAL
			
       	JSR display_DATE_TIME_SET
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
             jsr disp_loc ; will change where the  '>' is
             ldab LCD_CUR
             staa LCD_CUR
             movb #' ', LCD_VAL ; changes to the current location of '>' to  ' '
             jsr disp_loc
             stab LCD_CUR
             movb #'>', LCD_VAL ; after '>' moves will set it to that position
             ldx #0
             bra ENTER_DT  ; return to the top of DT_TI
             
          DT_CONT:
            ldaa LCD_CUR
            cmpa #0
            BNE TIME
            
          DATE:
              
            JSR DATE_SET
            ldaa TIME_VAL
            cmpa #0
            BEQ ENTER_DT
            bra END_DT
          
          TIME: 
            JSR TIME_SET
            ldaa DATE_VAL
            cmpa #0
            BEQ ENTER_DT
            BRA END_DT
          
          
          END_DT:
              RTS

;------------------------------------------------------------------------
;This is the top of the set admin password        	        
ADMIN:	  
        jsr ADMIN_SET
        RTS
        
;-------------------------------------------------------------------------           
;This is the top of the set secret ID and Password
  SECRET:
		    jsr SECRET_SET
		    RTS

;------------------------------------------------------------------
;This is the main of the main menu setup sequence which will display 
;most of the time
MAIN_MENU:
        
        JSR MAIN_MENU_SETUP
        JSR TIME_disp
        JSR DATE_disp
        
       ;movb #FLOOR_CUR, disp+15
       ;movb #FLOOR_DEST, disp+31
        ldd #disp
        jsr display_string
        
         
        RTS	    	
 
;------------------------------------------------------------------- 
 
 
 
  INPUT:
        
        psha			 ;saves value of A
        pshb
        ldaa LCD_CUR	 ;loads current location on LCD SCREEN
        ldab pressed
        
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
        