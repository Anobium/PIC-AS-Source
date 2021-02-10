;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\290_showing_progmem_data_to_serial_terminal.S"
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
 DATAWORD                         EQU 1294                    ; 0X50E
 DATAWORD_H                       EQU 1295                    ; 0X50F
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 HSERPRINTCRLFCOUNT               EQU 1296                    ; 0X510
 PFMADDRESS                       EQU 1297                    ; 0X511
 PFMADDRESS_E                     EQU 1300                    ; 0X514
 PFMADDRESS_H                     EQU 1298                    ; 0X512
 PFMADDRESS_U                     EQU 1299                    ; 0X513
 PFMREAD                          EQU 1301                    ; 0X515
 PFMREADWORD                      EQU 1302                    ; 0X516
 PFMREADWORD_H                    EQU 1303                    ; 0X517
 PRINTLEN                         EQU 1304                    ; 0X518
 SERDATA                          EQU 1305                    ; 0X519
 STRINGPOINTER                    EQU 1306                    ; 0X51A
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSLONGDIVMULTA                  EQU 1307                    ; 0X51B
 SYSLONGDIVMULTA_E                EQU 1310                    ; 0X51E
 SYSLONGDIVMULTA_H                EQU 1308                    ; 0X51C
 SYSLONGDIVMULTA_U                EQU 1309                    ; 0X51D
 SYSLONGDIVMULTB                  EQU 1311                    ; 0X51F
 SYSLONGDIVMULTB_E                EQU 1314                    ; 0X522
 SYSLONGDIVMULTB_H                EQU 1312                    ; 0X520
 SYSLONGDIVMULTB_U                EQU 1313                    ; 0X521
 SYSLONGDIVMULTX                  EQU 1315                    ; 0X523
 SYSLONGDIVMULTX_E                EQU 1318                    ; 0X526
 SYSLONGDIVMULTX_H                EQU 1316                    ; 0X524
 SYSLONGDIVMULTX_U                EQU 1317                    ; 0X525
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
 SYSPRINTDATAHANDLER              EQU 1319                    ; 0X527
 SYSPRINTDATAHANDLER_H            EQU 1320                    ; 0X528
 SYSPRINTTEMP                     EQU 1321                    ; 0X529
 SYSREPEATTEMP1                   EQU 1322                    ; 0X52A
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 5112                    ; 0X13F8
 SYSSTRINGTEMP                    EQU 1323                    ; 0X52B
 SYSTEMP1                         EQU 1324                    ; 0X52C
 SYSTEMP1_H                       EQU 1325                    ; 0X52D
 SYSVALTEMP                       EQU 1326                    ; 0X52E
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 SYS_PFM_BUFFERHANDLER            EQU 1327                    ; 0X52F
 SYS_PFM_BUFFERHANDLER_H          EQU 1328                    ; 0X530
 _DUMMY                           EQU 1329                    ; 0X531
 _GIE_SAVE                        EQU 1330                    ; 0X532
 _HEXPICAS                        EQU 5115                    ; 0X13FB
 _PFM_ADDR                        EQU 1331                    ; 0X533
 _PFM_ADDR_E                      EQU 1334                    ; 0X536
 _PFM_ADDR_H                      EQU 1332                    ; 0X534
 _PFM_ADDR_U                      EQU 1333                    ; 0X535
 _PFM_BLOCKNUM                    EQU 1335                    ; 0X537
 _PFM_BLOCKNUM_E                  EQU 1338                    ; 0X53A
 _PFM_BLOCKNUM_H                  EQU 1336                    ; 0X538
 _PFM_BLOCKNUM_U                  EQU 1337                    ; 0X539
 _PFM_BUFFER                      EQU 5119                    ; 0X13FF
 _PFM_COUNT                       EQU 1339                    ; 0X53B
 _PFM_COUNT_H                     EQU 1340                    ; 0X53C
 _PFM_DATABYTE                    EQU 1341                    ; 0X53D
 _PFM_DATABYTE_H                  EQU 1342                    ; 0X53E
 _PFM_DATAWORD                    EQU 1343                    ; 0X53F
 _PFM_DATAWORD_H                  EQU 1344                    ; 0X540
 _PFM_LOOPCOUNTER                 EQU 1345                    ; 0X541
 _PFM_LOOPCOUNTER_H               EQU 1346                    ; 0X542
 _PFM_OFFSET                      EQU 1347                    ; 0X543
 _PFM_OFFSET_E                    EQU 1350                    ; 0X546
 _PFM_OFFSET_H                    EQU 1348                    ; 0X544
 _PFM_OFFSET_U                    EQU 1349                    ; 0X545

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYS_HEXPICAS_0                   EQU 5115
 SYS_HEXPICAS_1                   EQU 5116
 SYS_HEXPICAS_2                   EQU 5117
 _PFM_ABS_ADDR                    EQU 67
 _PFM_ABS_ADDR_H                  EQU 68
 _PFM_ABS_ADDR_U                  EQU 69
 _PFM_ABS_ADDR_E                  EQU 1329
 _TBL_ABS_ADDR                    EQU 1270
 _TBL_ABS_ADDR_H                  EQU 1271
 _TBL_ABS_ADDR_U                  EQU 1272
 _TBL_ABS_ADDR_E                  EQU 1329
 _TFM_ABS_ADDR                    EQU 1270
 _TFM_ABS_ADDR_H                  EQU 1271
 _TFM_ABS_ADDR_U                  EQU 1272
 _TFM_ABS_ADDR_E                  EQU 1329

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

