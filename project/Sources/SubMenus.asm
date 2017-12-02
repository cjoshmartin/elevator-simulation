            xdef TIME_SUBMENU, DATE_SUBMENU, CORRECT_SUBMENU, SECRET_ID_SUBMENU, SECRET_PASS_SUBMENU
            xref disp, LCD_CUR
            xref display_string
            
            
SUBMENU_CODE: Section

    TIME_SUBMENU:
            psha
            pshb
            movb #11, LCD_CUR 
        
          movb #'E',disp        
       	 	movb #'n',disp+1
          movb #'t',disp+2
        	movb #'e',disp+3
        	movb #'r',disp+4
        	movb #' ',disp+5
        	movb #'T',disp+6
        	movb #'i',disp+7
        	movb #'m',disp+8
        	movb #'e',disp+9
        	movb #':',disp+10
        	movb #'-',disp+11
        	movb #'-',disp+12
        	movb #':',disp+13
        	movb #'-',disp+14
        	movb #'-',disp+15
        	movb #'A',disp+16
        	movb #'M',disp+17
        	movb #'?',disp+18
        	movb #'(',disp+19
        	movb #'C',disp+20
        	movb #')',disp+21
        	movb #' ',disp+22
        	movb #'P',disp+23
        	movb #'M',disp+24
        	movb #'?',disp+25
        	movb #'(',disp+26
        	movb #'D',disp+27
        	movb #')',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string            
        	
        	pulb
        	pula
       RTS
       
;-----------------------------------------------------------------------------

DATE_SUBMENU:

            psha
            pshb
            movb #17, LCD_CUR
    
    		movb #'E',disp        
       	 	movb #'n',disp+1
            movb #'t',disp+2
        	movb #'e',disp+3
        	movb #'r',disp+4
        	movb #' ',disp+5
        	movb #'T',disp+6
        	movb #'h',disp+7
        	movb #'e',disp+8
        	movb #' ',disp+9
        	movb #'D',disp+10
        	movb #'a',disp+11
        	movb #'t',disp+12
        	movb #'e',disp+13
        	movb #':',disp+14
        	movb #' ',disp+15
        	movb #' ',disp+16
        	movb #'-',disp+17
        	movb #'-',disp+18
        	movb #'/',disp+19
        	movb #'-',disp+20
        	movb #'-',disp+21
        	movb #'/',disp+22
        	movb #'-',disp+23
        	movb #'-',disp+24
        	movb #'-',disp+25
        	movb #'-',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string
       
            pulb
            pula
        rts
        
;------------------------------------------------------------------------------

SECRET_ID_SUBMENU:
         psha
         pshb
    	  	movb #'E',disp        
       	 	movb #'n',disp+1
          movb #'t',disp+2
        	movb #'e',disp+3
        	movb #'r',disp+4
        	movb #' ',disp+5
        	movb #'S',disp+6
        	movb #'e',disp+7
        	movb #'c',disp+8
        	movb #'r',disp+9
        	movb #'e',disp+10
        	movb #'t',disp+11
        	movb #' ',disp+12
        	movb #'I',disp+13
        	movb #'d',disp+14
        	movb #':',disp+15
        	movb #'*',disp+16
        	movb #'*',disp+17
        	movb #'*',disp+18
        	movb #'*',disp+19
        	movb #'*',disp+20
        	movb #'*',disp+21
        	movb #'*',disp+22
        	movb #'-',disp+23
        	movb #'-',disp+24
        	movb #'*',disp+25
        	movb #'*',disp+26
        	movb #'*',disp+27
        	movb #'*',disp+28
        	movb #'*',disp+29
        	movb #'*',disp+30
        	movb #'*',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string

         pulb
         pula
      RTS
      
;------------------------------------------------------------------------------

SECRET_PASS_SUBMENU:
         psha
         pshb
    		movb #'E',disp        ;remaining code loads in Welcome and startup
       	 	movb #'n',disp+1
            movb #'t',disp+2
        	movb #'e',disp+3
        	movb #'r',disp+4
        	movb #' ',disp+5
        	movb #'S',disp+6
        	movb #'e',disp+7
        	movb #'c',disp+8
        	movb #'.',disp+9
        	movb #' ',disp+10
        	movb #'P',disp+11
        	movb #'a',disp+12
        	movb #'s',disp+13
        	movb #'s',disp+14
        	movb #'.',disp+15
        	movb #'-',disp+16
        	movb #'-',disp+17
        	movb #'-',disp+18
        	movb #'-',disp+19
        	movb #'-',disp+20
        	movb #'-',disp+21
        	movb #'-',disp+22
        	movb #'-',disp+23
        	movb #'-',disp+24
        	movb #'-',disp+25
        	movb #'-',disp+26
        	movb #'-',disp+27
        	movb #'-',disp+28
        	movb #'-',disp+29
        	movb #'-',disp+30
        	movb #'-',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string

         pulb
         pula
      RTS

;---------------------------------------------------------------------------------                  
CORRECT_SUBMENU:
        
        psha
        pshb
        
            movb #'I',disp        
       	 	movb #'s',disp+1
            movb #' ',disp+2
        	movb #'T',disp+3
        	movb #'h',disp+4
        	movb #'a',disp+5
        	movb #'t',disp+6
        	movb #' ',disp+7
        	movb #'C',disp+8
        	movb #'o',disp+9
        	movb #'r',disp+10
        	movb #'r',disp+11
        	movb #'e',disp+12
        	movb #'c',disp+13
        	movb #'t',disp+14
        	movb #'?',disp+15
        	movb #'Y',disp+16
        	movb #'e',disp+17
        	movb #'s',disp+18
        	movb #'(',disp+19
        	movb #'a',disp+20
        	movb #')',disp+21
        	movb #' ',disp+22
        	movb #'N',disp+23
        	movb #'o',disp+24
        	movb #'(',disp+25
        	movb #'b',disp+26
        	movb #')',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string
        	
        pulb
        pula
        
        RTS	
               