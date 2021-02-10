;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\270_millis.S"
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
 CURMS                            EQU 1281                    ; 0X501
 CURMS_H                          EQU 1282                    ; 0X502
 LSTMS                            EQU 1283                    ; 0X503
 LSTMS_H                          EQU 1284                    ; 0X504
 MILLIS                           EQU 1296                    ; 0X510
 MILLIS_E                         EQU 1299                    ; 0X513
 MILLIS_H                         EQU 1297                    ; 0X511
 MILLIS_U                         EQU 1298                    ; 0X512
 MSCTR_                           EQU 1300                    ; 0X514
 MSCTR__E                         EQU 1303                    ; 0X517
 MSCTR__H                         EQU 1301                    ; 0X515
 MSCTR__U                         EQU 1302                    ; 0X516
 SYSBSR                           EQU 1287                    ; 0X507
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSINTSTATESAVE0                 EQU 1288                    ; 0X508
 SYSSTATUS                        EQU 1295                    ; 0X50F
 SYSTEMP1                         EQU 1291                    ; 0X50B
 SYSTEMP1_H                       EQU 1292                    ; 0X50C
 SYSTEMP2                         EQU 1293                    ; 0X50D
 SYSW                             EQU 1294                    ; 0X50E
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 TMRPOST                          EQU 1304                    ; 0X518
 TMRPRES                          EQU 1305                    ; 0X519
 TMRSOURCE                        EQU 1306                    ; 0X51A

;********************************************************************************

 PSECT   RESETVEC,delta=1, abs
 RESETVEC:
;VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	BRA	INTERRUPT

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	12
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	RCALL	INITSYS
	RCALL	INIT_MSCTR_INT
;ENABLE INTERRUPTS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	BSF	SYSINTSTATESAVE0,0,ACCESS

;START OF THE MAIN PROGRAM
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the timer capabilities using hthe millis function.
;'':
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    31.12.2020
;''********************************************************************************
;Chip Settings
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   ---------------------SW------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----TX---------LED--LED-LED LED--
;'-----------------------------------------
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
;#DEFINE SWITCHIN      PORTA.2
;Dir     SWITCHIN      In
	BSF	TRISA,2,ACCESS
;analogue port selection
;#DEFINE ADCChannelSelected AN0
;#DEFINE ADSpeed LowSpeed
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;#define LED RC1       ' Define the LED Pin
;#define LEDRate 1000     ' Flash rate in mS
;Dim CurMs, LstMs as word  ' declare working variables
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	CLRF	LSTMS,ACCESS
	CLRF	LSTMS_H,ACCESS
;CurMs = 0
	CLRF	CURMS,ACCESS
	CLRF	CURMS_H,ACCESS
;Main                    ' This loop runs over and over forever.
;Do
SYSDOLOOP_S1:
;CurMs = millis()
	RCALL	FN_MILLIS
	MOVFF	MILLIS,CURMS
	MOVFF	MILLIS_H,CURMS_H
;if CurMs - LstMs >= LEDRate then  ' required Time has Elapsed
	MOVF	LSTMS,W,ACCESS
	SUBWF	CURMS,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	LSTMS_H,W,ACCESS
	SUBWFB	CURMS_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVFF	SYSTEMP1,SYSWORDTEMPA
	MOVFF	SYSTEMP1_H,SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF1
;LED = !LED                      ' So Toggle state of LED
	CLRF	SYSTEMP2,ACCESS
;A8: ASM Source was:  BTFSC PORTC,RC1,ACCESS
	BTFSC	PORTC,1,ACCESS
	INCF	SYSTEMP2,F,ACCESS
	COMF	SYSTEMP2,F,ACCESS
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
	BTFSC	SYSTEMP2,0,ACCESS
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;LstMs = CurMs                   ' And Record Toggle Time
	MOVFF	CURMS,LSTMS
	MOVFF	CURMS_H,LSTMS_H
;end if
ENDIF1:
;IntOn
	BTFSS	SYSINTSTATESAVE0,0,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	BTFSC	SYSINTSTATESAVE0,0,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;END
	BRA	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1360)
INITTIMER0182:
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	MOVLW	240
BANKSEL	T0CON1
	ANDWF	T0CON1,W,BANKED
	MOVWF	SYSTEMP2,ACCESS
	IORWF	TMRPRES,F,ACCESS
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ELSE4_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5,ACCESS
;ELSE
	BRA	ENDIF4
