;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\120_use_pwm_via_ccp_and_adc_to_control_led_brightness.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic18f16q41.inc

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;********************************************************************************
;Explicit CONFIG
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF
;Inferred CONFIG
 CONFIG  BBEN=ON
 CONFIG  BBSIZE=BBSIZE_512
 CONFIG  BOREN=OFF
 CONFIG  BORV=VBOR_2P85
 CONFIG  CSWEN=ON
 CONFIG  DEBUG=OFF
 CONFIG  FCMENP=OFF
 CONFIG  FCMENS=OFF
 CONFIG  IVT1WAY=OFF
 CONFIG  LPBOREN=ON
 CONFIG  PPS1WAY=OFF
 CONFIG  PR1WAY=OFF
 CONFIG  PWRTS=PWRT_1
 CONFIG  SAFEN=ON
 CONFIG  STVREN=OFF
 CONFIG  WDTCCS=LFINTOSC
 CONFIG  WDTCPS=WDTCPS_0
 CONFIG  WDTCWS=WDTCWS_0
 CONFIG  WRTAPP=ON
 CONFIG  WRTC=ON
 CONFIG  ZCD=ON

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 ADCVAL                           EQU 1293                    ; 0X50D
 ADREADPORT                       EQU 1294                    ; 0X50E
 CCPCONCACHE                      EQU 1295                    ; 0X50F
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 L_CALIBRATE                      EQU 1296                    ; 0X510
 L_CALIBRATE_H                    EQU 1297                    ; 0X511
 L_FROMHIGH                       EQU 1298                    ; 0X512
 L_FROMHIGH_H                     EQU 1299                    ; 0X513
 L_FROMLOW                        EQU 1300                    ; 0X514
 L_FROMLOW_H                      EQU 1301                    ; 0X515
 L_MAP                            EQU 1302                    ; 0X516
 L_MAP_H                          EQU 1303                    ; 0X517
 L_SYSCALC                        EQU 1304                    ; 0X518
 L_SYSCALCF                       EQU 1306                    ; 0X51A
 L_SYSCALCF_E                     EQU 1309                    ; 0X51D
 L_SYSCALCF_H                     EQU 1307                    ; 0X51B
 L_SYSCALCF_U                     EQU 1308                    ; 0X51C
 L_SYSCALC_H                      EQU 1305                    ; 0X519
 L_TOHIGH                         EQU 1310                    ; 0X51E
 L_TOHIGH_H                       EQU 1311                    ; 0X51F
 L_TOLOW                          EQU 1312                    ; 0X520
 L_TOLOW_H                        EQU 1313                    ; 0X521
 PRX_TEMP                         EQU 1314                    ; 0X522
 PRX_TEMP_E                       EQU 1317                    ; 0X525
 PRX_TEMP_H                       EQU 1315                    ; 0X523
 PRX_TEMP_U                       EQU 1316                    ; 0X524
 PWMCHANNEL                       EQU 1318                    ; 0X526
 PWMDUTY                          EQU 1319                    ; 0X527
 PWMDUTY_H                        EQU 1320                    ; 0X528
 PWMFREQ                          EQU 1321                    ; 0X529
 PWMRESOLUTION                    EQU 1322                    ; 0X52A
 PWMRESOLUTION_H                  EQU 1323                    ; 0X52B
 READAD                           EQU 1324                    ; 0X52C
 SCALE                            EQU 1325                    ; 0X52D
 SCALE_H                          EQU 1326                    ; 0X52E
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSLONGDIVMULTA                  EQU 1327                    ; 0X52F
 SYSLONGDIVMULTA_E                EQU 1330                    ; 0X532
 SYSLONGDIVMULTA_H                EQU 1328                    ; 0X530
 SYSLONGDIVMULTA_U                EQU 1329                    ; 0X531
 SYSLONGDIVMULTB                  EQU 1331                    ; 0X533
 SYSLONGDIVMULTB_E                EQU 1334                    ; 0X536
 SYSLONGDIVMULTB_H                EQU 1332                    ; 0X534
 SYSLONGDIVMULTB_U                EQU 1333                    ; 0X535
 SYSLONGDIVMULTX                  EQU 1335                    ; 0X537
 SYSLONGDIVMULTX_E                EQU 1338                    ; 0X53A
 SYSLONGDIVMULTX_H                EQU 1336                    ; 0X538
 SYSLONGDIVMULTX_U                EQU 1337                    ; 0X539
 SYSLONGTEMPA                     EQU 1285                    ; 0X505
 SYSLONGTEMPA_E                   EQU 1288                    ; 0X508
 SYSLONGTEMPA_H                   EQU 1286                    ; 0X506
 SYSLONGTEMPA_U                   EQU 1287                    ; 0X507
 SYSLONGTEMPB                     EQU 1289                    ; 0X509
 SYSLONGTEMPB_E                   EQU 1292                    ; 0X50C
 SYSLONGTEMPB_H                   EQU 1290                    ; 0X50A
 SYSLONGTEMPB_U                   EQU 1291                    ; 0X50B
 SYSLONGTEMPX                     EQU 1280                    ; 0X500
 SYSLONGTEMPX_E                   EQU 1283                    ; 0X503
 SYSLONGTEMPX_H                   EQU 1281                    ; 0X501
 SYSLONGTEMPX_U                   EQU 1282                    ; 0X502
 SYSREPEATTEMP1                   EQU 1339                    ; 0X53B
 SYSTEMP1                         EQU 1340                    ; 0X53C
 SYSTEMP1_E                       EQU 1343                    ; 0X53F
 SYSTEMP1_H                       EQU 1341                    ; 0X53D
 SYSTEMP1_U                       EQU 1342                    ; 0X53E
 SYSTEMP2                         EQU 1344                    ; 0X540
 SYSTEMP2_H                       EQU 1345                    ; 0X541
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 TIMERSELECTIONBITS               EQU 1346                    ; 0X542
 TX_PR                            EQU 1347                    ; 0X543
 _PWMTIMERSELECTED                EQU 1348                    ; 0X544

