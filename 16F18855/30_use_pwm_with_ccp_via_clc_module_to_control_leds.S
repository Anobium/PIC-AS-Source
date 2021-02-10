;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\30_use_pwm_with_ccp_via_clc_module_to_control_leds.S"
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
 FNLSL                            EQU 34                    ; 0X22
 FNLSL_E                          EQU 37                    ; 0X25
 FNLSL_H                          EQU 35                    ; 0X23
 FNLSL_U                          EQU 36                    ; 0X24
 NUMBITS                          EQU 38                    ; 0X26
 PRX_TEMP                         EQU 39                    ; 0X27
 PRX_TEMP_E                       EQU 42                    ; 0X2A
 PRX_TEMP_H                       EQU 40                    ; 0X28
 PRX_TEMP_U                       EQU 41                    ; 0X29
 PWMCHANNEL                       EQU 43                    ; 0X2B
 PWMDUTY                          EQU 44                    ; 0X2C
 PWMDUTY_H                        EQU 45                    ; 0X2D
 PWMFREQ                          EQU 46                    ; 0X2E
 PWMRESOLUTION                    EQU 47                    ; 0X2F
 PWMRESOLUTION_H                  EQU 48                    ; 0X30
 READAD                           EQU 49                    ; 0X31
 READAD10                         EQU 50                    ; 0X32
 READAD10_H                       EQU 51                    ; 0X33
 SYSBITVAR0                       EQU 52                    ; 0X34
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSLONGDIVMULTA                  EQU 53                    ; 0X35
 SYSLONGDIVMULTA_E                EQU 56                    ; 0X38
 SYSLONGDIVMULTA_H                EQU 54                    ; 0X36
 SYSLONGDIVMULTA_U                EQU 55                    ; 0X37
 SYSLONGDIVMULTB                  EQU 57                    ; 0X39
 SYSLONGDIVMULTB_E                EQU 60                    ; 0X3C
 SYSLONGDIVMULTB_H                EQU 58                    ; 0X3A
 SYSLONGDIVMULTB_U                EQU 59                    ; 0X3B
 SYSLONGDIVMULTX                  EQU 61                    ; 0X3D
 SYSLONGDIVMULTX_E                EQU 64                    ; 0X40
 SYSLONGDIVMULTX_H                EQU 62                    ; 0X3E
 SYSLONGDIVMULTX_U                EQU 63                    ; 0X3F
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
 SYSREPEATTEMP1                   EQU 65                    ; 0X41
 SYSREPEATTEMP3                   EQU 66                    ; 0X42
 SYSTEMP1                         EQU 67                    ; 0X43
 SYSTEMP1_E                       EQU 70                    ; 0X46
 SYSTEMP1_H                       EQU 68                    ; 0X44
 SYSTEMP1_U                       EQU 69                    ; 0X45
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 TIMERSELECTIONBITS               EQU 71                    ; 0X47
 TX_PR                            EQU 72                    ; 0X48
 _PWMTIMERSELECTED                EQU 73                    ; 0X49

;********************************************************************************

;ALIAS VARIABLES
 BRIGHT                           EQU 780
 BRIGHT_H                         EQU 781
 SYSFNLSLWORD                     EQU 34
 SYSFNLSLWORD_H                   EQU 35
 SYSREADAD10WORD                  EQU 50
 SYSREADAD10WORD_H                EQU 51
 SYSREADADBYTE                    EQU 49

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
;'' This demonstration uses CCP1 that is then redirected via the CLC model to OR the value of CCP1 to the CLC1 output, then
;'' PPS is used to map the CLC1 outputs to the LEDs
;''
;'' Very cool!!!
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 19.2.2016
;''
;Set the PPS for this solution.
;Dir porta.0 Out
	BCF	TRISA,0
;Dir porta.1 Out
	BCF	TRISA,1
;Dir porta.2 Out
	BCF	TRISA,2
;Dir porta.3 Out
	BCF	TRISA,3
