		   xdef keypad, pressed


pressed: ds.b 1

MY_EXTENDED_RAM: SECTION
port_u: equ     $268
port_u_ddr: equ     $26A
port_u_psr: equ     $26D
port_u_pde: equ     $26C
port_s: equ     $248
port_s_ddr: equ $24A
SEQ:  dc.b  $70, $B0, $D0, $E0
VAL:  dc.b  $BE, $77, $7B, $7D, $B7, $BB, $BD, $D7, $DB, $DD, $E7, $ED, $7E, $EB, $DE, $EE

MY_VARIABLE: SECTION
VAR: ds.b $1
prev: ds.b $1
chck: ds.b $1
num: ds.b $1

keypad:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            jsr INITIALIZE
            
       L0:  ldx #SEQ        ;loads values to scan matrix
            ldy #$5         ;loads counter
            
     LOOP:  DBEQ y, L0      ;decrements y by 1 and if 0 branch else continue
            ldaa 1, x+      ;loads first value of lookup sequence
            staa port_u     ;stores into port_u       
            JSR DELAY       ;bounce delay
            
            ldab port_u     ;loads value from keypad
            stab VAR        ;stores into VAR   
            brset VAR, #$0F, LOOP    ;checks if any value is pressed or not
          
     held:  ldab port_u     ;loads in input from keypad
            andb #$0F       ;next few lines wait's until held
            cmpb #$0F
            BNE held
            jsr LKUP        ;looks up value if it is pressed or not
            bra L0          ;repeats for next value
            
                             
LKUP:               
   pshx
   psha
   pshy
   ldx #VAL           ;loads predefined array
   ldaa #$0           ;loads value counter
   ldy #$11           ;loads no value counter
   deca               ;decrements value counter by 1 to ensure 0 is included
   chk:
       inca           ;increments back to 0
       dbeq y, done   ;decrements no value counter and branches to done if 0
       
       ldab 1, x+     ;loads first value of array
       cmpb VAR       ;compares it to input
       BNE chk        ;if no match the branch


       done:       
   puly
   pula
   pulx
   rts        
end

INITIALIZE:
            BSET port_u, #$F0          ;turns necessary bits on so it reads up
            BSET port_u_ddr, #$F0      ;turns necessary bits on for ddr
            BSET port_u_psr, #$F0      ;turns necessary bits on for pull up
            BSET port_u_pde, #$0F      ;turns necessary bits on for 
            BSET port_s_ddr, #$FF      ;turns necessary bits on
            bset prev, #$0             ;gives value to previous
            ldaa #$1                   ;next two lines give alternation value
            staa num
            RTS
                        
DELAY:
    pshy
    ldy #$FA0   ;loads 4000 for 4 millisecond delay
    L2:         ;loop
    dey         ;decrements y untill 0
    BNE L2
    puly
    RTS