   xdef TIME_SUBMENU, DATE_SUBMENU, CORRECT_SUBMENU, SECRET_ID_SUBMENU, SECRET_PASS_SUBMENU, You_Entered, EXIT, ERROR_DOOR
            xdef FLOOR_ENTRY, FLOOR_DEST, secret_sel_menu
            xref disp, LCD_CUR, TIME_VAL, DATE_VAL, keypadoutput, pressed, flag
            xref display_string
            xref TIME_INT, WAIT, CARRY
            XDEF CORRECT_ADM_PASS, INCORRECT_INPUT, Go_Up, Go_Down
            
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
        	movb #'E',disp+27
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
        	movb #'C',disp+20
        	movb #')',disp+21
        	movb #' ',disp+22
        	movb #'N',disp+23
        	movb #'o',disp+24
        	movb #'(',disp+25
        	movb #'E',disp+26
        	movb #')',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldd #disp
        	jsr display_string
      
      Answer:  	
        	JSR keypadoutput
        	ldaa pressed
        	
        	
        Correct:
           cmpa #$C
           BNE Incorrect	
           pulb
           pula
        RTS
        
        Incorrect:
           cmpa #$E
           BNE Answer
           pulb
           pula
           ldy #1
         RTS  
        	       
;----------------------------------------------------------------------------------
You_Entered:

  pshd
           
            movb #'Y',disp        
       		movb #'o',disp+1
            movb #'u',disp+2
        	movb #' ',disp+3
        	movb #'E',disp+4
        	movb #'n',disp+5
        	movb #'t',disp+6
        	movb #'e',disp+7
        	movb #'r',disp+8
        	movb #'e',disp+9
        	movb #'d',disp+10
        	movb #':',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #' ',disp+16
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
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	       	
  puld      	
  RTS      	
  
;-----------------------------------------------------------

EXIT:

        pshd
          movb #16, LCD_CUR
           
            movb #'A',disp        
       		movb #'r',disp+1
            movb #'e',disp+2
        	movb #' ',disp+3
        	movb #'Y',disp+4
        	movb #'o',disp+5
        	movb #'u',disp+6
        	movb #' ',disp+7
        	movb #'d',disp+8
        	movb #'o',disp+9
        	movb #'n',disp+10
        	movb #'e',disp+11
        	movb #'?',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #' ',disp+16
        	movb #'Y',disp+17
        	movb #'e',disp+18
        	movb #'s',disp+19
        	movb #' ',disp+20
        	movb #'(',disp+21
        	movb #'C',disp+22
        	movb #')',disp+23
        	movb #' ',disp+24
        	movb #'N',disp+25
        	movb #'o',disp+26
        	movb #' ',disp+27
        	movb #'(',disp+28
        	movb #'E',disp+29
        	movb #')',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        
          ldd #disp
        	jsr display_string
      
      Answer_E:  	
        	JSR keypadoutput
        	ldaa pressed
        	
        	
        Exit_Prog:
           cmpa #$C
           BNE Cont_Prog	
           pulb
           pula
           ldy #1
        RTS
        
        Cont_Prog:
           cmpa #$E
           BNE Answer_E
           pulb
           pula
           
         RTS
         
;-------------------------------------------------------------------------

CORRECT_ADM_PASS:

            pshd
           
            movb #'Y',disp        
       		movb #'o',disp+1
            movb #'u',disp+2
        	movb #' ',disp+3
        	movb #'E',disp+4
        	movb #'n',disp+5
        	movb #'t',disp+6
        	movb #'e',disp+7
        	movb #'r',disp+8
        	movb #'e',disp+9
        	movb #'d',disp+10
        	movb #' ',disp+11
        	movb #'T',disp+12
        	movb #'h',disp+13
        	movb #'e',disp+14
        	movb #' ',disp+15
        	movb #'C',disp+16
        	movb #'o',disp+17
        	movb #'d',disp+18
        	movb #'e',disp+19
        	movb #' ',disp+20
        	movb #'W',disp+21
        	movb #'i',disp+22
        	movb #'s',disp+23
        	movb #'e',disp+24
        	movb #'l',disp+25
        	movb #'y',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        
            ldd #disp
        	jsr display_string
        	
        	JSR keypadoutput
       puld
       RTS
       
