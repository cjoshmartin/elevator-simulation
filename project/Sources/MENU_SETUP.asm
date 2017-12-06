 XDEF MAIN_MENU_SETUP, ADMIN_MENU_SETUP, display_DATE_TIME_SET, ERROR_MENU, SECRET_MENU_SETUP, SYS_SET_MAIN_MEN_1, SYS_SET_MAIN_MEN_2
    XDEF Floor_SEL_MENU, NEXT_FLOOR_MENU, ERROR_MENU
    
    XREF disp, LCD_VAL, LCD_CUR
    XREF display_string, display_admin




MENU_SETUP_CODE: SECTION

MAIN_MENU_SETUP:
        psha
        pshb
        
  		movb #' ',disp
       	movb #' ',disp+1
       	movb #':',disp+2
      	movb #' ',disp+3
       	movb #' ',disp+4
       	movb #' ',disp+5
       	movb #' ',disp+6
       	movb #' ',disp+7
       	movb #'F',disp+8
       	movb #'L',disp+9
       	movb #'O',disp+10
       	movb #'O',disp+11
       	movb #'R',disp+12
       	movb #':',disp+13
       	movb #' ',disp+14
       	movb #' ',disp+15
       	movb #' ',disp+16
       	movb #' ',disp+17
       	movb #'/',disp+18
       	movb #' ',disp+19
       	movb #' ',disp+20
       	movb #'/',disp+21
       	movb #' ',disp+22
       	movb #' ',disp+23
       	movb #' ',disp+24
       	movb #' ',disp+25
       	movb #' ',disp+26
       	movb #'T',disp+27
       	movb #'O',disp+28
       	movb #':',disp+29
      	movb #' ',disp+30
       	movb #' ',disp+31
       	movb #0,disp+32    
       	
       	ldd #disp
       	JSR display_string
       	pulb
       	pula
      RTS

;------------------------------------------------------------------

display_DATE_TIME_SET:
		psha
		pshb

		movb #0, LCD_CUR
		movb #'>', LCD_VAL
			
		movb #'>',disp
       	movb #'D',disp+1
       	movb #'A',disp+2
      	movb #'T',disp+3
       	movb #'E',disp+4
       	movb #':',disp+5
       	movb #'-',disp+6
       	movb #'-',disp+7
       	movb #'/',disp+8
       	movb #'-',disp+9
       	movb #'-',disp+10
       	movb #'/',disp+11
       	movb #'-',disp+12
       	movb #'-',disp+13
       	movb #'-',disp+14
       	movb #'-',disp+15
       	movb #' ',disp+16
       	movb #'T',disp+17
       	movb #'I',disp+18
       	movb #'M',disp+19
       	movb #'E',disp+20
       	movb #':',disp+21
       	movb #'-',disp+22
       	movb #'-',disp+23
       	movb #':',disp+24
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
;---------------------------------------------------------

ADMIN_MENU_SETUP:
    psha
    pshb
        movb #20, LCD_CUR
        
      	movb #'E',disp
       	movb #'n',disp+1
       	movb #'t',disp+2
      	movb #'e',disp+3
       	movb #'r',disp+4
       	movb #' ',disp+5
       	movb #'A',disp+6
       	movb #'d',disp+7
       	movb #'m',disp+8
       	movb #'i',disp+9
       	movb #'n',disp+10
       	movb #' ',disp+11
       	movb #'P',disp+12
       	movb #'a',disp+13
       	movb #'s',disp+14
       	movb #'s',disp+15
       	movb #'*',disp+16
       	movb #'*',disp+17
       	movb #'*',disp+18
       	movb #'*',disp+19
       	movb #'-',disp+20
       	movb #'-',disp+21
       	movb #'-',disp+22
       	movb #'-',disp+23
       	movb #'-',disp+24
       	movb #'-',disp+25
       	movb #'-',disp+26
       	movb #'-',disp+27
       	movb #'*',disp+28
       	movb #'*',disp+29
      	movb #'*',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32
       	
       	ldd #disp
       	JSR display_string
      pulb
      pula
      RTS
     
;-----------------------------------------------------------------       	
      
SECRET_MENU_SETUP:
    psha
    pshb
    
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
       	movb #'*',disp+10
       	movb #'*',disp+11
       	movb #'-',disp+12
       	movb #'-',disp+13
       	movb #'*',disp+14
       	movb #'*',disp+15
       	movb #'P',disp+16
       	movb #'A',disp+17
       	movb #'S',disp+18
       	movb #'S',disp+19
       	movb #':',disp+20
       	movb #'*',disp+21
       	movb #'-',disp+22
       	movb #'-',disp+23
       	movb #'-',disp+24
       	movb #'-',disp+25
       	movb #'-',disp+26
       	movb #'-',disp+27
       	movb #'-',disp+28
       	movb #'-',disp+29
      	movb #'*',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32
       	
       	ldd #disp
       	JSR display_string
       	
    pulb
    pula
    RTS   	      
    
