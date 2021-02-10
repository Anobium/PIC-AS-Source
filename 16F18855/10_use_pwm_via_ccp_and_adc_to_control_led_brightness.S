;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\10_use_pwm_via_ccp_and_adc_to_control_led_brightness.S"
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
 CONFIG CLKOUTEN = OFF
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
 ADREADPORT                       EQU 32                    ; 0X20
 CCPCONCACHE                      EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 PRX_TEMP                         EQU 34                    ; 0X22
 PRX_TEMP_E                       EQU 37                    ; 0X25
 PRX_TEMP_H                       EQU 35                    ; 0X23
 PRX_TEMP_U                       EQU 36                    ; 0X24
 PWMCHANNEL                       EQU 38                    ; 0X26
 PWMDUTY                          EQU 39                    ; 0X27
 PWMDUTY_H                        EQU 40                    ; 0X28
 PWMFREQ                          EQU 41                    ; 0X29
 PWMRESOLUTION                    EQU 42                    ; 0X2A
 PWMRESOLUTION_H                  EQU 43                    ; 0X2B
 READAD                           EQU 44                    ; 0X2C
 SYSBITVAR0                       EQU 45                    ; 0X2D
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSLONGDIVMULTA                  EQU 46                    ; 0X2E
 SYSLONGDIVMULTA_E                EQU 49                    ; 0X31
 SYSLONGDIVMULTA_H                EQU 47                    ; 0X2F
 SYSLONGDIVMULTA_U                EQU 48                    ; 0X30
 SYSLONGDIVMULTB                  EQU 50                    ; 0X32
 SYSLONGDIVMULTB_E                EQU 53                    ; 0X35
 SYSLONGDIVMULTB_H                EQU 51                    ; 0X33
 SYSLONGDIVMULTB_U                EQU 52                    ; 0X34
 SYSLONGDIVMULTX                  EQU 54                    ; 0X36
 SYSLONGDIVMULTX_E                EQU 57                    ; 0X39
 SYSLONGDIVMULTX_H                EQU 55                    ; 0X37
 SYSLONGDIVMULTX_U                EQU 56                    ; 0X38
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
 SYSREPEATTEMP1                   EQU 58                    ; 0X3A
 SYSTEMP1                         EQU 59                    ; 0X3B
 SYSTEMP1_E                       EQU 62                    ; 0X3E
 SYSTEMP1_H                       EQU 60                    ; 0X3C
 SYSTEMP1_U                       EQU 61                    ; 0X3D
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 TIMERSELECTIONBITS               EQU 63                    ; 0X3F
 TX_PR                            EQU 64                    ; 0X40
 _PWMTIMERSELECTED                EQU 65                    ; 0X41

;********************************************************************************

;ALIAS VARIABLES
 SYSREADADBYTE                    EQU 44

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
	CALL	INITPPS
	CALL	INITPWM

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
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
;'' This demonstation shows a how the changing PWM values can dim the LEDs
;''
;'' This demonstration uses CCP5 that is then redirected via PPS to the output LEDs
;''
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 06.3.2017
;''
;Set the PPS for this solution.
;' -------------------LATA-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|D5 |D4 |D3 |D1 |-
;'-----------------------------------------
;'
;#DEFINE LEDD2 PORTA.0
;#DEFINE LEDD3 PORTA.1
;#DEFINE LEDD4 PORTA.2
;#DEFINE LEDD5 PORTA.3
;Dir     LEDD2 Out
	BCF	TRISA,0
;Dir     LEDD3 Out
	BCF	TRISA,1
;Dir     LEDD4 Out
	BCF	TRISA,2
;Dir     LEDD5 Out
	BCF	TRISA,3