;-----------------------------------------------------------------------

INCORRECT_INPUT:

          pshd
           
            movb #'S',disp        
       		movb #'o',disp+1
            movb #'r',disp+2
        	movb #'r',disp+3
        	movb #'y',disp+4
        	movb #' ',disp+5
        	movb #'A',disp+6
        	movb #'c',disp+7
        	movb #'c',disp+8
        	movb #'e',disp+9
        	movb #'s',disp+10
        	movb #'s',disp+11
        	movb #' ',disp+12
        	movb #'i',disp+13
        	movb #'s',disp+14
        	movb #' ',disp+15
        	movb #'O',disp+16
        	movb #'n',disp+17
        	movb #'l',disp+18
        	movb #'y',disp+19
        	movb #' ',disp+20
        	movb #'F',disp+21
        	movb #'o',disp+22
        	movb #'r',disp+23
        	movb #' ',disp+24
        	movb #'T',disp+25
        	movb #'h',disp+26
        	movb #'e',disp+27
        	movb #' ',disp+28
        	movb #'F',disp+29
        	movb #'e',disp+30
        	movb #'w',disp+31
        	movb #0,disp+32
        
            ldd #disp
        	jsr display_string 
        	
        	JSR keypadoutput
        	puld
       RTS
       
;------------------------------------------------------------------------------       
        	    
ERROR_DOOR:
        pshd
        
  		movb #' ',disp
       	movb #' ',disp+1
       	movb #'P',disp+2
      	movb #'L',disp+3
       	movb #'E',disp+4
       	movb #'A',disp+5
       	movb #'S',disp+6
       	movb #'E',disp+7
       	movb #' ',disp+8
       	movb #'C',disp+9
       	movb #'L',disp+10
       	movb #'O',disp+11
       	movb #'S',disp+12
       	movb #'E',disp+13
       	movb #' ',disp+14
       	movb #' ',disp+15
       	movb #' ',disp+16
       	movb #' ',disp+17
       	movb #' ',disp+18
       	movb #'T',disp+19
       	movb #'H',disp+20
       	movb #'E',disp+21
       	movb #' ',disp+22
       	movb #'D',disp+23
       	movb #'O',disp+24
       	movb #'O',disp+25
       	movb #'R',disp+26
       	movb #'!',disp+27
       	movb #' ',disp+28
       	movb #' ',disp+29
      	movb #' ',disp+30
       	movb #' ',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       	puld
      RTS
      
;-------------------------------------------------------------------------------------

FLOOR_ENTRY:

        pshd
        
  		movb #'Y',disp
       	movb #'o',disp+1
       	movb #'u',disp+2
      	movb #' ',disp+3
       	movb #'C',disp+4
       	movb #'h',disp+5
       	movb #'o',disp+6
       	movb #'s',disp+7
       	movb #'e',disp+8
       	movb #' ',disp+9
       	movb #'F',disp+10
       	movb #'l',disp+11
       	movb #'o',disp+12
       	movb #'o',disp+13
       	movb #'r',disp+14
       	movb #'s',disp+15
       	movb #'-',disp+16
       	movb #' ',disp+17
       	movb #'-',disp+18
       	movb #' ',disp+19
       	movb #'-',disp+20
       	movb #' ',disp+21
       	movb #'-',disp+22
       	movb #' ',disp+23
       	movb #'-',disp+24
       	movb #' ',disp+25
       	movb #'-',disp+26
       	movb #' ',disp+27
       	movb #'-',disp+28
       	movb #' ',disp+29
      	movb #' ',disp+30
       	movb #' ',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       
       	puld
      RTS
      
;----------------------------------------------------------------------------------- 

