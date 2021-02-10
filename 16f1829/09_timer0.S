;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\09_timer0.S"
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
 SYSTEMP1                         EQU 32                    ; 0X20
 TMRPRES                          EQU 33                    ; 0X21
 TMRSOURCE                        EQU 34                    ; 0X22

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
;''  Lesson 9 - "Timer0"
;''
;''  Timer0 is a counter implemented in the processor. It may be used to count instruction
;''  cycles or external events, that occur at or below the instruction cycle rate.
;''  In the PIC18, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
;''  enhanced mid-range core implements only an 8-bit counter.
;''  This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;''  over. This frees up the processor to do meaningful work rather than wasting instruction
;''  cycles in a timing loop.
;''  Using a counter provides a convenient method of measuring time or delay loops as it
;''  allows the processor to work on other tasks rather than counting instruction cycles.
;''
;''
;''  LEDs rotate from right to left, similar to Lesson 3, at a rate of ~.5 seconds.
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
;portc = 0
BANKSEL	PORTC
CLRF	PORTC
;portc.5 = 1
BANKSEL	LATC
	BSF	LATC,5
;InitTimer0 Osc, PS0_256
	MOVLW	1
	BANKSEL	TMRSOURCE
	MOVWF	TMRSOURCE
	MOVLW	7
	MOVWF	TMRPRES
	CALL	INITTIMER0177
;Do
SYSDOLOOP_S1:
;Wait While !TMR0IF
SYSWAITLOOP1:
	BANKSEL	SYSTEMP1
	CLRF	SYSTEMP1
;B7: ASM Source was:  BTFSC INTCON,TMR0IF
	BTFSC	INTCON,2
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BTFSC	SYSTEMP1,0
	GOTO	SYSWAITLOOP1
;T0IF = 0
;B7: ASM Source was:  BCF INTCON,T0IF
	BCF	INTCON,2
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Right
	RRF	PORTC,F
;If C = 1 Then portc.3 = 1
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
	GOTO	ENDIF2
BANKSEL	LATC
	BSF	LATC,3
ENDIF2:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;equates to OSCCON = OSCCON AND b'10000111' & OSCCON = OSCCON OR b'01100000'
;= 2Mhz
;Set IRCF3 On
BANKSEL	OSCCON
;B7: ASM Source was:  BSF OSCCON,IRCF3
	BSF	OSCCON,6
;Set IRCF2 On
;B7: ASM Source was:  BSF OSCCON,IRCF2
	BSF	OSCCON,5
;Set IRCF1 Off
;B7: ASM Source was:  BCF OSCCON,IRCF1
	BCF	OSCCON,4
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: TIMER.H (1411)
INITTIMER0177:
;Some PICS (18F+) Use T0CON for timer0 Control
;ALL OTHER PICS USE OPTION_REG for timer0 control
;Sub modified to set all TMR Control bits at once
;* TMRPres, TMRSource & TMRPost now shared *
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
	MOVF	TMRPRES,W
	SUBLW	7
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	CLRF	TMRPRES
;If Timer0 is 16-bit capable
;Re-Use TMRPres as T0CON Temp_register
;Keep T0CON 7:6 and write bits 2:0 from TMRPres
;Bits 5,4 & 3 will be cleared!
;TMRPres = (OPTION_REG AND 192) OR TMRPres
	MOVLW	192
BANKSEL	OPTION_REG
	ANDWF	OPTION_REG,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
;IF TMRSource = EXT then
	MOVLW	2
	SUBWF	TMRSOURCE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE4_1
;Set TMRPres.5 ON   'EXT
	BSF	TMRPRES,5
;ELSE
	GOTO	ENDIF4
ELSE4_1:
;Set TMRPres.5 OFF  'OSC
	BCF	TMRPRES,5
;END IF
ENDIF4:
;Now Write the OPTION_REG
;OPTION_REG = TMRPres
	MOVF	TMRPRES,W
BANKSEL	OPTION_REG
MOVWF	OPTION_REG
;Added For baseline Chips with write only option_reg
;If Timer0 is 16-bit capable
BANKSEL	STATUS
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
