;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\13_eeprom.S"
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
 ADC_VALUE                        EQU 32                    ; 0X20
 ADREADPORT                       EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 READAD                           EQU 34                    ; 0X22
 RESTORED_VALUE                   EQU 35                    ; 0X23
 SAVEDELAYTEMP2                   EQU 36                    ; 0X24
 SAVEPCLATH                       EQU 37                    ; 0X25
 SAVESYSBYTETEMPA                 EQU 38                    ; 0X26
 SAVESYSBYTETEMPB                 EQU 39                    ; 0X27
 SAVESYSBYTETEMPX                 EQU 40                    ; 0X28
 SAVESYSDIVLOOP                   EQU 41                    ; 0X29
 SAVESYSWAITTEMPMS                EQU 42                    ; 0X2A
 SAVESYSWAITTEMPMS_H              EQU 43                    ; 0X2B
 SYSBSR                           EQU 44                    ; 0X2C
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSINTSTATESAVE0                 EQU 45                    ; 0X2D
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSW                             EQU 126                    ; 0X7E
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73

;********************************************************************************

;ALIAS VARIABLES
 EEADDRESS                        EQU 401
 EEADDRESS_H                      EQU 402
 EEDATAVALUE                      EQU 403
 SYSREADADBYTE                    EQU 34

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
	MOVF	SYSWAITTEMPMS,W
	MOVWF	SAVESYSWAITTEMPMS
	MOVF	SYSWAITTEMPMS_H,W
	MOVWF	SAVESYSWAITTEMPMS_H
	MOVF	SYSBYTETEMPA,W
	MOVWF	SAVESYSBYTETEMPA
	MOVF	SYSBYTETEMPB,W
	MOVWF	SAVESYSBYTETEMPB
	MOVF	SYSBYTETEMPX,W
	MOVWF	SAVESYSBYTETEMPX
	MOVF	SYSDIVLOOP,W
	MOVWF	SAVESYSDIVLOOP
	MOVF	DELAYTEMP2,W
	MOVWF	SAVEDELAYTEMP2
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
;B7: ASM Source was:  BTFSS INTCON,IOCIE
	BTFSS	INTCON,3
	GOTO	NOTIOCIF
;B7: ASM Source was:  BTFSS INTCON,IOCIF
	BTFSS	INTCON,0
	GOTO	NOTIOCIF
	CALL	INTERRUPTHANDLER
;B7: ASM Source was:  BCF INTCON,IOCIF
	BCF	INTCON,0
	GOTO	INTERRUPTDONE
NOTIOCIF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	MOVF	SAVESYSWAITTEMPMS,W
	MOVWF	SYSWAITTEMPMS
	MOVF	SAVESYSWAITTEMPMS_H,W
	MOVWF	SYSWAITTEMPMS_H
	MOVF	SAVESYSBYTETEMPA,W
	MOVWF	SYSBYTETEMPA
	MOVF	SAVESYSBYTETEMPB,W
	MOVWF	SYSBYTETEMPB
	MOVF	SAVESYSBYTETEMPX,W
	MOVWF	SYSBYTETEMPX
	MOVF	SAVESYSDIVLOOP,W
	MOVWF	SYSDIVLOOP
	MOVF	SAVEDELAYTEMP2,W
	MOVWF	DELAYTEMP2
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
	ORG	58
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;B7: ASM Source was:  BSF INTCON,PEIE
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;'' Lesson 13 - "EEPROM"
;''
;'' This lesson will provide code for writing and reading a single byte onto
;'' the on-board EEPROM. EEPROM is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The EEPROM is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' Writes and reads to the EEPROM are practically instant and are much faster
;'' than program memory operations.
;'' Press the switch to save the LED state and then disconnect the power. When
;'' power is then applied again, the program will start with that same LED lit.
;'' When the lesson is first programmed, no LEDs will light up even with movement
;'' of the POT. When the switch is pressed, the corresponding LED will be lit and
;'' then the PIC will go to sleep until the switch is pressed again. Each press of
;'' the switch saves the ADC value into EEPROM. The PIC uses interrupts to wake up
;'' from sleep, take an ADC reading, save to EEPROM, and then goes back to sleep.
;''
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
;This script allows for the voltage drop and compensates of any losses.
;#DEFINE DOWN                0
;#DEFINE UP                  1
;#DEFINE SWITCH              PORTA.3
;' -------------------LATC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|DS4|DS3|DS2|DS1|-
;'-----------------------------------------
;'
;Dim RESTORED_VALUE, ADC_VALUE As Byte
;Dir portc Out
BANKSEL	TRISC
CLRF	TRISC
;portc = 0
BANKSEL	PORTC
CLRF	PORTC
;Dir porta.3 In
BANKSEL	TRISA
	BSF	TRISA,3
;IOCAN3 = 1
BANKSEL	IOCAN
;B7: ASM Source was:  BSF IOCAN,IOCAN3
	BSF	IOCAN,3
;IOCIE = 1
;B7: ASM Source was:  BSF INTCON,IOCIE
	BSF	INTCON,3
;On Interrupt PORTChange  Call InterruptHandler
;B7: ASM Source was:  BSF INTCON,IOCIE
	BSF	INTCON,3
;Do
SYSDOLOOP_S1:
;EPRead ( 0, restored_value)
;B9: ASM Source was:  BANKSEL EEADDRESS
BANKSEL	EEADRL
;B9: ASM Source was:  CLRF EEADDRESS
CLRF	EEADRL
;B9: ASM Source was:  CLRF EEADDRESS_H
CLRF	EEADRH
BANKSEL	STATUS
	CALL	SYSEPREAD