;Using ADC value to the CCP/PWM
;Do
SYSDOLOOP_S1:
;HPWM 5, 40, ReadAD( AN4 )
	MOVLW	5
	MOVWF	PWMCHANNEL
	MOVLW	40
	MOVWF	PWMFREQ
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD5
	MOVF	SYSREADADBYTE,W
	MOVWF	PWMDUTY
	CLRF	PWMDUTY_H
	CALL	HPWM25
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Code optimisation
;This is not used so optimise
;#DEFINE USE_HPWMCCP1 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP2 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP3 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP4 FALSE
;This is used so include in the compiled code
;#DEFINE USE_HPWMCCP5 TRUE
;This is used so include in the compiled code
;#DEFINE USE_HPWM_TIMER2 TRUE
;#DEFINE USE_HPWM_TIMER4 FALSE
;#DEFINE USE_HPWM_TIMER6 FALSE
;#DEFINE USE_HPWM_TIMER7 FALSE
;Optimise A-d.h
;Standard family chips
;#DEFINE USE_AD0 FALSE
;#DEFINE USE_AD1 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD3 FALSE
;This is used so include in the compiled code
;#DEFINE USE_AD4 TRUE
;#DEFINE USE_AD5 FALSE
;#DEFINE USE_AD6 FALSE
;#DEFINE USE_AD7 FALSE
;#DEFINE USE_AD8 FALSE
;#DEFINE USE_AD9 FALSE
;#DEFINE USE_AD10 FALSE
;#DEFINE USE_AD11 FALSE
;#DEFINE USE_AD12 FALSE
;#DEFINE USE_AD13 FALSE
;#DEFINE USE_AD14 FALSE
;#DEFINE USE_AD15 FALSE
;#DEFINE USE_AD16 FALSE
;#DEFINE USE_AD17 FALSE
;#DEFINE USE_AD18 FALSE
;#DEFINE USE_AD19 FALSE
;#DEFINE USE_AD20 FALSE
;#DEFINE USE_AD21 FALSE
;#DEFINE USE_AD22 FALSE
;#DEFINE USE_AD23 FALSE
;#DEFINE USE_AD24 FALSE
;#DEFINE USE_AD25 FALSE
;#DEFINE USE_AD26 FALSE
;#DEFINE USE_AD27 FALSE
;#DEFINE USE_AD28 FALSE
;#DEFINE USE_AD29 FALSE
;#DEFINE USE_AD30 FALSE
;#DEFINE USE_AD31 FALSE
;#DEFINE USE_AD32 FALSE
;#DEFINE USE_AD33 FALSE
;#DEFINE USE_AD34 FALSE
;Family of chips based on 16f1688x with ADCON3 register
;#DEFINE USE_ADA0 FALSE
;#DEFINE USE_ADA1 FALSE
;#DEFINE USE_ADA2 FALSE
;#DEFINE USE_ADA3 FALSE
;#DEFINE USE_ADA4 FALSE
;#DEFINE USE_ADA5 FALSE
;#DEFINE USE_ADA6 FALSE
;#DEFINE USE_ADA7 FALSE
;#DEFINE USE_ADB0 FALSE
;#DEFINE USE_ADB1 FALSE
;#DEFINE USE_ADB2 FALSE
;#DEFINE USE_ADB3 FALSE
;#DEFINE USE_ADB4 FALSE
;#DEFINE USE_ADB5 FALSE
;#DEFINE USE_ADB6 FALSE
;#DEFINE USE_ADB7 FALSE
;#DEFINE USE_ADC0 FALSE
;#DEFINE USE_ADC1 FALSE
;#DEFINE USE_ADC2 FALSE
;#DEFINE USE_ADC3 FALSE
;#DEFINE USE_ADC4 FALSE
;#DEFINE USE_ADC5 FALSE
;#DEFINE USE_ADC6 FALSE
;#DEFINE USE_ADC7 FALSE
;#DEFINE USE_ADD0 FALSE
;#DEFINE USE_ADD1 FALSE
;#DEFINE USE_ADD2 FALSE
;#DEFINE USE_ADD3 FALSE
;#DEFINE USE_ADD4 FALSE
;#DEFINE USE_ADD5 FALSE
;#DEFINE USE_ADD6 FALSE
;#DEFINE USE_ADD7 FALSE
;#DEFINE USE_ADE0 FALSE
;#DEFINE USE_ADE1 FALSE
;#DEFINE USE_ADE2 FALSE
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: PWM.H (4412)
CALCULATEDUTY:
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	MOVLW	1
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
;Set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Repeat 2
	MOVLW	2
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1:
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	MOVF	PRX_TEMP,W
	MOVWF	SYSLONGTEMPA
	MOVF	PRX_TEMP_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	PRX_TEMP_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	PRX_TEMP_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	PWMRESOLUTION,W
	MOVWF	SYSLONGTEMPB
	MOVF	PWMRESOLUTION_H,W
	MOVWF	SYSLONGTEMPB_H
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
;Set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Repeat 6
	MOVLW	6
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP2:
;rotate PRx_Temp left
	RLF	PRX_TEMP,F
	RLF	PRX_TEMP_H,F
	RLF	PRX_TEMP_U,F
	RLF	PRX_TEMP_E,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;exits with PRx_Temp calculated
	RETURN

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	25
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
	MOVLW	14
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	189
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
HPWM25:
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
	MOVLW	64
	MOVWF	SYSLONGTEMPA
	MOVLW	31
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
	GOTO	ENDIF5
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
ENDIF5:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF6
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
ENDIF6:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF7
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
ENDIF7:
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
	GOTO	SYSSELECTEND2
