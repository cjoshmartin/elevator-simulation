     xdef pressed, keypadoutput
     XREF keypad, port_s, ADMIN_SET, port_u, ADMIN_CHECK

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
	 held:  ldab port_u     ;loads in input from keypad
            andb #$0F       ;next few lines wait's until held
            cmpb #$0F
            BNE held
     puly
     pulx
    RTS

     pressedf: clr pressed
               jsr ADMIN_CHECK
               puly
               pulx
               rts
               
     presseda: ldab #$FA
               stab port_s
               bra redoo
               
     pressedb: ldab #$FB
               stab port_s
               bra redoo