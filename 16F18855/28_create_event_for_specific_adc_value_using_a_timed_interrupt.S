;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\28_create_event_for_specific_adc_value_using_a_timed_interrupt.S"
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
 CURMILLIS                        EQU 33                    ; 0X21
 CURMILLIS_E                      EQU 36                    ; 0X24
 CURMILLIS_H                      EQU 34                    ; 0X22
 CURMILLIS_U                      EQU 35                    ; 0X23
 CURRENTACVALUE                   EQU 37                    ; 0X25
 CURRENTACVALUE_H                 EQU 38                    ; 0X26
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 MILLIS                           EQU 39                    ; 0X27
 MILLIS_E                         EQU 42                    ; 0X2A
 MILLIS_H                         EQU 40                    ; 0X28
 MILLIS_U                         EQU 41                    ; 0X29
 READAD10                         EQU 43                    ; 0X2B
 READAD10_H                       EQU 44                    ; 0X2C
 SAVEPCLATH                       EQU 45                    ; 0X2D
 SYSBSR                           EQU 46                    ; 0X2E
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSINTSTATESAVE0                 EQU 47                    ; 0X2F
 SYSLONGTEMPA                     EQU 117                    ; 0X75
 SYSLONGTEMPA_E                   EQU 120                    ; 0X78
 SYSLONGTEMPA_H                   EQU 118                    ; 0X76
 SYSLONGTEMPA_U                   EQU 119                    ; 0X77
 SYSLONGTEMPB                     EQU 121                    ; 0X79
 SYSLONGTEMPB_E                   EQU 124                    ; 0X7C
 SYSLONGTEMPB_H                   EQU 122                    ; 0X7A
 SYSLONGTEMPB_U                   EQU 123                    ; 0X7B
 SYSREPEATTEMP1                   EQU 48                    ; 0X30
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 49                    ; 0X31
 SYSW                             EQU 126                    ; 0X7E
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 T0_MILLIS                        EQU 50                    ; 0X32
 T0_MILLIS_E                      EQU 53                    ; 0X35
 T0_MILLIS_H                      EQU 51                    ; 0X33
 T0_MILLIS_U                      EQU 52                    ; 0X34
 TMRNUMBER                        EQU 54                    ; 0X36
 TMRPOST                          EQU 55                    ; 0X37
 TMRPRES                          EQU 56                    ; 0X38
 TMRSOURCE                        EQU 57                    ; 0X39
 TMRVALUE                         EQU 58                    ; 0X3A
 TMRVALUE_H                       EQU 59                    ; 0X3B

;********************************************************************************

;ALIAS VARIABLES
 SYSREADAD10WORD                  EQU 43
 SYSREADAD10WORD_H                EQU 44

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
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
BANKSEL	PIE0
;B7: ASM Source was:  BTFSS PIE0,TMR0IE
	BTFSS	PIE0,5
	GOTO	NOTTMR0IF
;B7: ASM Source was:  BTFSS PIR0,TMR0IF
	BTFSS	PIR0,5
	GOTO	NOTTMR0IF
BANKSEL	STATUS
	CALL	TMR0_ISR
BANKSEL	PIR0
;B7: ASM Source was:  BCF PIR0,TMR0IF
	BCF	PIR0,5
	GOTO	INTERRUPTDONE
NOTTMR0IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEPCLATH
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
	ORG	34
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;B7: ASM Source was:  BSF INTCON,PEIE
	BSF	INTCON,6
	BSF	SYSINTSTATESAVE0,0

;START OF THE MAIN PROGRAM
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program demonstrates how to read the ADC and create an event at a specific ADC value.
;''
;''@author    EvanV & CRoper
;''@licence   GPL
;''@version   1.0
;''@date      6.7.2016
;''
;''  PIC: 16F18855 - Xpress Evaluation Board
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''
;'' The data sheet states interrupts are complete when the A/D conversion is done.
;''
;'' When the A/D conversion is complete, the result is loaded into
;'' this A/D result register pair, the GO/DONE bit (ADCON0<2>)
;'' is cleared and the A/D interrupt flag bit ADIF is set.
;''
;''
;'' Solution:
;'' You can create a periodic timer interrupt (using Timer0 for example)
;'' and read the A/D in the ISR. In effect you would be polling the A/D
;'' voltage. Then, set a flag or do something if the current value is
;'' sufficiently different from the previous value.
;'' If you were just looking for a interrupt if the input moved above or
;'' below a fixed voltage, then you could use the comparator, and use
;'' the INT_COMP interrupt. You could even change the reference voltage
;'' inside the ISR, to provide some hysteresis, and thereby reduce the
;'' effects of signal noise (to prevent getting lots of spurious interrupts
;'' if the input voltage is very close to the reference voltage).
;''
;''********************************************************************************
;Chip Settings.
;this is in milliseconds - this therefore reads the ADC every... ms.
;#DEFINE ADCTimeDelay 10
;There is a small processing overhead so the actual delay may a tiny bit out.
;this is the alarm setting
;#DEFINE myADCLimit   131
;Critical - Used by the ISR'
;Dim t0_millis             As Long
;working copy '
;Dim curMillis             As Long
;Dim currentACvalue        As Word
;Potentitor is connected to RA4...set as input
;Dir porta.4 In
	BSF	TRISA,4