;********************************************************************************

;ALIAS VARIABLES
 SYSREADADBYTE                    EQU 1324
 SYSSCALEWORD                     EQU 1325
 SYSSCALEWORD_H                   EQU 1326

;********************************************************************************

 PSECT   RESETVEC,delta=1, abs
 RESETVEC:
;VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	12
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	RCALL	INITSYS
	RCALL	INITPPS
	RCALL	INITPWM

;START OF THE MAIN PROGRAM
;''
;''  This demonstration flashes an LED to show the use of CCP PWM operations
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
;'' This demonstation shows a how the changing PWM values can dim the LED
;''
;'' This demonstration uses CCP3. This is logically connect to Portb.5 and therefore the RC2
;''
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.6.2
;PinManager data: v1.81.0
;Generated for 18f16q41
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18f16q41
;Template comment at the end of the config file
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -----------------SW----------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------LED--LED-LED LED--
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;#DEFINE LEDPORT LATC
;Dir     RC0         Out
	BCF	TRISC,0,ACCESS
;Dir     RC1         Out
	BCF	TRISC,1,ACCESS
;Dir     RC2         Out
	BCF	TRISC,2,ACCESS
;Dir     RC3         Out
	BCF	TRISC,3,ACCESS
;#DEFINE POTENTIOMETER PORTA.0
;Dir     POTENTIOMETER In
	BSF	TRISA,0,ACCESS
;#DEFINE SWITCHIN      PORTA.3
;Dir     SWITCHIN      In
	BSF	TRISA,3,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim ADCVal, MaxVal as byte
;Using ADC value to set the CCP/PWM
;Do
SYSDOLOOP_S1:
;HPWM CCPchannel, frequency, duty cycle
;ADCVal = ReadAD( AN0 )
	CLRF	ADREADPORT,ACCESS
	RCALL	FN_READAD5
	MOVFF	SYSREADADBYTE,ADCVAL
