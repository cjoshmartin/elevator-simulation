          XDEF SECRET_SET, SECRET_ID, SECRET_PASS
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
          ldaa #0
          staa 1, x+
          ldx #SECRET_PASS
          jmp SECRET_PASS_SET
             
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
      
      JSR INPUT
      cpy #1
      BEQ SECRET_PASS_SET
      
      SECRET_PASS_CON:
        adda #48
        staa LCD_VAL
        
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
          ldaa #0
          staa 1, x+
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
          