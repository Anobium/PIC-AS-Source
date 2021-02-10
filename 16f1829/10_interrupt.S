;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\10_interrupt.S"
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
 SAVEDELAYTEMP                    EQU 32                    ; 0X20
 SAVEDELAYTEMP2                   EQU 33                    ; 0X21
 SAVEPCLATH                       EQU 34                    ; 0X22
 SAVESYSWAITTEMPMS                EQU 35                    ; 0X23
 SAVESYSWAITTEMPMS_H              EQU 36                    ; 0X24
 SYSBSR                           EQU 37                    ; 0X25
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 38                    ; 0X26
 SYSW                             EQU 126                    ; 0X7E
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 TMRPRES                          EQU 39                    ; 0X27
 TMRSOURCE                        EQU 40                    ; 0X28
 _DIRECTION                       EQU 41                    ; 0X29

;********************************************************************************

 PSECT   RESETVEC,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
INTERRUPT:

;********************************************************************************

;SAVE CONTEXT
	MOVWF	SYSW
	SWAPF	STATUS,W
	MOVWF	SYSSTATUS
	MOVF	BSR,W
BANKSEL	STATUS
	MOVWF	SYSBSR
;STORE SYSTEM VARIABLES
	MOVF	SYSWAITTEMPMS,W
	MOVWF	SAVESYSWAITTEMPMS
	MOVF	SYSWAITTEMPMS_H,W
	MOVWF	SAVESYSWAITTEMPMS_H
	MOVF	DELAYTEMP2,W
	MOVWF	SAVEDELAYTEMP2
	MOVF	DELAYTEMP,W
	MOVWF	SAVEDELAYTEMP
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
;B7: ASM Source was:  BTFSS INTCON,TMR0IE
	BTFSS	INTCON,5
	GOTO	NOTTMR0IF
;B7: ASM Source was:  BTFSS INTCON,TMR0IF
	BTFSS	INTCON,2
	GOTO	NOTTMR0IF
	CALL	INTERRUPTHANDLER
;B7: ASM Source was:  BCF INTCON,TMR0IF
	BCF	INTCON,2
	GOTO	INTERRUPTDONE
NOTTMR0IF:
;B7: ASM Source was:  BTFSS INTCON,IOCIE
	BTFSS	INTCON,3
	GOTO	NOTIOCIF
;B7: ASM Source was:  BTFSS INTCON,IOCIF
	BTFSS	INTCON,0
	GOTO	NOTIOCIF
	CALL	INTERRUPTHANDLER
;B7: ASM Source was:  BCF INTCON,IOCIF
	BCF	INTCON,0
	GOTO	INTERRUPTDONE
NOTIOCIF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	MOVF	SAVESYSWAITTEMPMS,W
	MOVWF	SYSWAITTEMPMS
	MOVF	SAVESYSWAITTEMPMS_H,W
	MOVWF	SYSWAITTEMPMS_H
	MOVF	SAVEDELAYTEMP2,W
	MOVWF	DELAYTEMP2
	MOVF	SAVEDELAYTEMP,W
	MOVWF	DELAYTEMP
	MOVF	SAVEPCLATH,W
MOVWF	PCLATH
	MOVF	SYSBSR,W
MOVWF	BSR
	SWAPF	SYSSTATUS,W
MOVWF	STATUS
	SWAPF	SYSW,F
	SWAPF	SYSW,W
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	53
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;B7: ASM Source was:  BSF INTCON,PEIE
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''  Lesson 10 - "Interrupts and Pull-ups"
;''
;''  This lesson will introduce interrupts and how they are useful. It will
;''  also introduce internal weak pull-ups that are available on most PICs.
;''
;''  It should be noted that this lesson is more efficent than the last
;''  one, "Timer0". Notice how the processor is no longer waiting for
;''  Timer0 to roll over. Instead, we let the hardware modules do the work,
;''  freeing the CPU to do other things in the main loop
;''
;''  The switch is no longer continuously polled for a button press. Instead,
;''  an interrupt will occur which will automically place the program counter
;''  inside of the ISR where we can change directions outisde of normal code execution
;''
;''  LEDs rotate at a constant speed and the switch reverses their direction
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
;#DEFINE DOWN                0
;#DEFINE UP                  1
;#DEFINE SWITCH              PORTA.3
;#DEFINE LED_RIGHT           1
;#DEFINE LED_LEFT            0
;if this is uncommented, the trace under JP5 can be cut
;#DEFINE PULL_UPS
;with no affect on the output
;' -------------------LATC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|DS4|DS3|DS2|DS1|-
;'-----------------------------------------
;'
;Dim _DIRECTION As Byte
;Dir portc Out
BANKSEL	TRISC
CLRF	TRISC
;portc = 0
BANKSEL	PORTC
CLRF	PORTC
;portc.3 = 1
BANKSEL	LATC
	BSF	LATC,3