;ADCVal = Scale ( ADCVal, 0 , 210, 0, 255 )
	MOVFF	ADCVAL,L_MAP
	CLRF	L_MAP_H,ACCESS
	CLRF	L_FROMLOW,ACCESS
	CLRF	L_FROMLOW_H,ACCESS
	MOVLW	210
	MOVWF	L_FROMHIGH,ACCESS
	CLRF	L_FROMHIGH_H,ACCESS
	CLRF	L_TOLOW,ACCESS
	CLRF	L_TOLOW_H,ACCESS
	SETF	L_TOHIGH,ACCESS
	CLRF	L_TOHIGH_H,ACCESS
	CLRF	L_CALIBRATE,ACCESS
	CLRF	L_CALIBRATE_H,ACCESS
	RCALL	FN_SCALE73
	MOVFF	SYSSCALEWORD,ADCVAL
;Wait 10 ms
	MOVLW	10
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;HPWM ( 1, 20, ADCVal )
	MOVLW	1
	MOVWF	PWMCHANNEL,ACCESS
	MOVLW	20
	MOVWF	PWMFREQ,ACCESS
	MOVFF	ADCVAL,PWMDUTY
	CLRF	PWMDUTY_H,ACCESS
	RCALL	HPWM25
	MOVFF	PWMDUTY,ADCVAL
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Code optimisation - to reduce code size - this needs to match out program. So, look for the TRUEs
;This is not used so optimise
;#DEFINE USE_HPWMCCP1 TRUE
;This is not used so optimise
;#DEFINE USE_HPWMCCP2 FALSE
;This is used so include in the compiled code
;#DEFINE USE_HPWMCCP3 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP4 FALSE
;This is not used so optimise
;#DEFINE USE_HPWMCCP5 FALSE
;This is used so include in the compiled code
;#DEFINE USE_HPWM_TIMER2 TRUE
;#DEFINE USE_HPWM_TIMER4 FALSE
;#DEFINE USE_HPWM_TIMER6 FALSE
;#DEFINE USE_HPWM_TIMER7 FALSE
;Optimise A-d.h
;Standard family chips
;#DEFINE USE_AD0 TRUE
;#DEFINE USE_AD1 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD3 FALSE
;#DEFINE USE_AD4 FALSE
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
;This is used so include in the compiled code
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
	BRA	BASPROGRAMEND

;********************************************************************************

;SOURCE: PWM.H (4412)
CALCULATEDUTY:
;dim PRx_Temp as long
;dim PWMDuty as word
;dim PWMResolution as word
;assumes PRx_Temp and PWMDuty are valid
;PRx_Temp = PWMDuty  * ( PRx_Temp + 1 )
	MOVLW	1
	ADDWF	PRX_TEMP,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	0
	ADDWFC	PRX_TEMP_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVLW	0
	ADDWFC	PRX_TEMP_U,W,ACCESS
	MOVWF	SYSTEMP1_U,ACCESS
	MOVLW	0
	ADDWFC	PRX_TEMP_E,W,ACCESS
	MOVWF	SYSTEMP1_E,ACCESS
	MOVFF	PWMDUTY,SYSLONGTEMPA
	MOVFF	PWMDUTY_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	SYSTEMP1,SYSLONGTEMPB
	MOVFF	SYSTEMP1_H,SYSLONGTEMPB_H
	MOVFF	SYSTEMP1_U,SYSLONGTEMPB_U
	MOVFF	SYSTEMP1_E,SYSLONGTEMPB_E
	RCALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,PRX_TEMP
	MOVFF	SYSLONGTEMPX_H,PRX_TEMP_H
	MOVFF	SYSLONGTEMPX_U,PRX_TEMP_U
	MOVFF	SYSLONGTEMPX_E,PRX_TEMP_E
;Set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Repeat 2
	MOVLW	2
	MOVWF	SYSREPEATTEMP1,ACCESS
SYSREPEATLOOP1:
;rotate PRx_Temp left
	RLCF	PRX_TEMP,F,ACCESS
	RLCF	PRX_TEMP_H,F,ACCESS
	RLCF	PRX_TEMP_U,F,ACCESS
	RLCF	PRX_TEMP_E,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;PRx_Temp = PRx_Temp / PWMResolution    'where PWMResolution is 255 or 1023
	MOVFF	PRX_TEMP,SYSLONGTEMPA
	MOVFF	PRX_TEMP_H,SYSLONGTEMPA_H
	MOVFF	PRX_TEMP_U,SYSLONGTEMPA_U
	MOVFF	PRX_TEMP_E,SYSLONGTEMPA_E
	MOVFF	PWMRESOLUTION,SYSLONGTEMPB
	MOVFF	PWMRESOLUTION_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,PRX_TEMP
	MOVFF	SYSLONGTEMPA_H,PRX_TEMP_H
	MOVFF	SYSLONGTEMPA_U,PRX_TEMP_U
	MOVFF	SYSLONGTEMPA_E,PRX_TEMP_E
