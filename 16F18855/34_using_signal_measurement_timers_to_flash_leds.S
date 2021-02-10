;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\34_using_signal_measurement_timers_to_flash_leds.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18855.inc

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
 CONFIG CLKOUTEN = ON
 CONFIG RSTOSC = HFINT32
 CONFIG FEXTOSC = OFF
 CONFIG MCLRE = OFF
 CONFIG WDTE = OFF
 CONFIG LVP = OFF
 CONFIG WRT = OFF
 CONFIG CPD = OFF
 CONFIG CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 SAVEPCLATH                       EQU 32                    ; 0X20
 SAVESYSTEMP1                     EQU 33                    ; 0X21
 SMTCLOCKSOURCEVARIANT            EQU 34                    ; 0X22
 SMTPRES                          EQU 35                    ; 0X23
 SMTSOURCE                        EQU 36                    ; 0X24
 SMTTEMP                          EQU 37                    ; 0X25
 SMTTEMP_E                        EQU 40                    ; 0X28
 SMTTEMP_H                        EQU 38                    ; 0X26
 SMTTEMP_U                        EQU 39                    ; 0X27
 SYSBSR                           EQU 41                    ; 0X29
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 42                    ; 0X2A
 SYSW                             EQU 126                    ; 0X7E
 SYS_DUM                          EQU 43                    ; 0X2B

;********************************************************************************

;ALIAS VARIABLES
 SMT1                             EQU 1164
 SMT1_H                           EQU 1165
 SMT1_U                           EQU 1166
 SMT1_E                           EQU 43
 SMT1PERIOD                       EQU 1173
 SMT1PERIOD_H                     EQU 1174
 SMT1PERIOD_U                     EQU 1175
 SMT1PERIOD_E                     EQU 43
 SMT2                             EQU 1292
 SMT2_H                           EQU 1293
 SMT2_U                           EQU 1294
 SMT2_E                           EQU 43
 SMT2PERIOD                       EQU 1301
 SMT2PERIOD_H                     EQU 1302
 SMT2PERIOD_U                     EQU 1303
 SMT2PERIOD_E                     EQU 43

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
	MOVF	SYSTEMP1,W
	MOVWF	SAVESYSTEMP1
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
BANKSEL	PIE8
;B7: ASM Source was:  BTFSS PIE8,SMT1IE
	BTFSS	PIE8,0
	GOTO	NOTSMT1IF
;B7: ASM Source was:  BTFSS PIR8,SMT1IF
	BTFSS	PIR8,0
	GOTO	NOTSMT1IF
BANKSEL	STATUS
	CALL	BLINKLEDD2
BANKSEL	PIR8
;B7: ASM Source was:  BCF PIR8,SMT1IF
	BCF	PIR8,0
	GOTO	INTERRUPTDONE
NOTSMT1IF:
;B7: ASM Source was:  BTFSS PIE8,SMT2IE
	BTFSS	PIE8,3
	GOTO	NOTSMT2IF
;B7: ASM Source was:  BTFSS PIR8,SMT2IF
	BTFSS	PIR8,3
	GOTO	NOTSMT2IF
BANKSEL	STATUS
	CALL	BLINKLEDD3
BANKSEL	PIR8
;B7: ASM Source was:  BCF PIR8,SMT2IF
	BCF	PIR8,3
	GOTO	INTERRUPTDONE
