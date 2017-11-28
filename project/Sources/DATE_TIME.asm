    XDEF TIME_VAL, DATE_VAL, TIME_SET, DATE_SET
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
       adda #48
       staa LCD_VAL
       cmpa #0
       BEQ TIME_IN
       ;ldaa LCD_CUR
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
    ldy #DATE_VAL
    
    DATE_IN:
       JSR keypadoutput
       ldaa pressed
       adda #48
       staa LCD_VAL
       cmpa #0
       BEQ TIME_IN
       ldaa #LCD_CUR
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
      ldab #LCD_CUR
      incb   
      stab LCD_CUR
      staa DATE_VAL          ;**********************************
      BRA DATE_IN
      
;---------------------------------------------------------------------      
      
      