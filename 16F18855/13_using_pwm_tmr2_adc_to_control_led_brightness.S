;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\13_using_pwm_tmr2_adc_to_control_led_brightness.S"
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
 FNLSL                            EQU 34                    ; 0X22
 FNLSL_E                          EQU 37                    ; 0X25
 FNLSL_H                          EQU 35                    ; 0X23
 FNLSL_U                          EQU 36                    ; 0X24
 NUMBITS                          EQU 38                    ; 0X26
 PRX_TEMP                         EQU 39                    ; 0X27
 PRX_TEMP_CACHE                   EQU 43                    ; 0X2B
 PRX_TEMP_CACHE_E                 EQU 46                    ; 0X2E
 PRX_TEMP_CACHE_H                 EQU 44                    ; 0X2C
 PRX_TEMP_CACHE_U                 EQU 45                    ; 0X2D
 PRX_TEMP_E                       EQU 42                    ; 0X2A
 PRX_TEMP_H                       EQU 40                    ; 0X28
 PRX_TEMP_U                       EQU 41                    ; 0X29
 PWMCHANNEL                       EQU 47                    ; 0X2F
 PWMDUTY                          EQU 48                    ; 0X30
 PWMDUTY_H                        EQU 49                    ; 0X31
 PWMFREQ                          EQU 50                    ; 0X32
 PWMFREQ_H                        EQU 51                    ; 0X33
 PWMRESOLUTION                    EQU 52                    ; 0X34
 PWMRESOLUTION_H                  EQU 53                    ; 0X35
 READAD10                         EQU 54                    ; 0X36
 READAD10_H                       EQU 55                    ; 0X37
 SYSBITVAR0                       EQU 56                    ; 0X38
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSLONGDIVMULTA                  EQU 57                    ; 0X39
 SYSLONGDIVMULTA_E                EQU 60                    ; 0X3C
 SYSLONGDIVMULTA_H                EQU 58                    ; 0X3A
 SYSLONGDIVMULTA_U                EQU 59                    ; 0X3B
 SYSLONGDIVMULTB                  EQU 61                    ; 0X3D
 SYSLONGDIVMULTB_E                EQU 64                    ; 0X40
 SYSLONGDIVMULTB_H                EQU 62                    ; 0X3E
 SYSLONGDIVMULTB_U                EQU 63                    ; 0X3F
 SYSLONGDIVMULTX                  EQU 65                    ; 0X41
 SYSLONGDIVMULTX_E                EQU 68                    ; 0X44
 SYSLONGDIVMULTX_H                EQU 66                    ; 0X42
 SYSLONGDIVMULTX_U                EQU 67                    ; 0X43
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
 SYSREPEATTEMP1                   EQU 69                    ; 0X45
 SYSREPEATTEMP3                   EQU 70                    ; 0X46
 SYSTEMP1                         EQU 71                    ; 0X47
 SYSTEMP1_E                       EQU 74                    ; 0X4A
 SYSTEMP1_H                       EQU 72                    ; 0X48
 SYSTEMP1_U                       EQU 73                    ; 0X49
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 TX_PR                            EQU 75                    ; 0X4B
 _PWMTIMERSELECTED                EQU 76                    ; 0X4C

;********************************************************************************

;ALIAS VARIABLES
 BRIGHT                           EQU 908
 BRIGHT_H                         EQU 909
 SYSFNLSLWORD                     EQU 34
 SYSFNLSLWORD_H                   EQU 35
 SYSREADAD10WORD                  EQU 54
 SYSREADAD10WORD_H                EQU 55

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
;'' This demonstation shows a how the changing the POT changes the PWM values across the LEDs using the PWM module.
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;Set the PPS of the PWM and the RS232 ports.
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
;Create an alias to the registers that control the PWM on channel 6
;Dim Bright As Word Alias PWM6DCH, PWM6DCL
;Setup PMW6 at 62kHz, 0% Duty using timer2
;HPWM ( 6, 62, 0 , 2  )
	MOVLW	6
	MOVWF	PWMCHANNEL
	MOVLW	62
	MOVWF	PWMFREQ
	CLRF	PWMFREQ_H
	CLRF	PWMDUTY
	CLRF	PWMDUTY_H
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED
	MOVLW	255
	MOVWF	PWMRESOLUTION
	CLRF	PWMRESOLUTION_H
	CALL	HPWM26
