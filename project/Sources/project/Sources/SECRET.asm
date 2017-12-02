          XDEF SECRET_SET, SECRET_ID, SECRET_PASS
          XREF pressed, LCD_VAL, LCD_CUR
          XREF disp_loc, keypadoutput, INPUT, SECRET_MENU_SETUP
SECRET_RAM: section          
SECRET_ID: ds.b $2
SECRET_PASS: ds.b $8

SECRET_CODE: section
SECRET_SET:
	JSR SECRET_MENU_SETUP
    ldx #SECRET_ID
    
    SECRET_ID_SET:
      jsr keypadoutput
      ldaa pressed
      staa LCD_VAL
      cmpa #0
      BEQ SECRET_ID_SET  
      
      ldaa LCD_CUR
      JSR INPUT
      cmpa #LCD_CUR
      BNE SECRET_ID_SET
      
        ldaa LCD_CUR
        SECRET_ID_CON_1:
          cmpa #10
          BGT SECRET_ID_CON_2
          movb #11, LCD_CUR
                    
        SECRET_ID_CON_2:
          cmpa #14
          BLT SECRET_ID_CON_3
          movb #11, LCD_CUR
          
        SECRET_ID_CON_3:
          cmpa #14
          BNE SECRET_ID_CONF
          ldx #SECRET_PASS
          BRA SECRET_PASS_SET
             
      SECRET_ID_CONF:
        JSR disp_loc     
         ldab LCD_CUR
         incb   
         stab LCD_CUR
         ldaa pressed       
         staa 1,x+
        BRA SECRET_ID_SET
        
;-------------------------------------------------------------        
          
    SECRET_PASS_SET:
      jsr keypadoutput
      ldaa pressed
      staa LCD_VAL
      cmpa #0
      BEQ SECRET_PASS_SET  
      
      ldaa LCD_CUR
      JSR INPUT
      cmpa LCD_CUR
      BNE SECRET_PASS_SET
      
        ldaa LCD_CUR
        SECRET_PASS_CON_1:
          cmpa #10
          BGT SECRET_PASS_CON_2
          movb #11, LCD_CUR
                    
        SECRET_PASS_CON_2:
          cmpa #14
          BLT SECRET_PASS_CON_3
          movb #11, LCD_CUR
          
        SECRET_PASS_CON_3:
          cmpa #14
          BNE SECRET_PASS_CONF
          RTS
             
      SECRET_PASS_CONF:
        JSR disp_loc     
         ldab LCD_CUR
         incb   
         stab LCD_CUR
         ldaa pressed       
         staa 1,x+
        BRA SECRET_PASS_SET    
          