;START OF THE MAIN PROGRAM
;''
;''  This demonstration shows reading PROGMEM on the Serial Terminal.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
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
;Setup Serial port
;#DEFINE USART_BAUD_RATE 9600
;#DEFINE USART_TX_BLOCKING
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Now assumes Serial Terminal is operational
;Dim  PFMAddress as long
;Dim  DataWord as word
;wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;PFMReadWord
;We are reading words, so we send the PFMAddress address every two bytes (a word).
;for PFMAddress = 0x0000 to 0x001F - 2 step 2
	MOVLW	254
	MOVWF	PFMADDRESS,ACCESS
	SETF	PFMADDRESS_H,ACCESS
	SETF	PFMADDRESS_U,ACCESS
	SETF	PFMADDRESS_E,ACCESS
SYSFORLOOP1:
	MOVLW	2
	ADDWF	PFMADDRESS,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_H,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_U,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_E,F,ACCESS
;Display the value
;HSerPrint "0x"
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
;HSerPrint hex(PFMAddress_h)
	MOVFF	PFMADDRESS_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint hex(PFMAddress)
	MOVFF	PFMADDRESS,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND283
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND283
;Read the value of the PFMAddress to the PFM
;PFMRead  ( PFMAddress, DataWord )
;DataWord = PFMReadWord  ( PFMAddress)
;A6: ASM Source was:  MOVFF PFMADDRESS,_TFM_ABS_ADDR
	MOVFF	PFMADDRESS,TBLPTR
;A6: ASM Source was:  MOVFF PFMADDRESS_H,_TFM_ABS_ADDR_H
	MOVFF	PFMADDRESS_H,TBLPTRH
;A6: ASM Source was:  MOVFF PFMADDRESS_U,_TFM_ABS_ADDR_U
	MOVFF	PFMADDRESS_U,TBLPTRU
	MOVFF	PFMADDRESS_E,_TFM_ABS_ADDR_E
	RCALL	FN_PFMREADWORD
	MOVFF	PFMREADWORD,DATAWORD
	MOVFF	PFMREADWORD_H,DATAWORD_H
;Display the received value
;HSerPrint "0x"
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
;HSerPrint hex(DataWord_h)
	MOVFF	DATAWORD_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint hex(DataWord)
	MOVFF	DATAWORD,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;Next
	MOVFF	PFMADDRESS,SYSLONGTEMPA
	MOVFF	PFMADDRESS_H,SYSLONGTEMPA_H
	MOVFF	PFMADDRESS_U,SYSLONGTEMPA_U
	MOVFF	PFMADDRESS_E,SYSLONGTEMPA_E
	MOVLW	29
	MOVWF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;PFMWrite
;PFMWrite ( 0x00FFF0, 0x55 )
	MOVLW	240
	MOVWF	_PFM_ADDR,ACCESS
	SETF	_PFM_ADDR_H,ACCESS
	CLRF	_PFM_ADDR_U,ACCESS
	CLRF	_PFM_ADDR_E,ACCESS
	MOVLW	85
	MOVWF	_PFM_DATABYTE,ACCESS
	RCALL	PFMWRITE243
