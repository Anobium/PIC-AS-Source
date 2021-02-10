;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18446
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f18446\08_pwm.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18446.inc

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
 CONFIG WRTSAF = OFF
 CONFIG WRTD = OFF
 CONFIG WRTB = OFF
 CONFIG CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 ADREADPORT                       EQU 32                    ; 0X20
 CCPCONCACHE                      EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 L_CALIBRATE                      EQU 34                    ; 0X22
 L_CALIBRATE_H                    EQU 35                    ; 0X23
 L_FROMHIGH                       EQU 36                    ; 0X24
 L_FROMHIGH_H                     EQU 37                    ; 0X25
 L_FROMLOW                        EQU 38                    ; 0X26
 L_FROMLOW_H                      EQU 39                    ; 0X27
 L_MAP                            EQU 40                    ; 0X28
 L_MAP_H                          EQU 41                    ; 0X29
 L_SYSCALC                        EQU 42                    ; 0X2A
 L_SYSCALCF                       EQU 44                    ; 0X2C
 L_SYSCALCF_E                     EQU 47                    ; 0X2F
 L_SYSCALCF_H                     EQU 45                    ; 0X2D
 L_SYSCALCF_U                     EQU 46                    ; 0X2E
 L_SYSCALC_H                      EQU 43                    ; 0X2B
 L_TOHIGH                         EQU 48                    ; 0X30
 L_TOHIGH_H                       EQU 49                    ; 0X31
 L_TOLOW                          EQU 50                    ; 0X32
 L_TOLOW_H                        EQU 51                    ; 0X33
 PRX_TEMP                         EQU 52                    ; 0X34
 PRX_TEMP_E                       EQU 55                    ; 0X37
 PRX_TEMP_H                       EQU 53                    ; 0X35
 PRX_TEMP_U                       EQU 54                    ; 0X36
 PWMCHANNEL                       EQU 56                    ; 0X38
 PWMDUTY                          EQU 57                    ; 0X39
 PWMDUTY_H                        EQU 58                    ; 0X3A
 PWMFREQ                          EQU 59                    ; 0X3B
 PWMRESOLUTION                    EQU 60                    ; 0X3C
 PWMRESOLUTION_H                  EQU 61                    ; 0X3D
 READAD12                         EQU 62                    ; 0X3E
 READAD12_H                       EQU 63                    ; 0X3F
 SCALE                            EQU 64                    ; 0X40
 SCALE_H                          EQU 65                    ; 0X41
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSLONGDIVMULTA                  EQU 66                    ; 0X42
 SYSLONGDIVMULTA_E                EQU 69                    ; 0X45
 SYSLONGDIVMULTA_H                EQU 67                    ; 0X43
 SYSLONGDIVMULTA_U                EQU 68                    ; 0X44
 SYSLONGDIVMULTB                  EQU 70                    ; 0X46
 SYSLONGDIVMULTB_E                EQU 73                    ; 0X49
 SYSLONGDIVMULTB_H                EQU 71                    ; 0X47
 SYSLONGDIVMULTB_U                EQU 72                    ; 0X48
 SYSLONGDIVMULTX                  EQU 74                    ; 0X4A
 SYSLONGDIVMULTX_E                EQU 77                    ; 0X4D
 SYSLONGDIVMULTX_H                EQU 75                    ; 0X4B
 SYSLONGDIVMULTX_U                EQU 76                    ; 0X4C
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
 SYSREPEATTEMP1                   EQU 78                    ; 0X4E
 SYSTEMP1                         EQU 79                    ; 0X4F
 SYSTEMP1_E                       EQU 82                    ; 0X52
 SYSTEMP1_H                       EQU 80                    ; 0X50
 SYSTEMP1_U                       EQU 81                    ; 0X51
 SYSTEMP2                         EQU 83                    ; 0X53
 SYSTEMP2_H                       EQU 84                    ; 0X54
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 TIMERSELECTIONBITS               EQU 85                    ; 0X55
 TX_PR                            EQU 86                    ; 0X56
 _PWMTIMERSELECTED                EQU 87                    ; 0X57