;LED out
;#DEFINE LEDD2 porta.0
;Dir LEDD2 Out
	BCF	TRISA,0
;LEDD2 = On
	BSF	LATA,0
;#DEFINE LEDD3 porta.1
;Dir LEDD3 Out
	BCF	TRISA,1
;LEDD3 = On
	BSF	LATA,1
;#DEFINE LEDD4 porta.2
;Dir LEDD4 Out
	BCF	TRISA,2
;LEDD4 = On
	BSF	LATA,2
;#DEFINE LEDD5 porta.3
;Dir LEDD5 Out
	BCF	TRISA,3
;LEDD5 = On
	BSF	LATA,3
;Just to show we are operational!!
;Repeat 16
	MOVLW	16
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1:
;LEDD2  = !LEDD2
	CLRF	SYSTEMP1
	BTFSC	PORTA,0
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATA,0
	BTFSC	SYSTEMP1,0
	BSF	LATA,0
;LEDD3  = LEDD2
	BCF	LATA,1
	BTFSC	PORTA,0
	BSF	LATA,1
;LEDD4  = LEDD2
	BCF	LATA,2
	BTFSC	PORTA,0
	BSF	LATA,2
;LEDD5  = LEDD2
	BCF	LATA,3
	BTFSC	PORTA,0
	BSF	LATA,3
;Wait 125 ms
	MOVLW	125
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;LEDD2 = Off
	BCF	LATA,0
;LEDD3 = Off
	BCF	LATA,1
;LEDD4 = Off
	BCF	LATA,2
;LEDD5 = Off
	BCF	LATA,3
;Set up the Interrupt
;TMR0_Initialize()
;#DEFINE TMR0_16bit
;Period 1ms
;#DEFINE period_1ms   0xE0C0
;InitTimer0(Osc, TMR0_FOSC4 + PRE0_1 , POST0_1)
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	64
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0178
;Preload Count for 1ms
;SetTimer(0, period_1ms)
	CLRF	TMRNUMBER
	MOVLW	192
	MOVWF	TMRVALUE
	MOVLW	224
	MOVWF	TMRVALUE_H
	CALL	SETTIMER176
;StartTimer 0
	CLRF	TMRNUMBER
	CALL	STARTTIMER
;Add a handler for the interrupt
;On Interrupt Timer0Overflow Call TMR0_ISR
BANKSEL	PIE0
;B7: ASM Source was:  BSF PIE0,TMR0IE
	BSF	PIE0,5
;Loop forever
;Do Forever
SYSDOLOOP_S1:
;Get the current time in ms
;curMillis = millis
BANKSEL	STATUS
	CALL	FN_MILLIS
	MOVF	MILLIS,W
	MOVWF	CURMILLIS
	MOVF	MILLIS_H,W
	MOVWF	CURMILLIS_H
	MOVF	MILLIS_U,W
	MOVWF	CURMILLIS_U
	MOVF	MILLIS_E,W
	MOVWF	CURMILLIS_E
;is the current time greater than our specified time delay.
;If curMillis => ADCTimeDelay  Then
	MOVF	CURMILLIS,W
	MOVWF	SYSLONGTEMPA
	MOVF	CURMILLIS_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	CURMILLIS_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	CURMILLIS_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVLW	10
	MOVWF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	CALL	SYSCOMPLESSTHAN32
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF1
;currentACvalue = ReadAD10 ( AN4 )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD108
	MOVF	SYSREADAD10WORD,W
	MOVWF	CURRENTACVALUE
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	CURRENTACVALUE_H
;Just to show we are here...
;LEDD2  = !LEDD2
	CLRF	SYSTEMP1
	BTFSC	PORTA,0
	INCF	SYSTEMP1,F
	COMF	SYSTEMP1,F
	BCF	LATA,0
	BTFSC	SYSTEMP1,0
	BSF	LATA,0
;Is the ADC greater than the specified value?
;If currentACvalue > myADCLimit Then
	MOVF	CURRENTACVALUE,W
	MOVWF	SYSWORDTEMPB
	MOVF	CURRENTACVALUE_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	131
	MOVWF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE2_1
;LEDD5 = On
	BSF	LATA,3
;Else
	GOTO	ENDIF2
ELSE2_1:
;LEDD5 = Off
	BCF	LATA,3
