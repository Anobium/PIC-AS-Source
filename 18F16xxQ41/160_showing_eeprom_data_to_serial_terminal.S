;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\160_showing_eeprom_data_to_serial_terminal.S"
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
 COMPORT                          EQU 1293                    ; 0X50D
 DISPLAYNEWLINE                   EQU 1294                    ; 0X50E
 EEDATA                           EQU 1295                    ; 0X50F
 EEDATAVALUE                      EQU 1296                    ; 0X510
 EEPROMADDRESS                    EQU 1297                    ; 0X511
 EEPROMADDRESS_H                  EQU 1298                    ; 0X512
 HSERPRINTCRLFCOUNT               EQU 1299                    ; 0X513
 INDATA                           EQU 1300                    ; 0X514
 OUTDATA                          EQU 1301                    ; 0X515
 PRINTLEN                         EQU 1302                    ; 0X516
 RANDOM                           EQU 1303                    ; 0X517
 RANDOMSEED                       EQU 1304                    ; 0X518
 RANDOMSEED_H                     EQU 1305                    ; 0X519
 RANDOMTEMP                       EQU 1306                    ; 0X51A
 RANDOMTEMP_H                     EQU 1307                    ; 0X51B
 RD                               EQU 1308                    ; 0X51C
 RIGHT                            EQU 5335                    ; 0X14D7
 SERDATA                          EQU 1309                    ; 0X51D
 STRINGPOINTER                    EQU 1310                    ; 0X51E
 SYSARRAYTEMP1                    EQU 1311                    ; 0X51F
 SYSARRAYTEMP2                    EQU 1312                    ; 0X520
 SYSBITVAR0                       EQU 1313                    ; 0X521
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSCHARCOUNT                     EQU 1314                    ; 0X522
 SYSCHARSTART                     EQU 1315                    ; 0X523
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSDIVMULTA                      EQU 1287                    ; 0X507
 SYSDIVMULTA_H                    EQU 1288                    ; 0X508
 SYSDIVMULTB                      EQU 1291                    ; 0X50B
 SYSDIVMULTB_H                    EQU 1292                    ; 0X50C
 SYSDIVMULTX                      EQU 1282                    ; 0X502
 SYSDIVMULTX_H                    EQU 1283                    ; 0X503
 SYSEEADDRESS                     EQU 1316                    ; 0X524
 SYSEEADDRESS_H                   EQU 1317                    ; 0X525
 SYSPRINTDATAHANDLER              EQU 1318                    ; 0X526
 SYSPRINTDATAHANDLER_H            EQU 1319                    ; 0X527
 SYSPRINTTEMP                     EQU 1320                    ; 0X528
 SYSREPEATTEMP1                   EQU 1321                    ; 0X529
 SYSREPEATTEMP2                   EQU 1322                    ; 0X52A
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 5301                    ; 0X14B5
 SYSSTRINGTEMP                    EQU 1323                    ; 0X52B
 SYSSYSINSTRINGHANDLER            EQU 1324                    ; 0X52C
 SYSSYSINSTRINGHANDLER_H          EQU 1325                    ; 0X52D
 SYSTEMP1                         EQU 1326                    ; 0X52E
 SYSTEMP1_H                       EQU 1327                    ; 0X52F
 SYSTEMP2                         EQU 1328                    ; 0X530
 SYSTEMP2_H                       EQU 1329                    ; 0X531
 SYSVALTEMP                       EQU 1330                    ; 0X532
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 SYSWORDTEMPX                     EQU 1280                    ; 0X500
 SYSWORDTEMPX_H                   EQU 1281                    ; 0X501
 _HEXPICAS                        EQU 5297                    ; 0X14B1

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYSRIGHT_0                       EQU 5335
 SYS_HEXPICAS_0                   EQU 5297
 SYS_HEXPICAS_1                   EQU 5298
 SYS_HEXPICAS_2                   EQU 5299

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
	RCALL	INITUSART
	RCALL	INITRANDOM

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows the EEProm values on the Serial Terminal.
;''
;'' This lesson will provide code for writing and reading a single byte onto
;'' the on-board EEPROM. EEPROM is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The EEPROM is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' Writes and reads to the EEPROM are practically instant and are much faster
;'' than program memory operations.
;'' This will show the value of the EEPROM on the serial Terminal.
;'' You can experiment by changing the variable 'Outdata' from Random function to a specific range.  Enjoy.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.6.1
;PinManager data: v1.79.0
;Generated for 18F16Q41
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18F16Q41
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
;#DEFINE SWITCHIN      PORTA.3
;Dir     SWITCHIN      In
	BSF	TRISA,3,ACCESS