;********************************************************************************

;ALIAS VARIABLES
 SYSREADAD12WORD                  EQU 62
 SYSREADAD12WORD_H                EQU 63
 SYSSCALEWORD                     EQU 64
 SYSSCALEWORD_H                   EQU 65

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
;'' Great Cow BASIC Header block Header block
;''
;''@author  Chris Roper
;''@licence GPL
;''@version 1.00
;''@date    03/05/2018
;''********************************************************************
;as found by A2D example
;#DEFINE  ADC_Fudge 0x0739
;Dir portc.2 Out
	BCF	TRISC,2
;Do
SYSDOLOOP_S1:
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;HPWM 2, 40, Scale(ReadAD12(An0), 0, ADC_Fudge, 1, 255)
	MOVLW	2
	MOVWF	PWMCHANNEL
	MOVLW	40
	MOVWF	PWMFREQ
	CLRF	ADREADPORT
	CALL	FN_READAD129
	MOVF	SYSREADAD12WORD,W
	MOVWF	L_MAP
	MOVF	SYSREADAD12WORD_H,W
	MOVWF	L_MAP_H
	CLRF	L_FROMLOW
	CLRF	L_FROMLOW_H
	MOVLW	57
	MOVWF	L_FROMHIGH
	MOVLW	7
	MOVWF	L_FROMHIGH_H
	MOVLW	1
	MOVWF	L_TOLOW
	CLRF	L_TOLOW_H
	MOVLW	255
	MOVWF	L_TOHIGH
	CLRF	L_TOHIGH_H
	CLRF	L_CALIBRATE
	CLRF	L_CALIBRATE_H
	CALL	FN_SCALE73
	MOVF	SYSSCALEWORD,W
	MOVWF	PWMDUTY
	MOVF	SYSSCALEWORD_H,W
	MOVWF	PWMDUTY_H
	CALL	HPWM25
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
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
	GOTO	ENDIF2
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
ENDIF2:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF3
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
ENDIF3:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF4
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
ENDIF4:
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
	GOTO	ENDIF5
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF5:
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF6
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
ENDIF6:
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF7
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF7:
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
;B9: ASM Source was:  BANKSEL PR4
BANKSEL	T4PR
;B9: ASM Source was:  MOVWF PR4
MOVWF	T4PR
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T4CKPS0 OFF
;B7: ASM Source was:  BCF T4CON,T4CKPS0
	BCF	T4CON,4
;SET T4CKPS1 OFF
;B7: ASM Source was:  BCF T4CON,T4CKPS1
	BCF	T4CON,5
;Set Prescaler bits
;if Tx_PR = 4  then SET T4CKPS0 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF8
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS0
	BSF	T4CON,4
ENDIF8:
;if Tx_PR = 16 then SET T4CKPS1 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF9
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS1
	BSF	T4CON,5
ENDIF9:
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T4CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T4CKPS0 ON: SET T4CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,T4CKPS0
	BSF	T4CON,4
;B7: ASM Source was:  BSF T4CON,T4CKPS1
	BSF	T4CON,5
ENDIF10:
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility
;T4CLKCON.T4CS0 = 1
BANKSEL	T4CLKCON
;B7: ASM Source was:  BSF T4CLKCON,T4CS0
	BSF	T4CLKCON,0
;T4CLKCON.T4CS1 = 0
;B7: ASM Source was:  BCF T4CLKCON,T4CS1
	BCF	T4CLKCON,1
;T4CLKCON.T4CS2 = 0
;B7: ASM Source was:  BCF T4CLKCON,T4CS2
	BCF	T4CLKCON,2
;T4CLKCON.T4CS3 = 0
;B7: ASM Source was:  BCF T4CLKCON,T4CS3
	BCF	T4CLKCON,3
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
;B9: ASM Source was:  BANKSEL PR6
BANKSEL	T6PR
;B9: ASM Source was:  MOVWF PR6
MOVWF	T6PR
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T6CKPS0 OFF
;B7: ASM Source was:  BCF T6CON,T6CKPS0
	BCF	T6CON,4