;Variables
;Dim Bright As Word Alias CCPR1H, CCPR1L
;Setup CLC configuration
;This simply OR's the CCP1 output to CLC1 then to the CLC1 output. Then, using PPS we redirect CLC1 output to the LEDs
;LC1G1POL not_inverted; LC1G2POL not_inverted; LC1G3POL not_inverted; LC1G4POL not_inverted; LC1POL not_inverted;
;CLC1POL = 0x00
BANKSEL	CLC1POL
CLRF	CLC1POL
;LC1D1S CCP1_OUT;
;CLC1SEL0 = 0x13
	MOVLW	19
MOVWF	CLC1SEL0
;LC1D2S CCP1_OUT;
;CLC1SEL1 = 0x13
	MOVLW	19
MOVWF	CLC1SEL1
;LC1D3S CLCIN1 (CLCIN1PPS);
;CLC1SEL2 = 0x01
	MOVLW	1
MOVWF	CLC1SEL2
;LC1D4S CCP1_OUT;
;CLC1SEL3 = 0x13
	MOVLW	19
MOVWF	CLC1SEL3
;LC1G1D3N disabled; LC1G1D2N disabled; LC1G1D4N disabled; LC1G1D1T enabled; LC1G1D3T disabled; LC1G1D2T disabled; LC1G1D4T disabled; LC1G1D1N disabled;
;CLC1GLS0 = 0x02
	MOVLW	2
MOVWF	CLC1GLS0
;LC1G2D2N disabled; LC1G2D1N disabled; LC1G2D4N disabled; LC1G2D3N disabled; LC1G2D2T disabled; LC1G2D1T disabled; LC1G2D4T disabled; LC1G2D3T disabled;
;CLC1GLS1 = 0x00
CLRF	CLC1GLS1
;LC1G3D1N disabled; LC1G3D2N disabled; LC1G3D3N disabled; LC1G3D4N disabled; LC1G3D1T disabled; LC1G3D2T disabled; LC1G3D3T disabled; LC1G3D4T disabled;
;CLC1GLS2 = 0x00
CLRF	CLC1GLS2
;LC1G4D1N disabled; LC1G4D2N disabled; LC1G4D3N disabled; LC1G4D4N disabled; LC1G4D1T disabled; LC1G4D2T disabled; LC1G4D3T disabled; LC1G4D4T disabled;
;CLC1GLS3 = 0x00
CLRF	CLC1GLS3
;LC1EN enabled; INTN disabled; INTP disabled; MODE OR-XOR;
;CLC1CON = 0x81
	MOVLW	129
MOVWF	CLC1CON
;Initialise CCP/PWM - this is standard code - nothing changed
;HPWM 1, 40, Bright
	MOVLW	1
	BANKSEL	PWMCHANNEL
	MOVWF	PWMCHANNEL
	MOVLW	40
	MOVWF	PWMFREQ
;B9: ASM Source was:  BANKSEL BRIGHT
BANKSEL	CCPR1L
;B2: ASM Source was:  MOVF BRIGHT,W
;B4: ASM Source was:  MOVF BRIGHT,W
	MOVF	CCPR1L,W
	BANKSEL	PWMDUTY
	MOVWF	PWMDUTY
;B9: ASM Source was:  BANKSEL BRIGHT_H
BANKSEL	CCPR1H
;B2: ASM Source was:  MOVF BRIGHT_H,W
;B4: ASM Source was:  MOVF BRIGHT_H,W
	MOVF	CCPR1H,W
	BANKSEL	PWMDUTY_H
	MOVWF	PWMDUTY_H
	CALL	HPWM25
	MOVF	PWMDUTY,W
;B9: ASM Source was:  BANKSEL BRIGHT
BANKSEL	CCPR1L
;B9: ASM Source was:  MOVWF BRIGHT
MOVWF	CCPR1L
	BANKSEL	PWMDUTY_H
	MOVF	PWMDUTY_H,W
;B9: ASM Source was:  BANKSEL BRIGHT_H
BANKSEL	CCPR1H
;B9: ASM Source was:  MOVWF BRIGHT_H
MOVWF	CCPR1H
;Using Bright as an ALIAS simply set the ADC value to the CCP/PWM registers, an alternative is shown below
;Do
SYSDOLOOP_S1:
;BRIGHT =  FnLSL( ReadAD10( AN4 ), 6 )
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
BANKSEL	CCPR1L
;B9: ASM Source was:  MOVWF BRIGHT
MOVWF	CCPR1L
	BANKSEL	SYSFNLSLWORD_H
	MOVF	SYSFNLSLWORD_H,W