;PFMWrite ( 0x00FFFC, 0x1234 )
	MOVLW	252
	MOVWF	_PFM_ADDR,ACCESS
	SETF	_PFM_ADDR_H,ACCESS
	CLRF	_PFM_ADDR_U,ACCESS
	CLRF	_PFM_ADDR_E,ACCESS
	MOVLW	52
	MOVWF	_PFM_DATAWORD,ACCESS
	MOVLW	18
	MOVWF	_PFM_DATAWORD_H,ACCESS
	RCALL	PFMWRITE244
;We are reading words, so we send the PFMAddress address every two bytes (a word).
;for PFMAddress = 0xFFF0 to 0xFFFF - 2 step 2
	MOVLW	238
	MOVWF	PFMADDRESS,ACCESS
	SETF	PFMADDRESS_H,ACCESS
	CLRF	PFMADDRESS_U,ACCESS
	CLRF	PFMADDRESS_E,ACCESS
SYSFORLOOP2:
	MOVLW	2
	ADDWF	PFMADDRESS,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_H,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_U,F,ACCESS
	MOVLW	0
	ADDWFC	PFMADDRESS_E,F,ACCESS
;Display the value
;HSerPrint "0x"
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
;HSerPrint hex(PFMAddress_h)
	MOVFF	PFMADDRESS_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint hex(PFMAddress)
	MOVFF	PFMADDRESS,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND283
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND283
;Read the value of the PFMAddress to the PFM
;PFMRead  ( PFMAddress, DataWord )
;A6: ASM Source was:  MOVFF PFMADDRESS,_TFM_ABS_ADDR
	MOVFF	PFMADDRESS,TBLPTR
;A6: ASM Source was:  MOVFF PFMADDRESS_H,_TFM_ABS_ADDR_H
	MOVFF	PFMADDRESS_H,TBLPTRH
;A6: ASM Source was:  MOVFF PFMADDRESS_U,_TFM_ABS_ADDR_U
	MOVFF	PFMADDRESS_U,TBLPTRU
	MOVFF	PFMADDRESS_E,_TFM_ABS_ADDR_E
	RCALL	PFMREAD242
	MOVFF	_PFM_DATABYTE,DATAWORD
	MOVFF	_PFM_DATABYTE_H,DATAWORD_H
;DataWord = PFMReadWord  ( PFMAddress)
;Display the received value
;HSerPrint "0x"
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
;HSerPrint hex(DataWord_h)
	MOVFF	DATAWORD_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrint hex(DataWord)
	MOVFF	DATAWORD,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;Next
	MOVFF	PFMADDRESS,SYSLONGTEMPA
	MOVFF	PFMADDRESS_H,SYSLONGTEMPA_H
	MOVFF	PFMADDRESS_U,SYSLONGTEMPA_U
	MOVFF	PFMADDRESS_E,SYSLONGTEMPA_E
	MOVLW	253
	MOVWF	SYSLONGTEMPB,ACCESS
	SETF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;do
SYSDOLOOP_S1:
;loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
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
	BRA	ENDIF16
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP,ACCESS
	MOVLW	1
	SUBWF	PRINTLEN,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND6
SYSFORLOOP6:
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
	BRA	SYSFORLOOP6
SYSFORLOOPEND6:
;End If
ENDIF16:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVFF	HSERPRINTCRLFCOUNT,SYSREPEATTEMP1
	MOVF	SYSREPEATTEMP1,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND1
SYSREPEATLOOP1:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;end Repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (759)
HSERSEND283:
;Registers/Bits determined by #samevar at top of library
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
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	BANKSEL	0
	BRA	DELAY_MS

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF23
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP5:
;A8: ASM Source was:  BTFSS PIR4,U1TXIF,ACCESS
	BTFSS	PIR4,1,ACCESS
	BRA	SYSWAITLOOP5
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP6:
BANKSEL	U1ERRIR
;A8: ASM Source was:  BTFSS U1ERRIR,TXMTIF,BANKED
	BTFSS	U1ERRIR,7,BANKED
	BRA	SYSWAITLOOP6
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	MOVFF	SERDATA,U1TXB
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	BANKSEL	0
	RCALL	DELAY_MS