;Do Forever
SYSDOLOOP_S1:
;Set the variable(this maps to the registers) to the value of the ADC moved the left by 6 shifts.
;Bright = FnLSL( ReadAD10( AN4 ), 6 )
	MOVLW	4
	BANKSEL	ADREADPORT
	MOVWF	ADREADPORT
	CALL	FN_READAD107
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	6
	MOVWF	NUMBITS
	CALL	FN_FNLSL85
	MOVF	SYSFNLSLWORD,W
;B9: ASM Source was:  BANKSEL BRIGHT
BANKSEL	PWM6DCL
;B9: ASM Source was:  MOVWF BRIGHT
MOVWF	PWM6DCL
	BANKSEL	SYSFNLSLWORD_H
	MOVF	SYSFNLSLWORD_H,W
;B9: ASM Source was:  BANKSEL BRIGHT_H
BANKSEL	PWM6DCH
;B9: ASM Source was:  MOVWF BRIGHT_H
MOVWF	PWM6DCH
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
;not used Optimise
;#DEFINE USE_ADA0 FALSE
;not used Optimise
;#DEFINE USE_ADA1 FALSE
;not used Optimise
;#DEFINE USE_ADA2 FALSE
;not used Optimise
;#DEFINE USE_ADA3 FALSE
;used so compile
;#DEFINE USE_ADA4 TRUE
;not used Optimise
;#DEFINE USE_ADA5 FALSE
;not used Optimise
;#DEFINE USE_ADA6 FALSE
;not used Optimise
;#DEFINE USE_ADA7 FALSE
;not used Optimise
;#DEFINE USE_ADB0 FALSE
;not used Optimise
;#DEFINE USE_ADB1 FALSE
;not used Optimise
;#DEFINE USE_ADB2 FALSE
;not used Optimise
;#DEFINE USE_ADB3 FALSE
;not used Optimise
;#DEFINE USE_ADB4 FALSE
;not used Optimise
;#DEFINE USE_ADB5 FALSE
;not used Optimise
;#DEFINE USE_ADB6 FALSE
;not used Optimise
;#DEFINE USE_ADB7 FALSE
;not used Optimise
;#DEFINE USE_ADC0 FALSE
;not used Optimise
;#DEFINE USE_ADC1 FALSE
;not used Optimise
;#DEFINE USE_ADC2 FALSE
;not used Optimise
;#DEFINE USE_ADC3 FALSE
;not used Optimise
;#DEFINE USE_ADC4 FALSE
;not used Optimise
;#DEFINE USE_ADC5 FALSE
;not used Optimise
;#DEFINE USE_ADC6 FALSE
;not used Optimise
;#DEFINE USE_ADC7 FALSE
;not used Optimise
;#DEFINE USE_ADD0 FALSE
;not used Optimise
;#DEFINE USE_ADD1 FALSE
;not used Optimise
;#DEFINE USE_ADD2 FALSE
;not used Optimise
;#DEFINE USE_ADD3 FALSE
;not used Optimise
;#DEFINE USE_ADD4 FALSE
;not used Optimise
;#DEFINE USE_ADD5 FALSE
;not used Optimise
;#DEFINE USE_ADD6 FALSE
;not used Optimise
;#DEFINE USE_ADD7 FALSE
;not used Optimise
;#DEFINE USE_ADE0 FALSE
;not used Optimise
;#DEFINE USE_ADE1 FALSE
;not used Optimise
;#DEFINE USE_ADE2 FALSE
;Optimise commands  for PWM modules to reduce the size of the code produced.
;not used Optimise      ' not used Optimise
;#DEFINE USE_HPWMCCP1 FALSE
;not used Optimise      ' not used Optimise
;#DEFINE USE_HPWMCCP2 FALSE
;not used Optimise      ' not used Optimise
;#DEFINE USE_HPWMCCP3 FALSE
;not used Optimise      ' not used Optimise
;#DEFINE USE_HPWMCCP4 FALSE
;used so compile
;#DEFINE USE_HPWM6 TRUE
;not used Optimise         ' not used Optimise
;#DEFINE USE_HPWM7 FALSE
;used so compile
;#DEFINE USE_HPWM_TIMER2 TRUE
;not used Optimise   ' not used Optimise
;#DEFINE USE_HPWM_TIMER4 FALSE
;not used Optimise   ' not used Optimise
;#DEFINE USE_HPWM_TIMER6 FALSE
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