;B9: ASM Source was:  BANKSEL BRIGHT_H
BANKSEL	CCPR1H
;B9: ASM Source was:  MOVWF BRIGHT_H
MOVWF	CCPR1H
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Alternative method
;Do
SYSDOLOOP_S2:
;HPWM 1, 40, ReadAD( AN4 )
	MOVLW	1
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
	GOTO	SYSDOLOOP_S2
SYSDOLOOP_E2:
;Code optimisation
;This is used so include in the compiled code
;#DEFINE USE_HPWMCCP1 TRUE
;This is not used so optimise
;#DEFINE USE_HPWMCCP2 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP3 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP4 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP5 FALSE
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
	GOTO	ENDIF6
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
ENDIF6:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF7
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
ENDIF7:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF8
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
ENDIF8:
;added to handle different timer sources
;added to support HPWM_CCPTimerN. Makes the code longer but more flexible
;user optimisation to reduce code.
CCPPWMSETUPCLOCKSOURCE:
;select case _PWMTimerSelected
;case 2:
SYSSELECT3CASE1:
	MOVLW	2
	SUBWF	_PWMTIMERSELECTED,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND3
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
	GOTO	ENDIF9
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF9:
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
ENDIF10:
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	BANKSEL	TX_PR
	SUBWF	TX_PR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,T2CKPS2
	BSF	T2CON,6
;B7: ASM Source was:  BSF T2CON,T2CKPS1
	BSF	T2CON,5
ENDIF11:
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
SYSSELECTEND3:
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
;if PWMChannel = 1 then
	DECF	PWMCHANNEL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
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
;C1TSEL0 = TimerSelectionBits.0
BANKSEL	CCPTMRS0
;B7: ASM Source was:  BCF CCPTMRS0,C1TSEL0
	BCF	CCPTMRS0,0
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,0
	GOTO	ENDIF13
BANKSEL	CCPTMRS0
;B7: ASM Source was:  BSF CCPTMRS0,C1TSEL0
	BSF	CCPTMRS0,0
ENDIF13:
;C1TSEL1 = TimerSelectionBits.1
BANKSEL	CCPTMRS0
;B7: ASM Source was:  BCF CCPTMRS0,C1TSEL1
	BCF	CCPTMRS0,1
	BANKSEL	TIMERSELECTIONBITS
	BTFSS	TIMERSELECTIONBITS,1
	GOTO	ENDIF14
BANKSEL	CCPTMRS0
;B7: ASM Source was:  BSF CCPTMRS0,C1TSEL1
	BSF	CCPTMRS0,1
ENDIF14:
;end if
ENDIF12:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 30_USE_PWM_WITH_CCP_VIA_CLC_MODULE_TO_CONTROL_LEDS.GCB (35)
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
;Set up the CLC
;RC3->TMR2:T2IN
;T2AINPPS = 0x13
	MOVLW	19
MOVWF	T2AINPPS
;RA5->CLC1:CLCIN1
;CLCIN1PPS = 0x05
	MOVLW	5
MOVWF	CLCIN1PPS
;Set up the CLC1 to the LEDs
;RA3->CLC1:CLC1OUT
;RA3PPS = 0x01
	MOVLW	1
BANKSEL	RA3PPS
MOVWF	RA3PPS
;RA1->CLC1:CLC1OUT
;RA1PPS = 0x01
	MOVLW	1
MOVWF	RA1PPS
;RA2->CLC1:CLC1OUT
;RA2PPS = 0x01
	MOVLW	1
MOVWF	RA2PPS
;RA0->CLC1:CLC1OUT
;RA0PPS = 0x01
	MOVLW	1
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
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND2:
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
SYSWAITLOOP2:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP2
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
	GOTO	ENDIF17
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
ENDIF17:
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
	GOTO	ENDIF18
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
ENDIF18:
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
	GOTO	ENDIF15
	MOVF	SYSLONGDIVMULTA,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTA_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTA_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTA_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
ENDIF15:
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