;PR2 = PRx_Temp
	MOVF	PRX_TEMP,W
;B9: ASM Source was:  BANKSEL PR2
BANKSEL	T2PR
;B9: ASM Source was:  MOVWF PR2
MOVWF	T2PR
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS0
	BCF	T2CON,4
;SET T2CKPS1 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS1
	BCF	T2CON,5
;SET T2CKPS2 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS2
	BCF	T2CON,6
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS1 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF8
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF8:
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF9
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
ENDIF9:
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF10:
;Revised to show overflow issue
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility
;T2CLKCON.T2CS0 = 1
BANKSEL	T2CLKCON
;B7: ASM Source was:  BSF T2CLKCON,T2CS0
	BSF	T2CLKCON,0
;T2CLKCON.T2CS1 = 0
;B7: ASM Source was:  BCF T2CLKCON,T2CS1
	BCF	T2CLKCON,1
;T2CLKCON.T2CS2 = 0
;B7: ASM Source was:  BCF T2CLKCON,T2CS2
	BCF	T2CLKCON,2
;T2CLKCON.T2CS3 = 0
;B7: ASM Source was:  BCF T2CLKCON,T2CS3
	BCF	T2CLKCON,3
;end Select
SYSSELECTEND2:
END_OF_CCPPWMSETUPCLOCKSOURCE:
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS:
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;TimerSelectionBits =  (_PWMTimerSelected / 2 )
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
	BANKSEL	_PWMTIMERSELECTED
	RRF	_PWMTIMERSELECTED,W
	MOVWF	TIMERSELECTIONBITS
SETUPCCPPWMREGISTERS:
;Devices with more than one CCP
;if PWMChannel = 5 then  'USE_HPWMCCP5 TRUE
	MOVLW	5
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6.  ifdef VAR(CCPR1H)
	CALL	CALCULATEDUTY
;CCPR5H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR5H
MOVWF	CCPR5H
;CCPR5L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	CCPR5L
MOVWF	CCPR5L
;SET CCP5M3 ON'These my have been remapped using a script - do check ASM and script in INITPWM @2@CCP5
;B7: ASM Source was:  BSF CCP5CON,CCP5MODE3
	BSF	CCP5CON,3
;SET CCP5M2 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP5CON,CCP5MODE2
	BSF	CCP5CON,2
;SET CCP5M1 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP5CON,CCP5MODE1
	BSF	CCP5CON,1
;SET CCP5M0 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP5CON,CCP5MODE0
	BSF	CCP5CON,0
;SET CCP5EN ON
;B7: ASM Source was:  BSF CCP5CON,CCP5EN
	BSF	CCP5CON,7
;SET CCP5CON_EN ON
;B7: ASM Source was:  BSF CCP5CON,CCP5EN
	BSF	CCP5CON,7
;SET CCP5FMT ON
;B7: ASM Source was:  BSF CCP5CON,CCP5FMT
	BSF	CCP5CON,4
;C5TSEL0 = TimerSelectionBits.0
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BCF CCPTMRS1,C5TSEL0
	BCF	CCPTMRS1,0
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF12
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BSF CCPTMRS1,C5TSEL0
	BSF	CCPTMRS1,0
ENDIF12:
;C5TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BCF CCPTMRS1,C5TSEL1
	BCF	CCPTMRS1,1
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF13
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BSF CCPTMRS1,C5TSEL1
	BSF	CCPTMRS1,1
ENDIF13:
;end if
ENDIF11:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 10_USE_PWM_VIA_CCP_AND_ADC_TO_CONTROL_LED_BRIGHTNESS.GCB (35)
INITPPS:
;UNLOCKPPS
;Macro Source: stdbasic.h (78)
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,1
;GIE = 0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;PPSLOCK = 0x55
	MOVLW	85