;OVERLOADED SIGNATURE: WORD:BYTE:, SOURCE: STDBASIC.H (416)
FN_FNLSL85:
;Repeat NumBits
	MOVF	NUMBITS,W
	MOVWF	SYSREPEATTEMP3
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND3
SYSREPEATLOOP3:
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysWordTempB Left
	RLF	SYSWORDTEMPB,F
	RLF	SYSWORDTEMPB_H,F
;End Repeat
	DECFSZ	SYSREPEATTEMP3,F
	GOTO	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
;FnLSL = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	FNLSL
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	FNLSL_H
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:BYTE:BYTE:WORD:, SOURCE: PWM.H (3259)
HPWM26:
;dim PWMDuty as word
;HPWM ( PWMChannel, PWMFreq, [word]PWMDuty, _PWMTimerSelected, PWMResolution  )
	GOTO	HPWM27

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:WORD:BYTE:WORD:, SOURCE: PWM.H (3266)
HPWM27:
;Dim PRx_Temp as LONG
;Dim TimerSelectionBits as byte
;If HPWM_FAST operation selected, only recalculate duty timer prescaler when
;needed.
;Commence calculations of PMW parameters
;This figures out Postscaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply sets up Tx_PR to 1,4 or 16
;PRx_Temp  = PWMOsc1 / PWMFreq
	MOVLW	64
	MOVWF	SYSLONGTEMPA
	MOVLW	31
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	PWMFREQ,W
	MOVWF	SYSLONGTEMPB
	MOVF	PWMFREQ_H,W
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
;Tx_PR = 1
	MOVLW	1
	MOVWF	TX_PR
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
;This section setups the timer
;Set up PRx dependent on timer selected
;Select Case _PWMTimerSelected
;case 2 'Select timer2 as the driver for PWM
SYSSELECT2CASE1:
	MOVLW	2
	SUBWF	_PWMTIMERSELECTED,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND2
;Set PR2
;PR2 = PRx_Temp  'This is required in the next sction of code, and as will not know which timer has been selected
	MOVF	PRX_TEMP,W
;B9: ASM Source was:  BANKSEL PR2
BANKSEL	T2PR
;B9: ASM Source was:  MOVWF PR2
MOVWF	T2PR
;Set Clock Source
;Set to FOSC/4 for backward compatibility
;#ifdef var(T2CLKCON): T2CLKCON = 0x01: #ENDIF
	MOVLW	1
MOVWF	T2CLKCON
;T2PSYNC Not Synchronized; T2MODE Software control; T2CKPOL Rising Edge; T2CKSYNC Not Synchronized
;T2HLT = 0x00
;#ifdef var(T2HLT): T2HLT = 0x00: #ENDIF
CLRF	T2HLT
;T2RSEL T2CKIPPS pin
;T2RST = 0x00
;#ifdef var(T2RST): T2RST = 0x00: #ENDIF
CLRF	T2RST
;TMR2.  Holding Register for the 8-bit TMR2 Register
;T2TMR = 0x00
;#ifdef var(T2TMR): T2TMR = 0x00: #ENDIF
CLRF	T2TMR
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
;Clearing IF flag.
;SET TMR2IF OFF
BANKSEL	PIR4
;B7: ASM Source was:  BCF PIR4,TMR2IF
	BCF	PIR4,1
