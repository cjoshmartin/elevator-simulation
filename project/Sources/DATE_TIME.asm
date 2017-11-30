    XDEF TIME_VAL, DATE_VAL, TIME_SET, DATE_SET, TIME_disp, DATE_disp
    XREF LCD_VAL, LCD_CUR, pressed
    XREF disp_loc, keypadoutput, INPUT, TIME_SUBMENU, DATE_SUBMENU, display_DATE_TIME_SET
    
TD_RAM: section
TIME_VAL: ds.b $6
DATE_VAL: ds.b $8    

TD_CODE: section    
TIME_SET:
     pshx
     JSR TIME_SUBMENU
     ldx #TIME_VAL
     clr pressed             
     TIME_IN:
       ldy #0
       JSR keypadoutput
       ldaa pressed
	   JSR INPUT
       cpy #1
       BEQ TIME_IN
       
     TIME_IN_CON:  
       adda #48
       staa LCD_VAL

       
            
       TC_1:
         LDAA LCD_CUR
         CMPA #10
         BGT TC_2
         movb #11, LCD_CUR
              
       TC_2:
         CMPA #13
         BNE TC_3
         movb #14, LCD_CUR
       TC_3:
         cmpa #16
         BNE TIME_IN_CONF
         pulx
         JSR display_DATE_TIME_SET 
         RTS
         
       TIME_IN_CONF:      
         JSR disp_loc     
         ldab LCD_CUR
         incb   
         stab LCD_CUR
         ldaa pressed       
         staa 1,x+
         
         BRA TIME_IN   

;-----------------------------------------------------------------

DATE_SET:
    pshx
    JSR DATE_SUBMENU
    ldx #DATE_VAL
    clr pressed                 
    DATE_IN:
       ldy #0 
       JSR keypadoutput
       ldaa pressed
       
       JSR INPUT
       cpy #1
       BEQ TIME_IN
    DATE_IN_CON:    
       adda #48
       staa LCD_VAL

       
       DATE_CON_1:
       ldaa LCD_CUR
       CMPA #16
       BGT DATE_CON_2
       movb #17, LCD_CUR
        
       DATE_CON_2:
       CMPA #19
       BNE DATE_CON_3
       movb #20, LCD_CUR
       
       DATE_CON_3:
       cmpa #22
       BNE DATE_CON_4
       movb #23, LCD_CUR
       
       DATE_CON_4:
       CMPA #27
       BNE DATE_IN_CONF
       pulx
       JSR display_DATE_TIME_SET
       RTS
       
    DATE_IN_CONF:
      JSR disp_loc     
      ldab LCD_CUR
      incb   
      stab LCD_CUR
      ldaa pressed       
      staa 1,x+
      BRA DATE_IN
      
;---------------------------------------------------------------------      
      

TIME_disp:
  movb #0, LCD_CUR
  LDX #TIME_VAL
  ldab LCD_CUR
  
  TIME_disp_L:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    cmpb #2
    BNE  TIME_disp_CON_1
    movb #3, LCD_CUR
    
    TIME_disp_CON_1:
    cmpb #8
    BNE TIME_disp_CON_2
    RTS
    
    TIME_disp_CON_2:
    bra TIME_disp_L        

;---------------------------------------------------------------------

DATE_disp:
  movb #16, LCD_CUR
  LDX #DATE_VAL
  ldab LCD_CUR
  
  DATE_disp_L:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    cmpb #18
    BNE DATE_disp_CON_1
    movb #19, LCD_CUR
    
  DATE_disp_CON_1:
    cmpb #21
    BNE DATE_disp_CON_2
    movb #22, LCD_CUR
    
  DATE_disp_CON_2:
    CMPB #26
    BNE DATE_disp_CON_3
    RTS
  
  DATE_disp_CON_3:
    BRA DATE_disp_L         