;end if
ENDIF23:
	RETURN

;********************************************************************************

;SOURCE: 290_SHOWING_PROGMEM_DATA_TO_SERIAL_TERMINAL.GCB (24)
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

;OVERLOADED SIGNATURE: LONG:WORD:, SOURCE: SYSTEM.H (3694)
PFMREAD242:
;Dim _dummy as byte
;Dim _TFM_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;TBLRD*+
	TBLRD*+
;_PFM_DataByte = TABLAT
	MOVFF	TABLAT,_PFM_DATABYTE
	CLRF	_PFM_DATABYTE_H,ACCESS
;TBLRD*+
	TBLRD*+
;_PFM_DataByte_h = TABLAT
	MOVFF	TABLAT,_PFM_DATABYTE_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3669)
FN_PFMREADWORD:
;Dim _dummy as byte
;Dim _TFM_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;TBLRD*+
	TBLRD*+
;PFMReadWord = TABLAT
	MOVFF	TABLAT,PFMREADWORD
	CLRF	PFMREADWORD_H,ACCESS
;TBLRD*+
	TBLRD*+
;PFMReadWord_h = TABLAT
	MOVFF	TABLAT,PFMREADWORD_H
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: LONG:BYTE:, SOURCE: SYSTEM.H (3708)
PFMWRITE243:
;Tested on 18F16Q41
;Dim _PFM_BlockNum, _PFM_Offset as long
;Dim _PFM_Buffer(SAF_ROWSIZE_BYTES)
;Writes a single byte of data [_PFM_PFM_DataOut]
;at relative location [_PFM_Address] between 0 and extent of page
;
;The existing data in the row of [_PFM_Address] is preserved
;Calculate block number
;_PFM_BlockNum = _PFM_ADDR / SAF_ROWSIZE_BYTES
	MOVFF	_PFM_ADDR,SYSLONGTEMPA
	MOVFF	_PFM_ADDR_H,SYSLONGTEMPA_H
	MOVFF	_PFM_ADDR_U,SYSLONGTEMPA_U
	MOVFF	_PFM_ADDR_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,_PFM_BLOCKNUM
	MOVFF	SYSLONGTEMPA_H,_PFM_BLOCKNUM_H
	MOVFF	SYSLONGTEMPA_U,_PFM_BLOCKNUM_U
	MOVFF	SYSLONGTEMPA_E,_PFM_BLOCKNUM_E
;Calculate offset in block/row
;_PFM_Offset = _PFM_Addr % SAF_ROWSIZE_BYTES
	MOVFF	_PFM_ADDR,SYSLONGTEMPA
	MOVFF	_PFM_ADDR_H,SYSLONGTEMPA_H
	MOVFF	_PFM_ADDR_U,SYSLONGTEMPA_U
	MOVFF	_PFM_ADDR_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPX,_PFM_OFFSET
	MOVFF	SYSLONGTEMPX_H,_PFM_OFFSET_H
	MOVFF	SYSLONGTEMPX_U,_PFM_OFFSET_U
	MOVFF	SYSLONGTEMPX_E,_PFM_OFFSET_E
;Save data previously stored in row#
;_PFMReadBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	MOVLW	LOW _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER_H,ACCESS
	CLRF	_PFM_COUNT,ACCESS
	MOVLW	1
	MOVWF	_PFM_COUNT_H,ACCESS
	RCALL	_PFMREADBLOCK
;Update buffer with DataValue at offset
;_PFM_Buffer(_PFM_Offset + 1) =  _PFM_DataByte
	LFSR	0,_PFM_BUFFER
	MOVF	_PFM_OFFSET,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,W,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,W,ACCESS
	ADDWF	FSR0,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	_PFM_OFFSET_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
	ADDWFC	FSR0H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVLW	1
	ADDWF	SYSTEMP1,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	_PFM_DATABYTE,INDF0
;Write back the updated row buffer to  PFMM
;_PFMwriteBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	MOVLW	LOW _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER_H,ACCESS
	CLRF	_PFM_COUNT,ACCESS
	MOVLW	1
	MOVWF	_PFM_COUNT_H,ACCESS
	BRA	_PFMWRITEBLOCK

;********************************************************************************

