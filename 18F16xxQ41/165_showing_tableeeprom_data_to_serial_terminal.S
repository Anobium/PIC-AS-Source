;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\165_showing_tableeeprom_data_to_serial_terminal.S"
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
 EEADDRESS                        EQU 1285                    ; 0X505
 EEDATA                           EQU 1286                    ; 0X506
 EEDATAVALUE                      EQU 1287                    ; 0X507
 RD                               EQU 1288                    ; 0X508
 SOMEVAR                          EQU 1289                    ; 0X509
 SYSBITVAR0                       EQU 1290                    ; 0X50A
 SYSEEADDRESS                     EQU 1291                    ; 0X50B
 SYSEEADDRESS_H                   EQU 1292                    ; 0X50C
 SYSTEMP1                         EQU 1293                    ; 0X50D
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504
 TABLELOC                         EQU 1294                    ; 0X50E

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
;''
;''  This demonstration shows the use of EEProm values created from a Table..
;''
;'' This will show the value of the EEPROM on the serial Terminal.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;Template comment at the end of the config file
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
;' IO:    ---- TX---------LED--LED-LED LED--
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim DisplayNewLine, Outdata, Indata  As Byte
;Dim EEPromAddress as Word
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;Read table item
;Must use ReadTable and a variable for the index, or the table will not be downloaded to EEPROM
;Dim TableLoc, SomeVar as Byte
;TableLoc = 2
	MOVLW	2
	MOVWF	TABLELOC,ACCESS
;ReadTable TestDataSource, TableLoc, SomeVar
	MOVLW	LOW(TABLETESTDATASOURCE)
	ADDWF	TABLELOC,W,ACCESS
	MOVWF	EEADDRESS,ACCESS
	RCALL	NVMADR_EPREAD
	MOVFF	EEDATAVALUE,SOMEVAR
;Write to table , this is not required
;EPWrite 0x08, 0x55
	MOVLW	8
	MOVWF	SYSEEADDRESS,ACCESS
	CLRF	SYSEEADDRESS_H,ACCESS
	MOVLW	85
	MOVWF	EEDATA,ACCESS
	RCALL	NVMADR_EPWRITE
;Table of values to write to EEPROM
;EEPROM location 0 will store length of table
;Subsequent locations will each store a value
;End
	BRA	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

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

DELAY_S:
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS,ACCESS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F,ACCESS
	BRA	DS_START
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

;SOURCE: EEPROM.H (428)
NVMADR_EPREAD:
;Select DATA EE section (0x380000 - 0x3803FF) for ChipFamily18FxxQ41
;NVMADRU = 0x38
	MOVLW	56
	MOVWF	NVMADRU,BANKED
;NVMADRH =SysEEAddress_h
	MOVFF	SYSEEADDRESS_H,NVMADRH
;NVMADRL =SysEEAddress
;A6: ASM Source was:  MOVFF SYSEEADDRESS,NVMADRL
	MOVFF	SYSEEADDRESS,NVMADR
;RD = 1
	MOVLW	1
	MOVWF	RD,ACCESS
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;EEDataValue = NVMDATL
;A2: ASM Source was:  MOVFF NVMDATL,EEDATAVALUE
;A4: ASM Source was:  MOVFF NVMDATL,EEDATAVALUE
	MOVFF	NVMDAT,EEDATAVALUE
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (284)
NVMADR_EPWRITE:
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	BSF	SYSBITVAR0,1,ACCESS
;Dim SysEEPromAddress As Word
;Dim  NVMCON1_0_State, NVMCON1_1_State, NVMCON1_2_State as bit
;NVMCON1_0_State = NVMCON1.0
	BCF	SYSBITVAR0,4,ACCESS
	BTFSC	NVMCON1,0,BANKED
	BSF	SYSBITVAR0,4,ACCESS
;NVMCON1_1_State = NVMCON1.1
	BCF	SYSBITVAR0,5,ACCESS
	BTFSC	NVMCON1,1,BANKED
	BSF	SYSBITVAR0,5,ACCESS
;NVMCON1_2_State = NVMCON1.2
	BCF	SYSBITVAR0,6,ACCESS
	BTFSC	NVMCON1,2,BANKED
	BSF	SYSBITVAR0,6,ACCESS
;Select DATA EE section (0x380000 - 0x3803FF) for ChipFamily18FxxQ41
;NVMADRU = 0x38
	MOVLW	56
	MOVWF	NVMADRU,BANKED
;Set the NVMCMD control bits for DFM Byte Read operation
;NVMCON1 = NVMCON1 and 0XF8 or 0x03' set bits ,1 and0
	MOVLW	248
	ANDWF	NVMCON1,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	3
	IORWF	SYSTEMP1,W,ACCESS
	MOVWF	NVMCON1,BANKED
;NVMADRH =SysEEAddress_h
	MOVFF	SYSEEADDRESS_H,NVMADRH
;NVMADRL =SysEEAddress
;A6: ASM Source was:  MOVFF SYSEEADDRESS,NVMADRL
	MOVFF	SYSEEADDRESS,NVMADR
;NVMDATL = EEData
;A6: ASM Source was:  MOVFF EEDATA,NVMDATL
	MOVFF	EEDATA,NVMDAT
;GIE = 0
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;ChipMemorylock = 0x55
	MOVLW	85
	MOVWF	NVMLOCK,BANKED
;ChipMemorylock = 0xAA
	MOVLW	170
	MOVWF	NVMLOCK,BANKED
;GO_NVMCON0 =1
;A8: ASM Source was:  BSF NVMCON0,GO_NVMCON0,BANKED
	BSF	NVMCON0,0,BANKED
;wait while GO_NVMCON0 = 1
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP1
;NVMCON1 = NVMCON1 and 0XF8
	MOVLW	248
	ANDWF	NVMCON1,F,BANKED
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
;NVMCON1.0 = NVMCON1_0_State
	BCF	NVMCON1,0,BANKED
	BTFSC	SYSBITVAR0,4,ACCESS
	BSF	NVMCON1,0,BANKED
;NVMCON1.1 = NVMCON1_1_State
	BCF	NVMCON1,1,BANKED
	BTFSC	SYSBITVAR0,5,ACCESS
	BSF	NVMCON1,1,BANKED
;NVMCON1.2 = NVMCON1_2_State
	BCF	NVMCON1,2,BANKED
	BTFSC	SYSBITVAR0,6,ACCESS
	BSF	NVMCON1,2,BANKED
;Restore interrupt to initial  State
;GIE = IntState
	BTFSS	SYSBITVAR0,1,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	BTFSC	SYSBITVAR0,1,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	RETURN

;********************************************************************************

;********************************************************************************

; DATA LOOKUP TABLES (CHIPFAMILY18FXXQ41 EEPROM ADDRESS 0X380000)
	ORG	0X380000
TABLETESTDATASOURCE:
	DB	7, 1, 2, 3, 4, 5, 6, 7
	ALIGN	2 ;X1
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