BANKSEL	PPSLOCK
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
;B7: ASM Source was:  BCF PPSLOCK,PPSLOCKED
	BCF	PPSLOCK,0
;Module: CCP5
;CCP5 > RA0
;RA0PPS = 0x000D
	MOVLW	13
BANKSEL	RA0PPS
MOVWF	RA0PPS
;RA0 > CCP5 (bi-directional)
;CCP5PPS = 0x0000
BANKSEL	CCP5PPS
CLRF	CCP5PPS
;CCP5 > RA1
;RA1PPS = 0x000D
	MOVLW	13
BANKSEL	RA1PPS
MOVWF	RA1PPS
;RA1 > CCP5 (bi-directional)
;CCP5PPS = 0x0001
	MOVLW	1
BANKSEL	CCP5PPS
MOVWF	CCP5PPS
;CCP5 > RA2
;RA2PPS = 0x000D
	MOVLW	13
BANKSEL	RA2PPS
MOVWF	RA2PPS
;RA2 > CCP5 (bi-directional)
;CCP5PPS = 0x0002
	MOVLW	2
BANKSEL	CCP5PPS
MOVWF	CCP5PPS
;CCP5 > RA3
;RA3PPS = 0x000D
	MOVLW	13
BANKSEL	RA3PPS
MOVWF	RA3PPS
;RA3 > CCP5 (bi-directional)
;CCP5PPS = 0x0003
	MOVLW	3
BANKSEL	CCP5PPS
MOVWF	CCP5PPS
;LOCKPPS
;Macro Source: stdbasic.h (89)
;PPSLOCK = 0x55
	MOVLW	85
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
;B7: ASM Source was:  BSF PPSLOCK,PPSLOCKED
	BSF	PPSLOCK,0
;GIE = IntState
	BANKSEL	SYSBITVAR0
	BTFSS	SYSBITVAR0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,1
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
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
	MOVLW	210
;B9: ASM Source was:  BANKSEL PR2
BANKSEL	T2PR
;B9: ASM Source was:  MOVWF PR2
MOVWF	T2PR
;SET T2CON.T2CKPS0 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS0
	BCF	T2CON,4
;SET T2CON.T2CKPS1 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS1
	BCF	T2CON,5
;SET T2CON.T2CKPS2 OFF
;B7: ASM Source was:  BCF T2CON,T2CKPS2
	BCF	T2CON,6
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
	BANKSEL	CCPCONCACHE
;B7: ASM Source was:  BSF CCPCONCACHE,CCP1FMT
	BSF	CCPCONCACHE,4
;CCPR1H = DutyCycleH
	MOVLW	105
BANKSEL	CCPR1H
MOVWF	CCPR1H
;CCPR1L = DutyCycleL*64
	MOVLW	128
MOVWF	CCPR1L
;[canskip]T2CLKCON = 1
	MOVLW	1
BANKSEL	T2CLKCON
MOVWF	T2CLKCON
;[canskip]CCPCONCache.en = 1
	BANKSEL	CCPCONCACHE
;B7: ASM Source was:  BSF CCPCONCACHE,EN
	BSF	CCPCONCACHE,7
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
;B7: ASM Source was:  BSF CCPCONCACHE,CCP1MODE3
	BSF	CCPCONCACHE,3
;B7: ASM Source was:  BSF CCPCONCACHE,CCP1MODE2
	BSF	CCPCONCACHE,2
;B7: ASM Source was:  BCF CCPCONCACHE,CCP1MODE1
	BCF	CCPCONCACHE,1
;B7: ASM Source was:  BCF CCPCONCACHE,CCP1MODE0
	BCF	CCPCONCACHE,0
;Enable Timer 2
;SET T2CON.TMR2ON ON
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD5:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
MOVWF	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 15    'FOSC/16
	MOVLW	15
MOVWF	ADCLK
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Set ADFM0 OFF
;B7: ASM Source was:  BCF ADCON0,ADFM0
	BCF	ADCON0,2
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Enable A/D
;SET ADON ON
;B7: ASM Source was:  BSF ADCON0,ADON
	BSF	ADCON0,7
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
	BSF	ADCON0,0
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP1
;Switch off A/D
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
;ReadAD = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
BANKSEL	STATUS
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
	GOTO	ENDIF16
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
ENDIF16:
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
	GOTO	ENDIF17
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
ENDIF17:
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
	GOTO	ENDIF14
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
ENDIF14:
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