;Set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Repeat 6
	MOVLW	6
	MOVWF	SYSREPEATTEMP1,ACCESS
SYSREPEATLOOP2:
;rotate PRx_Temp left
	RLCF	PRX_TEMP,F,ACCESS
	RLCF	PRX_TEMP_H,F,ACCESS
	RLCF	PRX_TEMP_U,F,ACCESS
	RLCF	PRX_TEMP_E,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;exits with PRx_Temp calculated
	RETURN

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	52
	MOVWF	DELAYTEMP,ACCESS
DELAYUS0:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS0
	DECFSZ	SYSWAITTEMP10US, F,ACCESS
	BRA	D10US_START
	RETURN

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F,ACCESS
DMS_START:
	MOVLW	129
	MOVWF	DELAYTEMP2,ACCESS
DMS_OUTER:
	MOVLW	40
	MOVWF	DELAYTEMP,ACCESS
DMS_INNER:
	DECFSZ	DELAYTEMP, F,ACCESS
	BRA	DMS_INNER
	DECFSZ	DELAYTEMP2, F,ACCESS
	BRA	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F,ACCESS
	BRA	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F,ACCESS
	BRA	DMS_START
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: PWM.H (2697)
HPWM25:
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
	SETF	PWMRESOLUTION,ACCESS
	CLRF	PWMRESOLUTION_H,ACCESS
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
	MOVWF	TX_PR,ACCESS
;PRx_Temp = PWMOsc1 / PWMFreq
	MOVLW	128
	MOVWF	SYSLONGTEMPA,ACCESS
	MOVLW	62
	MOVWF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	PWMFREQ,SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,PRX_TEMP
	MOVFF	SYSLONGTEMPA_H,PRX_TEMP_H
	MOVFF	SYSLONGTEMPA_U,PRX_TEMP_U
	MOVFF	SYSLONGTEMPA_E,PRX_TEMP_E
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W,ACCESS
	SUBLW	0
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF2
;Tx_PR = 4
	MOVLW	4
	MOVWF	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
;end if
ENDIF2:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W,ACCESS
	SUBLW	0
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF3
;Tx_PR = 16
	MOVLW	16
	MOVWF	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
;end if
ENDIF3:
;IF PRx_Temp_H > 0 then
	MOVF	PRX_TEMP_H,W,ACCESS
	SUBLW	0
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF4
;Tx_PR = 64
	MOVLW	64
	MOVWF	TX_PR,ACCESS
;Divide by 4
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate PRx_Temp right
	RRCF	PRX_TEMP_E,F,ACCESS
	RRCF	PRX_TEMP_U,F,ACCESS
	RRCF	PRX_TEMP_H,F,ACCESS
	RRCF	PRX_TEMP,F,ACCESS
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
	SUBWF	_PWMTIMERSELECTED,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND2
;PR2 = PRx_Temp
;A6: ASM Source was:  MOVFF PRX_TEMP,PR2
	MOVFF	PRX_TEMP,T2PR
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;SET T2CKPS0 OFF
BANKSEL	T2CON
;A8: ASM Source was:  BCF T2CON,T2CKPS0,BANKED
	BCF	T2CON,4,BANKED
;SET T2CKPS1 OFF
;A8: ASM Source was:  BCF T2CON,T2CKPS1,BANKED
	BCF	T2CON,5,BANKED
;SET T2CKPS2 OFF
;A8: ASM Source was:  BCF T2CON,T2CKPS2,BANKED
	BCF	T2CON,6,BANKED
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS1 ON
	MOVLW	4
	SUBWF	TX_PR,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;A8: ASM Source was:  BSF T2CON,T2CKPS1,BANKED
	BSF	T2CON,5,BANKED
