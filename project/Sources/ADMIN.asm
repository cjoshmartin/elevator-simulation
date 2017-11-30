           XDEF ADMIN_SET, ADMIN_PASS
           XREF pressed, LCD_VAL, LCD_CUR
           XREF disp_loc, keypadoutput, INPUT, disp, display_string, ADMIN_MENU_SETUP


ADMIN_RAM: section          
ADMIN_USER: ds.b 7
ADMIN_PASS: ds.b 7

ADMIN_CODE: section
ADMIN_SET:
     JSR ADMIN_MENU_SETUP 
     ldy #16
             
    ADMIN_PASS_SET:
     
      jsr keypadoutput  ; call the keypad ; TODO: NEEED TO fix
      ldaa pressed	   	; store the value from the keypad to Registor 'A'
      adda #48
      staa LCD_VAL		; 'A' -> 'LCD_VAL'
      
      
      ldaa LCD_CUR
      ADMIN_PASS_CON_1:
        CMPA #19
        BGT ADMIN_PASS_CON_2
        movb #20, LCD_CUR
          
      ADMIN_PASS_CON_2:
        cmpa #27
        BLE ADMIN_PASS_CONF
        RTS

        
    ADMIN_PASS_CONF:
      JSR disp_loc     
         ldab LCD_CUR
         incb   
         stab LCD_CUR
         ldaa pressed       
         staa 1,x+
       bra ADMIN_PASS_SET 
      
          
                