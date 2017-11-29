    XDEF MAIN_MENU_SETUP,ADMIN_MENU_SETUP
    XREF disp
    XREF display_string




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

;---------------------------------------------------------

ADMIN_MENU_SETUP:
    psha
    pshb
    
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
       	
       	LDD #disp
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
       	movb #' ',disp+10
       	movb #' ',disp+11
       	movb #' ',disp+12
       	movb #' ',disp+13
       	movb #'-',disp+14
       	movb #'-',disp+15
       	movb #'P',disp+16
       	movb #'A',disp+17
       	movb #'S',disp+18
       	movb #'S',disp+19
       	movb #':',disp+20
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
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS
      
;------------------------------------------------------------------          

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
       	movb #'-',disp+17
       	movb #'-',disp+18
       	movb #'-',disp+19
       	movb #'-',disp+20
       	movb #'-',disp+21
       	movb #'-',disp+22
       	movb #' ',disp+23
       	movb #' ',disp+24
       	movb #'-',disp+25
       	movb #'-',disp+26
       	movb #'-',disp+27
       	movb #'-',disp+28
       	movb #'-',disp+29
      	movb #'-',disp+30
       	movb #'-',disp+31
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

SYS_SET_MAIN_MENU:

    psha
    pshb
    
        movb #'>',disp
       	movb #'D',disp+1
       	movb #'T',disp+2
      	movb #'/',disp+3
       	movb #'T',disp+4
       	movb #'I',disp+5
       	movb #' ',disp+6
       	movb #' ',disp+7
       	movb #' ',disp+8
       	movb #'A',disp+9
       	movb #'D',disp+10
       	movb #'M',disp+11
       	movb #'I',disp+12
       	movb #'N',disp+13
       	movb #' ',disp+14
       	movb #' ',disp+15
       	movb #' ',disp+16
       	movb #'S',disp+17
       	movb #'E',disp+18
       	movb #'C',disp+19
       	movb #' ',disp+20
       	movb #'I',disp+21
       	movb #'D',disp+22
       	movb #' ',disp+23
       	movb #' ',disp+24
       	movb #'S',disp+25
       	movb #'E',disp+26
       	movb #'C',disp+27
       	movb #' ',disp+28
       	movb #'P',disp+29
      	movb #'A',disp+30
       	movb #'S',disp+31
       	movb #0,disp+32
       	
       	LDD #disp
       	JSR display_string
       	
      pulb
      pula
      RTS            