;if Tx_PR = 16 then SET T2CKPS2 ON
	MOVLW	16
	SUBWF	TX_PR,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;A8: ASM Source was:  BSF T2CON,T2CKPS2,BANKED
	BSF	T2CON,6,BANKED
;if Tx_PR = 64 then SET T2CKPS2 ON: SET T2CKPS1 ON
	MOVLW	64
	SUBWF	TX_PR,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF7
;A8: ASM Source was:  BSF T2CON,T2CKPS2,BANKED
	BSF	T2CON,6,BANKED
;A8: ASM Source was:  BSF T2CON,T2CKPS1,BANKED
	BSF	T2CON,5,BANKED
ENDIF7:
;Revised to show overflow issue
;Set Clock Source, if required
;Set to FOSC/4 for backward compatibility
;T2CLKCON.T2CS0 = 1
;A8: ASM Source was:  BSF T2CLKCON,T2CS0,BANKED
	BSF	T2CLKCON,0,BANKED
;T2CLKCON.T2CS1 = 0
;A8: ASM Source was:  BCF T2CLKCON,T2CS1,BANKED
	BCF	T2CLKCON,1,BANKED
;T2CLKCON.T2CS2 = 0
;A8: ASM Source was:  BCF T2CLKCON,T2CS2,BANKED
	BCF	T2CLKCON,2,BANKED
;T2CLKCON.T2CS3 = 0
;A8: ASM Source was:  BCF T2CLKCON,T2CS3,BANKED
	BCF	T2CLKCON,3,BANKED
;end Select
SYSSELECTEND2:
END_OF_CCPPWMSETUPCLOCKSOURCE:
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS:
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
	RRCF	_PWMTIMERSELECTED,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	DECF	SYSTEMP1,W,ACCESS
	MOVWF	TIMERSELECTIONBITS,ACCESS
SETUPCCPPWMREGISTERS:
;Identify the Q41 chip that only has ONE CCP1PMW
;calculateDuty 'Sets PRx_Temp  to the duty value for bits 15-8 and 7-6
	BANKSEL	0
	RCALL	CALCULATEDUTY
;CCPR1H = PRx_Temp_H
	MOVFF	PRX_TEMP_H,CCPR1H
;CCPR1L = PRx_Temp
;A6: ASM Source was:  MOVFF PRX_TEMP,CCPR1L
	MOVFF	PRX_TEMP,CCPR1
;SET CCP1M3 ON
BANKSEL	CCP1CON
;A8: ASM Source was:  BSF CCP1CON,CCP1MODE3,BANKED
	BSF	CCP1CON,3,BANKED
;SET CCP1M2 ON
;A8: ASM Source was:  BSF CCP1CON,CCP1MODE2,BANKED
	BSF	CCP1CON,2,BANKED
;SET CCP1M1 ON
;A8: ASM Source was:  BSF CCP1CON,CCP1MODE1,BANKED
	BSF	CCP1CON,1,BANKED
;SET CCP1M0 ON
;A8: ASM Source was:  BSF CCP1CON,CCP1MODE0,BANKED
	BSF	CCP1CON,0,BANKED
;SET CCP1EN ON
;A8: ASM Source was:  BSF CCP1CON,CCP1EN,BANKED
	BSF	CCP1CON,7,BANKED
;SET CCP1CON_EN ON
;A8: ASM Source was:  BSF CCP1CON,CCP1CON_EN,BANKED
	BSF	CCP1CON,7,BANKED
;SET CCP1FMT ON
;A8: ASM Source was:  BSF CCP1CON,CCP1FMT,BANKED
	BSF	CCP1CON,4,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: 120_USE_PWM_VIA_CCP_AND_ADC_TO_CONTROL_LED_BRIGHTNESS.GCB (42)
INITPPS:
;Module: CCP1
;RC0PPS = 0x0009    'CCP1 > RC0
	MOVLW	9
BANKSEL	RC0PPS
	MOVWF	RC0PPS,BANKED
;CCP1PPS = 0x0010    'RC0 > CCP1 (bi-directional)
	MOVLW	16
	MOVWF	CCP1PPS,BANKED
;RC1PPS = 0x0009    'CCP1 > RC1
	MOVLW	9
	MOVWF	RC1PPS,BANKED