FLOOR_DEST:
		 pshd
        
        movw #8000, WAIT
        movb #0, CARRY
  		movb #'Y',disp
       	movb #'o',disp+1
       	movb #'u',disp+2
      	movb #' ',disp+3
       	movb #'H',disp+4
       	movb #'a',disp+5
       	movb #'v',disp+6
       	movb #'e',disp+7
       	movb #' ',disp+8
       	movb #'R',disp+9
       	movb #'e',disp+10
       	movb #'a',disp+11
       	movb #'c',disp+12
       	movb #'h',disp+13
       	movb #'e',disp+14
       	movb #'d',disp+15
       	movb #'F',disp+16
       	movb #'l',disp+17
       	movb #'o',disp+18
       	movb #'o',disp+19
       	movb #'r',disp+20
       	movb #':',disp+21
       	movb #'*',disp+22
       	movb #'*',disp+23
       	movb #'*',disp+24
       	movb #'*',disp+25
       	movb #'0',disp+26
       	movb #'-',disp+27
       	movb #'*',disp+28
       	movb #'*',disp+29
      	movb #'*',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       
       Down_WAIT:
          ldaa CARRY
          cmpa #1
          BNE Down_WAIT
       
       	puld
      RTS 
      
;----------------------------------------------------------------------------------- 

Go_Up:
	pshd
        movb #0, flag
        
  		movb #'G',disp
       	movb #'o',disp+1
       	movb #'i',disp+2
      	movb #'n',disp+3
       	movb #'g',disp+4
       	movb #' ',disp+5
       	movb #'U',disp+6
       	movb #'p',disp+7
       	movb #' ',disp+8
       	movb #'T',disp+9
       	movb #'o',disp+10
       	movb #' ',disp+11
       	movb #'T',disp+12
       	movb #'h',disp+13
       	movb #'e',disp+14
       	movb #' ',disp+15
       	movb #'F',disp+16
       	movb #'l',disp+17
       	movb #'o',disp+18
       	movb #'o',disp+19
       	movb #'r',disp+20
       	movb #':',disp+21
       	movb #'*',disp+22
       	movb #'*',disp+23
       	movb #'*',disp+24
       	movb #'*',disp+25
       	movb #'0',disp+26
       	movb #'-',disp+27
       	movb #'*',disp+28
       	movb #'*',disp+29
      	movb #'*',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       	
        JSR keypadoutput  
       	puld
      RTS 
      
;----------------------------------------------------------------------------------- 

Go_Down:
	pshd
        
  		movb #'G',disp
       	movb #'o',disp+1
       	movb #'i',disp+2
      	movb #'n',disp+3
       	movb #'g',disp+4
       	movb #' ',disp+5
       	movb #'D',disp+6
       	movb #'o',disp+7
       	movb #'w',disp+8
       	movb #'n',disp+9
       	movb #' ',disp+10
       	movb #'T',disp+11
       	movb #'o',disp+12
       	movb #' ',disp+13
       	movb #' ',disp+14
       	movb #' ',disp+15
       	movb #'F',disp+16
       	movb #'l',disp+17
       	movb #'o',disp+18
       	movb #'o',disp+19
       	movb #'r',disp+20
       	movb #':',disp+21
       	movb #'*',disp+22
       	movb #'*',disp+23
       	movb #'*',disp+24
       	movb #'*',disp+25
       	movb #'0',disp+26
       	movb #'-',disp+27
       	movb #'*',disp+28
       	movb #'*',disp+29
      	movb #'*',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       
       	puld
      RTS 
      
;---------------------------------------------------------------------------------

secret_sel_menu:
	    pshd
        
  		movb #'C',disp
       	movb #'h',disp+1
       	movb #'n',disp+2
      	movb #'g',disp+3
       	movb #' ',disp+4
       	movb #'W',disp+5
       	movb #'h',disp+6
       	movb #'i',disp+7
       	movb #'c',disp+8
       	movb #'h',disp+9
       	movb #' ',disp+10
       	movb #'S',disp+11
       	movb #'c',disp+12
       	movb #'r',disp+13
       	movb #'t',disp+14
       	movb #'?',disp+15
       	movb #'1',disp+16
       	movb #'(',disp+17
       	movb #'1',disp+18
       	movb #')',disp+19
       	movb #' ',disp+20
       	movb #'2',disp+21
       	movb #'(',disp+22
       	movb #'2',disp+23
       	movb #')',disp+24
       	movb #' ',disp+25
       	movb #'3',disp+26
       	movb #'(',disp+27
       	movb #'3',disp+28
       	movb #')',disp+29
      	movb #' ',disp+30
       	movb #' ',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       
       	puld
      RTS                        