NOTSMT2IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVESYSTEMP1
	MOVF	SAVESYSTEMP1,W
	MOVWF	SYSTEMP1
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
	ORG	47
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
;'' This demonstration shows the SMT timer in operation
;''
;'' Microchip PIC Microcontrollers have either 1 or 2 Signal Measurement Timers (SMT).
;'' The SMT's can be used as regular 24-bit timers.
;''
;'' The following PIC MIcrocontroller are supported at the time of this program. (Includes "LF" variations)
;''
;'' 12f1612, 16f1613, 16f1614, 16f1615, 16f1618, 16f1619
;'' 16f18854, 16f18855, 16f18856, 16f18857, 16f18875, 16f18876, 16f18877
;'' 18f65k40, 18f66k40, 18f67k40
;''
;'' A 24-bit timer allow for very long timer periods/high resolution and can be quite useful for certain applications.  These timers support multiple clock sources and prescales.  Interrupt on overflow/match is also supported.
;''
;'' These timers will "overflow" when the 24-bit timer value "matches"  the 24-bit period registers. The timer period can be precisely adjusted/set by writing a period value to the repective period register for eact timer.
;''
;'' The maximum period is achieved by a period register value of 16,777,215.
;'' This is the default value at POR. The timer period is also affected by the ChipMhz, TimerSource and Timer Prescale.
;''  The library (SMT_Timers.h)  that supports "normal" timer operation of SMT1/SMT2.  It does not support the advanced signal measurement features.
;''
;'' Available commands are:
;''
;''
;''
;'' InitSMT1 (Source,Prescale)
;'' InitSMT2 (Source,Prescale)
;''
;''   Source can be one of the below:
;''       SMT_AT1_perclk      6
;''       SMT_MFINTOSC        5         (500KHz)
;''       SMT_MFINTOSC_16     4         (500Khz / 16)
;''       SMT_LFINTOSC        3         (32Khz)
;''       SMT_HFINTOSC        2
;''       SMT_FOSC4           1         (FOSC/4)
;''       SMT_FOSC            0
;''
;''   Prescale can be one of the following:
;''     SMTPres_1      1:1
;''     SMTPres_2      1:2
;''     SMTPres_4      1:4
;''     SMTPres_8      1:8
;'' Example:   InitSMT1(SMT_FOSC4,SMTPres_2)
;''
;'' SETSMT1PERIOD (Timervalue)
;'' SETSMT2PERIOD (Timervalue)
;''
;'' StartSMT1    'Starts SMT1
;'' StartSMT2    'Starts SMT2
;''
;'' StopSMT1      'Stops SMT1   '
;'' StopSMT1      'Stops SMT1
;''
;'' SetSMT1 (Timervalue)
;'' SetSMT2 (TimerValue)
;''
;'' ClearSMT1    'Clears SMT1 to 0
;'' ClearSMT2    'Clears SMT2 to 0
;''
;''
;''
;''
;''@author     William Roth
;''@licence    GPL
;''@version    1.00
;''@date       09.6.2017
;''
;----- Configuration
;' -------------------LATA-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|D5 |D4 |D3 |D1 |-
;'-----------------------------------------
;'
;#DEFINE LEDD2 PORTA.0
;#DEFINE LEDD3 PORTA.1
;#DEFINE LEDD4 PORTA.2
;#DEFINE LEDD5 PORTA.3
;#DEFINE Potentiometer   PORTA.4
;Dir     LEDD2 Out
	BCF	TRISA,0
;Dir     LEDD3 Out
	BCF	TRISA,1
;Dir     LEDD4 Out
	BCF	TRISA,2
;Dir     LEDD5 Out
	BCF	TRISA,3
;Dir     Potentiometer In
	BSF	TRISA,4
;1.000s periodwith the parameters of SMT_FOSC and SMTPres_1 within the clock variance of the interclock
;SetSMT1Period ( 4045000 )
;Macro Source: smt_timers.h (201)
;SMT1PERIOD_U = SMTTEMP_U
	MOVF	SMTTEMP_U,W
;B9: ASM Source was:  BANKSEL SMT1PERIOD_U
BANKSEL	SMT1PRU
;B9: ASM Source was:  MOVWF SMT1PERIOD_U
MOVWF	SMT1PRU
;SMT1PERIOD_H = SMTTEMP_H
	BANKSEL	SMTTEMP_H
	MOVF	SMTTEMP_H,W
;B9: ASM Source was:  BANKSEL SMT1PERIOD_H
BANKSEL	SMT1PRH
;B9: ASM Source was:  MOVWF SMT1PERIOD_H
MOVWF	SMT1PRH
;SMT1PERIOD = SMTTEMP
	MOVLW	200