;CCP1PPS = 0x0011    'RC1 > CCP1 (bi-directional)
	MOVLW	17
	MOVWF	CCP1PPS,BANKED
;RC2PPS = 0x0009    'CCP1 > RC2
	MOVLW	9
	MOVWF	RC2PPS,BANKED
;CCP1PPS = 0x0012    'RC2 > CCP1 (bi-directional)
	MOVLW	18
	MOVWF	CCP1PPS,BANKED
;RC3PPS = 0x0009    'CCP1 > RC3
	MOVLW	9
	MOVWF	RC3PPS,BANKED
;CCP1PPS = 0x0013    'RC3 > CCP1 (bi-directional)
	MOVLW	19
	MOVWF	CCP1PPS,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: PWM.H (192)
INITPWM:
;_PWMTimerSelected = 2
	MOVLW	2
	MOVWF	_PWMTIMERSELECTED,ACCESS
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
	CLRF	CCPCONCACHE,ACCESS
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	MOVLW	105
;A9: ASM Source was:  BANKSEL PR2
BANKSEL	T2PR
;A2: ASM Source was:  MOVWF PR2,BANKED
;A4: ASM Source was:  MOVWF PR2,BANKED
	MOVWF	T2PR,BANKED
;SET T2CON.T2CKPS0 OFF
;A8: ASM Source was:  BCF T2CON,T2CKPS0,BANKED
	BCF	T2CON,4,BANKED
;SET T2CON.T2CKPS1 ON
;A8: ASM Source was:  BSF T2CON,T2CKPS1,BANKED
	BSF	T2CON,5,BANKED
;SET T2CON.T2CKPS2 OFF
;A8: ASM Source was:  BCF T2CON,T2CKPS2,BANKED
	BCF	T2CON,6,BANKED
;Set Duty cycle
;CCPCONCache.CCP1FMT = 1
;A8: ASM Source was:  BSF CCPCONCACHE,CCP1FMT,ACCESS
	BSF	CCPCONCACHE,4,ACCESS
;CCPR1H = DutyCycleH
	MOVLW	53
	MOVWF	CCPR1H,BANKED
;CCPR1L = DutyCycleL*64
;A2: ASM Source was:  CLRF CCPR1L,BANKED
;A4: ASM Source was:  CLRF CCPR1L,BANKED
	CLRF	CCPR1,BANKED
;[canskip]T2CLKCON = 1
	MOVLW	1
	MOVWF	T2CLKCON,BANKED
;[canskip]CCPCONCache.en = 1
;A8: ASM Source was:  BSF CCPCONCACHE,EN,ACCESS
	BSF	CCPCONCACHE,7,ACCESS
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
;A8: ASM Source was:  BSF CCPCONCACHE,CCP1MODE3,ACCESS
	BSF	CCPCONCACHE,3,ACCESS
;A8: ASM Source was:  BSF CCPCONCACHE,CCP1MODE2,ACCESS
	BSF	CCPCONCACHE,2,ACCESS
;A8: ASM Source was:  BCF CCPCONCACHE,CCP1MODE1,ACCESS
	BCF	CCPCONCACHE,1,ACCESS
;A8: ASM Source was:  BCF CCPCONCACHE,CCP1MODE0,ACCESS
	BCF	CCPCONCACHE,0,ACCESS
;Enable Timer 2
;SET T2CON.TMR2ON ON
;A8: ASM Source was:  BSF T2CON,TMR2ON,BANKED
	BSF	T2CON,7,BANKED
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
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	CLRF	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	CLRF	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	CLRF	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family ChipFamily
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;asm showdebug OSCCON type is 101
;Clear NDIV3:0
;NDIV3 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV3,BANKED
	BCF	OSCCON1,3,BANKED
;NDIV2 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV2,BANKED
	BCF	OSCCON1,2,BANKED
;NDIV1 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV1,BANKED
	BCF	OSCCON1,1,BANKED
;NDIV0 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV0,BANKED
	BCF	OSCCON1,0,BANKED
;OSCFRQ = 0b00001000  '64mhz
	MOVLW	8
	MOVWF	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	CLRF	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	CLRF	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;A8: ASM Source was:  BCF ADCON0,ADON,BANKED
	BCF	ADCON0,7,BANKED