;SET T6CKPS1 OFF
;B7: ASM Source was:  BCF T6CON,T6CKPS1
	BCF	T6CON,5
;Set Prescaler bits
;if Tx_PR = 4  then SET T6CKPS0 ON
	MOVLW	4
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS0
	BSF	T6CON,4
ENDIF11:
;if Tx_PR = 16 then SET T6CKPS1 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS1
	BSF	T6CON,5
ENDIF12:
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T6CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T6CKPS0 ON: SET T6CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,T6CKPS0
	BSF	T6CON,4
;B7: ASM Source was:  BSF T6CON,T6CKPS1
	BSF	T6CON,5
ENDIF13:
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility
;T6CLKCON.T6CS0 = 1
BANKSEL	T6CLKCON
;B7: ASM Source was:  BSF T6CLKCON,T6CS0
	BSF	T6CLKCON,0
;T6CLKCON.T6CS1 = 0
;B7: ASM Source was:  BCF T6CLKCON,T6CS1
	BCF	T6CLKCON,1
;T6CLKCON.T6CS2 = 0
;B7: ASM Source was:  BCF T6CLKCON,T6CS2
	BCF	T6CLKCON,2
;T6CLKCON.T6CS3 = 0
;B7: ASM Source was:  BCF T6CLKCON,T6CS3
	BCF	T6CLKCON,3
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
;Devices with more than one CCP
;if PWMChannel = 1 then
	DECF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
;ifdef BIT(CCP1FMT) Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L for PWM
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR1H
MOVWF	CCPR1H
;CCPR1L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	CCPR1L
MOVWF	CCPR1L
;SET CCP1M3 ON
;B7: ASM Source was:  BSF CCP1CON,CCP1MODE3
	BSF	CCP1CON,3
;SET CCP1M2 ON
;B7: ASM Source was:  BSF CCP1CON,CCP1MODE2
	BSF	CCP1CON,2
;SET CCP1M1 ON
;B7: ASM Source was:  BSF CCP1CON,CCP1MODE1
	BSF	CCP1CON,1
;SET CCP1M0 ON
;B7: ASM Source was:  BSF CCP1CON,CCP1MODE0
	BSF	CCP1CON,0
;SET CCP1EN ON
;B7: ASM Source was:  BSF CCP1CON,CCP1EN
	BSF	CCP1CON,7
;SET CCP1FMT ON
;B7: ASM Source was:  BSF CCP1CON,CCP1FMT
	BSF	CCP1CON,4
;end if
ENDIF14:
;if PWMChannel = 2 then
	MOVLW	2
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;CCPR2H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR2H
MOVWF	CCPR2H
;CCPR2L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	CCPR2L
MOVWF	CCPR2L
;SET CCP2M3 ON
;B7: ASM Source was:  BSF CCP2CON,CCP2MODE3
	BSF	CCP2CON,3
;SET CCP2M2 ON
;B7: ASM Source was:  BSF CCP2CON,CCP2MODE2
	BSF	CCP2CON,2
;SET CCP2M1 ON
;B7: ASM Source was:  BSF CCP2CON,CCP2MODE1
	BSF	CCP2CON,1
;SET CCP2M0 ON
;B7: ASM Source was:  BSF CCP2CON,CCP2MODE0
	BSF	CCP2CON,0
;SET CCP2EN ON
;B7: ASM Source was:  BSF CCP2CON,CCP2EN
	BSF	CCP2CON,7
;SET CCP2CON_EN ON
;B7: ASM Source was:  BSF CCP2CON,CCP2EN
	BSF	CCP2CON,7
;SET CCP2FMT ON
;B7: ASM Source was:  BSF CCP2CON,CCP2FMT
	BSF	CCP2CON,4
