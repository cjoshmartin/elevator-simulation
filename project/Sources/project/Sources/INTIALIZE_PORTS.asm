		XDEF INTIALIZE_PORTS
	    XREF init_LCD


PORTS_RAM: SECTION
ddr_port_u: equ $26A
psr_port_u: equ $26D
pde_port_u: equ $26C
port_s: equ     $248
port_s_ddr: equ $24A
port_t: equ		$240 ;DC Motor
port_t_ddr: equ $242
port_p: equ     $258 ;Stepper Motor
port_p_ddr: equ $25A
		
PORTS_CODE:	 SECTION

	INITIALIZE_PORTS:
	JSR init_LCD
	bset port_s_ddr, #$FF ; used to intiliaze the LED display
	bset ddr_port_u, #$F0; used to intiliaze the hex keys
    bset psr_port_u, #$F0
    bset pde_port_u, #$0F
    bset port_p_ddr, #$1E ;Turns the stepper motor on
    BSET port_t_ddr, #$08 ;Turns the DC MOTOR
    
RTS    
				