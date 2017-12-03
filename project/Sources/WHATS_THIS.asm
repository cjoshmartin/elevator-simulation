		XDEF INTIALIZE_PORTS
	    XREF init_LCD


PORTS_RAM: SECTION

;		
PORTS_CODE:	 SECTION

	INITIALIZE_PORTS:
	JSR init_LCD
	
	bset ddr_port_u, #$F0; used to intiliaze the hex keys
    bset psr_port_u, #$F0
    bset pde_port_u, #$0F
    
				