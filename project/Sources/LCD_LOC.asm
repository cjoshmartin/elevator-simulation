    XDEF disp_loc
    XREF LCD_VAL, LCD_CUR, disp
    XREF display_string
    
LOC: section        
disp_loc:
  pshb
  pshx
  psha
  ldab LCD_CUR
        
  disp_0:
  cmpb #0
  BNE disp_1    
  movb LCD_VAL, disp
  jmp disp_loc_end
  
  disp_1:
  cmpb #1
  BNE disp_2    
  movb LCD_VAL, disp+1
  jmp disp_loc_end
  
  disp_2:
  cmpb #2
  BNE disp_3    
  movb LCD_VAL, disp+2
  jmp disp_loc_end
  
  disp_3:
  cmpb #3
  BNE disp_4    
  movb LCD_VAL, disp+3
  jmp disp_loc_end
  
  disp_4:
  cmpb #4
  BNE disp_5    
  movb LCD_VAL, disp+4
  jmp disp_loc_end
  
  disp_5:
  cmpb #5
  BNE disp_6    
  movb LCD_VAL, disp+5
  jmp disp_loc_end
  
  disp_6:
  cmpb #6
  BNE disp_7    
  movb LCD_VAL, disp+6
  jmp disp_loc_end
  
  disp_7:
  cmpb #7
  BNE disp_8    
  movb LCD_VAL, disp+7
  jmp disp_loc_end
  
  disp_8:
  cmpb #8
  BNE disp_9    
  movb LCD_VAL, disp+8
  jmp disp_loc_end
  
  disp_9:
  cmpb #9
  BNE disp_10    
  movb LCD_VAL, disp+9
  jmp disp_loc_end
  
  disp_10:
  cmpb #10
  BNE disp_11    
  movb LCD_VAL, disp+10
  jmp disp_loc_end
  
  disp_11:
  cmpb #11
  BNE disp_12    
  movb LCD_VAL, disp+11
  jmp disp_loc_end
  
  disp_12:
  cmpb #12
  BNE disp_13    
  movb LCD_VAL, disp+12
  jmp disp_loc_end
  
  disp_13:
  cmpb #13
  BNE disp_14    
  movb LCD_VAL, disp+13
  jmp disp_loc_end
  
  disp_14:
  cmpb #14
  BNE disp_15    
  movb LCD_VAL, disp+14
  jmp disp_loc_end
  
  disp_15:
  cmpb #15
  BNE disp_16    
  movb LCD_VAL, disp+15
  jmp disp_loc_end
  
  disp_16:
  cmpb #16
  BNE disp_17    
  movb LCD_VAL, disp+16
  jmp disp_loc_end
  
  disp_17:
  cmpb #17
  BNE disp_18    
  movb LCD_VAL, disp+17
  jmp disp_loc_end
  
  disp_18:
  cmpb #18
  BNE disp_19    
  movb LCD_VAL, disp+18
  jmp disp_loc_end
  
  disp_19:
  cmpb #19
  BNE disp_20    
  movb LCD_VAL, disp+19
  jmp disp_loc_end
  
  disp_20:
  cmpb #20
  BNE disp_21    
  movb LCD_VAL, disp+20
  jmp disp_loc_end
  
  disp_21:
  cmpb #21
  BNE disp_22    
  movb LCD_VAL, disp+21
  jmp disp_loc_end
  
  disp_22:
  cmpb #22
  BNE disp_23    
  movb LCD_VAL, disp+22
  jmp disp_loc_end
  
  disp_23:
  cmpb #23
  BNE disp_24    
  movb LCD_VAL, disp+23
  jmp disp_loc_end
  
  disp_24:
  cmpb #24
  BNE disp_25    
  movb LCD_VAL, disp+24
  jmp disp_loc_end
  
  disp_25:
  cmpb #25
  BNE disp_26    
  movb LCD_VAL, disp+25
  jmp disp_loc_end
  
  disp_26:
  cmpb #26
  BNE disp_27    
  movb LCD_VAL, disp+26
  jmp disp_loc_end
  
  disp_27:
  cmpb #27
  BNE disp_28    
  movb LCD_VAL, disp+27
  jmp disp_loc_end
  
  disp_28:
  cmpb #28
  BNE disp_29    
  movb LCD_VAL, disp+28
  bra disp_loc_end
  
  disp_29:
  cmpb #29
  BNE disp_30    
  movb LCD_VAL, disp+29   
  bra disp_loc_end
  
  disp_30:
  cmpb #30
  BNE disp_31    
  movb LCD_VAL, disp+30   
  bra disp_loc_end
  
  disp_31:
  cmpb #31
  BNE disp_loc_end    
  movb LCD_VAL, disp+31
  bra disp_loc_end
  
  disp_loc_end:
    ldd #disp
    jsr display_string
    pula
    pulx
    pulb
    rts