;OVERLOADED SIGNATURE: LONG:WORD:, SOURCE: SYSTEM.H (3739)
PFMWRITE244:
;Tested on 18F16Q41
;Dim _PFM_BlockNum, _PFM_Offset as long
;Dim _PFM_Buffer(SAF_ROWSIZE_BYTES)
;Writes a Word of data [_PFM_PFM_DataOut]
;at relative location [_PFM_Address] between 0 and extent of page
;
;The existing data in the row of [_PFM_Address] is preserved
;Calculate block number
;_PFM_BlockNum = _PFM_ADDR / SAF_ROWSIZE_BYTES
	MOVFF	_PFM_ADDR,SYSLONGTEMPA
	MOVFF	_PFM_ADDR_H,SYSLONGTEMPA_H
	MOVFF	_PFM_ADDR_U,SYSLONGTEMPA_U
	MOVFF	_PFM_ADDR_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,_PFM_BLOCKNUM
	MOVFF	SYSLONGTEMPA_H,_PFM_BLOCKNUM_H
	MOVFF	SYSLONGTEMPA_U,_PFM_BLOCKNUM_U
	MOVFF	SYSLONGTEMPA_E,_PFM_BLOCKNUM_E
;Calculate offset in block/row
;_PFM_Offset = _PFM_Addr % SAF_ROWSIZE_BYTES
	MOVFF	_PFM_ADDR,SYSLONGTEMPA
	MOVFF	_PFM_ADDR_H,SYSLONGTEMPA_H
	MOVFF	_PFM_ADDR_U,SYSLONGTEMPA_U
	MOVFF	_PFM_ADDR_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPX,_PFM_OFFSET
	MOVFF	SYSLONGTEMPX_H,_PFM_OFFSET_H
	MOVFF	SYSLONGTEMPX_U,_PFM_OFFSET_U
	MOVFF	SYSLONGTEMPX_E,_PFM_OFFSET_E
;Save data previously stored in row#
;_PFMReadBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	MOVLW	LOW _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER_H,ACCESS
	CLRF	_PFM_COUNT,ACCESS
	MOVLW	1
	MOVWF	_PFM_COUNT_H,ACCESS
	RCALL	_PFMREADBLOCK
;Update buffer with DataValue at offset
;_PFM_Buffer(_PFM_Offset + 1) =  _PFM_DataWord
	LFSR	0,_PFM_BUFFER
	MOVF	_PFM_OFFSET,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,W,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,W,ACCESS
	ADDWF	FSR0,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	_PFM_OFFSET_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
	ADDWFC	FSR0H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVLW	1
	ADDWF	SYSTEMP1,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	_PFM_DATAWORD,INDF0
;_PFM_Buffer(_PFM_Offset + 2) =  _PFM_DataWord_H
	LFSR	0,_PFM_BUFFER
	MOVF	_PFM_OFFSET,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,W,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,W,ACCESS
	ADDWF	FSR0,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	_PFM_OFFSET_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
	ADDWFC	FSR0H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVLW	2
	ADDWF	SYSTEMP1,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	_PFM_DATAWORD_H,INDF0
;Write back the updated row buffer to  PFMM
;_PFMwriteBlock(_PFM_BlockNum, _PFM_Buffer(), SAF_ROWSIZE_BYTES)
	MOVLW	LOW _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _PFM_BUFFER
	MOVWF	SYS_PFM_BUFFERHANDLER_H,ACCESS
	CLRF	_PFM_COUNT,ACCESS
	MOVLW	1
	MOVWF	_PFM_COUNT_H,ACCESS
	BRA	_PFMWRITEBLOCK

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
	BRA	ENDIF21
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF21:
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
	BRA	ENDIF22
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
ENDIF22:
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
	BRA	ENDIF19
	MOVF	SYSLONGDIVMULTA,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTA_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTA_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTA_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF19:
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
	DB	2,48,120

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
	BRA	ENDIF5
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF5:
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
	BRA	ENDIF7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF7:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_1
	MOVWF	SYS_HEXPICAS_1,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3771)
_PFMREADBLOCK:
;Tested on 18F16Q41
;Dim _PFM_Count as word
;Dim _PFM_LoopCounter as word
;Dim _dummy as byte
;Dim _PFM_ABS_ADDR as Long Alias _dummy, NVMADRU, NVMADRH, NVMADRL
;Dim _TBL_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;Set memory address
;_PFM_ABS_ADDR = _PFM_BlockNum * SAF_ROWSIZE_BYTES
	MOVFF	_PFM_BLOCKNUM,SYSLONGTEMPA
	MOVFF	_PFM_BLOCKNUM_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSMULTSUB32
