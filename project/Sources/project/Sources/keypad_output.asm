     xdef pressed, keypadoutput
     XREF keypad, port_s,ADMIN_MENU_SETUP

RAM: section     
     pressed: ds.b 1

CODE: section
     ;clr pressed
     keypadoutput:
     pshx
     pshy 
     clr pressed
  redoo:   jsr keypad
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

     pressedf: clr pressed
               jsr ADMIN_MENU_SETUP
               bra redoo
               
     presseda: ldab #$FA
               stab port_s
               bra redoo
               
     pressedb: ldab #$FB
               stab port_s
               bra redoo