;end if
ENDIF15:
;if PWMChannel = 3 then 'USE_HPWMCCP3 TRUE
	MOVLW	3
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	CALL	CALCULATEDUTY
;CCPR3H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR3H
MOVWF	CCPR3H
;CCPR3L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	CCPR3L
MOVWF	CCPR3L
;SET CCP3M3 ON
;B7: ASM Source was:  BSF CCP3CON,CCP3MODE3
	BSF	CCP3CON,3
;SET CCP3M2 ON
;B7: ASM Source was:  BSF CCP3CON,CCP3MODE2
	BSF	CCP3CON,2
;SET CCP3M1 ON
;B7: ASM Source was:  BSF CCP3CON,CCP3MODE1
	BSF	CCP3CON,1
;SET CCP3M0 ON
;B7: ASM Source was:  BSF CCP3CON,CCP3MODE0
	BSF	CCP3CON,0
;SET CCP3EN ON
;B7: ASM Source was:  BSF CCP3CON,CCP3EN
	BSF	CCP3CON,7
;SET CCP3CON_EN ON
;B7: ASM Source was:  BSF CCP3CON,CCP3EN
	BSF	CCP3CON,7
;SET CCP3FMT ON
;B7: ASM Source was:  BSF CCP3CON,CCP3FMT
	BSF	CCP3CON,4
;end if
ENDIF16:
;if PWMChannel = 4 then  'USE_HPWMCCP4 TRUE
	MOVLW	4
	BANKSEL	PWMCHANNEL
	SUBWF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6.  ifdef VAR(CCPR1H)
	CALL	CALCULATEDUTY
;CCPR4H = PRx_Temp_H
	MOVF	PRX_TEMP_H,W
BANKSEL	CCPR4H
MOVWF	CCPR4H
;CCPR4L = PRx_Temp
	BANKSEL	PRX_TEMP
	MOVF	PRX_TEMP,W
BANKSEL	CCPR4L
MOVWF	CCPR4L
;SET CCP4M3 ON'These my have been remapped using a script - do check ASM and script in INITPWM @2@CCP4
;B7: ASM Source was:  BSF CCP4CON,CCP4MODE3
	BSF	CCP4CON,3
;SET CCP4M2 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP4CON,CCP4MODE2
	BSF	CCP4CON,2
;SET CCP4M1 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP4CON,CCP4MODE1
	BSF	CCP4CON,1
;SET CCP4M0 ON'These my have been remapped using a script - do check ASM and script in INITPWM
;B7: ASM Source was:  BSF CCP4CON,CCP4MODE0
	BSF	CCP4CON,0
;SET CCP4EN ON
;B7: ASM Source was:  BSF CCP4CON,CCP4EN
	BSF	CCP4CON,7
;SET CCP4CON_EN ON
;B7: ASM Source was:  BSF CCP4CON,CCP4EN
	BSF	CCP4CON,7
;SET CCP4FMT ON
;B7: ASM Source was:  BSF CCP4CON,CCP4FMT
	BSF	CCP4CON,4
;end if
ENDIF17:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 08_PWM.GCB (17)
INITPPS:
;Module: CCP2
;CCP2 > RC2
;RC2PPS = 0x000A
	MOVLW	10
BANKSEL	RC2PPS
MOVWF	RC2PPS
;RC2 > CCP2 (bi-directional)
;CCP2PPS = 0x0012
	MOVLW	18
BANKSEL	CCP2PPS
MOVWF	CCP2PPS
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
;B7: ASM Source was:  BCF ADCON0,ADFM0
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
;C2EN = 0
BANKSEL	CM2CON0
;B7: ASM Source was:  BCF CM2CON0,C2EN
	BCF	CM2CON0,7
;C1EN = 0
;B7: ASM Source was:  BCF CM1CON0,C1EN
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2190)
FN_READAD129:
;Always RIGHT justified
;Set up A/D format
;SET ADFM ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,ADFM0
	BSF	ADCON0,2