;ANSELA = 0
BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;ANSELB = 0
	CLRF	ANSELB,BANKED
;ANSELC = 0
	CLRF	ANSELC,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
BANKSEL	CM2CON0
;A8: ASM Source was:  BCF CM2CON0,C2EN,BANKED
	BCF	CM2CON0,7,BANKED
;C1EN = 0
;A8: ASM Source was:  BCF CM1CON0,C1EN,BANKED
	BCF	CM1CON0,7,BANKED
;
;'Turn off all ports
;PORTA = 0
	CLRF	PORTA,ACCESS
;PORTB = 0
	CLRF	PORTB,ACCESS
;PORTC = 0
	CLRF	PORTC,ACCESS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD5:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	MOVFF	ADREADPORT,ADPCH
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
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
	MOVWF	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 15    'FOSC/16
	MOVLW	15
	MOVWF	ADCLK,BANKED
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;Set ADFM0 OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	MOVFF	ADREADPORT,ADPCH
;Enable A/D
;SET ADON ON
;A8: ASM Source was:  BSF ADCON0,ADON,BANKED
	BSF	ADCON0,7,BANKED
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US,ACCESS
	BANKSEL	0
	RCALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;A8: ASM Source was:  BSF ADCON0,GO_NOT_DONE,BANKED
	BSF	ADCON0,0,BANKED
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE,BANKED
	BTFSC	ADCON0,0,BANKED
	BRA	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
;A8: ASM Source was:  BCF ADCON0,ADON,BANKED
	BCF	ADCON0,7,BANKED
;ANSELA = 0
BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;ANSELB = 0
	CLRF	ANSELB,BANKED
;ANSELC = 0
	CLRF	ANSELC,BANKED
;ReadAD = ADRESH
	MOVFF	ADRESH,READAD
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (263)
FN_SCALE73:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	MOVF	L_FROMLOW,W,ACCESS
	SUBWF	L_MAP,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	L_FROMLOW_H,W,ACCESS
	SUBWFB	L_MAP_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVF	L_TOLOW,W,ACCESS
	SUBWF	L_TOHIGH,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	L_TOLOW_H,W,ACCESS
	SUBWFB	L_TOHIGH_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVFF	SYSTEMP1,SYSLONGTEMPA
	MOVFF	SYSTEMP1_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	SYSTEMP2,SYSLONGTEMPB
	MOVFF	SYSTEMP2_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,L_SYSCALCF
	MOVFF	SYSLONGTEMPX_H,L_SYSCALCF_H
	MOVFF	SYSLONGTEMPX_U,L_SYSCALCF_U
	MOVFF	SYSLONGTEMPX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	MOVF	L_FROMLOW,W,ACCESS
	SUBWF	L_FROMHIGH,W,ACCESS
	MOVWF	L_SYSCALC,ACCESS
	MOVF	L_FROMLOW_H,W,ACCESS
	SUBWFB	L_FROMHIGH_H,W,ACCESS
	MOVWF	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	MOVFF	L_SYSCALCF,SYSLONGTEMPA
	MOVFF	L_SYSCALCF_H,SYSLONGTEMPA_H
	MOVFF	L_SYSCALCF_U,SYSLONGTEMPA_U
	MOVFF	L_SYSCALCF_E,SYSLONGTEMPA_E
	MOVFF	L_SYSCALC,SYSLONGTEMPB
	MOVFF	L_SYSCALC_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,SYSTEMP1
	MOVFF	SYSLONGTEMPA_H,SYSTEMP1_H
	MOVFF	SYSLONGTEMPA_U,SYSTEMP1_U
	MOVFF	SYSLONGTEMPA_E,SYSTEMP1_E
	MOVF	L_TOLOW,W,ACCESS
	ADDWF	SYSTEMP1,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	L_TOLOW_H,W,ACCESS
	ADDWFC	SYSTEMP1_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVF	L_CALIBRATE,W,ACCESS
	ADDWF	SYSTEMP2,W,ACCESS
	MOVWF	SCALE,ACCESS
	MOVF	L_CALIBRATE_H,W,ACCESS
	ADDWFC	SYSTEMP2_H,W,ACCESS
	MOVWF	SCALE_H,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2948)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	MOVF	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	CPFSEQ	SYSLONGTEMPA,ACCESS
