;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\08_pwm.S"
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
 ADREADPORT                       EQU 32                    ; 0X20
 CALCULATEDPWM                    EQU 33                    ; 0X21
 CALCULATEDPWM_H                  EQU 34                    ; 0X22
 CCPCONCACHE                      EQU 35                    ; 0X23
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 PRX_TEMP                         EQU 36                    ; 0X24
 PRX_TEMP_E                       EQU 39                    ; 0X27
 PRX_TEMP_H                       EQU 37                    ; 0X25
 PRX_TEMP_U                       EQU 38                    ; 0X26
 PWMCHANNEL                       EQU 40                    ; 0X28
 PWMDUTY                          EQU 41                    ; 0X29
 PWMDUTY_H                        EQU 42                    ; 0X2A
 PWMFREQ                          EQU 43                    ; 0X2B
 PWMRESOLUTION                    EQU 44                    ; 0X2C
 PWMRESOLUTION_H                  EQU 45                    ; 0X2D
 READAD10                         EQU 46                    ; 0X2E
 READAD10_H                       EQU 47                    ; 0X2F
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSLONGDIVMULTA                  EQU 48                    ; 0X30
 SYSLONGDIVMULTA_E                EQU 51                    ; 0X33
 SYSLONGDIVMULTA_H                EQU 49                    ; 0X31
 SYSLONGDIVMULTA_U                EQU 50                    ; 0X32
 SYSLONGDIVMULTB                  EQU 52                    ; 0X34
 SYSLONGDIVMULTB_E                EQU 55                    ; 0X37
 SYSLONGDIVMULTB_H                EQU 53                    ; 0X35
 SYSLONGDIVMULTB_U                EQU 54                    ; 0X36
 SYSLONGDIVMULTX                  EQU 56                    ; 0X38
 SYSLONGDIVMULTX_E                EQU 59                    ; 0X3B
 SYSLONGDIVMULTX_H                EQU 57                    ; 0X39
 SYSLONGDIVMULTX_U                EQU 58                    ; 0X3A
 SYSLONGTEMPA                     EQU 117                    ; 0X75
 SYSLONGTEMPA_E                   EQU 120                    ; 0X78
 SYSLONGTEMPA_H                   EQU 118                    ; 0X76
 SYSLONGTEMPA_U                   EQU 119                    ; 0X77
 SYSLONGTEMPB                     EQU 121                    ; 0X79
 SYSLONGTEMPB_E                   EQU 124                    ; 0X7C
 SYSLONGTEMPB_H                   EQU 122                    ; 0X7A
 SYSLONGTEMPB_U                   EQU 123                    ; 0X7B
 SYSLONGTEMPX                     EQU 112                    ; 0X70
 SYSLONGTEMPX_E                   EQU 115                    ; 0X73
 SYSLONGTEMPX_H                   EQU 113                    ; 0X71
 SYSLONGTEMPX_U                   EQU 114                    ; 0X72
 SYSTEMP1                         EQU 60                    ; 0X3C
 SYSTEMP1_E                       EQU 63                    ; 0X3F
 SYSTEMP1_H                       EQU 61                    ; 0X3D
 SYSTEMP1_U                       EQU 62                    ; 0X3E
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 SYSWORDTEMPX                     EQU 112                    ; 0X70
 SYSWORDTEMPX_H                   EQU 113                    ; 0X71
 TIMERSELECTIONBITS               EQU 64                    ; 0X40
 TX_PR                            EQU 65                    ; 0X41
 _PWMTIMERSELECTED                EQU 66                    ; 0X42

;********************************************************************************

