		XDEF WELCOME, DATE_TIME, ADMIN, SECRET, INPUT, MAIN_MENU ;Functions defined
		XDEF disp, LCD_CUR, LCD_VAL,  SYS_SETTINGS                              ;Variables defined
		
		XREF WAIT, keypadoutput, pressed, TIME_VAL, DATE_VAL, CARRY, You_Entered, CORRECT_SUBMENU
    XREF display_string, disp_loc, TIME_SET, DATE_SET, ADMIN_SET, SECRET_SET, EXIT
    XREF TIME_disp, DATE_disp, MAIN_MENU_SETUP, display_DATE_TIME_SET, disp_ADMIN, disp_SECRET_ID, disp_SECRET_PASS
    XREF TIME_INT
    XREF NEXT_FLOOR, stateofelevator, INFO_MENU_1, INFO_MENU_2, keypad, INFO_MENU_3, INFO_MENU_4, SYS_SET_MAIN_MEN_1, SYS_SET_MAIN_MEN_2
    XREF INFO_MENU_5, INFO_MENU_6, currentfloor, speaker,sound_flag 
    
LCD_RAM: section
disp: ds.b 33	  ;values to display the LCD
LCD_CUR: ds.b 1  ;Holds the current LCD display value
LCD_VAL: ds.b 1  ;Holds The value for flash on and off

number_to_ascii_convert: ds.b 1

;----------------------------------------------------------------------
CODE_LCD: SECTION
;This segment of the code only occurs upon the start up of the elevator		
WELCOME:
            movw #9999, WAIT		  ;Loads in value for interrupt
			    
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
        	
        WELCOME_WAIT:
          ldaa CARRY
          cmpa #1
          BNE WELCOME_WAIT
          movb #0, CARRY
          movb #0, WAIT
          
          JSR INFO_MENU_1
          JSR INFO_MENU_2
          JSR INFO_MENU_3
          JSR INFO_MENU_5
		  RTS
		
;------------------------------------------------------------------------
;This section of code intializes the Date and Time for the elevator to
;reference and display. You can enter C and E from the keypad which will
;go into a subroutine to move the kernal up and down until the push button
;is pressed. It then jumps to either date or time and then you set it from 
;there

DATE_TIME:
        JSR display_DATE_TIME_SET
        ldy #0
               
               movb #6, LCD_CUR
        	   JSR DATE_disp
        	   movb #22, LCD_CUR
        	   JSR TIME_disp 
        	   movb #0, LCD_CUR
        	   movb #'>', LCD_VAL
        	ENTER_DT:

        	  
             jsr keypadoutput
             ldaa pressed
             cmpa #$D
             BNE ENTER_DT_CONT
             jmp Exit_DT
             
           ENTER_DT_CONT:  
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
            
          DATE:               ;This the Date set sequence which goes to the DATE set and sets
            JSR DATE_SET
            JSR You_Entered
            JSR DATE_disp
            CLI
            
          Pause_D:
            ldaa CARRY
            cmpa #1
            BNE Pause_D
            movb #0, CARRY
            SEI
            
            JSR CORRECT_SUBMENU
            cpy #1
            BEQ DATE
               
            JSR EXIT
            cpy #1
            BEQ Exit_DT
            JSR display_DATE_TIME_SET
            movb #6, LCD_CUR
            JSR DATE_disp
            movb #22, LCD_CUR
            JSR TIME_disp
            movb #0, LCD_CUR
            movb #'>', LCD_VAL
            JMP ENTER_DT
            
          TIME:             ;This is the time set sequence which goes to the time set
            JSR TIME_SET
            JSR You_Entered
            JSR TIME_disp
            CLI
            
          Pause_T:
            ldaa CARRY
            cmpa #1
            BNE Pause_T
            movb #0, CARRY
            SEI
            
            JSR CORRECT_SUBMENU
            cpy #1
            BEQ TIME
            JSR EXIT
            cpy #1
            BEQ Exit_DT
            
            JSR display_DATE_TIME_SET
            movb #6, LCD_CUR
            JSR DATE_disp
            movb #22, LCD_CUR
            JSR TIME_disp
            movb #0, LCD_CUR
            movb #'>', LCD_VAL
            JMP ENTER_DT
           
           Exit_DT:
             ldaa TIME_VAL
             CMPA #'-'
             BEQ NO_EXIT_DT
             ldaa DATE_VAL
             cmpa #'-'
             BEQ NO_EXIT_DT
            RTS
          
		   NO_EXIT_DT:
		     JSR INFO_MENU_6
		     jmp DATE_TIME

;------------------------------------------------------------------------
;This is the top of the set admin password        	        
ADMIN:	  
        jsr ADMIN_SET
        JSR You_Entered
        JSR disp_ADMIN
        CLI
            
          Pause_A:
            ldaa CARRY
            cmpa #1
            BNE Pause_A
            movb #0, CARRY
            SEI
            
            JSR CORRECT_SUBMENU
            cpy #1
            BEQ ADMIN
        RTS
        
;-------------------------------------------------------------------------           
;This is the top of the set secret ID and Password
  SECRET:
		    jsr SECRET_SET
		    JSR You_Entered
        JSR disp_SECRET_ID
        JSR disp_SECRET_PASS
        CLI
            
          Pause_S:
            ldaa CARRY
            cmpa #1
            BNE Pause_S
            movb #0, CARRY
            SEI
            
            JSR CORRECT_SUBMENU
            cpy #1
            BEQ SECRET
          RTS
		    

