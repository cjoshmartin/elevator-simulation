           XDEF ADMIN_SET, ADMIN_PASS
           XREF pressed, LCD_VAL, LCD_CUR
           XREF disp_loc, keypadoutput, INPUT


ADMIN_RAM: section          
ADMIN_USER: ds.b 7
ADMIN_PASS: ds.b 7

ADMIN_CODE: section
ADMIN_SET:
           
    ADMIN_PASS_SET:  
      jsr keypadoutput
      ldaa pressed
      staa LCD_VAL
      cmpa #0
      BEQ ADMIN_PASS_SET
      
      ldaa LCD_CUR
      JSR INPUT
      cmpa #LCD_CUR
      BNE ADMIN_PASS_SET
      
      ldaa LCD_CUR
      ADMIN_PASS_CON_1:
        CMPA #24
        BGT ADMIN_PASS_CON_2
        movb #25, LCD_CUR
          
      ADMIN_PASS_CON_2:
        cmpa #31
        BLE ADMIN_PASS_CON_3
        movb #25, LCD_CUR
        
      ADMIN_PASS_CON_3:
        cmpa #32
        BNE ADMIN_PASS_CONF
        RTS
        
    ADMIN_PASS_CONF:
      JSR disp_loc     
         ldab LCD_CUR
         incb   
         stab LCD_CUR
         ldaa pressed       
         staa 1,x+
      JMP ADMIN_USER_SET
      
          
                