;ALIAS VARIABLES
 SYSREADAD10WORD                  EQU 46
 SYSREADAD10WORD_H                EQU 47

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
	CALL	INITPWM

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;'' Lesson 8 - "PWM"
;''
;'' Pulse-Width Modulation (PWM) is a scheme that provides power to a load by switching
;'' quickly between fully on and fully off states. The PWM signal resembles a square wave
;'' where the high portion of the signal is considered the on state and the low portion of
;'' the signal is considered the off state. The high portion, also known as the pulse width,
;'' can vary in time and is defined in steps. A longer, high on time will illuminate the LED
;'' brighter. The frequency or period of the PWM does not change. A larger number of
;'' steps applied, which lengthens the pulse width, also supplies more power to the load.
;'' Lowering the number of steps applied, which shortens the pulse width, supplies less
;'' power. The PWM period is defined as the duration of one complete cycle or the total
;'' amount of on and off time combined.
;''
;'' Demo1.  Rotating the POT will adjust the brightness of a single CCP port.
;'' Demo2.  Shows a how the changing PWM values across four CCP ports
;''
;'' As CCP1 is connect to portc.x you have two choices....
;'' 1. Connect the output of CCPx to the output of any of the existing LEDs ports, such as portc.0, portc.1, portc.2 or portc.3
;'' 2. Or, connect an LED via a suitable resistor to portc.x then to 0v.  Like MCU portc.x ---> resistor 1kOhmns ----> Ov
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
;'' As CCP1 is connect to portc.x you have two choices....
;'' 1. Connect the output of CCPx to the output of any of the existing LEDs ports, such as portc.0, portc.1, portc.2 or portc.3
;'' 2. Or, connect an LED via a suitable resistor to portc.x then to 0v.  Like MCU portc.x ---> resistor 1kOhmns ----> Ov
;''
;#DEFINE demo1
;#define demo2
;' -------------------LATC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|DS4|DS3|DS2|DS1|-
;'-----------------------------------------
;'
;Dir portc Out
BANKSEL	TRISC
CLRF	TRISC
;Dir portc.3 Out
	BCF	TRISC,3
;Dim calculatedPWM As Word
;Do
SYSDOLOOP_S1:
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;calculatedPWM = ( ( ReadAD10 ( AN0 ) * 10  ) / ADC_adjustment   )
	CLRF	ADREADPORT
	CALL	FN_READAD106
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSMULTSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	SYSTEMP1
	MOVF	SYSWORDTEMPX_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	32
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	CALCULATEDPWM
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	CALCULATEDPWM_H
;If calculatedPWM > 255 Then calculatedPWM = 255
	MOVF	CALCULATEDPWM,W
	MOVWF	SYSWORDTEMPB
	MOVF	CALCULATEDPWM_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	255
	MOVWF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF1
	MOVLW	255
	MOVWF	CALCULATEDPWM
	CLRF	CALCULATEDPWM_H
ENDIF1:
;HPWM 2, 40, calculatedPWM
	MOVLW	2
	MOVWF	PWMCHANNEL
	MOVLW	40
	MOVWF	PWMFREQ
	MOVF	CALCULATEDPWM,W
	MOVWF	PWMDUTY
	MOVF	CALCULATEDPWM_H,W
	MOVWF	PWMDUTY_H
	CALL	HPWM24
	MOVF	PWMDUTY,W
	MOVWF	CALCULATEDPWM
	MOVF	PWMDUTY_H,W
	MOVWF	CALCULATEDPWM_H
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;'' As CCP1 is connect to portc.x you have two choices....
;'' 1. Connect the output of CCPx to the output of any of the existing LEDs ports, such as portc.0, portc.1, portc.2 or portc.3
;'' 2. Or, connect an LED via a suitable resistor to portc.x then to 0v.  Like MCU portc.x ---> resistor 1kOhmns ----> Ov
;''
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	5
	MOVWF	DELAYTEMP
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
	RETURN

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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: PWM.H (2697)
HPWM24:
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
;If HPWM_FAST operation selected, only recalculate timer prescaler when
;needed. Gives faster operation, but uses extra byte of RAM and may cause
;problems if HPWM and PWMOn are used together in a program.
;(No issues using HPWM and PWMOff in the same program with HPWM_FAST.)
;Commence calculations of PMW parameters
;This figures out Postscaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply set Tx_PR to 1,4 or 16
;Tx_PR = 1
	MOVLW	1
	MOVWF	TX_PR
