    XDEF TIME_VAL, DATE_VAL, TIME_SET, DATE_SET, TIME_disp, DATE_disp
    XREF LCD_VAL, LCD_CUR, pressed
    XREF disp_loc, keypadoutput, INPUT
    
TD_RAM: section
TIME_VAL: ds.b $6
DATE_VAL: ds.b $8    

TD_CODE: section    
TIME_SET:
     pshy
     LDAA #22
     STAA LCD_CUR
     ldy #TIME_VAL
                  
     TIME_IN:
       JSR keypadoutput
       ldaa pressed
       cmpa #$10
       BNE TIME_IN_CON
       RTS
       
     TIME_IN_CON:  
       adda #48
       staa LCD_VAL
       cmpa #48
       BEQ TIME_IN
       JSR INPUT
       cmpa #0
       BEQ TIME_IN
       ldx #TIME_VAL
            
       TC_1:
         LDAA LCD_CUR
         CMPA #21
         BGT TC_2
         movb #22, LCD_CUR
              
       TC_2:
         CMPA #24
         BNE TC_3
         movb #25, LCD_CUR
       TC_3:
         cmpa #30
         BNE TIME_IN_CONF
         puly
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
    pshy
    LDAA #6
    STAA LCD_CUR
    ldx #DATE_VAL
                     
    DATE_IN:
       JSR keypadoutput
       ldaa pressed
       cmpa #$10
       BNE DATE_IN_CON
       RTS
       
    DATE_IN_CON:    
       adda #48
       staa LCD_VAL
       cmpa #0
       BEQ TIME_IN
       ldaa LCD_CUR
       JSR INPUT
       cmpa #LCD_CUR
       BNE DATE_IN
       
       DATE_CON_1:
       ldaa #LCD_CUR
       CMPA #5
       BGT DATE_CON_2
       movb #6, LCD_CUR
        
       DATE_CON_2:
       CMPA #8
       BNE DATE_CON_3
       movb #9, LCD_CUR
       
       DATE_CON_3:
       cmpa #11
       BNE DATE_CON_4
       movb #12, LCD_CUR
       
       DATE_CON_4:
       CMPA #16
       BLT DATE_IN_CONF
       puly
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