;Start Timer2
;SET TMR2ON ON
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
;End Select
SYSSELECTEND2:
TENBITPMWSECTION:
;This section setups up the PWM Duty
;The following code can be optimised via 'defines'
;Dim PRx_Temp_Cache as Long
;Cache the PRx_Temp value ONLY when NOT HPWM_FAST - this can be then used by HPWMUpdate
;PRx_Temp_Cache = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
	MOVWF	PRX_TEMP_CACHE
	MOVF	PRX_TEMP_H,W
	MOVWF	PRX_TEMP_CACHE_H
	MOVF	PRX_TEMP_U,W
	MOVWF	PRX_TEMP_CACHE_U
	MOVF	PRX_TEMP_E,W
	MOVWF	PRX_TEMP_CACHE_E
;if PWMChannel = 6 then  'in section USE_HPWM6
	MOVLW	6
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
;calculates duty, assisgns duty to  bits 15-8 and 7-6 of PMWxDH(H&L) and links this PWM to the correct timer
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;PWM6DCH = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	PWM6DCH
MOVWF	PWM6DCH
;PWM6DCL = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	PWM6DCL
MOVWF	PWM6DCL
;Select timer by updating CCPTMRS1 register
;SetWith ( P6TSEL0, _PWMTimerSelected.1 )
;Macro Source: stdbasic.h (369)
;if Source then
	BANKSEL	_PWMTIMERSELECTED
	BTFSS	_PWMTIMERSELECTED,1
	GOTO	ELSE12_1
;TargetBit = 1
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BSF CCPTMRS1,P6TSEL0
	BSF	CCPTMRS1,2
;else
	GOTO	ENDIF12
ELSE12_1:
;TargetBit = 0
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BCF CCPTMRS1,P6TSEL0
	BCF	CCPTMRS1,2
;end if
ENDIF12:
;SetWith ( P6TSEL1, _PWMTimerSelected.2 )
;Macro Source: stdbasic.h (369)
;if Source then
	BANKSEL	_PWMTIMERSELECTED
	BTFSS	_PWMTIMERSELECTED,2
	GOTO	ELSE13_1
;TargetBit = 1
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BSF CCPTMRS1,P6TSEL1
	BSF	CCPTMRS1,3
;else
	GOTO	ENDIF13
ELSE13_1:
;TargetBit = 0
BANKSEL	CCPTMRS1
;B7: ASM Source was:  BCF CCPTMRS1,P6TSEL1
	BCF	CCPTMRS1,3
;end if
ENDIF13:
;PWM6OE = 1
BANKSEL	PWM6CON
;B7: ASM Source was:  BSF PWM6CON,PWM6OE
	BSF	PWM6CON,6
;Start PMW6
;Set PWM6EN On
;B7: ASM Source was:  BSF PWM6CON,PWM6EN
	BSF	PWM6CON,7
;End if
ENDIF11:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 13_USING_PWM_TMR2_ADC_TO_CONTROL_LED_BRIGHTNESS.GCB (29)
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
;'RA3->PWM6:PWM6OUT;
;RA3PPS = 0x000E
	MOVLW	14
BANKSEL	RA3PPS
MOVWF	RA3PPS
;'RA1->PWM6:PWM6OUT;
;RA1PPS = 0x000E
	MOVLW	14
MOVWF	RA1PPS
;'RA2->PWM6:PWM6OUT;
;RA2PPS = 0x000E
	MOVLW	14
MOVWF	RA2PPS
;'RA0->PWM6:PWM6OUT;
;RA0PPS = 0x000E
	MOVLW	14
MOVWF	RA0PPS
;LOCKPPS
;Macro Source: stdbasic.h (89)
;PPSLOCK = 0x55
	MOVLW	85
BANKSEL	PPSLOCK
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD107:
;Always RIGHT justified
;SET ADFM ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 4: Set ANSELA.4 ON
SYSSELECT1CASE1:
	MOVLW	4
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELA
	BSF	ANSELA,4
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
BANKSEL	ADCON0
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
;Set ADCON0.2 ON
;Set ADFM ON
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;Set ADFM0 ON
;B7: ASM Source was:  BSF ADCON0,ADFM0
	BSF	ADCON0,2
;Else
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