;PRx_Temp = PWMOsc1 / PWMFreq
	MOVLW	208
	MOVWF	SYSLONGTEMPA
	MOVLW	7
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	PWMFREQ,W
	MOVWF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPA,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	PRX_TEMP_E
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF7
;Tx_PR = 4
	MOVLW	4
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF7:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF8
;Tx_PR = 16
	MOVLW	16
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF8:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF9
;Tx_PR = 64
	MOVLW	64
	MOVWF	TX_PR
;Divide by 4
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate PRx_Temp right
	RRF	PRX_TEMP_E,F
	RRF	PRX_TEMP_U,F
	RRF	PRX_TEMP_H,F
	RRF	PRX_TEMP,F
;end if
ENDIF9:
;added to handle different timer sources
;added to support HPWM_CCPTimerN. Makes the code longer but more flexible
;user optimisation to reduce code.
CCPPWMSETUPCLOCKSOURCE:
;select case _PWMTimerSelected
;case 2:
SYSSELECT2CASE1:
	MOVLW	2
	SUBWF	_PWMTIMERSELECTED,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE2
;PR2 = PRx_Temp
	MOVF	PRX_TEMP,W
MOVWF	PR2
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T2CKPS0 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS0
	BCF	T2CON,0
;SET T2CKPS1 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS1
	BCF	T2CON,1
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS0 ON
	MOVLW	4
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;B7: ASM Source was:  BSF T2CON,T2CKPS0
	BSF	T2CON,0
;if Tx_PR = 16 then SET T2CKPS1 ON
	MOVLW	16
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,1
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T2CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T2CKPS0 ON: SET T2CKPS1 ON
	MOVLW	64
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
;B7: ASM Source was:  BSF T2CON,T2CKPS0
	BSF	T2CON,0
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,1
ENDIF12:
;Set Clock Source, if required
;case 4:
	GOTO	SYSSELECTEND2
SYSSELECT2CASE2:
	MOVLW	4
	SUBWF	_PWMTIMERSELECTED,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT2CASE3
;PR4 = PRx_Temp
	MOVF	PRX_TEMP,W
BANKSEL	PR4
MOVWF	PR4
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T4CKPS0 OFF
;B7: ASM Source was:  BCF T4CON,T4CKPS0
	BCF	T4CON,0
;SET T4CKPS1 OFF
;B7: ASM Source was:  BCF T4CON,T4CKPS1
	BCF	T4CON,1
;Set Prescaler bits
;if Tx_PR = 4  then SET T4CKPS0 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS0
	BSF	T4CON,0
ENDIF13:
;if Tx_PR = 16 then SET T4CKPS1 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS1
	BSF	T4CON,1
ENDIF14:
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T4CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T4CKPS0 ON: SET T4CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS0
	BSF	T4CON,0
;B7: ASM Source was:  BSF T4CON,T4CKPS1
	BSF	T4CON,1
ENDIF15:
;Set Clock Source, if required
;case 6:
	GOTO	SYSSELECTEND2
SYSSELECT2CASE3:
	MOVLW	6
	SUBWF	_PWMTIMERSELECTED,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND2
;PR6 = PRx_Temp
	MOVF	PRX_TEMP,W
BANKSEL	PR6
MOVWF	PR6
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T6CKPS0 OFF
;B7: ASM Source was:  BCF T6CON,T6CKPS0
	BCF	T6CON,0
;SET T6CKPS1 OFF
;B7: ASM Source was:  BCF T6CON,T6CKPS1
	BCF	T6CON,1
;Set Prescaler bits
;if Tx_PR = 4  then SET T6CKPS0 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS0
	BSF	T6CON,0
ENDIF16:
;if Tx_PR = 16 then SET T6CKPS1 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS1
	BSF	T6CON,1
ENDIF17:
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T6CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T6CKPS0 ON: SET T6CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF18
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS0
	BSF	T6CON,0
;B7: ASM Source was:  BSF T6CON,T6CKPS1
	BSF	T6CON,1
ENDIF18:
;Set Clock Source, if required
;end Select
SYSSELECTEND2:
END_OF_CCPPWMSETUPCLOCKSOURCE:
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS:
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
	BANKSEL	_PWMTIMERSELECTED
	RRF	_PWMTIMERSELECTED,W
	MOVWF	SYSTEMP1
	DECF	SYSTEMP1,W
	MOVWF	TIMERSELECTIONBITS
