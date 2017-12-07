          XDEF SECRET_SET_1, SECRET_ID_1, SECRET_PASS_1, disp_SECRET_ID_1, disp_SECRET_PASS_1
          XDEF SECRET_SET_2, SECRET_ID_2, SECRET_PASS_2, disp_SECRET_ID_2, disp_SECRET_PASS_2
          XDEF SECRET_SET_3, SECRET_ID_3, SECRET_PASS_3, disp_SECRET_ID_3, disp_SECRET_PASS_3
          
          XREF pressed, LCD_VAL, LCD_CUR
          XREF disp_loc, keypadoutput, INPUT, SECRET_MENU_SETUP
SECRET_RAM: section          
SECRET_ID_1: ds.b $2
SECRET_PASS_1: ds.b $8
SECRET_ID_2: ds.b $2
SECRET_PASS_2: ds.b $8
SECRET_ID_3: ds.b $2
SECRET_PASS_3: ds.b $8


SECRET_CODE: section
SECRET_SET_1:
   	JSR SECRET_MENU_SETUP
   	pshx
    ldx #SECRET_ID_1
    clr pressed
    
    movb #12, LCD_CUR
    SECRET_ID_SET_1:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_ID_SET_1
      
      JSR INPUT
      cpy #1
      BEQ SECRET_ID_SET_1  
      
      
      SECRET_ID_CON_1:
      adda #48
      staa LCD_VAL
      staa pressed
      
        ldaa LCD_CUR  
        SECRET_ID_CON_1_1:
          cmpa #11
          BGT SECRET_ID_CON_2_1
          movb #12, LCD_CUR
                    
        SECRET_ID_CON_2_1:
          cmpa #14
          BLT SECRET_ID_CONF_1
          movb #22, LCD_CUR
          clr pressed
          ldx #SECRET_PASS_1
          BRA SECRET_PASS_SET_1
             
      SECRET_ID_CONF_1:
        JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #14
         BEQ SECRET_ID_CON_2_1
        BRA SECRET_ID_SET_1
        
;-------------------------------------------------------------        
 
    SECRET_PASS_SET_1:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_PASS_SET_1
      
      JSR INPUT
      cpy #1
      BEQ SECRET_PASS_SET_1
      
      SECRET_PASS_CON_1:
        adda #48
        staa LCD_VAL
        staa pressed
        
        ldaa LCD_CUR
        SECRET_PASS_CON_1_1:
          cmpa #21
          BGT SECRET_PASS_CON_2_1
          movb #22, LCD_CUR
                    
        SECRET_PASS_CON_2_1:
          cmpa #30
          BLT SECRET_PASS_CONF_1
          movb #0, LCD_VAL
          movb #0, LCD_CUR
          pulx
          RTS
          
             
      SECRET_PASS_CONF_1:
        JSR disp_loc
        ldaa pressed       
        staa 1,x+     
        ldaa LCD_CUR
        inca   
        staa LCD_CUR
        cmpa #30
        BEQ SECRET_PASS_CON_2_1
         
        BRA SECRET_PASS_SET_1
        
        
;------------------------------------------------

disp_SECRET_ID_1:        
  LDX #SECRET_ID_1
  ldab LCD_CUR
  ldy #0
  SECRET_disp_L1_1:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_1_1:
    cpy #1 
    BNE SECRET_disp_CON_2_1
    RTS
    
    SECRET_disp_CON_2_1:
    iny
    bra SECRET_disp_L1_1
    
;--------------------------------------------------

disp_SECRET_PASS_1:
  ldab LCD_CUR
  addb #2
  stab LCD_CUR
  LDX #SECRET_PASS_1
  ldy #0
  
  SECRET_disp_L2_1:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_3_1:
    cpy #7 
    BNE SECRET_disp_CON_4_1
    RTS
    
    SECRET_disp_CON_4_1:
    iny
    bra SECRET_disp_L2_1
    
;-------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------

SECRET_SET_2:
   	JSR SECRET_MENU_SETUP
   	pshx
    ldx #SECRET_ID_2
    clr pressed
    
    movb #12, LCD_CUR
    SECRET_ID_SET_2:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_ID_SET_2
      
      JSR INPUT
      cpy #1
      BEQ SECRET_ID_SET_2  
      
      
      SECRET_ID_CON_2:
      adda #48
      staa LCD_VAL
      staa pressed
      
        ldaa LCD_CUR  
        SECRET_ID_CON_1_2:
          cmpa #11
          BGT SECRET_ID_CON_2_2
          movb #12, LCD_CUR
                    
        SECRET_ID_CON_2_2:
          cmpa #14
          BLT SECRET_ID_CONF_2
          movb #22, LCD_CUR
          clr pressed
          ldx #SECRET_PASS_2
          BRA SECRET_PASS_SET_2
             
      SECRET_ID_CONF_2:
        JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #14
         BEQ SECRET_ID_CON_2_2
        BRA SECRET_ID_SET_2
        
