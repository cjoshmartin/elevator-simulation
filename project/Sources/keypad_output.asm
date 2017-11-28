     xdef pressed, keypadoutput
     XREF keypad, port_s, ADMIN

RAM: section     
     pressed: ds.b 1

CODE: section
     ;clr pressed
     keypadoutput:
     pshx
     pshy 
     clr pressed
     jsr keypad
     cmpb #$0F
     beq pressedf
     cmpb #$0A
     beq presseda
     cmpb #$0B
     beq pressedb
     
     stab pressed ; stores the output from the keypad into pressed
     puly
     pulx
     RTS

     pressedf: ldab #$FF
               ;stab port_s
               jsr ADMIN
               RTS

; A or B ->should be used to navigate through the system settings menu.               
     presseda: ldab #$FA
               stab port_s
               RTS
               
     pressedb: ldab #$FB
               stab port_s
               RTS