;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\22_using_eeprom_to_save_adc_data_using_an_interrupt.S"
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
 ADC_VALUE                        EQU 32                    ; 0X20
 ADREADPORT                       EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 EEDATA                           EQU 34                    ; 0X22
 EEDATAVALUE                      EQU 35                    ; 0X23
 OUTVALUE                         EQU 36                    ; 0X24
 READAD                           EQU 37                    ; 0X25
 SAVEDELAYTEMP                    EQU 38                    ; 0X26
 SAVEDELAYTEMP2                   EQU 39                    ; 0X27
 SAVENVMADRH                      EQU 40                    ; 0X28
 SAVENVMADRL                      EQU 41                    ; 0X29
 SAVENVMCON1                      EQU 42                    ; 0X2A
 SAVEPCLATH                       EQU 43                    ; 0X2B
 SAVESYSWAITTEMP10US              EQU 44                    ; 0X2C
 SAVESYSWAITTEMPMS                EQU 45                    ; 0X2D
 SAVESYSWAITTEMPMS_H              EQU 46                    ; 0X2E
 SYSBITVAR0                       EQU 47                    ; 0X2F
 SYSBSR                           EQU 48                    ; 0X30
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSEEADDRESS                     EQU 49                    ; 0X31
 SYSEEADDRESS_H                   EQU 50                    ; 0X32
 SYSEEPROMADDRESS                 EQU 51                    ; 0X33
 SYSEEPROMADDRESS_H               EQU 52                    ; 0X34
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 53                    ; 0X35
 SYSTEMP2                         EQU 54                    ; 0X36
 SYSW                             EQU 126                    ; 0X7E
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73

;********************************************************************************

;ALIAS VARIABLES
 SYSREADADBYTE                    EQU 37

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
	MOVF	DELAYTEMP2,W
	MOVWF	SAVEDELAYTEMP2
	MOVF	DELAYTEMP,W
	MOVWF	SAVEDELAYTEMP
BANKSEL	NVMADRH
	MOVF	NVMADRH,W
	BANKSEL	SAVENVMADRH
	MOVWF	SAVENVMADRH
BANKSEL	NVMADRL
	MOVF	NVMADRL,W
	BANKSEL	SAVENVMADRL
	MOVWF	SAVENVMADRL
BANKSEL	NVMCON1
	MOVF	NVMCON1,W
	BANKSEL	SAVENVMCON1
	MOVWF	SAVENVMCON1
	MOVF	SYSWAITTEMP10US,W
	MOVWF	SAVESYSWAITTEMP10US
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
BANKSEL	PIE0
;B7: ASM Source was:  BTFSS PIE0,IOCIE
	BTFSS	PIE0,4
	GOTO	NOTIOCIF
;B7: ASM Source was:  BTFSS PIR0,IOCIF
	BTFSS	PIR0,4
	GOTO	NOTIOCIF
BANKSEL	STATUS
	CALL	INTERRUPTHANDLER
BANKSEL	PIR0
;B7: ASM Source was:  BCF PIR0,IOCIF
	BCF	PIR0,4
	GOTO	INTERRUPTDONE
NOTIOCIF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVESYSWAITTEMPMS
	MOVF	SAVESYSWAITTEMPMS,W
	MOVWF	SYSWAITTEMPMS
	MOVF	SAVESYSWAITTEMPMS_H,W
	MOVWF	SYSWAITTEMPMS_H
	MOVF	SAVEDELAYTEMP2,W
	MOVWF	DELAYTEMP2
	MOVF	SAVEDELAYTEMP,W
	MOVWF	DELAYTEMP
	MOVF	SAVENVMADRH,W
BANKSEL	NVMADRH
MOVWF	NVMADRH
	BANKSEL	SAVENVMADRL
	MOVF	SAVENVMADRL,W
BANKSEL	NVMADRL
MOVWF	NVMADRL
	BANKSEL	SAVENVMCON1
	MOVF	SAVENVMCON1,W
BANKSEL	NVMCON1
MOVWF	NVMCON1
	BANKSEL	SAVESYSWAITTEMP10US
	MOVF	SAVESYSWAITTEMP10US,W
	MOVWF	SYSWAITTEMP10US
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
	ORG	78
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
;''
;'' This demonstration will provide code for writing and reading a single byte onto
;'' the on-board EEPROM. EEPROM is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The EEPROM is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' Writes and reads to the EEPROM are practically instant and are much faster
;'' than program memory operations.
;'' Press the switch to save the LED state and then disconnect the power. When
;'' power is then applied again, the program will start with that same LED lit.
;'' When the demonstration is first programmed, no LEDs will light up even with movement
;'' of the POT. When the switch is pressed, the corresponding LED will be lit and
;'' then the PIC will go to sleep until the switch is pressed again. Each press of
;'' the switch saves the ADC value into EEPROM. The PIC uses interrupts to wake up
;'' from sleep, take an ADC reading, save to EEPROM, and then goes back to sleep.
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;Chip Settings.
;' -------------------LATA-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|D5 |D4 |D3 |D1 |-
;'-----------------------------------------
;'
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
;#DEFINE LEDD2 PORTA.0
;#DEFINE LEDD3 PORTA.1
;#DEFINE LEDD4 PORTA.2
;#DEFINE LEDD5 PORTA.3
;Dir     LEDD2 Out
	BCF	TRISA,0