;A6: ASM Source was:  MOVFF SYSLONGTEMPX,_PFM_ABS_ADDR
	MOVFF	SYSLONGTEMPX,NVMADR
;A6: ASM Source was:  MOVFF SYSLONGTEMPX_H,_PFM_ABS_ADDR_H
	MOVFF	SYSLONGTEMPX_H,NVMADRH
;A6: ASM Source was:  MOVFF SYSLONGTEMPX_U,_PFM_ABS_ADDR_U
	MOVFF	SYSLONGTEMPX_U,NVMADRU
	MOVFF	SYSLONGTEMPX_E,_PFM_ABS_ADDR_E
;_TBL_ABS_ADDR = _PFM_ABS_ADDR
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR,_TBL_ABS_ADDR
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR,_TBL_ABS_ADDR
	MOVFF	NVMADR,_TBL_ABS_ADDR
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR_H,_TBL_ABS_ADDR_H
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR_H,_TBL_ABS_ADDR_H
	MOVFF	NVMADRH,_TBL_ABS_ADDR_H
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR_U,_TBL_ABS_ADDR_U
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR_U,_TBL_ABS_ADDR_U
	MOVFF	NVMADRU,_TBL_ABS_ADDR_U
	MOVFF	_PFM_ABS_ADDR_E,_TBL_ABS_ADDR_E
;Read memory to buffer
;For _PFM_LoopCounter = 1 to _PFM_Count
	CLRF	_PFM_LOOPCOUNTER,ACCESS
	CLRF	_PFM_LOOPCOUNTER_H,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	MOVFF	_PFM_COUNT,SYSWORDTEMPA
	MOVFF	_PFM_COUNT_H,SYSWORDTEMPA_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	_PFM_LOOPCOUNTER,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	_PFM_LOOPCOUNTER_H,F,ACCESS
;TBLRD*+
	TBLRD*+
;_PFM_Buffer( _PFM_LoopCounter  ) = TABLAT
	MOVF	_PFM_LOOPCOUNTER,W,ACCESS
	ADDWF	SYS_PFM_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	_PFM_LOOPCOUNTER_H,W,ACCESS
	ADDWFC	SYS_PFM_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	TABLAT,INDF0
;next
	MOVFF	_PFM_LOOPCOUNTER,SYSWORDTEMPA
	MOVFF	_PFM_LOOPCOUNTER_H,SYSWORDTEMPA_H
	MOVFF	_PFM_COUNT,SYSWORDTEMPB
	MOVFF	_PFM_COUNT_H,SYSWORDTEMPB_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3793)
_PFMWRITEBLOCK:
;Tested on 18F16Q41
;Dim _PFM_Count as word
;Dim _PFM_LoopCounter as word
;Dim _GIE_SAVE, _dummy as byte
;Dim _PFM_ABS_ADDR as Long Alias _dummy, NVMADRU, NVMADRH, NVMADRL
;Dim _TBL_ABS_ADDR as Long Alias _dummy, TBLPTRU, TBLPTRH, TBLPTRL
;Set memory address for erase operation
;_PFM_ABS_ADDR =  _PFM_BlockNum * SAF_ROWSIZE_BYTES
	MOVFF	_PFM_BLOCKNUM,SYSLONGTEMPA
	MOVFF	_PFM_BLOCKNUM_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSMULTSUB32
;A6: ASM Source was:  MOVFF SYSLONGTEMPX,_PFM_ABS_ADDR
	MOVFF	SYSLONGTEMPX,NVMADR
;A6: ASM Source was:  MOVFF SYSLONGTEMPX_H,_PFM_ABS_ADDR_H
	MOVFF	SYSLONGTEMPX_H,NVMADRH
;A6: ASM Source was:  MOVFF SYSLONGTEMPX_U,_PFM_ABS_ADDR_U
	MOVFF	SYSLONGTEMPX_U,NVMADRU
	MOVFF	SYSLONGTEMPX_E,_PFM_ABS_ADDR_E
