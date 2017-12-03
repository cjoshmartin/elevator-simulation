    XDEF INFO_MENU_1, INFO_MENU_2, INFO_MENU_3
     XREF LCD_VAL, LCD_CUR, display_string, disp, TIME_INT, WAIT, CARRY

;----------------------------------------------------------------------
;This section of code holds the information used to operate the elevator


     
INFO_CODE: SECTION

INFO_MENU_1:
          movb #80, WAIT		  ;Loads in value for interrupt
			    
		    movb #'T',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
            movb #' ',disp+2
        	movb #'M',disp+3
        	movb #'o',disp+4
        	movb #'v',disp+5
        	movb #'e',disp+6
        	movb #' ',disp+7
        	movb #'U',disp+8
        	movb #'p',disp+9
        	movb #' ',disp+10
        	movb #' ',disp+11
        	movb #'(',disp+12
        	movb #'A',disp+13
        	movb #')',disp+14
        	movb #' ',disp+15
        	movb #'T',disp+16
        	movb #'o',disp+17
        	movb #' ',disp+18
        	movb #'M',disp+19
        	movb #'o',disp+20
        	movb #'v',disp+21
        	movb #'e',disp+22
        	movb #' ',disp+23
        	movb #'D',disp+24
        	movb #'W',disp+25
        	movb #'N',disp+26
        	movb #' ',disp+27
        	movb #'(',disp+28
        	movb #'B',disp+29
        	movb #')',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	
        	CLI
        	IM1_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM1_WAIT
          movb #0, CARRY
          movb #0, WAIT
          SEI
          
        RTS    
        
;---------------------------------------------------------------------------

INFO_MENU_2:
          movb #80, WAIT		  ;Loads in value for interrupt
			    
		    movb #'T',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
            movb #' ',disp+2
        	movb #'E',disp+3
        	movb #'n',disp+4
        	movb #'t',disp+5
        	movb #'e',disp+6
        	movb #'r',disp+7
        	movb #' ',disp+8
        	movb #'I',disp+9
        	movb #'n',disp+10
        	movb #'f',disp+11
        	movb #'o',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #'U',disp+16
        	movb #'s',disp+17
        	movb #'e',disp+18
        	movb #' ',disp+19
        	movb #'K',disp+20
        	movb #'e',disp+21
        	movb #'y',disp+22
        	movb #'p',disp+23
        	movb #'a',disp+24
        	movb #'d',disp+25
        	movb #':',disp+26
        	movb #' ',disp+27
        	movb #'1',disp+28
        	movb #'-',disp+29
        	movb #'9',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	
        	CLI
        	IM2_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM2_WAIT
          movb #0, CARRY
          movb #0, WAIT
          SEI
          
        RTS 
        
;-------------------------------------------------------------------------------------

INFO_MENU_3:
          movb #80, WAIT		  ;Loads in value for interrupt
			    
		    movb #'T',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
            movb #' ',disp+2
        	movb #'S',disp+3
        	movb #'e',disp+4
        	movb #'l',disp+5
        	movb #'e',disp+6
        	movb #'c',disp+7
        	movb #'t',disp+8
        	movb #'/',disp+9
        	movb #'E',disp+10
        	movb #'n',disp+11
        	movb #'t',disp+12
        	movb #'e',disp+13
        	movb #'r',disp+14
        	movb #' ',disp+15
        	movb #'F',disp+16
        	movb #'l',disp+17
        	movb #'o',disp+18
        	movb #'o',disp+19
        	movb #'r',disp+20
        	movb #' ',disp+21
        	movb #'H',disp+22
        	movb #'i',disp+23
        	movb #'t',disp+24
        	movb #' ',disp+25
        	movb #'P',disp+26
        	movb #'s',disp+27
        	movb #'h',disp+28
        	movb #'B',disp+29
        	movb #'t',disp+30
        	movb #'n',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	
        	CLI
        	IM3_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM3_WAIT
          movb #0, CARRY
          movb #0, WAIT
          SEI
          
        RTS                   