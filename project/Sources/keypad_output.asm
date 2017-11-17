     xdef pressed, keypadoutput
     XREF keypad, port_s
     
     pressed: ds.b 1
     clr pressed
     keypadoutput: jsr keypad
     cmpb #$0F
     beq pressedf
     cmpb #$0A
     beq presseda
     cmpb #$0B
     beq pressedb
     
     stab pressed ; stores the output from the keypad into pressed
     
     bra keypadoutput

     pressedf: ldab #$FF
               stab port_s
               bra keypadoutput
               
     presseda: ldab #$FA
               stab port_s
               bra keypadoutput
               
     pressedb: ldab #$FB
               stab port_s
               bra keypadoutput