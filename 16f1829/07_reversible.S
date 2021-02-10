;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F1829
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f1829\07_reversible.S"
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
 ADREADPORT                       EQU 32                    ; 0X20
 CHECK_SWITCH                     EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DIRECTION                        EQU 34                    ; 0X22
 MYDELAY                          EQU 35                    ; 0X23
 READAD10                         EQU 36                    ; 0X24
 READAD10_H                       EQU 37                    ; 0X25
 SYSBITVAR0                       EQU 38                    ; 0X26
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSTEMP1                         EQU 39                    ; 0X27
 SYSTEMP1_H                       EQU 40                    ; 0X28
 SYSTEMP2                         EQU 41                    ; 0X29
 SYSTEMP3                         EQU 42                    ; 0X2A
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 SYSWORDTEMPX                     EQU 112                    ; 0X70
 SYSWORDTEMPX_H                   EQU 113                    ; 0X71

;********************************************************************************

;ALIAS VARIABLES
 SYSREADAD10WORD                  EQU 36
 SYSREADAD10WORD_H                EQU 37

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

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''  Lesson 7 - "Reversible"
;''
;''  This lesson combines all of the previous lessons in using the button to reverse the
;''  direction of rotation when the button is pressed. The speed of rotation is controlled
;''  using the potentiometer.
;''
;''  The program needs to keep track of rotation direction and new code needs to be added
;''  to rotate in the other direction. Lesson 5 rotates right and checks for a '1' in the carry
;''  bit to determine when to restart the sequence. In Lesson 7, the program needs to rotate
;''  both ways and check for a '1' in bit 4 of the display when rotating to the left. When the
;''  '1' shows up in bit 4 of LATC, it will be re-inserted into bit  0 .
;''
;''  The debounce routine is more in-depth in this lesson because we need to keep in mind
;''  of the scenario of the switch being held down for long periods of time. If SW1 is held
;''  down, the LEDs would change direction rapidly, making the display look like it is out of
;''  control. The above flowchart will only change direction on the first indication of a solid
;''  press and then ignore the switch until it is released and pushed again. The switch must
;''  be pressed for at least the time it takes for the program to check the switch in its loop.
;''  Since the PIC MCU is running at 500 kHz, this will seem instantaneous.
;''
;''  LEDs will rotate at a speed that is proportional to the ADC value. The switch will toggle
;''  the direction of the LEDs
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
;' -------------------LATC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|DS4|DS3|DS2|DS1|-
;'-----------------------------------------
;'
;This script allows for the voltage drop and compensates of any losses.
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE LED_RIGHT           TRUE
;#DEFINE LED_LEFT            FALSE
;#DEFINE SWITCH      PORTA.3
;Dim mydelay As Byte
;Dim DIRECTION As Byte
;start from the right to left
;direction = LED_RIGHT
	MOVLW	255
	MOVWF	DIRECTION
;Dir portc Out
BANKSEL	TRISC
CLRF	TRISC
;portc.3 = 1
BANKSEL	LATC
	BSF	LATC,3
;Potentiamtor is connected to RA4...set as input
;Dir porta.0 In
BANKSEL	TRISA
	BSF	TRISA,0
;setup switch (SW1)
;Dir porta.3 In
	BSF	TRISA,3
;Do
SYSDOLOOP_S1:
;mydelay = ReadAD10 ( AN0 )  / ADC_adjustment
	BANKSEL	ADREADPORT
	CLRF	ADREADPORT
	CALL	FN_READAD107
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	54
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	MYDELAY
;decrement the 8 MSbs of the ADC and delay 20ms for each
;Do While ( mydelay <> 0 )
SYSDOLOOP_S2:
	MOVF	MYDELAY,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	SYSDOLOOP_E2
;mydelay--
	DECF	MYDELAY,F
;Wait 20 ms
	MOVLW	20
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Loop
	GOTO	SYSDOLOOP_S2
SYSDOLOOP_E2:
;If check_switch = TRUE Then
	CALL	FN_CHECK_SWITCH
	INCF	CHECK_SWITCH,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;toggle the direction
;direction = !direction
	COMF	DIRECTION,F
;End If
;If  direction = LED_RIGHT  Then
	INCF	DIRECTION,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE2_1
;shift to the right by 1
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Right
	RRF	PORTC,F
;when the last LED is lit, restart the pattern
;If C = 1 Then
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
	GOTO	ENDIF3
;portc.3 = 1
BANKSEL	LATC
	BSF	LATC,3
;End If
ENDIF3:
;Else
	GOTO	ENDIF2
ELSE2_1:
;shift to the left by 1
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate portc Left
	RLF	PORTC,F
;when the last LED is lit, restart the pattern
;If  portC.4 = 1 Then
	BTFSS	PORTC,4
	GOTO	ENDIF4
;portC.0 = 1
BANKSEL	LATC
	BSF	LATC,0
;portC.4 = 0
	BCF	LATC,4
;End If
ENDIF4:
;End If
ENDIF2:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;global variable - if button is held down, we don't want to keep on switching directions
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: 07_REVERSIBLE.GCB (129)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,3
	GOTO	ELSE5_1
;debounce by delaying and checking if switch is still pressed
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If ( (previous_state =  SWITCH_DOWN) & (SWITCH = SWITCH_DOWN) ) Then
	CLRF	SYSBYTETEMPX
	BTFSS	SYSBITVAR0,0
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	CLRF	SYSBYTETEMPX
	BTFSS	PORTA,3
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	ANDWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ELSE6_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF6
ELSE6_1:
;check if still down
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,3
	GOTO	ELSE7_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	MOVLW	255
	MOVWF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF7
ELSE7_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF7:
;End If
ENDIF6:
;Else
	GOTO	ENDIF5
ELSE5_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF5:
	RETURN

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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD107:
;Always RIGHT justified
;SET ADFM ON
BANKSEL	ADCON1
;B7: ASM Source was:  BSF ADCON1,ADFM
	BSF	ADCON1,7
;Do conversion
;LLReadAD 0
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
	GOTO	ENDIF8
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS0
	BSF	ADCON0,2
ENDIF8:
;IF ADReadPort.1 On Then Set CHS1 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,1
	GOTO	ENDIF9
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS1
	BSF	ADCON0,3
ENDIF9:
;IF ADReadPort.2 On Then Set CHS2 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,2
	GOTO	ENDIF10
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS2
	BSF	ADCON0,4
ENDIF10:
;If ADReadPort.3 On Then Set CHS3 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,3
	GOTO	ENDIF11
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS3
	BSF	ADCON0,5
ENDIF11:
;If ADReadPort.4 On Then Set CHS4 On
	BANKSEL	ADREADPORT
	BTFSS	ADREADPORT,4
	GOTO	ENDIF12
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,CHS4
	BSF	ADCON0,6
ENDIF12:
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
BANKSEL	ADCON1
;B7: ASM Source was:  BCF ADCON1,ADFM
	BCF	ADCON1,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2894)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2712)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF13
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF13:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
SYSDIV16START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	GOTO	ENDIF14
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF14:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
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