;End If
ENDIF2:
;disable interrupts while we reset our timer.
;IntOff
	BCF	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;t0_millis = 0
	CLRF	T0_MILLIS
	CLRF	T0_MILLIS_H
	CLRF	T0_MILLIS_U
	CLRF	T0_MILLIS_E
;IntOn
	BTFSS	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;End If
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Returns the current value of the timer.
;This is called every time timer1 overflows.  We increment t0_millis so we can count things.
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1360)
INITTIMER0178:
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
	ANDWF	T0CON1,W
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ELSE25_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF25
ELSE25_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
ENDIF25:
;Write the TOCON register
;T0CON1 = TMRPres
	MOVF	TMRPRES,W
MOVWF	T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W
	MOVWF	SYSTEMP1
	IORWF	TMRPOST,F
;Set TO16BIT
;Set TMRPost.4 ON '16-bit Timer0
	BSF	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	MOVF	TMRPOST,W
MOVWF	T0CON0
	RETURN

;********************************************************************************

;SOURCE: 28_CREATE_EVENT_FOR_SPECIFIC_ADC_VALUE_USING_A_TIMED_INTERRUPT.GCB (124)
FN_MILLIS:
;disable interrupts while we read t0_millis '
;IntOff
	BCF	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;millis = t0_millis
	MOVF	T0_MILLIS,W
	MOVWF	MILLIS
	MOVF	T0_MILLIS_H,W
	MOVWF	MILLIS_H
	MOVF	T0_MILLIS_U,W
	MOVWF	MILLIS_U
	MOVF	T0_MILLIS_E,W
	MOVWF	MILLIS_E
;IntOn
	BTFSS	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD108:
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

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1049)
SETTIMER176:
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF18
;Handle chips with TMR0H
;TMR0H = TMRValue_H
	MOVF	TMRVALUE_H,W
MOVWF	TMR0H
;TMR0L = TMRValue
	MOVF	TMRVALUE,W
MOVWF	TMR0L
;exit to prevent default setting TMR0L = TMRValue
;exit sub
	RETURN
;End If
ENDIF18:
;If TMRNumber = 1 then
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF19
;TMR1H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR1H
MOVWF	TMR1H
;TMR1L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR1L
MOVWF	TMR1L
;End If
ENDIF19:
;If TMRNumber = 2 Then
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF20
;TMR2 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR2
BANKSEL	T2TMR
;B9: ASM Source was:  MOVWF TMR2
MOVWF	T2TMR
;End If
ENDIF20:
;If TMRNumber = 3 then
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF21
;TMR3H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR3H
MOVWF	TMR3H
;TMR3L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR3L
MOVWF	TMR3L
;End If
ENDIF21:
;If TMRNumber = 4 Then
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF22
;TMR4 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR4
BANKSEL	T4TMR
;B9: ASM Source was:  MOVWF TMR4
MOVWF	T4TMR
;End If
ENDIF22:
;If TMRNumber = 5 then
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF23
;TMR5H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR5H
MOVWF	TMR5H
;TMR5L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR5L
MOVWF	TMR5L
;End If
ENDIF23:
;If TMRNumber = 6 Then
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF24
;TMR6 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR6
BANKSEL	T6TMR
;B9: ASM Source was:  MOVWF TMR6
MOVWF	T6TMR
;End If
ENDIF24:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (704)
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;B7: ASM Source was:  BSF T0CON0,T0EN
	BSF	T0CON0,7
;IF TMRNumber = 1 then Set TMR1ON on
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
BANKSEL	T1CON
;B7: ASM Source was:  BSF T1CON,TMR1ON
	BSF	T1CON,0
ENDIF12:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
ENDIF13:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
BANKSEL	T3CON
;B7: ASM Source was:  BSF T3CON,TMR3ON
	BSF	T3CON,0
ENDIF14:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,TMR4ON
	BSF	T4CON,7
ENDIF15:
;IF TMRNumber = 5 then Set TMR5ON on
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
BANKSEL	T5CON
;B7: ASM Source was:  BSF T5CON,TMR5ON
	BSF	T5CON,0
ENDIF16:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,TMR6ON
	BSF	T6CON,7
ENDIF17:
BANKSEL	STATUS
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

;SOURCE: 28_CREATE_EVENT_FOR_SPECIFIC_ADC_VALUE_USING_A_TIMED_INTERRUPT.GCB (132)
TMR0_ISR:
;reset count for 1ms compensated for isr time
;tick
;SetTimer(0, period_1ms + 1)
	CLRF	TMRNUMBER
	MOVLW	193
	MOVWF	TMRVALUE
	MOVLW	224
	MOVWF	TMRVALUE_H
	CALL	SETTIMER176
;Increment Millis()
;t0_millis += 1
	INCF	T0_MILLIS,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	T0_MILLIS_H,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	T0_MILLIS_U,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	T0_MILLIS_E,F
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
