     XDEF INFO_MENU_1, INFO_MENU_2
     XREF LCD_VAL, LCD_CUR, display_string, disp, TIME_INT, WAIT, CARRY
     
INFO_CODE: SECTION

INFO_MENU_1:
          movb #80, WAIT		  ;Loads in value for interrupt
			    
		      movb #'T',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
          movb #' ',disp+2
        	movb #'T',disp+3
        	movb #'o',disp+4
        	movb #'g',disp+5
        	movb #'g',disp+6
        	movb #'l',disp+7
        	movb #'e',disp+8
        	movb #' ',disp+9
        	movb #'U',disp+10
        	movb #'p',disp+11
        	movb #' ',disp+12
        	movb #'(',disp+13
        	movb #'c',disp+14
        	movb #')',disp+15
        	movb #'D',disp+16
        	movb #'o',disp+17
        	movb #'w',disp+18
        	movb #'n',disp+19
        	movb #' ',disp+20
        	movb #'(',disp+21
        	movb #'e',disp+22
        	movb #')',disp+23
        	movb #' ',disp+24
        	movb #'S',disp+25
        	movb #'e',disp+26
        	movb #'l',disp+27
        	movb #':',disp+28
        	movb #' ',disp+29
        	movb #'P',disp+30
        	movb #'B',disp+31
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
			    
		      movb #'F',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
          movb #'r',disp+2
        	movb #' ',disp+3
        	movb #'v',disp+4
        	movb #'a',disp+5
        	movb #'l',disp+6
        	movb #'u',disp+7
        	movb #'e',disp+8
        	movb #'s',disp+9
        	movb #' ',disp+10
        	movb #'-',disp+11
        	movb #' ',disp+12
        	movb #'H',disp+13
        	movb #'I',disp+14
        	movb #'T',disp+15
        	movb #'A',disp+16
        	movb #'n',disp+17
        	movb #'y',disp+18
        	movb #' ',disp+19
        	movb #'D',disp+20
        	movb #'i',disp+21
        	movb #'g',disp+22
        	movb #'i',disp+23
        	movb #'t',disp+24
        	movb #' ',disp+25
        	movb #'1',disp+26
        	movb #'-',disp+27
        	movb #'9',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
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