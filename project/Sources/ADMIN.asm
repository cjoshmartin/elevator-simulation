           XDEF ADMIN_SET, ADMIN_PASS
           XREF pressed, LCD_VAL, LCD_CUR
           XREF disp_loc, keypadoutput, INPUT, disp, display_string, ADMIN_MENU_SETUP


ADMIN_RAM: section          
ADMIN_PASS: ds.b 8

ADMIN_CODE: section
ADMIN_SET:
     pshx
     JSR ADMIN_MENU_SETUP 
     ldx #ADMIN_PASS
     movb #20, LCD_CUR
             
    ADMIN_PASS_SET:
      ldy #0
      jsr keypadoutput  ; call the keypad ; TODO: NEEED TO fix
      ldaa pressed	   	; store the value from the keypad to Registor 'A'
      
      JSR INPUT
      cpy #1
      BEQ ADMIN_PASS_SET
      
      ADMIN_PASS_CON:
      adda #48
      staa LCD_VAL
      staa pressed
      
      ldaa LCD_CUR
      ADMIN_PASS_CON_1:
        CMPA #19
        BGT ADMIN_PASS_CON_2
        movb #20, LCD_CUR
          
      ADMIN_PASS_CON_2:
        cmpa #28
        BLT ADMIN_PASS_CONF
        ldaa #0
        staa 1, x+
        pulx
        RTS

        
    ADMIN_PASS_CONF:
         JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #28
         BEQ ADMIN_PASS_CON_2 
       bra ADMIN_PASS_SET 
      
          
                