SETUPCCPPWMREGISTERS:
;C1TSEL0 = TimerSelectionBits.0
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C1TSEL0
	BCF	CCPTMRS,0
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF27
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C1TSEL0
	BSF	CCPTMRS,0
ENDIF27:
;C1TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C1TSEL1
	BCF	CCPTMRS,1
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF28
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C1TSEL1
	BSF	CCPTMRS,1
ENDIF28:
;Devices with more than one CCP
;if PWMChannel = 1 then
	BANKSEL	PWMCHANNEL
	DECF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF19
;ifndef BIT(CCP1FMT) Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L for PWM
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  'Correction
	MOVLW	2
	ADDWF	PRX_TEMP,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W
	MOVWF	SYSTEMP1_U
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W
	MOVWF	SYSTEMP1_E
	MOVF	PWMDUTY,W
	MOVWF	SYSLONGTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSTEMP1_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSTEMP1_E,W
	MOVWF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	PRX_TEMP_E
;CCPR1L = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR1L
MOVWF	CCPR1L
;If PWMDuty = 0 Then CCPR1L = 0  ' Assure OFF at Zero
	BANKSEL	PWMDUTY
	MOVF	PWMDUTY,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF23
BANKSEL	CCPR1L
CLRF	CCPR1L
ENDIF23:
;SET CCP1M3 ON
BANKSEL	CCP1CON
;B7: ASM Source was:  BSF CCP1CON,CCP1M3
	BSF	CCP1CON,3
;SET CCP1M2 ON
;B7: ASM Source was:  BSF CCP1CON,CCP1M2
	BSF	CCP1CON,2
;SET CCP1M1 OFF
;B7: ASM Source was:  BCF CCP1CON,CCP1M1
	BCF	CCP1CON,1
;SET CCP1M0 OFF
;B7: ASM Source was:  BCF CCP1CON,CCP1M0
	BCF	CCP1CON,0
;C1TSEL0 = TimerSelectionBits.0
;B7: ASM Source was:  BCF CCPTMRS,C1TSEL0
	BCF	CCPTMRS,0
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF29
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C1TSEL0
	BSF	CCPTMRS,0
ENDIF29:
;C1TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C1TSEL1
	BCF	CCPTMRS,1
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF30
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C1TSEL1
	BSF	CCPTMRS,1
ENDIF30:
;end if
ENDIF19:
;if PWMChannel = 2 then
	MOVLW	2
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF20
;PRx_Temp = PWMDuty * ( PRx_Temp + 2)  'Correction
	MOVLW	2
	ADDWF	PRX_TEMP,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W
	MOVWF	SYSTEMP1_U
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W
	MOVWF	SYSTEMP1_E
	MOVF	PWMDUTY,W
	MOVWF	SYSLONGTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSTEMP1_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSTEMP1_E,W
	MOVWF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	PRX_TEMP_E
;CCPR2L = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR2L
MOVWF	CCPR2L
;If PWMDuty = 0 Then CCPR2L = 0  ' Assure OFF at Zero
	BANKSEL	PWMDUTY
	MOVF	PWMDUTY,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF24
BANKSEL	CCPR2L
CLRF	CCPR2L
ENDIF24:
;SET CCP2M3 ON
BANKSEL	CCP2CON
;B7: ASM Source was:  BSF CCP2CON,CCP2M3
	BSF	CCP2CON,3
;SET CCP2M2 ON
;B7: ASM Source was:  BSF CCP2CON,CCP2M2
	BSF	CCP2CON,2
;SET CCP2M1 OFF
;B7: ASM Source was:  BCF CCP2CON,CCP2M1
	BCF	CCP2CON,1
;SET CCP2M0 OFF
;B7: ASM Source was:  BCF CCP2CON,CCP2M0
	BCF	CCP2CON,0
;C2TSEL0 = TimerSelectionBits.0
;B7: ASM Source was:  BCF CCPTMRS,C2TSEL0
	BCF	CCPTMRS,2
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF31
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C2TSEL0
	BSF	CCPTMRS,2