;-------------------------------------------------------------        
 
    SECRET_PASS_SET_2:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_PASS_SET_2
      
      JSR INPUT
      cpy #1
      BEQ SECRET_PASS_SET_2
      
      SECRET_PASS_CON_2:
        adda #48
        staa LCD_VAL
        staa pressed
        
        ldaa LCD_CUR
        SECRET_PASS_CON_1_2:
          cmpa #21
          BGT SECRET_PASS_CON_2_2
          movb #22, LCD_CUR
                    
        SECRET_PASS_CON_2_2:
          cmpa #30
          BLT SECRET_PASS_CONF_2
          movb #0, LCD_VAL
          movb #0, LCD_CUR
          pulx
          RTS
          
             
      SECRET_PASS_CONF_2:
        JSR disp_loc
        ldaa pressed       
        staa 1,x+     
        ldaa LCD_CUR
        inca   
        staa LCD_CUR
        cmpa #30
        BEQ SECRET_PASS_CON_2_2
         
        BRA SECRET_PASS_SET_2
        
        
;------------------------------------------------

disp_SECRET_ID_2:        
  LDX #SECRET_ID_2
  ldab LCD_CUR
  ldy #0
  SECRET_disp_L1_2:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_1_2:
    cpy #1 
    BNE SECRET_disp_CON_2_2
    RTS
    
    SECRET_disp_CON_2_2:
    iny
    bra SECRET_disp_L1_2
    
;--------------------------------------------------

disp_SECRET_PASS_2:
  ldab LCD_CUR
  addb #2
  stab LCD_CUR
  LDX #SECRET_PASS_2
  ldy #0
  
  SECRET_disp_L2_2:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_3_2:
    cpy #7 
    BNE SECRET_disp_CON_4_2
    RTS
    
    SECRET_disp_CON_4_2:
    iny
    bra SECRET_disp_L2_2                    


;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------

SECRET_SET_3:
   	JSR SECRET_MENU_SETUP
   	pshx
    ldx #SECRET_ID_3
    clr pressed
    
    movb #12, LCD_CUR
    SECRET_ID_SET_3:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_ID_SET_3
      
      JSR INPUT
      cpy #1
      BEQ SECRET_ID_SET_3  
      
      
      SECRET_ID_CON_3:
      adda #48
      staa LCD_VAL
      staa pressed
      
        ldaa LCD_CUR  
        SECRET_ID_CON_1_3:
          cmpa #11
          BGT SECRET_ID_CON_2_3
          movb #12, LCD_CUR
                    
        SECRET_ID_CON_2_3:
          cmpa #14
          BLT SECRET_ID_CONF_3
          movb #22, LCD_CUR
          clr pressed
          ldx #SECRET_PASS_3
          BRA SECRET_PASS_SET_3
             
      SECRET_ID_CONF_3:
        JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #14
         BEQ SECRET_ID_CON_2_3
        BRA SECRET_ID_SET_3
        
;-------------------------------------------------------------        
 
    SECRET_PASS_SET_3:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_PASS_SET_3
      
      JSR INPUT
      cpy #1
      BEQ SECRET_PASS_SET_3
      
      SECRET_PASS_CON_3:
        adda #48
        staa LCD_VAL
        staa pressed
        
        ldaa LCD_CUR
        SECRET_PASS_CON_1_3:
          cmpa #21
          BGT SECRET_PASS_CON_2_3
          movb #22, LCD_CUR
                    
        SECRET_PASS_CON_2_3:
          cmpa #30
          BLT SECRET_PASS_CONF_3
          movb #0, LCD_VAL
          movb #0, LCD_CUR
          pulx
          RTS
          
             
      SECRET_PASS_CONF_3:
        JSR disp_loc
        ldaa pressed       
        staa 1,x+     
        ldaa LCD_CUR
        inca   
        staa LCD_CUR
        cmpa #30
        BEQ SECRET_PASS_CON_2_3
         
        BRA SECRET_PASS_SET_3
        
        
;------------------------------------------------

disp_SECRET_ID_3:        
  LDX #SECRET_ID_3
  ldab LCD_CUR
  ldy #0
  SECRET_disp_L1_3:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_1_3:
    cpy #1 
    BNE SECRET_disp_CON_2_3
    RTS
    
    SECRET_disp_CON_2_3:
    iny
    bra SECRET_disp_L1_3
    
;--------------------------------------------------

disp_SECRET_PASS_3:
  ldab LCD_CUR
  addb #2
  stab LCD_CUR
  LDX #SECRET_PASS_3
  ldy #0
  
  SECRET_disp_L2_3:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_3_3:
    cpy #7 
    BNE SECRET_disp_CON_4_3
    RTS
    
    SECRET_disp_CON_4_3:
    iny
    bra SECRET_disp_L2_3          