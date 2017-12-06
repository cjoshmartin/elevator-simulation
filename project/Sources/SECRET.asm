          XDEF SECRET_SET, SECRET_ID, SECRET_PASS, disp_SECRET_ID, disp_SECRET_PASS
          XREF pressed, LCD_VAL, LCD_CUR
          XREF disp_loc, keypadoutput, INPUT, SECRET_MENU_SETUP
SECRET_RAM: section          
SECRET_ID: ds.b $2
SECRET_PASS: ds.b $8

SECRET_CODE: section
SECRET_SET:
   	JSR SECRET_MENU_SETUP
   	pshx
    ldx #SECRET_ID
    clr pressed
    
    movb #12, LCD_CUR
    SECRET_ID_SET:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_ID_SET
      
      JSR INPUT
      cpy #1
      BEQ SECRET_ID_SET  
      
      
      SECRET_ID_CON:
      adda #48
      staa LCD_VAL
      staa pressed
      
        ldaa LCD_CUR  
        SECRET_ID_CON_1:
          cmpa #11
          BGT SECRET_ID_CON_2
          movb #12, LCD_CUR
                    
        SECRET_ID_CON_2:
          cmpa #14
          BLT SECRET_ID_CONF
          movb #22, LCD_CUR
          clr pressed
          ldx #SECRET_PASS
          BRA SECRET_PASS_SET
             
      SECRET_ID_CONF:
        JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #14
         BEQ SECRET_ID_CON_2
        BRA SECRET_ID_SET
        
;-------------------------------------------------------------        
 
    SECRET_PASS_SET:
      ldy #0
      jsr keypadoutput
      ldaa pressed
      cmpa #9
	    BGT SECRET_PASS_SET
      
      JSR INPUT
      cpy #1
      BEQ SECRET_PASS_SET
      
      SECRET_PASS_CON:
        adda #48
        staa LCD_VAL
        staa pressed
        
        ldaa LCD_CUR
        SECRET_PASS_CON_1:
          cmpa #21
          BGT SECRET_PASS_CON_2
          movb #22, LCD_CUR
                    
        SECRET_PASS_CON_2:
          cmpa #30
          BLT SECRET_PASS_CONF
          movb #0, LCD_VAL
          movb #0, LCD_CUR
          pulx
          RTS
          
             
      SECRET_PASS_CONF:
        JSR disp_loc
        ldaa pressed       
        staa 1,x+     
        ldaa LCD_CUR
        inca   
        staa LCD_CUR
        cmpa #30
        BEQ SECRET_PASS_CON_2
         
        BRA SECRET_PASS_SET
        
        
;------------------------------------------------

disp_SECRET_ID:        
  LDX #SECRET_ID
  ldab LCD_CUR
  ldy #0
  SECRET_disp_L1:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_1:
    cpy #1 
    BNE SECRET_disp_CON_2
    RTS
    
    SECRET_disp_CON_2:
    iny
    bra SECRET_disp_L1
    
;--------------------------------------------------

disp_SECRET_PASS:
  ldab LCD_CUR
  addb #2
  stab LCD_CUR
  LDX #SECRET_PASS
  ldy #0
  
  SECRET_disp_L2:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    SECRET_disp_CON_3:
    cpy #7 
    BNE SECRET_disp_CON_4
    RTS
    
    SECRET_disp_CON_4:
    iny
    bra SECRET_disp_L2                
          