ELSE4_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5,ACCESS
;END IF
ENDIF4:
;Write the TOCON register
;T0CON1 = TMRPres
	MOVFF	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W,BANKED
	MOVWF	SYSTEMP2,ACCESS
	IORWF	TMRPOST,F,ACCESS
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	BCF	TMRPOST,4,ACCESS
;Write the TOCON register
;T0CON0 = TMRPost
	MOVFF	TMRPOST,T0CON0
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: MILLIS.H (164)
INIT_MSCTR_INT:
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
;A8: ASM Source was:  BSF PIE3,TMR0IE,ACCESS
	BSF	PIE3,7,ACCESS
;MsCtr_ = 0
	CLRF	MSCTR_,ACCESS
	CLRF	MSCTR__H,ACCESS
	CLRF	MSCTR__U,ACCESS
	CLRF	MSCTR__E,ACCESS
;Millis = 0
	RCALL	FN_MILLIS
;
;#define PS_0_0 0        ' no clock source
;#define PS_0_1 1
;#define PS_0_8 2
;#define PS_0_64 3
;#define PS_0_256 4
;#define PS_0_1024 5
;asm ShowDebug 16bit capable, but running in 8bit mode
;InitTimer0 Osc, PRE0_64 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE,ACCESS
	MOVLW	70
	MOVWF	TMRPRES,ACCESS
	CLRF	TMRPOST,ACCESS
	RCALL	INITTIMER0182
;asm ShowDebug  Call_SetTimer_Millis_macro
;SetTimer_Millis Tmr0InitVal
;Macro Source: millis.h (365)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	MOVLW	6
BANKSEL	TMR0L
	MOVWF	TMR0L,BANKED
;asm ShowDebug Call_StartTimer_Millis_macro
;StartTimer_Millis
;Macro Source: millis.h (397)
;Set T0EN on
;A8: ASM Source was:  BSF T0CON0,T0EN,BANKED
	BSF	T0CON0,7,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

INTERRUPT:
;USE AUTOMATIC CONTEXT SAVE FOR K42 AND K83 WITH MVECEN = OFF.  INTERRUPT PRIORITY NOT SUPPORTED
;STORE SYSTEM VARIABLES
;ON INTERRUPT HANDLERS
;A8: ASM Source was:  BTFSS PIE3,TMR0IE,ACCESS
	BTFSS	PIE3,7,ACCESS
	BRA	NOTTMR0IF
;A8: ASM Source was:  BTFSS PIR3,TMR0IF,ACCESS
	BTFSS	PIR3,7,ACCESS
	BRA	NOTTMR0IF
	RCALL	MSCTR_INT_HDLR
;A8: ASM Source was:  BCF PIR3,TMR0IF,ACCESS
	BCF	PIR3,7,ACCESS
	BRA	INTERRUPTDONE
NOTTMR0IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	RETFIE	1

;********************************************************************************

;SOURCE: MILLIS.H (355)
FN_MILLIS:
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	BCF	SYSINTSTATESAVE0,1,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	BSF	SYSINTSTATESAVE0,1,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;Millis = MsCtr_
	MOVFF	MSCTR_,MILLIS
	MOVFF	MSCTR__H,MILLIS_H
	MOVFF	MSCTR__U,MILLIS_U
	MOVFF	MSCTR__E,MILLIS_E
;IntOn
	BTFSS	SYSINTSTATESAVE0,1,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	BTFSC	SYSINTSTATESAVE0,1,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	RETURN

;********************************************************************************

;SOURCE: MILLIS.H (154)
MSCTR_INT_HDLR:
;dim MsCtr_ as Long
;asm ShowDebug Call_SetTimer_Millis_macro
;SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue
;Macro Source: millis.h (365)
;Handle chips with TMR0H
;USe default 8-bit mode
;TMR0L = TMRValueMillis
	MOVLW	6
BANKSEL	TMR0L
	MOVWF	TMR0L,BANKED
;MsCtr_ = MsCtr_ + 1
	INCF	MSCTR_,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	MSCTR__H,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	MSCTR__U,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	MSCTR__E,F,ACCESS
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3065)
SYSCOMPLESSTHAN16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	BNC	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
;return
	RETURN
SCLT16TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F,ACCESS
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