;Set A/D Result Mode to 12-Bit
;Required by some chips
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
;Case 3: Set ANSELA.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3
;Case 4: Set ANSELA.4 ON
	GOTO	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 5: Set ANSELA.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 6: Set ANSELA.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6
;Case 7: Set ANSELA.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7
;Case 8: Set ANSELB.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0
;Case 9: Set ANSELB.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1
;Case 10: Set ANSELB.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2
;Case 11: Set ANSELB.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3
;Case 12: Set ANSELB.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4
;Case 13: Set ANSELB.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5
;Case 14: Set ANSELB.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6
;Case 15: Set ANSELB.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5
;Case 22: Set ANSELC.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 23: Set ANSELC.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELC
	BSF	ANSELC,7
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
;B7: ASM Source was:  BSF ADCON0,ADFM0
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
BANKSEL	ADCON0
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
;ReadAD12 = ADRESL
BANKSEL	ADRESL
	MOVF	ADRESL,W
	BANKSEL	READAD12
	MOVWF	READAD12
	CLRF	READAD12_H
;ReadAD12_H = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD12_H
	MOVWF	READAD12_H
;Put A/D format back to normal
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFM0
	BCF	ADCON0,2
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (263)
FN_SCALE73:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	MOVF	L_FROMLOW,W
	SUBWF	L_MAP,W
	MOVWF	SYSTEMP1
	MOVF	L_FROMLOW_H,W
	SUBWFB	L_MAP_H,W
	MOVWF	SYSTEMP1_H
	MOVF	L_TOLOW,W
	SUBWF	L_TOHIGH,W
	MOVWF	SYSTEMP2
	MOVF	L_TOLOW_H,W
	SUBWFB	L_TOHIGH_H,W
	MOVWF	SYSTEMP2_H
	MOVF	SYSTEMP1,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
	MOVF	SYSTEMP2,W
	MOVWF	SYSLONGTEMPB
	MOVF	SYSTEMP2_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVF	SYSLONGTEMPX,W
	MOVWF	L_SYSCALCF
	MOVF	SYSLONGTEMPX_H,W
	MOVWF	L_SYSCALCF_H
	MOVF	SYSLONGTEMPX_U,W
	MOVWF	L_SYSCALCF_U
	MOVF	SYSLONGTEMPX_E,W
	MOVWF	L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	MOVF	L_FROMLOW,W
	SUBWF	L_FROMHIGH,W
	MOVWF	L_SYSCALC
	MOVF	L_FROMLOW_H,W
	SUBWFB	L_FROMHIGH_H,W
	MOVWF	L_SYSCALC_H
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	MOVF	L_SYSCALCF,W
	MOVWF	SYSLONGTEMPA
	MOVF	L_SYSCALCF_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	L_SYSCALCF_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	L_SYSCALCF_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVF	L_SYSCALC,W
	MOVWF	SYSLONGTEMPB
	MOVF	L_SYSCALC_H,W
	MOVWF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPA,W
	MOVWF	SYSTEMP1
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSTEMP1_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSTEMP1_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSTEMP1_E
	MOVF	L_TOLOW,W
	ADDWF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	MOVF	L_TOLOW_H,W
	ADDWFC	SYSTEMP1_H,W
	MOVWF	SYSTEMP2_H
	MOVF	L_CALIBRATE,W
	ADDWF	SYSTEMP2,W
	MOVWF	SCALE
	MOVF	L_CALIBRATE_H,W
	ADDWFC	SYSTEMP2_H,W
	MOVWF	SCALE_H
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
	GOTO	ENDIF20
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
ENDIF20:
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
	GOTO	ENDIF21
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
ENDIF21:
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
	GOTO	ENDIF18
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
ENDIF18:
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
;START OF PROGRAM MEMORY PAGE 4
	ORG	8192
;START OF PROGRAM MEMORY PAGE 5
	ORG	10240
;START OF PROGRAM MEMORY PAGE 6
	ORG	12288
;START OF PROGRAM MEMORY PAGE 7
	ORG	14336
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