;start with LEDs rotating from right to left
;_direction = LED_RIGHT
	MOVLW	1
	BANKSEL	_DIRECTION
	MOVWF	_DIRECTION
;setup switch (SW1)
;Dir switch In
BANKSEL	TRISA
	BSF	TRISA,3
;enable the weak pull-up for the switch
;WPUA2 = 1
BANKSEL	WPUA
;B7: ASM Source was:  BSF WPUA,WPUA2
	BSF	WPUA,2
;enable the global weak pull-up bit
;NOT_WPUEN = 0
BANKSEL	OPTION_REG
;B7: ASM Source was:  BCF OPTION_REG,NOT_WPUEN
	BCF	OPTION_REG,7
;TMR0IE = 1
;B7: ASM Source was:  BSF INTCON,TMR0IE
	BSF	INTCON,5
;InitTimer0 Osc, PS0_256
	MOVLW	1
	BANKSEL	TMRSOURCE
	MOVWF	TMRSOURCE
	MOVLW	7
	MOVWF	TMRPRES
	CALL	INITTIMER0178
;On Interrupt Timer0Overflow Call InterruptHandler
;B7: ASM Source was:  BSF INTCON,TMR0IE
	BSF	INTCON,5
;IOCAN3 = 1
BANKSEL	IOCAN
;B7: ASM Source was:  BSF IOCAN,IOCAN3
	BSF	IOCAN,3
;IOCIE = 1
;B7: ASM Source was:  BSF INTCON,IOCIE
	BSF	INTCON,3
;On Interrupt PORTChange  Call InterruptHandler
;B7: ASM Source was:  BSF INTCON,IOCIE
	BSF	INTCON,3
;Do
SYSDOLOOP_S1:
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
	MOVLW	38
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	3
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
INITTIMER0178:
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
	GOTO	ELSE8_1
;Set TMRPres.5 ON   'EXT
	BSF	TMRPRES,5
;ELSE
	GOTO	ENDIF8
ELSE8_1:
;Set TMRPres.5 OFF  'OSC
	BCF	TMRPRES,5
;END IF
ENDIF8:
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

;SOURCE: 10_INTERRUPT.GCB (89)
INTERRUPTHANDLER:
;If IOCAF3 = 1 Then
BANKSEL	IOCAF
;B7: ASM Source was:  BTFSS IOCAF,IOCAF3
	BTFSS	IOCAF,3
	GOTO	ENDIF1
;SW1 was just pressed
;must clear the flag in software
;IOCAF3 = 0
;B7: ASM Source was:  BCF IOCAF,IOCAF3
	BCF	IOCAF,3
;debounce by waiting and seeing if still held down
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;If ( SWITCH = DOWN ) Then
	BTFSC	PORTA,3
	GOTO	ENDIF3
;change directions
;_direction = 1 XOR _direction
	MOVLW	1
	XORWF	_DIRECTION,F
;End If
ENDIF3:
;End If
ENDIF1:
;If T0IF = 1 Then
;B7: ASM Source was:  BTFSS INTCON,T0IF
	BTFSS	INTCON,2
	GOTO	ENDIF2
;Timer has overflowed
;T0IF = 0
;B7: ASM Source was:  BCF INTCON,T0IF
	BCF	INTCON,2
;If  _direction.0 = LED_RIGHT  Then
	BANKSEL	_DIRECTION
	BTFSS	_DIRECTION,0
	GOTO	ELSE4_1
;shift to the right by 1
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Right
	RRF	PORTC,F
;when the last LED is lit, restart the pattern
;If C = 1 Then
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
	GOTO	ENDIF5
;portc.3 = 1
BANKSEL	LATC
	BSF	LATC,3
;End If
ENDIF5:
;Else
	GOTO	ENDIF4
ELSE4_1:
;shift to the left by 1
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Left
	RLF	PORTC,F
;when the last LED is lit, restart the pattern
;If  portC.4 = 1 Then
	BTFSS	PORTC,4
	GOTO	ENDIF6
;portC.0 = 1
BANKSEL	LATC
	BSF	LATC,0
;portC.4 = 0
	BCF	LATC,4
;End If
ENDIF6:
;End If
ENDIF4:
;End If
ENDIF2:
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
