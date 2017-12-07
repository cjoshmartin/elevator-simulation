    XDEF INFO_MENU_1, INFO_MENU_2, INFO_MENU_3, INFO_MENU_4, INFO_MENU_5, INFO_MENU_6
     XREF LCD_VAL, LCD_CUR, display_string, disp, TIME_INT, WAIT, CARRY
     
INFO_CODE: SECTION

INFO_MENU_1:
            movw #8000, WAIT		  ;Loads in value for interrupt
			    
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
        	movb #'(',disp+11
        	movb #'A',disp+12
        	movb #')',disp+13
        	movb #' ',disp+14
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
        	movb #'w',disp+25
        	movb #'n',disp+26
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
          movw #8000, WAIT		  ;Loads in value for interrupt
			    
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
        	movb #' ',disp+26
        	movb #'0',disp+27
        	movb #'-',disp+28
        	movb #'9',disp+29
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
        
;-------------------------------------------------------------------------------

INFO_MENU_3:
          movw #8000, WAIT		  ;Loads in value for interrupt
			    
		    movb #'S',disp        ;remaining code loads in Welcome and startup
       	 	movb #'e',disp+1
            movb #'l',disp+2
        	movb #'e',disp+3
        	movb #'c',disp+4
        	movb #'t',disp+5
        	movb #'/',disp+6
        	movb #'E',disp+7
        	movb #'n',disp+8
        	movb #'t',disp+9
        	movb #'e',disp+10
        	movb #'r',disp+11
        	movb #' ',disp+12
        	movb #'T',disp+13
        	movb #'h',disp+14
        	movb #'e',disp+15
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
        
;--------------------------------------------------------------------------------

INFO_MENU_4:
            movw #8000, WAIT		  ;Loads in value for interrupt
			movb #0, CARRY
			    
		    movb #'S',disp        ;remaining code loads in Welcome and startup
       	 	movb #'y',disp+1
            movb #'s',disp+2
        	movb #'t',disp+3
        	movb #'e',disp+4
        	movb #'m',disp+5
        	movb #' ',disp+6
        	movb #'S',disp+7
        	movb #'e',disp+8
        	movb #'t',disp+9
        	movb #'t',disp+10
        	movb #'i',disp+11
        	movb #'n',disp+12
        	movb #'g',disp+13
        	movb #'s',disp+14
        	movb #' ',disp+15
        	movb #'H',disp+16
        	movb #'i',disp+17
        	movb #'t',disp+18
        	movb #' ',disp+19
        	movb #'P',disp+20
        	movb #'B',disp+21
        	movb #' ',disp+22
        	movb #'T',disp+23
        	movb #'o',disp+24
        	movb #' ',disp+25
        	movb #'C',disp+26
        	movb #'h',disp+27
        	movb #'a',disp+28
        	movb #'n',disp+29
        	movb #'g',disp+30
        	movb #'e',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	
        	CLI
       	IM4_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM4_WAIT
          movb #0, CARRY
          movb #0, WAIT
            
        RTS 
        
;--------------------------------------------------------------------------------

INFO_MENU_5:
            movw #8000, WAIT		  ;Loads in value for interrupt
			    
		    movb #'T',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
            movb #' ',disp+2
        	movb #'g',disp+3
        	movb #'o',disp+4
        	movb #' ',disp+5
        	movb #'B',disp+6
        	movb #'a',disp+7
        	movb #'c',disp+8
        	movb #'k',disp+9
        	movb #' ',disp+10
        	movb #'E',disp+11
        	movb #'n',disp+12
        	movb #'t',disp+13
        	movb #'e',disp+14
        	movb #'r',disp+15
        	movb #'(',disp+16
        	movb #'D',disp+17
        	movb #')',disp+18
        	movb #' ',disp+19
        	movb #'I',disp+20
        	movb #'n',disp+21
        	movb #' ',disp+22
        	movb #'K',disp+23
        	movb #'e',disp+24
        	movb #'y',disp+25
        	movb #'p',disp+26
        	movb #'a',disp+27
        	movb #'d',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	
        	CLI
       	IM5_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM5_WAIT
          movb #0, CARRY
          movb #0, WAIT
          SEI  
        RTS
        
;------------------------------------------------------------------------------

INFO_MENU_6:
            movw #8000, WAIT		  ;Loads in value for interrupt
			    
		    movb #'Y',disp        ;remaining code loads in Welcome and startup
       	 	movb #'o',disp+1
            movb #'u',disp+2
        	movb #' ',disp+3
        	movb #'M',disp+4
        	movb #'u',disp+5
        	movb #'s',disp+6
        	movb #'t',disp+7
        	movb #' ',disp+8
        	movb #'E',disp+9
        	movb #'n',disp+10
        	movb #'t',disp+11
        	movb #'e',disp+12
        	movb #'r',disp+13
        	movb #' ',disp+14
        	movb #'A',disp+15
        	movb #'V',disp+16
        	movb #'a',disp+17
        	movb #'l',disp+18
        	movb #'u',disp+19
        	movb #'e',disp+20
        	movb #' ',disp+21
        	movb #'i',disp+22
        	movb #'n',disp+23
        	movb #'t',disp+24
        	movb #'o',disp+25
        	movb #' ',disp+26
        	movb #'D',disp+27
        	movb #'T',disp+28
        	movb #'/',disp+29
        	movb #'T',disp+30
        	movb #'I',disp+31
        	movb #0,disp+32 
        	
        	ldd #disp
        	JSR display_string
        	CLI
        	
       	IM6_WAIT:
          ldaa CARRY
          cmpa #1
          BNE IM6_WAIT
          movb #0, CARRY
          movb #0, WAIT
          SEI  
        RTS                                           