           XDEF ADMIN_SET, ADMIN_PASS, disp_ADMIN, ADMIN_CHECK
           XREF pressed, LCD_VAL, LCD_CUR, WAIT, CARRY, CORRECT_ADM_PASS, INCORRECT_INPUT
           XREF disp_loc, keypadoutput, INPUT, disp, display_string, ADMIN_MENU_SETUP, keypad
           XREF TIME_INT


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
      jsr keypad  ; call the keypad ; TODO: NEEED TO fix
      ldaa pressed	   	; store the value from the keypad to Registor 'A'
      cmpa #9
	    BGT ADMIN_PASS_SET
      
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
       
;---------------------------------------------------------------------------


disp_ADMIN:

  LDX #ADMIN_PASS
  ldab LCD_CUR
  ldy #0
  ADMIN_disp_L:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    ADMIN_disp_CON_1:
    cpy #8 
    BNE ADMIN_disp_CON_2
    RTS
    
    ADMIN_disp_CON_2:
    iny
    bra ADMIN_disp_L
    
    
;---------------------------------------------------------------------------
;This code is to enter the password 
ADMIN_CHECK:
  JSR ADMIN_MENU_SETUP
  movb #20, LCD_CUR
  movb #'*', LCD_VAL
  LDX #ADMIN_PASS
  ldaa LCD_CUR
  ldy #0
  ADMIN_CHECK_L:
    JSR keypadoutput
    ldab 1, x+
    subb #48
    cmpb pressed
    BNE INVALID_AD
    
    inca
    staa LCD_CUR
    JSR disp_loc
    
    iny
    cpy #8
    BNE ADMIN_CHECK_L
    
    JSR CORRECT_ADM_PASS
    CLI
    ADMIN_MATCH_WAIT:
      ldaa CARRY
      cmpa #1
      BNE ADMIN_MATCH_WAIT
      movb #0, CARRY
      movb #0, WAIT
      SEI
      
    ldy #1
    RTS
    
    INVALID_AD:
      JSR INCORRECT_INPUT
      CLI
    ADMIN_INVALID_WAIT:
      ldaa CARRY
      cmpa #1
      BNE ADMIN_INVALID_WAIT
      movb #0, CARRY
      movb #0, WAIT
      SEI
      
      RTS
      
    
                
      
          
                