;#DEFINE DOWN          0
;Setup Serial port
;#DEFINE USART_BAUD_RATE 9600
;#DEFINE USART_TX_BLOCKING
;#DEFINE USART_DELAY 0
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Now assumes Serial Terminal is operational
;Dim DisplayNewLine, Outdata, Indata  As Byte
;Dim EEPromAddress as Word
;Do Forever
SYSDOLOOP_S1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "EEPROM Test and Show Results "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE1
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE1
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "      "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE2
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE2
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;For EEPromAddress = 0 To 15
	SETF	EEPROMADDRESS,ACCESS
	SETF	EEPROMADDRESS_H,ACCESS
SYSFORLOOP1:
	INCF	EEPROMADDRESS,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	EEPROMADDRESS_H,F,ACCESS
;HSerPrint Hex(EEPromAddress)
	MOVFF	EEPROMADDRESS,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint " "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;Next
	MOVFF	EEPROMADDRESS,SYSWORDTEMPA
	MOVFF	EEPROMADDRESS_H,SYSWORDTEMPA_H
	MOVLW	15
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;For EEPromAddress = 0 To ChipEEProm -1
	SETF	EEPROMADDRESS,ACCESS
	SETF	EEPROMADDRESS_H,ACCESS
SYSFORLOOP2:
	INCF	EEPROMADDRESS,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	EEPROMADDRESS_H,F,ACCESS
;DisplayNewLine = EEPromAddress % 16
	MOVFF	EEPROMADDRESS,SYSWORDTEMPA
	MOVFF	EEPROMADDRESS_H,SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPX,DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	MOVF	DISPLAYNEWLINE,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF3
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint right(Hex(EEPromAddress_H),1)
	MOVFF	EEPROMADDRESS_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSSYSINSTRINGHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSSYSINSTRINGHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	SYSCHARCOUNT,ACCESS
	RCALL	FN_RIGHT
	MOVLW	LOW RIGHT
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH RIGHT
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint Hex(EEPromAddress)
	MOVFF	EEPROMADDRESS,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint ": "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE4
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE4
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;End If
ENDIF3:
;HSerPrint " "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;Outdata = Random
	RCALL	FN_RANDOM
	MOVFF	RANDOM,OUTDATA
;Outdata = 0x55    'If you DON'T believe put your own value here!
;Outdata = 255 - EEPromAddress    'If you DON'T believe put your own value here!
;Writes
;EPWrite ( EEPromAddress, Outdata )
	MOVFF	EEPROMADDRESS,SYSEEADDRESS
	MOVFF	EEPROMADDRESS_H,SYSEEADDRESS_H
	MOVFF	OUTDATA,EEDATA
	RCALL	NVMADR_EPWRITE
;Reads
;Indata = 0
	CLRF	INDATA,ACCESS
;EPRead  ( EEPromAddress, Indata )
	MOVFF	EEPROMADDRESS,SYSEEADDRESS
	MOVFF	EEPROMADDRESS_H,SYSEEADDRESS_H
	RCALL	NVMADR_EPREAD
	MOVFF	EEDATAVALUE,INDATA
;If Outdata = Indata Then
	MOVF	INDATA,W,ACCESS
	SUBWF	OUTDATA,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE4_1
;HSerPrint  Hex(Indata)
	MOVFF	INDATA,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;Else
	BRA	ENDIF4
ELSE4_1:
;HSerPrint  "--"
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE5
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE5
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;End If
ENDIF4:
;Next
	MOVFF	EEPROMADDRESS,SYSWORDTEMPA
	MOVFF	EEPROMADDRESS_H,SYSWORDTEMPA_H
	SETF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint   "End of EEProm Program and Display"
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE6
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE6
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;Wait While SwitchIn <> DOWN
SYSWAITLOOP1:
	BTFSC	PORTA,3,ACCESS
	BRA	SYSWAITLOOP1
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	BRA	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT294:
;PrintLen = PrintData(0)
;A6: ASM Source was:  MOVFF SYSPRINTDATAHANDLER,AFSR0
	MOVFF	SYSPRINTDATAHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSPRINTDATAHANDLER_H,AFSR0_H
	MOVFF	SYSPRINTDATAHANDLER_H,FSR0H
	MOVFF	INDF0,PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ENDIF24
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP,ACCESS
	MOVLW	1
	SUBWF	PRINTLEN,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND5
SYSFORLOOP5:
	INCF	SYSPRINTTEMP,F,ACCESS
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W,ACCESS
	ADDWF	SYSPRINTDATAHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,SERDATA
	RCALL	HSERSEND284
;next
	MOVF	PRINTLEN,W,ACCESS
	SUBWF	SYSPRINTTEMP,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