;Set the NVMCMD control bits for Erase operation
;NVMCON1 = NVMCON1 and 0XF8 or 0x06
	MOVLW	248
	ANDWF	NVMCON1,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	6
	IORWF	SYSTEMP1,W,ACCESS
	MOVWF	NVMCON1,BANKED
;_GIE_SAVE = GIE    'Save interrupt
	CLRF	_GIE_SAVE,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	INCF	_GIE_SAVE,F,ACCESS
;GIE = 0           'disable interrupts
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;ChipMemorylock = 0x55
	MOVLW	85
	MOVWF	NVMLOCK,BANKED
;ChipMemorylock = 0xAA
	MOVLW	170
	MOVWF	NVMLOCK,BANKED
;GO_NVMCON0 = 1
;A8: ASM Source was:  BSF NVMCON0,GO_NVMCON0,BANKED
	BSF	NVMCON0,0,BANKED
;wait while GO_NVMCON0 = 1
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP1
;Set memory address
;_TBL_ABS_ADDR = _PFM_ABS_ADDR
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR,_TBL_ABS_ADDR
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR,_TBL_ABS_ADDR
	MOVFF	NVMADR,_TBL_ABS_ADDR
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR_H,_TBL_ABS_ADDR_H
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR_H,_TBL_ABS_ADDR_H
	MOVFF	NVMADRH,_TBL_ABS_ADDR_H
;A2: ASM Source was:  MOVFF _PFM_ABS_ADDR_U,_TBL_ABS_ADDR_U
;A4: ASM Source was:  MOVFF _PFM_ABS_ADDR_U,_TBL_ABS_ADDR_U
	MOVFF	NVMADRU,_TBL_ABS_ADDR_U
	MOVFF	_PFM_ABS_ADDR_E,_TBL_ABS_ADDR_E
;For _PFM_LoopCounter = 1 to _PFM_Count
	CLRF	_PFM_LOOPCOUNTER,ACCESS
	CLRF	_PFM_LOOPCOUNTER_H,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	MOVFF	_PFM_COUNT,SYSWORDTEMPA
	MOVFF	_PFM_COUNT_H,SYSWORDTEMPA_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND5
SYSFORLOOP5:
	INCF	_PFM_LOOPCOUNTER,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	_PFM_LOOPCOUNTER_H,F,ACCESS
;TABLAT = _PFM_Buffer( _PFM_LoopCounter  )
	MOVF	_PFM_LOOPCOUNTER,W,ACCESS
	ADDWF	SYS_PFM_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	_PFM_LOOPCOUNTER_H,W,ACCESS
	ADDWFC	SYS_PFM_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,TABLAT
;TBLWT*+
	TBLWT*+
;next
	MOVFF	_PFM_LOOPCOUNTER,SYSWORDTEMPA
	MOVFF	_PFM_LOOPCOUNTER_H,SYSWORDTEMPA_H
	MOVFF	_PFM_COUNT,SYSWORDTEMPB
	MOVFF	_PFM_COUNT_H,SYSWORDTEMPB_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
;Set the NVMCMD control bits for Write Page operation
;NVMCON1 = NVMCON1 and 0XF8 or 0x05
	MOVLW	248
	ANDWF	NVMCON1,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	5
	IORWF	SYSTEMP1,W,ACCESS
	MOVWF	NVMCON1,BANKED
;_GIE_SAVE = GIE    'Save interrupt
	CLRF	_GIE_SAVE,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	INCF	_GIE_SAVE,F,ACCESS
;GIE = 0           'disable interrupts
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;ChipMemorylock = 0x55
	MOVLW	85
	MOVWF	NVMLOCK,BANKED
;ChipMemorylock = 0xAA
	MOVLW	170
	MOVWF	NVMLOCK,BANKED
;GO_NVMCON0 = 1
;A8: ASM Source was:  BSF NVMCON0,GO_NVMCON0,BANKED
	BSF	NVMCON0,0,BANKED
;wait while GO_NVMCON0 = 1
SYSWAITLOOP2:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP2
;Set the NVMCMD control bits for Word Read operation to avoid accidental writes
;NVMCON1 = NVMCON1 and 0XF8
	MOVLW	248
	ANDWF	NVMCON1,F,BANKED
;GIE = _GIE_SAVE     'restore saved interrupt
	BTFSC	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	BTFSS	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
