     xdef pressed, keypadoutput
     XREF keypad, port_s, ADMIN_SET, port_u, ADMIN_CHECK, flag, SYS_SETTINGS

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
     
     stab pressed ; stores the output from the keypad into pressed
	 held:  ldab port_u     ;loads in input from keypad
            andb #$0F       ;next few lines wait's until held
            cmpb #$0F
            BNE held
     puly
     pulx
    RTS

     pressedf: clr pressed
               movb #0, flag
               jsr ADMIN_CHECK
               cpy #1
               BNE pressedf_done
               JSR SYS_SETTINGS
               
               
             pressedf_done:
               movb #99, flag  
               puly
               pulx
               rts