;B9: ASM Source was:  BANKSEL EEDATAVALUE
BANKSEL	EEDATL
;B2: ASM Source was:  MOVF EEDATAVALUE,W
;B4: ASM Source was:  MOVF EEDATAVALUE,W
	MOVF	EEDATL,W
	BANKSEL	RESTORED_VALUE
	MOVWF	RESTORED_VALUE
;portc = restored_value / ADC_adjustment
	MOVWF	SYSBYTETEMPA
	MOVLW	13
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
MOVWF	PORTC
;Sleep
	SLEEP
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
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

;SOURCE: EEPROM.H (82)
EPWRITE:
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
	BCF	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;Select data memory
;SET EEPGD OFF
BANKSEL	EECON1
;B7: ASM Source was:  BCF EECON1,EEPGD
	BCF	EECON1,7
;Set CFGS OFF
;B7: ASM Source was:  BCF EECON1,CFGS
	BCF	EECON1,6
;Start write
;SET WREN ON
;B7: ASM Source was:  BSF EECON1,WREN
	BSF	EECON1,2
;EECON2 = 0x55
	MOVLW	85
MOVWF	EECON2
;EECON2 = 0xAA
	MOVLW	170
MOVWF	EECON2
;SET WR ON
;B7: ASM Source was:  BSF EECON1,WR
	BSF	EECON1,1
;SET WREN OFF
;B7: ASM Source was:  BCF EECON1,WREN
	BCF	EECON1,2
;Wait for write to complete
;WAIT WHILE WR ON
SYSWAITLOOP2:
;B7: ASM Source was:  BTFSC EECON1,WR
	BTFSC	EECON1,1
	GOTO	SYSWAITLOOP2
;SET WREN OFF
;B7: ASM Source was:  BCF EECON1,WREN
	BCF	EECON1,2
;Restore interrupt
;IntOn
	BANKSEL	SYSINTSTATESAVE0
	BTFSS	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,0
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
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

;SOURCE: 13_EEPROM.GCB (87)
INTERRUPTHANDLER:
;If IOCAF3 = 1 Then
BANKSEL	IOCAF
;B7: ASM Source was:  BTFSS IOCAF,IOCAF3
	BTFSS	IOCAF,3
	GOTO	ENDIF1
;SW1 was just pressed
;must clear the flag in software
;IOCAF3 = 0
;B7: ASM Source was:  BCF IOCAF,IOCAF3
	BCF	IOCAF,3
;debounce by waiting and seeing if still held down
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;If ( SWITCH = DOWN ) Then
	BTFSC	PORTA,3
	GOTO	ENDIF2
;adc_value = ReadAD ( AN0 )
	CLRF	ADREADPORT
	CALL	FN_READAD5
	MOVF	SYSREADADBYTE,W
	MOVWF	ADC_VALUE
;PORTC = adc_value / ADC_adjustment
	MOVWF	SYSBYTETEMPA
	MOVLW	13
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
MOVWF	PORTC
;EPWrite ( 0, adc_value )
;B9: ASM Source was:  BANKSEL EEADDRESS
BANKSEL	EEADRL
;B9: ASM Source was:  CLRF EEADDRESS
CLRF	EEADRL
;B9: ASM Source was:  CLRF EEADDRESS_H
CLRF	EEADRH
	BANKSEL	ADC_VALUE
	MOVF	ADC_VALUE,W
;B9: ASM Source was:  BANKSEL EEDATAVALUE
BANKSEL	EEDATL
;B9: ASM Source was:  MOVWF EEDATAVALUE
MOVWF	EEDATL
BANKSEL	STATUS
	CALL	EPWRITE
;End If
ENDIF2:
;End If
ENDIF1:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD5:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON1
;B7: ASM Source was:  BCF ADCON1,ADFM
	BCF	ADCON1,7
;***************************************
;Perform conversion
;LLReadAD 1
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
	GOTO	ENDIF3
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS0
	BSF	ADCON0,2
ENDIF3:
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,1
	GOTO	ENDIF4
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS1
	BSF	ADCON0,3
ENDIF4:
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,2
	GOTO	ENDIF5
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS2
	BSF	ADCON0,4
ENDIF5:
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,3
	GOTO	ENDIF6
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS3
	BSF	ADCON0,5
ENDIF6:
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,4
	GOTO	ENDIF7
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS4
	BSF	ADCON0,6
ENDIF7:
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
;ReadAD = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
BANKSEL	ADCON1
;B7: ASM Source was:  BCF ADCON1,ADFM
	BCF	ADCON1,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2644)
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfsc STATUS, Z
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP
SYSDIV8START:
;bcf STATUS, C
;B7: ASM Source was:  BCF STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	RLF	SYSBYTETEMPX, F
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0
;btfsc STATUS, C
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
;goto Div8NotNeg
	GOTO	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	GOTO	SYSDIV8START
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (167)
SYSEPREAD:
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
	BCF	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;Select data memory
;SET EEPGD OFF
BANKSEL	EECON1
;B7: ASM Source was:  BCF EECON1,EEPGD
	BCF	EECON1,7
;Set CFGS OFF
;B7: ASM Source was:  BCF EECON1,CFGS
	BCF	EECON1,6
;Read
;SET RD ON
;B7: ASM Source was:  BSF EECON1,RD
	BSF	EECON1,0
;Restore interrupt
;IntOn
	BANKSEL	SYSINTSTATESAVE0
	BTFSS	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSINTSTATESAVE0,1
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
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