ENDIF31:
;C2TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C2TSEL1
	BCF	CCPTMRS,3
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF32
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C2TSEL1
	BSF	CCPTMRS,3
ENDIF32:
;end if
ENDIF20:
;if PWMChannel = 3 then 'USE_HPWMCCP3 TRUE
	MOVLW	3
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF21
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  'Correction
	MOVLW	2
	ADDWF	PRX_TEMP,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W
	MOVWF	SYSTEMP1_U
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W
	MOVWF	SYSTEMP1_E
	MOVF	PWMDUTY,W
	MOVWF	SYSLONGTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSTEMP1_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSTEMP1_E,W
	MOVWF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	PRX_TEMP_E
;CCPR3L = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR3L
MOVWF	CCPR3L
;If PWMDuty = 0 Then CCPR3L = 0  ' Assure OFF at Zero
	BANKSEL	PWMDUTY
	MOVF	PWMDUTY,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF25
BANKSEL	CCPR3L
CLRF	CCPR3L
ENDIF25:
;SET CCP3M3 ON
BANKSEL	CCP3CON
;B7: ASM Source was:  BSF CCP3CON,CCP3M3
	BSF	CCP3CON,3
;SET CCP3M2 ON
;B7: ASM Source was:  BSF CCP3CON,CCP3M2
	BSF	CCP3CON,2
;SET CCP3M1 OFF
;B7: ASM Source was:  BCF CCP3CON,CCP3M1
	BCF	CCP3CON,1
;SET CCP3M0 OFF
;B7: ASM Source was:  BCF CCP3CON,CCP3M0
	BCF	CCP3CON,0
;C3TSEL0 = TimerSelectionBits.0
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C3TSEL0
	BCF	CCPTMRS,4
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF33
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C3TSEL0
	BSF	CCPTMRS,4
ENDIF33:
;C3TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C3TSEL1
	BCF	CCPTMRS,5
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF34
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C3TSEL1
	BSF	CCPTMRS,5
ENDIF34:
;end if
ENDIF21:
;if PWMChannel = 4 then  'USE_HPWMCCP4 TRUE
	MOVLW	4
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF22
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  '
	MOVLW	2
	ADDWF	PRX_TEMP,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W
	MOVWF	SYSTEMP1_U
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W
	MOVWF	SYSTEMP1_E
	MOVF	PWMDUTY,W
	MOVWF	SYSLONGTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSTEMP1_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSTEMP1_E,W
	MOVWF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	PRX_TEMP
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	PRX_TEMP_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	PRX_TEMP_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	PRX_TEMP_E
;CCPR4L = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR4L
MOVWF	CCPR4L
;If PWMDuty = 0 Then CCPR4L = 0  ' Assure OFF at Zero
	BANKSEL	PWMDUTY
	MOVF	PWMDUTY,W
	MOVWF	SYSWORDTEMPA
	MOVF	PWMDUTY_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF26
BANKSEL	CCPR4L
CLRF	CCPR4L
ENDIF26:
;SET CCP4M3 ON'These my have been remapped using a script - do check ASM and script in INITPWM @1@CCP4
BANKSEL	CCP4CON
;B7: ASM Source was:  BSF CCP4CON,CCP4M3
	BSF	CCP4CON,3
;SET CCP4M2 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP4CON,CCP4M2
	BSF	CCP4CON,2
;SET CCP4M1 OFF'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BCF CCP4CON,CCP4M1
	BCF	CCP4CON,1
;SET CCP4M0 OFF'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BCF CCP4CON,CCP4M0
	BCF	CCP4CON,0
;C4TSEL0 = TimerSelectionBits.0
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C4TSEL0
	BCF	CCPTMRS,6
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF35
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C4TSEL0
	BSF	CCPTMRS,6
ENDIF35:
;C4TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS
;B7: ASM Source was:  BCF CCPTMRS,C4TSEL1
	BCF	CCPTMRS,7
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF36
BANKSEL	CCPTMRS
;B7: ASM Source was:  BSF CCPTMRS,C4TSEL1
	BSF	CCPTMRS,7