;B9: ASM Source was:  MOVWF SMT1PERIOD
MOVWF	SMT1PRL
	MOVLW	184
;B9: ASM Source was:  MOVWF SMT1PERIOD_H
MOVWF	SMT1PRH
	MOVLW	61
;B9: ASM Source was:  MOVWF SMT1PERIOD_U
MOVWF	SMT1PRU
	BANKSEL	SMT1PERIOD_E
	CLRF	SMT1PERIOD_E
;a perfect internal clock would be 4000000
;4.600s period with the parameters of SMT_FOSC4 and SMTPres_8
;SetSMT2Period ( 9322401 )
;Macro Source: smt_timers.h (207)
;SMT2PERIOD_U = SMTTEMP_U
	MOVF	SMTTEMP_U,W
;B9: ASM Source was:  BANKSEL SMT2PERIOD_U
BANKSEL	SMT2PRU
;B9: ASM Source was:  MOVWF SMT2PERIOD_U
MOVWF	SMT2PRU
;SMT2PERIOD_H = SMTTEMP_H
	BANKSEL	SMTTEMP_H
	MOVF	SMTTEMP_H,W
;B9: ASM Source was:  BANKSEL SMT2PERIOD_H
BANKSEL	SMT2PRH
;B9: ASM Source was:  MOVWF SMT2PERIOD_H
MOVWF	SMT2PRH
;SMT2PERIOD = SMTTEMP
	MOVLW	161
;B9: ASM Source was:  MOVWF SMT2PERIOD
MOVWF	SMT2PRL
	MOVLW	63
;B9: ASM Source was:  MOVWF SMT2PERIOD_H
MOVWF	SMT2PRH
	MOVLW	142
;B9: ASM Source was:  MOVWF SMT2PERIOD_U
MOVWF	SMT2PRU
	BANKSEL	SMT2PERIOD_E
	CLRF	SMT2PERIOD_E
;InitSMT1(SMT_FOSC,SMTPres_1)
	MOVLW	1
	MOVWF	SMTSOURCE
	CLRF	SMTPRES
	CALL	INITSMT1
;InitSMT2(SMT_FOSC4,SMTPres_8)
	CLRF	SMTSOURCE
	MOVLW	3
	MOVWF	SMTPRES
	CALL	INITSMT2
;On Interrupt SMT1Overflow Call BlinkLEDD2
BANKSEL	PIE8
;B7: ASM Source was:  BSF PIE8,SMT1IE
	BSF	PIE8,0
;On Interrupt SMT2Overflow Call BlinkLEDD3
;B7: ASM Source was:  BSF PIE8,SMT2IE
	BSF	PIE8,3
;StartSMT1
;Macro Source: smt_timers.h (189)
;SET SMT1GO ON
BANKSEL	SMT1CON1
;B7: ASM Source was:  BSF SMT1CON1,SMT1GO
	BSF	SMT1CON1,7
;StartSMT2
;Macro Source: smt_timers.h (195)
;SET SMT2GO ON
BANKSEL	SMT2CON1
;B7: ASM Source was:  BSF SMT2CON1,SMT2GO
	BSF	SMT2CON1,7
;Do
SYSDOLOOP_S1:
;// Waiting for interrupts
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
	CLRF	SYS_DUM
;B9: ASM Source was:  BANKSEL SMT1
BANKSEL	SMT1TMRL
;B9: ASM Source was:  CLRF SMT1
CLRF	SMT1TMRL
;B9: ASM Source was:  CLRF SMT1_H
CLRF	SMT1TMRH
;B9: ASM Source was:  CLRF SMT1_U
CLRF	SMT1TMRU
	BANKSEL	SMT1_E
	CLRF	SMT1_E
	CLRF	SYS_DUM