;------------------------------------------------------------------
;This is the main of the main menu setup sequence which will display 
;most of the time
MAIN_MENU:
        
        JSR MAIN_MENU_SETUP
        
        movb #0, LCD_CUR
        JSR TIME_disp
        movb #16, LCD_CUR
        JSR DATE_disp
        
        ldab currentfloor
        addb #$31
        stab number_to_ascii_convert
        
        movb number_to_ascii_convert, disp+15
        
        ldab NEXT_FLOOR
        addb #$31
        stab number_to_ascii_convert
        
        movb number_to_ascii_convert, disp+31
        ldd #disp
        jsr display_string
        
         
        RTS	    	
 
;------------------------------------------------------------------- 
;The code below allows navigation through the system settings menu

SYS_SETTINGS:
    JSR INFO_MENU_4
    JSR SYS_SET_MAIN_MEN_1
	movb #0, LCD_CUR
    movb #'>', LCD_VAL
    
      SYS_SET_1:
        JSR keypadoutput
        ldaa LCD_CUR
        cmpa #16
        BNE SYS_SET_1_CONT
        ldaa pressed
        cmpa #$B
        BNE SYS_SET_1_CONT
        movb #0, LCD_CUR
        JSR SYS_SET_MAIN_MEN_2
        JMP SYS_SET_2
        
       SYS_SET_1_CONT:
         cmpa #$D
         BEQ SYS_SET_EXIT
         cmpa #$10
         BEQ SYS_SET_SEL_1a
         ldaa LCD_CUR
         JSR INPUT
                 
         KERNAl_2:     
             jsr disp_loc ; will change where the  '>' is
             ldab LCD_CUR
             staa LCD_CUR
             movb #' ', LCD_VAL ; changes to the current location of '>' to  ' '
             jsr disp_loc
             stab LCD_CUR
             movb #'>', LCD_VAL ; after '>' moves will set it to that position
             ldx #0
             bra SYS_SET_1  ; return to the top of DT_TI 
      
      SYS_SET_SEL_1a:
        ldaa LCD_CUR
        cmpa #0
        BNE SYS_SET_SEL_1b
        JSR DATE_TIME
        JSR SYS_SET_MAIN_MEN_1
        jmp SYS_SET_1
        
      SYS_SET_SEL_1b:
        JSR ADMIN
        JSR SYS_SET_MAIN_MEN_1
  		jmp SYS_SET_1
        
      SYS_SET_EXIT:
        RTS
          
      SYS_SET_2:
        JSR keypadoutput
        ldaa LCD_CUR
        cmpa #0
        BNE SYS_SET_2_CONT
        ldaa pressed
        cmpa #$A
        BNE SYS_SET_2_CONT
        movb #16, LCD_CUR
        JSR SYS_SET_MAIN_MEN_1
        jmp SYS_SET_1
        
        
       SYS_SET_2_CONT:
         cmpa #$D
         BEQ SYS_SET_EXIT
         cmpa #$10
         BEQ SYS_SET_SEL_2a
         ldaa LCD_CUR
         JSR INPUT
         
         
         KERNAl_3:     
             jsr disp_loc ; will change where the  '>' is
             ldab LCD_CUR
             staa LCD_CUR
             movb #' ', LCD_VAL ; changes to the current location of '>' to  ' '
             jsr disp_loc
             stab LCD_CUR
             movb #'>', LCD_VAL ; after '>' moves will set it to that position
             ldx #0
             bra SYS_SET_2  ; return to the top of DT_TI 
      
      SYS_SET_SEL_2a:
        ldaa LCD_CUR
        cmpa #0
        BNE SYS_SET_SEL_2b
        JSR SECRET_SET
        JSR SYS_SET_MAIN_MEN_2
        jmp SYS_SET_2
      SYS_SET_SEL_2b:
         jmp SYS_SET_EXIT
      
        
 
 
;-------------------------------------------------------------------------------------
  INPUT:
        
        psha			 ;saves value of A
        pshb
        ldaa LCD_CUR	 ;loads current location on LCD SCREEN
        ldab pressed
        
  UP:     cmpb #$A		 ;checks if up pressed
        BNE DOWN		 ;if not continue
        cmpa #16		 ;check if LCD SCREEN is on upper 16 
        BLT INPUT_DONE	 ;if so then exit
        suba #16		 ;else add 16  store and exit
        staa LCD_CUR
		ldy #1
        BRA INPUT_DONE
         
  DOWN:   cmpb #$B		 ;checks if down is pressed
        BNE INPUT_DONE		 ;if not then continue
        cmpa #16		 ;check if LCD SCREEN is on lower 16
        BGE INPUT_DONE	 ;if greater than then exit
        adda #16		 ;else subtract 16 save and exit 
        staa LCD_CUR
		ldy #1
        BRA INPUT_DONE
  
  INPUT_DONE:
  
  ENTER:
        cmpb #$10
        BNE INPUT_OVER
        ldx #1
  INPUT_OVER:
        pulb      
	    pula 	
        RTS 
        