;End If
ENDIF24:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVFF	HSERPRINTCRLFCOUNT,SYSREPEATTEMP2
	MOVF	SYSREPEATTEMP2,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND2
SYSREPEATLOOP2:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;end Repeat
	DECFSZ	SYSREPEATTEMP2,F,ACCESS
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF27
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP3:
;A8: ASM Source was:  BTFSS PIR4,U1TXIF,ACCESS
	BTFSS	PIR4,1,ACCESS
	BRA	SYSWAITLOOP3
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP4:
BANKSEL	U1ERRIR
;A8: ASM Source was:  BTFSS U1ERRIR,TXMTIF,BANKED
	BTFSS	U1ERRIR,7,BANKED
	BRA	SYSWAITLOOP4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	MOVFF	SERDATA,U1TXB
;end if
ENDIF27:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: 160_SHOWING_EEPROM_DATA_TO_SERIAL_TERMINAL.GCB (37)
INITPPS:
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	BCF	TRISC,6,ACCESS
;Module: UART1
;RC6PPS = 0x0010    'TX1 > RC6
	MOVLW	16
BANKSEL	RC6PPS
	MOVWF	RC6PPS,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: RANDOM.H (28)
INITRANDOM:
;Dim RandomSeed As Word
;RandomSeed = RandStart
	MOVLW	19
	MOVWF	RANDOMSEED,ACCESS
	MOVLW	5
	MOVWF	RANDOMSEED_H,ACCESS
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

;SOURCE: USART.H (539)
INITUSART:
;Set the default value for comport
;comport = 1
	MOVLW	1
	MOVWF	COMPORT,ACCESS
;Set baud rate for for 18fxxK42/K83 series UART
;U1BRGH=SPBRGH_TEMP
	MOVLW	6
BANKSEL	U1BRGH
	MOVWF	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	MOVLW	129
;A2: ASM Source was:  MOVWF U1BRGL,BANKED
;A4: ASM Source was:  MOVWF U1BRGL,BANKED
	MOVWF	U1BRG,BANKED
;U1BRGS = BRGS1_SCRIPT
;A8: ASM Source was:  BSF U1CON0,U1BRGS,BANKED
	BSF	U1CON0,7,BANKED
;U1TXEN=1   'Enable TX1
;A8: ASM Source was:  BSF U1CON0,U1TXEN,BANKED
	BSF	U1CON0,5,BANKED
;U1RXEN=1   'Enable RX1
;A8: ASM Source was:  BSF U1CON0,U1RXEN,BANKED
	BSF	U1CON0,4,BANKED
;ON_U1CON1=1 'Enable USART1
;A8: ASM Source was:  BSF U1CON1,ON_U1CON1,BANKED
	BSF	U1CON1,7,BANKED
	BANKSEL	0
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
SYSWAITLOOP2:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP2
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

;SOURCE: RANDOM.H (34)
FN_RANDOM:
;Repeat 7
	MOVLW	7
	MOVWF	SYSREPEATTEMP1,ACCESS
SYSREPEATLOOP1:
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	MOVFF	RANDOMSEED,RANDOMTEMP
	MOVFF	RANDOMSEED_H,RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	RLCF	RANDOMTEMP_H,W,ACCESS
	RLCF	RANDOMTEMP,F,ACCESS
	RLCF	RANDOMTEMP_H,F,ACCESS
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	MOVLW	1
	ANDWF	RANDOMSEED,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	CLRF	SYSTEMP1_H,ACCESS
	COMF	SYSTEMP1,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	COMF	SYSTEMP1_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVLW	1
	ADDWF	SYSTEMP2,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	CLRF	SYSTEMP2,ACCESS
	MOVLW	180
	ANDWF	SYSTEMP1_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVF	RANDOMTEMP,W,ACCESS
	XORWF	SYSTEMP2,W,ACCESS
	MOVWF	RANDOMSEED,ACCESS
	MOVF	RANDOMTEMP_H,W,ACCESS
	XORWF	SYSTEMP2_H,W,ACCESS
	MOVWF	RANDOMSEED_H,ACCESS
;Random = Random Xor RandomSeed_H
	MOVF	RANDOM,W,ACCESS
	XORWF	RANDOMSEED_H,W,ACCESS
	MOVWF	RANDOM,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (373)
FN_RIGHT:
;Empty input?
;If SysInString(0) = 0 Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	INDF0,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF20
;Right(0) = 0
	BANKSEL	SYSRIGHT_0
	CLRF	SYSRIGHT_0,BANKED
;Exit Function
	BANKSEL	0
	RETURN