;------------------------------------------------------------

Floor_SEL_MENU:

    psha
    pshb
    
        movb #'F',disp
       	movb #'L',disp+1
       	movb #'O',disp+2
      	movb #'O',disp+3
       	movb #'R',disp+4
       	movb #'(',disp+5
       	movb #'S',disp+6
       	movb #')',disp+7
       	movb #' ',disp+8
       	movb #'S',disp+9
       	movb #'E',disp+10
       	movb #'L',disp+11
       	movb #'E',disp+12
       	movb #'C',disp+13
       	movb #'T',disp+14
       	movb #':',disp+15
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
      	movb #'-',disp+30
       	movb #'-',disp+31
       	movb #0,disp+32
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS
      
;------------------------------------------------------------------          
;
NEXT_FLOOR_MENU:

    psha
    pshb
    
        movb #'N',disp
       	movb #'E',disp+1
       	movb #'X',disp+2
      	movb #'T',disp+3
       	movb #' ',disp+4
       	movb #'D',disp+5
       	movb #'E',disp+6
       	movb #'S',disp+7
       	movb #'T',disp+8
       	movb #'I',disp+9
       	movb #'N',disp+10
       	movb #'A',disp+11
       	movb #'T',disp+12
       	movb #'I',disp+13
       	movb #'O',disp+14
       	movb #'N',disp+15
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
      	movb #'-',disp+30
       	movb #' ',disp+31
       	movb #0,disp+32
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS
      
;---------------------------------------------------------------------

ERROR_MENU:

    psha
    pshb
    
        movb #'!',disp
       	movb #'!',disp+1
       	movb #'!',disp+2
      	movb #'!',disp+3
       	movb #'!',disp+4
       	movb #'E',disp+5
       	movb #'R',disp+6
       	movb #'R',disp+7
       	movb #'O',disp+8
       	movb #'R',disp+9
       	movb #'!',disp+10
       	movb #'!',disp+11
       	movb #'!',disp+12
       	movb #'!',disp+13
       	movb #'!',disp+14
       	movb #'!',disp+15
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
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS
      
;----------------------------------------------------------------------------------------

SYS_SET_MAIN_MEN_1:

    psha
    pshb
    
        movb #'>',disp
       	movb #'D',disp+1
       	movb #'A',disp+2
      	movb #'T',disp+3
       	movb #'E',disp+4
       	movb #'/',disp+5
       	movb #'T',disp+6
       	movb #'I',disp+7
       	movb #'M',disp+8
       	movb #'E',disp+9
       	movb #'*',disp+10
       	movb #'*',disp+11
       	movb #'*',disp+12
       	movb #'*',disp+13
       	movb #'*',disp+14
       	movb #'*',disp+15
       	movb #' ',disp+16
       	movb #'A',disp+17
       	movb #'D',disp+18
       	movb #'M',disp+19
       	movb #'I',disp+20
       	movb #'N',disp+21
       	movb #' ',disp+22
       	movb #'P',disp+23
       	movb #'A',disp+24
       	movb #'S',disp+25
       	movb #'S',disp+26
       	movb #'W',disp+27
       	movb #'O',disp+28
       	movb #'R',disp+29
      	movb #'D',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS
                 
;------------------------------------------------------------------------------------------

SYS_SET_MAIN_MEN_2:

    psha
    pshb
    
        movb #'>',disp
       	movb #'S',disp+1
       	movb #'E',disp+2
      	movb #'C',disp+3
       	movb #'R',disp+4
       	movb #'E',disp+5
       	movb #'T',disp+6
       	movb #' ',disp+7
       	movb #'I',disp+8
       	movb #'D',disp+9
       	movb #'/',disp+10
       	movb #'P',disp+11
       	movb #'A',disp+12
       	movb #'S',disp+13
       	movb #'S',disp+14
       	movb #'*',disp+15
       	movb #' ',disp+16
       	movb #'E',disp+17
       	movb #'x',disp+18
       	movb #'i',disp+19
       	movb #'t',disp+20
       	movb #' ',disp+21
       	movb #'S',disp+22
       	movb #'Y',disp+23
       	movb #'S',disp+24
       	movb #'.',disp+25
       	movb #' ',disp+26
       	movb #'S',disp+27
       	movb #'e',disp+28
       	movb #'t',disp+29
      	movb #'.',disp+30
       	movb #'*',disp+31
       	movb #0,disp+32
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS                 
                  