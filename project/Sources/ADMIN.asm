           XDEF ADMIN_SET, ADMIN_USER, ADMIN_PASS
           XREF pressed, LCD_VAL, LCD_CUR
           XREF disp_loc, keypadoutput, INPUT


ADMIN_RAM: section          
ADMIN_USER: ds.b 7
ADMIN_PASS: ds.b 7

ADMIN_CODE: section
ADMIN_SET:
    movb #9, LCD_CUR
    ldy #ADMIN_USER
    ADMIN_USER_SET:
      jsr keypadoutput
      ldaa #pressed
      staa LCD_VAL
      cmpa #0
      BEQ ADMIN_USER_SET
      
      ldaa #LCD_CUR
      JSR INPUT
      cmpa #LCD_CUR
      BNE ADMIN_USER_SET
      
      ldaa #LCD_CUR
      ADMIN_USER_CON_1:
        CMPA #8
        BGT ADMIN_USER_CON_2
        movb #9, LCD_CUR
          
      ADMIN_USER_CON_2:
        cmpa #15
        BLE ADMIN_USER_CON_3
        movb #9, LCD_CUR
        
      ADMIN_USER_CON_3:
        cmpa #16
        BNE ADMIN_USER_CONF
        movb #25, LCD_CUR
        BRA ADMIN_PASS_SET
        
    ADMIN_USER_CONF:
      JSR disp_loc
      ldab #LCD_CUR
      incb
      stab LCD_CUR
      ldaa #pressed                
      ;staa                          ;***************
      BRA ADMIN_USER_SET

;-----------------------------------------------------------------------------      
      
    ADMIN_PASS_SET:  
      jsr keypadoutput
      ldaa #pressed
      staa LCD_VAL
      cmpa #0
      BEQ ADMIN_PASS_SET
      
      ldaa #LCD_CUR
      JSR INPUT
      cmpa #LCD_CUR
      BNE ADMIN_PASS_SET
      
      ldaa #LCD_CUR
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
      ldab #LCD_CUR
      incb
      stab LCD_CUR
      ldaa #pressed                 ;***************
      ;staa                          ;*************** 
      BRA ADMIN_USER_SET
      
          
                