;B9: ASM Source was:  BANKSEL SMT2
BANKSEL	SMT2TMRL
;B9: ASM Source was:  CLRF SMT2
CLRF	SMT2TMRL
;B9: ASM Source was:  CLRF SMT2_H
CLRF	SMT2TMRH
;B9: ASM Source was:  CLRF SMT2_U
CLRF	SMT2TMRU
	BANKSEL	SMT2_E
	CLRF	SMT2_E
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: 34_USING_SIGNAL_MEASUREMENT_TIMERS_TO_FLASH_LEDS.GCB (123)
BLINKLEDD2:
;LEDD2 = !LEDD2
	CLRF	SYSTEMP1
	BTFSC	PORTA,0
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATA,0
	BTFSC	SYSTEMP1,0
	BSF	LATA,0
	RETURN

;********************************************************************************

;SOURCE: 34_USING_SIGNAL_MEASUREMENT_TIMERS_TO_FLASH_LEDS.GCB (129)
BLINKLEDD3:
;LEDD3 = !LEDD3
	CLRF	SYSTEMP1
	BTFSC	PORTA,1
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATA,1
	BTFSC	SYSTEMP1,0
	BSF	LATA,1
	RETURN

;********************************************************************************

;SOURCE: SMT_TIMERS.H (83)
INITSMT1:
;Default to FOSC4 if source is unsupported
;IF SMTClockSourceVariant = 1 then
	DECF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF5
;If SMTSource > 4 then 'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	4
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End if
;End If
ENDIF5:
;If SMTClockSourceVariant = 2 then
	MOVLW	2
	SUBWF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF6
;If SMTSource > 6 then   'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	6
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End IF
;END IF
ENDIF6:
;If SMTClockSourceVariant = 3 then
	MOVLW	3
	SUBWF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF7
;If SMTSource > 7 then   'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	7
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End IF
;END IF
ENDIF7:
;SMT1CLK = SMTSource
	MOVF	SMTSOURCE,W
BANKSEL	SMT1CLK
MOVWF	SMT1CLK
;SMT1CON0 = SMTPres
	BANKSEL	SMTPRES
	MOVF	SMTPRES,W
BANKSEL	SMT1CON0
MOVWF	SMT1CON0
;SET SMT1CON0_EN ON    '''Does not start the timer
;B7: ASM Source was:  BSF SMT1CON0,SMT1CON0_EN
	BSF	SMT1CON0,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SMT_TIMERS.H (113)
INITSMT2:
;Default to FOSC4 if source is unsupported
;IF SMTClockSourceVariant = 1 then
	DECF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
;If SMTSource > 4 then 'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	4
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End if
;End If
ENDIF11:
;If SMTClockSourceVariant = 2 then
	MOVLW	2
	SUBWF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
;If SMTSource > 6 then   'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	6
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End IF
;END IF
ENDIF12:
;If SMTClockSourceVariant = 3 then
	MOVLW	3
	SUBWF	SMTCLOCKSOURCEVARIANT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
;If SMTSource > 7 then   'Unsupported Source
	MOVF	SMTSOURCE,W
	SUBLW	7
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;SMTSource = SMT_FOSC4
	CLRF	SMTSOURCE
;End IF
;END IF
ENDIF13:
;SMT2CLK = SMTSource
	MOVF	SMTSOURCE,W
BANKSEL	SMT2CLK
MOVWF	SMT2CLK
;SMT2CON0 = SMTPres
	BANKSEL	SMTPRES
	MOVF	SMTPRES,W
BANKSEL	SMT2CON0
MOVWF	SMT2CON0
;SET SMT2CON0_EN ON    '''Does not start the timer
;B7: ASM Source was:  BSF SMT2CON0,SMT2CON0_EN
	BSF	SMT2CON0,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
BANKSEL	OSCCON1
MOVWF	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
CLRF	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
CLRF	OSCEN
;Default value
;OSCTUNE = 0x00
CLRF	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F18855 MCU family
;OSCFRQ = 0b00000110
	MOVLW	6
MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;B7: ASM Source was:  BCF ADCON0,ADON
	BCF	ADCON0,7
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
;PORTE = 0
CLRF	PORTE
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
