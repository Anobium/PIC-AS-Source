;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\040_rotate_the_leds_using_asm.S"
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
 DELAY1                           EQU 1280                    ; 0X500
 DELAY2                           EQU 1281                    ; 0X501
 DISPLAY                          EQU 1282                    ; 0X502

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

;START OF THE MAIN PROGRAM
;Dim Display, Delay1, Delay2 as byte
START:
;CLRF TRISC
	CLRF	TRISC,ACCESS
;MOVLW 0x08
	MOVLW	8
;MOVWF Display
	MOVWF	DISPLAY,ACCESS
MAINLOOP:
;MOVF Display,w    ;Copy the display to the LEDs
	MOVF	DISPLAY,W,ACCESS
;MOVWF PORTC
	MOVWF	PORTC,ACCESS
ONDELAYLOOP:
;DECFSZ Delay1,f
	DECFSZ	DELAY1,F,ACCESS
;GOTO OndelayLoop
	BRA	ONDELAYLOOP
;DECFSZ Delay2,f
	DECFSZ	DELAY2,F,ACCESS
;GOTO OndelayLoop
	BRA	ONDELAYLOOP
;BCF STATUS,C      ;ensure the carry bit is clear
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;RRF Display,f     ;Rotate Display right
	RRCF	DISPLAY,F,ACCESS
;BTFSC STATUS,C    ;Did the bit rotate into the carry?
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
;BSF Display,3     ;yes, put it into bit 3.
	BSF	DISPLAY,3,ACCESS
;GOTO MainLoop
	BRA	MAINLOOP
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
;OSCFRQ = 0b00000010    '4mhz
	MOVLW	2
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

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