;End If
ENDIF20:
;Input length too high?
;If SysInString(0) < SysCharCount Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	SYSCHARCOUNT,W,ACCESS
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF21
;SysCharCount = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	INDF0,SYSCHARCOUNT
;End If
ENDIF21:
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	SYSCHARCOUNT,W,ACCESS
	SUBWF	INDF0,W,ACCESS
	MOVWF	SYSCHARSTART,ACCESS
;For SysStringTemp = 1 To SysCharCount
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	SYSSTRINGTEMP,F,BANKED
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	MOVF	SYSSTRINGTEMP,W,BANKED
	ADDWF	SYSCHARSTART,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	ADDWF	SYSSYSINSTRINGHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	POSTINC0,SYSARRAYTEMP2
	MOVFF	SYSARRAYTEMP2,SYSARRAYTEMP1
	LFSR	0,RIGHT
	MOVF	SYSSTRINGTEMP,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	SYSARRAYTEMP1,POSTINC0
;Next
	MOVF	SYSCHARCOUNT,W,ACCESS
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
;Right(0) = SysCharCount
	MOVFFL	SYSCHARCOUNT,SYSRIGHT_0
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2894)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	MOVF	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	CPFSEQ	SYSWORDTEMPA,ACCESS
;return
	RETURN
;Test high, exit if false
;movf SysWordTempB_H, W
	MOVF	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	CPFSEQ	SYSWORDTEMPA_H,ACCESS
;return
	RETURN
;setf SysByteTempX
	SETF	SYSBYTETEMPX,ACCESS
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

;SOURCE: SYSTEM.H (2712)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVFF	SYSWORDTEMPA,SYSDIVMULTA
	MOVFF	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVFF	SYSWORDTEMPB,SYSDIVMULTB
	MOVFF	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX,ACCESS
	CLRF	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVFF	SYSDIVMULTB,SYSWORDTEMPA
	MOVFF	SYSDIVMULTB_H,SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF18
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
;exit sub
	RETURN
;end if
ENDIF18:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP,ACCESS
SYSDIV16START:
;set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SysDivMultA Left
	RLCF	SYSDIVMULTA,F,ACCESS
	RLCF	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	RLCF	SYSDIVMULTX,F,ACCESS
	RLCF	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	SUBWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	SUBWFB	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0,ACCESS
;If C Off Then
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF19
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	ADDWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	ADDWFC	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF19:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	BRA	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVFF	SYSDIVMULTA,SYSWORDTEMPA
	MOVFF	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVFF	SYSDIVMULTX,SYSWORDTEMPX
	MOVFF	SYSDIVMULTX_H,SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1473)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;ChipFamily 16 support
;Get length
;TBLRD*+
	TBLRD*+
;movff TABLAT,SysCalcTempA
	MOVFF	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	MOVFF	TABLAT,INDF1
;goto SysStringReadCheck
	BRA	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;TBLRD*+
	TBLRD*+
;movf TABLAT, W
	MOVF	TABLAT, W,ACCESS
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;return
	RETURN
;Copy
SYSSTRINGREAD:
;Copy char
;TBLRD*+
	TBLRD*+
;movff TABLAT,PREINC1
	MOVFF	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	BRA	SYSSTRINGREAD
	RETURN

;********************************************************************************

SYSSTRINGTABLES:

STRINGTABLE1:
	DB	29,69,69,80,82,79,77,32,84,101,115,116,32,97,110,100,32,83,104,111,119,32,82,101
	DB	115,117,108,116,115,32

	ALIGN	2;X3

STRINGTABLE2:
	DB	6,32,32,32,32,32,32

	ALIGN	2;X3

STRINGTABLE3:
	DB	1,32

	ALIGN	2;X3

STRINGTABLE4:
	DB	2,58,32

	ALIGN	2;X3

STRINGTABLE5:
	DB	2,45,45

	ALIGN	2;X3

STRINGTABLE6:
	DB	33,69,110,100,32,111,102,32,69,69,80,114,111,109,32,80,114,111,103,114,97,109
	DB	32,97,110,100,32,68,105,115,112,108,97,121

	ALIGN	2;X3

;********************************************************************************

;SOURCE: PICAS.H (7)
FN__HEXPICAS:
;_HexPICAS(0) = 2
	MOVLW	2
	BANKSEL	SYS_HEXPICAS_0
	MOVWF	SYS_HEXPICAS_0,BANKED
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W,ACCESS
	BANKSEL	SYSSTRINGTEMP
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF6
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF6:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_2
	MOVWF	SYS_HEXPICAS_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
SYSFORLOOP3:
	INCF	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	RRCF	SYSVALTEMP,F,ACCESS
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W,ACCESS
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF8
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF8:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_1
	MOVWF	SYS_HEXPICAS_1,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