ENDIF36:
;end if
ENDIF22:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: PWM.H (192)
INITPWM:
;_PWMTimerSelected = 2
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
;Script to calculate constants required for given Frequency and Duty Cycle
LEGACY_STARTOFFIXEDCCPPWMMODECODE:
;You can disable all the legacy CCPPWM fixed mode code to reduce program size
;This section is Library code, so it generates ASM
;This section uses the constants defined the script above.
;Essentially, sets CCPCONCache with the bits set correctly.
;And, timer 2.  Remember timer 2 can be the timer for CCP/PWM but the other timers can be specified for certain parts.
;If CCP1CON does not exist then there is NO CCP1 so no point in setting, as all this is to set up the CCP1 using constants method
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	CLRF	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	MOVLW	52
MOVWF	PR2
;SET T2CON.T2CKPS0 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS0
	BCF	T2CON,0
;SET T2CON.T2CKPS1 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS1
	BCF	T2CON,1
;Set Duty cycle
;This is the legacy code to support only one CCPPWM channel
;CCPR1L = DutyCycleH
	MOVLW	26
BANKSEL	CCPR1L
MOVWF	CCPR1L
;SET CCPCONCache.DC1B1 ON
	BANKSEL	CCPCONCACHE
;B7: ASM Source was:  BSF CCPCONCACHE,DC1B1
	BSF	CCPCONCACHE,5
;SET CCPCONCache.DC1B0 OFF
;B7: ASM Source was:  BCF CCPCONCACHE,DC1B0
	BCF	CCPCONCACHE,4
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
;B7: ASM Source was:  BSF CCPCONCACHE,CCP1M3
	BSF	CCPCONCACHE,3
;B7: ASM Source was:  BSF CCPCONCACHE,CCP1M2
	BSF	CCPCONCACHE,2
;B7: ASM Source was:  BCF CCPCONCACHE,CCP1M1
	BCF	CCPCONCACHE,1
;B7: ASM Source was:  BCF CCPCONCACHE,CCP1M0
	BCF	CCPCONCACHE,0
;Enable Timer 2
;SET T2CON.TMR2ON ON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,2
;This is the end of script section, now we use the constants created to updated registers.
STARTOFFIXEDPWMMODECODE:
;Set registers using the constants from script
;This is repeated for timer 2, 4 and 6 - and the two timer variants and the 9 PWM channels
;This uses the user defined constants to set the appropiate registers.
SETPWMDUTYCODE:
;This section finally, sets the Duty using the constants from the script.
;This uses the user defined constants to set the appropiate registers.
REV2018_ENDOFFIXEDPWMMODECODE:
;This is the end of the fixed PWM Mode handler
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD106:
;Always RIGHT justified
;SET ADFM ON
BANKSEL	ADCON1
;B7: ASM Source was:  BSF ADCON1,ADFM
	BSF	ADCON1,7
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (371)
;Handle devices with no ANSEL0 AND no ANSEL
;Code for devices with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;ChipPins = 20
;#ifNdef Bit(CHS5)
;Case 0: Set ANSELA.0 On
SYSSELECT1CASE1:
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE2:
	DECF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 4: Set ANSELc.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE6
BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 5: Set ANSELc.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE7
BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 6: Set ANSELc.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE8
BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 7: Set ANSELc.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE9
BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 8: Set ANSELc.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE10
BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 9: Set ANSELc.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE11
BANKSEL	ANSELC
	BSF	ANSELC,7
;Case 10: Set ANSELb.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE12
BANKSEL	ANSELB
	BSF	ANSELB,4
;Case 11: Set ANSELb.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELB
	BSF	ANSELB,5
;End Select  'End Select #1
SYSSELECTEND1:
;SET ADCS2 OFF
BANKSEL	ADCON1
;B7: ASM Source was:  BCF ADCON1,ADCS2
	BCF	ADCON1,6
;SET ADCS1 OFF
;B7: ASM Source was:  BCF ADCON1,ADCS1
	BCF	ADCON1,5
;SET ADCS0 ON
;B7: ASM Source was:  BSF ADCON1,ADCS0
	BSF	ADCON1,4
;Choose port
;SET CHS0 OFF
;B7: ASM Source was:  BCF ADCON0,CHS0
	BCF	ADCON0,2