;Dir     LEDD3 Out
	BCF	TRISA,1
;Dir     LEDD4 Out
	BCF	TRISA,2
;Dir     LEDD5 Out
	BCF	TRISA,3
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH              PORTA.5
;Dim OUTVALUE, DOWN, ADC_VALUE As Byte
;Setup an Interrupt event when porta.5 goes negative.
;IOCAN5 = 1
BANKSEL	IOCAN
;B7: ASM Source was:  BSF IOCAN,IOCAN5
	BSF	IOCAN,5
;On Interrupt PORTChange  Call InterruptHandler
BANKSEL	PIE0
;B7: ASM Source was:  BSF PIE0,IOCIE
	BSF	PIE0,4
;Do
SYSDOLOOP_S1:
;Read the value from the EEPROM from register Zero in the EEPROM
;EPRead ( 0, OutValue )
	BANKSEL	SYSEEADDRESS
	CLRF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
	CALL	NVMADR_EPREAD
	MOVF	EEDATAVALUE,W
	MOVWF	OUTVALUE
;Leave the Top Bytes alone and set the lower four bits
;PortA = ( PortA & 0XF0 ) OR ( OutValue / 16 )
	MOVLW	240
	ANDWF	PORTA,W
	MOVWF	SYSTEMP1
	MOVF	OUTVALUE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	IORWF	SYSTEMP2,W
MOVWF	PORTA
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

;SOURCE: 22_USING_EEPROM_TO_SAVE_ADC_DATA_USING_AN_INTERRUPT.GCB (77)
INTERRUPTHANDLER:
;If IOCAF5 = 1 Then
BANKSEL	IOCAF
;B7: ASM Source was:  BTFSS IOCAF,IOCAF5
	BTFSS	IOCAF,5
	GOTO	ENDIF1
;S2 was just pressed
;Prevent the event from reentering the InterruptHandler routine
;IOCAN5 = 0
;B7: ASM Source was:  BCF IOCAN,IOCAN5
	BCF	IOCAN,5
;We must clear the flag in software
;IOCAF5 = 0
;B7: ASM Source was:  BCF IOCAF,IOCAF5
	BCF	IOCAF,5
;debounce by waiting and seeing if still held down
;Wait 5 ms
	MOVLW	5
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;If ( SWITCH = SWITCH_DOWN ) Then
	BTFSC	PORTA,5
	GOTO	ENDIF2
;Read the ADC
;adc_value = ReadAD ( AN4 )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD5
	MOVF	SYSREADADBYTE,W
	MOVWF	ADC_VALUE
;Write the value to register Zero in the EEPROM
;EPWrite ( 0, adc_value )
	CLRF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
	MOVF	ADC_VALUE,W
	MOVWF	EEDATA
	CALL	NVMADR_EPWRITE
;End If
ENDIF2:
;ReEnable the InterruptHandler routine
;IOCAN5 = 1
BANKSEL	IOCAN
;B7: ASM Source was:  BSF IOCAN,IOCAN5
	BSF	IOCAN,5
;End If
ENDIF1:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (428)
NVMADR_EPREAD:
;Dim SysEEPromAddress As Word
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH = SysEEPromAddress_h
BANKSEL	NVMADRH
MOVWF	NVMADRH
;NVMADRL = SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
BANKSEL	NVMADRL
MOVWF	NVMADRL
;NVMREGS = 1
;B7: ASM Source was:  BSF NVMCON1,NVMREGS
	BSF	NVMCON1,6
;RD = 1
;B7: ASM Source was:  BSF NVMCON1,RD
	BSF	NVMCON1,0
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;EEDataValue = NVMDATL
	MOVF	NVMDATL,W
	BANKSEL	EEDATAVALUE
	MOVWF	EEDATAVALUE
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (284)
NVMADR_EPWRITE:
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,1
;Dim SysEEPromAddress As Word
;ALL 16F NVMREGS Devices Except 18FxxK40/K42
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH =SysEEPromAddress_h
BANKSEL	NVMADRH
MOVWF	NVMADRH
;NVMADRL =SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
BANKSEL	NVMADRL
MOVWF	NVMADRL
;NVMDATL = EEData
	BANKSEL	EEDATA
	MOVF	EEDATA,W
BANKSEL	NVMDATL
MOVWF	NVMDATL
;NVMREGS = 1
;B7: ASM Source was:  BSF NVMCON1,NVMREGS
	BSF	NVMCON1,6
;FREE =0b'0'
;B7: ASM Source was:  BCF NVMCON1,FREE
	BCF	NVMCON1,4
;WREN= 0b'1'
;B7: ASM Source was:  BSF NVMCON1,WREN
	BSF	NVMCON1,2
;GIE = 0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;NVMCON2 = 0x55
	MOVLW	85
MOVWF	NVMCON2
;NVMCON2 = 0xAA
	MOVLW	170
MOVWF	NVMCON2
;WR = 1
;B7: ASM Source was:  BSF NVMCON1,WR
	BSF	NVMCON1,1
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;wait while WR = 1
SYSWAITLOOP2:
;B7: ASM Source was:  BTFSC NVMCON1,WR
	BTFSC	NVMCON1,1
	GOTO	SYSWAITLOOP2
;WREN= 0b'0'
;B7: ASM Source was:  BCF NVMCON1,WREN
	BCF	NVMCON1,2
;Restore interrupt to initial  State
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
