	XDEF TIME_VAL, DATE_VAL, TIME_SET, DATE_SET, TIME_disp, DATE_disp       ;DEFINED FUNCTIONS FOR THIS FILE
    XREF LCD_VAL, LCD_CUR, pressed                                          ;REFERNECED VARIABLES
    XREF disp_loc, keypadoutput, INPUT, TIME_SUBMENU, DATE_SUBMENU, display_DATE_TIME_SET, keypad      ; REFERENCED FUNCTIONS
    
TD_RAM: section
TIME_VAL: ds.b $7
DATE_VAL: ds.b $A    

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
	     cmpa #9
	     BGT TIME_IN
	     JSR INPUT
       cpy #1
       BEQ TIME_IN
       
     TIME_IN_CON:  
       adda #48
       staa LCD_VAL
       staa pressed
     
       TC_1:             ;checks if current location is below appropriate value
         LDAA LCD_CUR
         CMPA #10
         BGT TC_2
         movb #11, LCD_CUR
              
       TC_2:             ;checks if current values is 13 if not continue else
         CMPA #13
         BNE TC_3
         LDAA #':'             ;sets it to : increments and continues
         STAA 1, x+
         movb #14, LCD_CUR
         jmp TIME_IN
      
       TC_3:                   ;sees if it reached the end or not 
         cmpa #16
         BNE TC_4
         BRA AM_PM
         
         
       TC_4:               ;sees if it is the tens place for hours
         CMPA #11
         BNE TC_5
         ldab pressed     ;if so checks to make sure an impossible value was inputted
         subb #48
         cmpb #1
         BLE TC_5
         jmp TIME_IN
         
       TC_5:
         CMPA #12
         BNE TC_6
         ldab TIME_VAL
         subb #48
         cmpb #1
         BNE TC_6
         ldab pressed
         subb #48
         cmpb #2
         BLE TC_6
         jmp TIME_IN
         
           
       TC_6:                ;checks the tens place for minutes
         CMPA #14
         BNE TIME_IN_CONF
         ldab pressed           ;if greater than then continue if equal to then
         subb #48
         cmpb #5 
         BGT TC_END
         JMP TIME_IN_CONF
           
       
       TC_END:
         jmp TIME_IN
             
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
         cmpa #$E
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
         
         JMP TIME_IN   

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
       cmpa #9
	     BGT DATE_IN
       
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
       jmp DATE_IN
        
       DATE_CON_2:
       CMPA #19
       BNE DATE_CON_3
       LDAA #'/'
       STAA 1, x+
       movb #20, LCD_CUR
       jmp DATE_IN
       
       DATE_CON_3:
       cmpa #22
       BNE DATE_CON_4
       LDAA #'/'
       STAA 1, x+
       movb #23, LCD_CUR
       JMP DATE_IN
       
       DATE_CON_4:
       cmpa #17
       BNE DATE_CON_5
       LDAB pressed
       subb #48
       cmpb #1
       BLE DATE_CON_5 
       JMP DATE_IN
       
       DATE_CON_5:
       cmpa #18
       BNE DATE_CON_6
       ldab DATE_VAL
       subb #48
       CMPB #1
       BGT DATE_IN
       ldab pressed
       subb #48
       cmpb #2
       BLE DATE_CON_6
	   jmp DATE_IN
	   
	   DATE_CON_6:
	   CMPA #20
	   BNE DATE_CON_7
	   ldab pressed
	   subb #48
	   cmpb #3
	   BLE DATE_CON_7
	   jmp DATE_IN
	   
	   DATE_CON_7:
	   cmpa #21
	   BNE DATE_CON_8
	   ldab DATE_VAL+3
	   subb #48
	   cmpb #3
	   BLT DATE_CON_8
	   ldab pressed
	   subb #48
	   cmpb #1
	   BLE DATE_CON_8
	   jmp DATE_IN
	   
       
       DATE_CON_8:
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
      JMP DATE_IN
      
;---------------------------------------------------------------------      
      

TIME_disp:
  
  LDX #TIME_VAL
  ldab LCD_CUR
  ldy #0
  TIME_disp_L:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    TIME_disp_CON_1:
    cpy #6 
    BNE TIME_disp_CON_2
    RTS
    
    TIME_disp_CON_2:
    iny
    bra TIME_disp_L        

;---------------------------------------------------------------------

DATE_disp:

  LDX #DATE_VAL
  ldab LCD_CUR
  ldy #0
  DATE_disp_L:
    LDAA 1, X+
    STAA LCD_VAL
    jsr disp_loc
    incb
    stab LCD_CUR
    
    
  DATE_disp_CON_1:
    CPY #9
    BNE DATE_disp_CON_3
    RTS
  
  DATE_disp_CON_3:
    iny
    BRA DATE_disp_L         