;SET CHS1 OFF
;B7: ASM Source was:  BCF ADCON0,CHS1
	BCF	ADCON0,3
;SET CHS2 OFF
;B7: ASM Source was:  BCF ADCON0,CHS2
	BCF	ADCON0,4
;SET CHS3 OFF
;B7: ASM Source was:  BCF ADCON0,CHS3
	BCF	ADCON0,5
;SET CHS4 OFF
;B7: ASM Source was:  BCF ADCON0,CHS4
	BCF	ADCON0,6
;IF ADReadPort.0 On Then Set CHS0 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,0
	GOTO	ENDIF2
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS0
	BSF	ADCON0,2
ENDIF2:
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,1
	GOTO	ENDIF3
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS1
	BSF	ADCON0,3
ENDIF3:
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,2
	GOTO	ENDIF4
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS2
	BSF	ADCON0,4
ENDIF4:
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,3
	GOTO	ENDIF5
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS3
	BSF	ADCON0,5
ENDIF5:
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,4
	GOTO	ENDIF6
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS4
	BSF	ADCON0,6
ENDIF6:
;Enable A/D
;SET ADON ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,ADON
	BSF	ADCON0,0
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,GO_NOT_DONE
	BSF	ADCON0,1
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,1
	GOTO	SYSWAITLOOP1
;Switch off A/D
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
;Write output
;ReadAD10 = ADRESL
BANKSEL	ADRESL
	MOVF	ADRESL,W
	BANKSEL	READAD10
	MOVWF	READAD10
	CLRF	READAD10_H
;ReadAD10_H = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD10_H
	MOVWF	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
BANKSEL	ADCON1
;B7: ASM Source was:  BCF ADCON1,ADFM
	BCF	ADCON1,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2894)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2948)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	MOVF	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	SUBWF	SYSLONGTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysLongTempA_H, W
	MOVF	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	SUBWF	SYSLONGTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempA_U, W
	MOVF	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	SUBWF	SYSLONGTEMPB_U, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempA_E, W
	MOVF	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	SUBWF	SYSLONGTEMPB_E, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3065)
SYSCOMPLESSTHAN16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
SCLT16TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3123)
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
;B7: ASM Source was:  BTFSS STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
;B7: ASM Source was:  BTFSS STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;If not more and not zero, is less
;btfss STATUS,Z
;B7: ASM Source was:  BTFSS STATUS,Z
	BTFSS	STATUS,2
;goto SCLT32True
	GOTO	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W
;btfsc STATUS,C
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2712)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF41
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF41:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
SYSDIV16START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	GOTO	ENDIF42
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF42:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2788)
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF43
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
ENDIF43:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP
SYSDIV32START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysLongDivMultA Left
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	RLF	SYSLONGDIVMULTX,F
	RLF	SYSLONGDIVMULTX_H,F
	RLF	SYSLONGDIVMULTX_U,F
	RLF	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	SUBWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	SUBWFB	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	SUBWFB	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	SUBWFB	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	GOTO	ENDIF44
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;End If
ENDIF44:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv32Start
	GOTO	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTA_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTA_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTA_E,W
	MOVWF	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2467)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	BTFSS	SYSDIVMULTB,0
	GOTO	ENDIF37
	MOVF	SYSDIVMULTA,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTA_H,W
	ADDWFC	SYSDIVMULTX_H,F
ENDIF37:
;set STATUS.C OFF
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysDivMultB right
	RRF	SYSDIVMULTB_H,F
	RRF	SYSDIVMULTB,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysDivMultA left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	MUL16LOOP
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2584)
SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BTFSS	SYSLONGDIVMULTB,0
	GOTO	ENDIF39
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
ENDIF39:
;set STATUS.C OFF
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysLongDivMultB right
	RRF	SYSLONGDIVMULTB_E,F
	RRF	SYSLONGDIVMULTB_U,F
	RRF	SYSLONGDIVMULTB_H,F
	RRF	SYSLONGDIVMULTB,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysLongDivMultA left
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPB_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPB_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	CALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0
	GOTO	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
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
