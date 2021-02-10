;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\170_using_external_interrupt_to_raise_an_event.S"
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
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 SAVEDELAYTEMP                    EQU 1282                    ; 0X502
 SAVEDELAYTEMP2                   EQU 1283                    ; 0X503
 SAVESYSTEMP1                     EQU 1284                    ; 0X504
 SYSBITVAR0                       EQU 1287                    ; 0X507
 SYSBSR                           EQU 1288                    ; 0X508
 SYSSTATUS                        EQU 1295                    ; 0X50F
 SYSTEMP1                         EQU 1289                    ; 0X509
 SYSW                             EQU 1294                    ; 0X50E
 SYSWAITTEMPUS                    EQU 1285                    ; 0X505
 SYSWAITTEMPUS_H                  EQU 1286                    ; 0X506

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
;ENABLE INTERRUPTS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS

;START OF THE MAIN PROGRAM
;''
;'' This demonstration will provide code for raising an event when a port changes.
;'' The port that is being set then inspected in PORTA.2. Why? Because we have the switch on that port.
;''
;'' When the event happens the LED is toggled.  The LED will toggle when the Signal value is 0.
;''
;'' This does not have a proper debounce check, you can add one.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;Chip Settings.
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
;Dim SWState as BIT
;Setup an Interrupt event when switch goes negative.
;IOCAN3 = 1
BANKSEL	IOCAN
;A8: ASM Source was:  BSF IOCAN,IOCAN3,BANKED
	BSF	IOCAN,3,BANKED
;On Interrupt PORTChange  Call InterruptHandler
;A8: ASM Source was:  BSF PIE0,IOCIE,ACCESS
	BSF	PIE0,7,ACCESS
;Loop forever
;Do
SYSDOLOOP_S1:
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
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

INTERRUPT:
;USE AUTOMATIC CONTEXT SAVE FOR K42 AND K83 WITH MVECEN = OFF.  INTERRUPT PRIORITY NOT SUPPORTED
;STORE SYSTEM VARIABLES
	MOVFF	SYSTEMP1,SAVESYSTEMP1
	MOVFF	DELAYTEMP2,SAVEDELAYTEMP2
	MOVFF	DELAYTEMP,SAVEDELAYTEMP
;ON INTERRUPT HANDLERS
;A8: ASM Source was:  BTFSS PIE0,IOCIE,ACCESS
	BTFSS	PIE0,7,ACCESS
	BRA	NOTIOCIF
;A8: ASM Source was:  BTFSS PIR0,IOCIF,ACCESS
	BTFSS	PIR0,7,ACCESS
	BRA	NOTIOCIF
	RCALL	INTERRUPTHANDLER
;A8: ASM Source was:  BCF PIR0,IOCIF,ACCESS
	BCF	PIR0,7,ACCESS
	BRA	INTERRUPTDONE
NOTIOCIF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	MOVFF	SAVESYSTEMP1,SYSTEMP1
	MOVFF	SAVEDELAYTEMP2,DELAYTEMP2
	MOVFF	SAVEDELAYTEMP,DELAYTEMP
	RETFIE	1

;********************************************************************************

;SOURCE: 170_USING_EXTERNAL_INTERRUPT_TO_RAISE_AN_EVENT.GCB (67)
INTERRUPTHANDLER:
;If IOCIF = 1 Then
;A8: ASM Source was:  BTFSS PIR0,IOCIF,ACCESS
	BTFSS	PIR0,7,ACCESS
	BRA	ENDIF1
;Is this our event?
;We must clear the flag in software
;IOCAF3  = 0
BANKSEL	IOCAF
;A8: ASM Source was:  BCF IOCAF,IOCAF3,BANKED
	BCF	IOCAF,3,BANKED
;Save the state
;SWState = RC2
	BCF	SYSBITVAR0,0,ACCESS
;A8: ASM Source was:  BTFSC PORTC,RC2,ACCESS
	BTFSC	PORTC,2,ACCESS
	BSF	SYSBITVAR0,0,ACCESS
;Toggle the LED
;RC1 = !RC1
	CLRF	SYSTEMP1,ACCESS
;A8: ASM Source was:  BTFSC PORTC,RC1,ACCESS
	BTFSC	PORTC,1,ACCESS
	INCF	SYSTEMP1,F,ACCESS
	COMF	SYSTEMP1,F,ACCESS
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
	BTFSC	SYSTEMP1,0,ACCESS
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;a little delay
;wait 100 us
	MOVLW	2
	MOVWF	DELAYTEMP2,ACCESS
DELAYUSO1:
	CLRF	DELAYTEMP,ACCESS
DELAYUS1:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS1
	DECFSZ	DELAYTEMP2,F,ACCESS
	BRA	DELAYUSO1
	MOVLW	19
	MOVWF	DELAYTEMP,ACCESS
DELAYUS2:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS2
;Wait while SWITCHIN = SWState
SYSWAITLOOP1:
	CLRF	WREG,ACCESS
	BTFSC	PORTA,3,ACCESS
	XORLW	255
	BTFSC	SYSBITVAR0,0,ACCESS
	XORLW	255
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSWAITLOOP1
;End If
ENDIF1:
	BANKSEL	0
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
