    XDEF TIME_VAL, DATE_VAL, TIME_SET, DATE_SET, TIME_disp, DATE_disp       ;DEFINED FUNCTIONS FOR THIS FILE
    XREF LCD_VAL, LCD_CUR, pressed                                          ;REFERNECED VARIABLES
    XREF disp_loc, keypadoutput, INPUT, TIME_SUBMENU, DATE_SUBMENU, display_DATE_TIME_SET      ; REFERENCED FUNCTIONS
    
TD_RAM: section
TIME_VAL: ds.b $6
DATE_VAL: ds.b $8    

TD_CODE: section    
TIME_SET:
     pshx                          ;pushes X onto stack
     JSR TIME_SUBMENU              ;loads in enter time display
     ldx #TIME_VAL                 ;loads in address of TIME_VAL
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
       staa pressed
     
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
         
       AM_PM:  
         JSR keypadoutput
         ldaa pressed
         cmpa #$C
         BNE PM
         
       AM:
         ldaa #$41
         staa 1,x+
         ldaa #$4D
         staa 1,x+
         JSR display_DATE_TIME_SET
         PULX   
         RTS
         
       PM:
         cmpa #$D
         BNE AM_PM  
         ldaa #$50
         staa 1,x+
         ldaa #$4D
         staa 1,x+
         JSR display_DATE_TIME_SET
         pulx   
         RTS
         
       TIME_IN_CONF:      
         JSR disp_loc
         ldaa pressed       
         staa 1,x+     
         ldaa LCD_CUR
         inca   
         staa LCD_CUR
         cmpa #16
         BEQ AM_PM
         
         
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
       BEQ DATE_IN
    DATE_IN_CON:    
       adda #48
       staa LCD_VAL
       staa pressed
       
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
      ldaa pressed       
      staa 1,x+     
      ldaa LCD_CUR
      inca   
      staa LCD_CUR
      cmpa #27
      BEQ DATE_CON_4
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
    stab LCD_CUR
    cmpb #2
    BNE  TIME_disp_CON_1
    movb #3, LCD_CUR
    incb
    
    TIME_disp_CON_1:
    cmpb #7
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
    stab LCD_CUR
    cmpb #18
    BNE DATE_disp_CON_1
    movb #19, LCD_CUR
    incb
    
  DATE_disp_CON_1:
    cmpb #21
    BNE DATE_disp_CON_2
    movb #22, LCD_CUR
    incb
    
  DATE_disp_CON_2:
    CMPB #26
    BNE DATE_disp_CON_3
    RTS
  
  DATE_disp_CON_3:
    BRA DATE_disp_L         