;return
	RETURN
;Test high, exit if false
;movf SysLongTempB_H, W
	MOVF	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	CPFSEQ	SYSLONGTEMPA_H,ACCESS
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempB_U, W
	MOVF	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	CPFSEQ	SYSLONGTEMPA_U,ACCESS
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempB_E, W
	MOVF	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	CPFSEQ	SYSLONGTEMPA_E,ACCESS
;return
	RETURN
;setf SysByteTempX
	SETF	SYSBYTETEMPX,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3123)
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
;return
	RETURN
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F,ACCESS
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
	MOVFF	SYSLONGTEMPA,SYSLONGDIVMULTA
	MOVFF	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	MOVFF	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	MOVFF	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVFF	SYSLONGTEMPB,SYSLONGDIVMULTB
	MOVFF	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	MOVFF	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	MOVFF	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX,ACCESS
	CLRF	SYSLONGDIVMULTX_H,ACCESS
	CLRF	SYSLONGDIVMULTX_U,ACCESS
	CLRF	SYSLONGDIVMULTX_E,ACCESS
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVFF	SYSLONGDIVMULTB,SYSLONGTEMPA
	MOVFF	SYSLONGDIVMULTB_H,SYSLONGTEMPA_H
	MOVFF	SYSLONGDIVMULTB_U,SYSLONGTEMPA_U
	MOVFF	SYSLONGDIVMULTB_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF10
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF10:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP,ACCESS
SYSDIV32START:
;set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SysLongDivMultA Left
	RLCF	SYSLONGDIVMULTA,F,ACCESS
	RLCF	SYSLONGDIVMULTA_H,F,ACCESS
	RLCF	SYSLONGDIVMULTA_U,F,ACCESS
	RLCF	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	RLCF	SYSLONGDIVMULTX,F,ACCESS
	RLCF	SYSLONGDIVMULTX_H,F,ACCESS
	RLCF	SYSLONGDIVMULTX_U,F,ACCESS
	RLCF	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,ACCESS
	SUBWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTB_H,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTB_U,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTB_E,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF11
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTB_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTB_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTB_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
;End If
ENDIF11:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	BRA	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVFF	SYSLONGDIVMULTA,SYSLONGTEMPA
	MOVFF	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	MOVFF	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	MOVFF	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVFF	SYSLONGDIVMULTX,SYSLONGTEMPX
	MOVFF	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	MOVFF	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	MOVFF	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
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
	MOVFF	SYSLONGTEMPA,SYSLONGDIVMULTA
	MOVFF	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	MOVFF	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	MOVFF	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVFF	SYSLONGTEMPB,SYSLONGDIVMULTB
	MOVFF	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	MOVFF	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	MOVFF	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX,ACCESS
	CLRF	SYSLONGDIVMULTX_H,ACCESS
	CLRF	SYSLONGDIVMULTX_U,ACCESS
	CLRF	SYSLONGDIVMULTX_E,ACCESS
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BTFSS	SYSLONGDIVMULTB,0,ACCESS
	BRA	ENDIF8
	MOVF	SYSLONGDIVMULTA,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTA_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTA_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTA_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF8:
;set STATUS.C OFF
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultB right
	RRCF	SYSLONGDIVMULTB_E,F,ACCESS
	RRCF	SYSLONGDIVMULTB_U,F,ACCESS
	RRCF	SYSLONGDIVMULTB_H,F,ACCESS
	RRCF	SYSLONGDIVMULTB,F,ACCESS
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultA left
	RLCF	SYSLONGDIVMULTA,F,ACCESS
	RLCF	SYSLONGDIVMULTA_H,F,ACCESS
	RLCF	SYSLONGDIVMULTA_U,F,ACCESS
	RLCF	SYSLONGDIVMULTA_E,F,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVFF	SYSLONGDIVMULTB,SYSLONGTEMPB
	MOVFF	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	MOVFF	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	MOVFF	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	RCALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	MOVFF	SYSLONGDIVMULTX,SYSLONGTEMPX
	MOVFF	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	MOVFF	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	MOVFF	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
