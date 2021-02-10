;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\03_rotate.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f1829.inc

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN = ON
 CONFIG CLKOUTEN = OFF
 CONFIG CPD = OFF
 CONFIG CP = OFF
 CONFIG MCLRE = OFF
 CONFIG WDTE = OFF
 CONFIG FOSC = INTOSC
 CONFIG LVP = OFF
 CONFIG PLLEN = OFF
 CONFIG WRT = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73

;********************************************************************************

 PSECT   RESETVEC,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;'' Lesson 3 - "Rotate"
;''
;'' This lesson will introduce shifting instructions as well as bit-oriented skip operations to
;'' move the LED display.
;''
;'' LEDs rotate from right to left at a rate of 1.5s.
;''
;''  PIC: 16F1829
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: PICkit 2 Low Pin Count Demo Board
;''  Date: 10.4.2015
;''
;'''''******************************************************************
;'' See Low Pin Count Demo Board User's Guide for Lesson Information*
;'''''*****************************************************************
;''
;' -------------------LATC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|DS4|DS3|DS2|DS1|-
;'-----------------------------------------
;'
;Dir portc Out
BANKSEL	TRISC
CLRF	TRISC
;portc = 0b0001000
	MOVLW	8
BANKSEL	PORTC
MOVWF	PORTC
;Do
SYSDOLOOP_S1:
;Wait 1500 ms
	MOVLW	220
	MOVWF	SYSWAITTEMPMS
	MOVLW	5
	MOVWF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Right
	RRF	PORTC,F
;If C = 1 Then portc.3 = 1
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
	GOTO	ENDIF1
BANKSEL	LATC
	BSF	LATC,3
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
DMS_START:
	MOVLW	4
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	165
	MOVWF	DELAYTEMP
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	GOTO	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	GOTO	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	GOTO	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	GOTO	DMS_START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' &  OSCCON = OSCCON OR b'01110000'
;= 8Mhz
;Set IRCF3 On
BANKSEL	OSCCON
;B7: ASM Source was:  BSF OSCCON,IRCF3
	BSF	OSCCON,6
;Set IRCF2 On
;B7: ASM Source was:  BSF OSCCON,IRCF2
	BSF	OSCCON,5
;Set IRCF1 On
;B7: ASM Source was:  BSF OSCCON,IRCF1
	BSF	OSCCON,4
;Set IRCF0 Off
;B7: ASM Source was:  BCF OSCCON,IRCF0
	BCF	OSCCON,3
;Set SPLLEN Off
;B7: ASM Source was:  BCF OSCCON,SPLLEN
	BCF	OSCCON,7
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
;B7: ASM Source was:  BCF ADCON1,ADFM
	BCF	ADCON1,7
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;B7: ASM Source was:  BCF ADCON0,ADON
	BCF	ADCON0,0
;ANSELA = 0
BANKSEL	ANSELA
CLRF	ANSELA
;ANSELB = 0
CLRF	ANSELB
;ANSELC = 0
CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
BANKSEL	CM2CON0
;B7: ASM Source was:  BCF CM2CON0,C2ON
	BCF	CM2CON0,7
;C1ON = 0
;B7: ASM Source was:  BCF CM1CON0,C1ON
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
BANKSEL	PORTA
CLRF	PORTA
;PORTB = 0
CLRF	PORTB
;PORTC = 0
CLRF	PORTC
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	ORG	6144
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
