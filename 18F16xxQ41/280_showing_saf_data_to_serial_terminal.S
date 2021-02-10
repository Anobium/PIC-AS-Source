;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\280_showing_saf_data_to_serial_terminal.S"
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
 BLOCKNUM                         EQU 1293                    ; 0X50D
 COMPORT                          EQU 1294                    ; 0X50E
 DATABYTE                         EQU 1295                    ; 0X50F
 DATAWORD                         EQU 1296                    ; 0X510
 DATAWORD_H                       EQU 1297                    ; 0X511
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 HSERPRINTCRLFCOUNT               EQU 1298                    ; 0X512
 INDEX                            EQU 1299                    ; 0X513
 INDEXWORD                        EQU 1300                    ; 0X514
 INDEXWORD_H                      EQU 1301                    ; 0X515
 MYBUFFER                         EQU 5119                    ; 0X13FF
 NUMBYTES                         EQU 1302                    ; 0X516
 NVM_ADDRESS                      EQU 1303                    ; 0X517
 NVM_ADDRESS_E                    EQU 1306                    ; 0X51A
 NVM_ADDRESS_H                    EQU 1304                    ; 0X518
 NVM_ADDRESS_U                    EQU 1305                    ; 0X519
 OUTVALUETEMP                     EQU 1307                    ; 0X51B
 PRINTLEN                         EQU 1308                    ; 0X51C
 REL_ADDRESS                      EQU 1309                    ; 0X51D
 SAFREAD                          EQU 1310                    ; 0X51E
 SAFREADWORD                      EQU 1311                    ; 0X51F
 SAFREADWORD_H                    EQU 1312                    ; 0X520
 SERDATA                          EQU 1313                    ; 0X521
 SERPRINTVAL                      EQU 1314                    ; 0X522
 STRINGPOINTER                    EQU 1315                    ; 0X523
 SYSBYTETEMPA                     EQU 1285                    ; 0X505
 SYSBYTETEMPB                     EQU 1289                    ; 0X509
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSCALCTEMPX                     EQU 1280                    ; 0X500
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSDIVMULTA                      EQU 1287                    ; 0X507
 SYSDIVMULTA_H                    EQU 1288                    ; 0X508
 SYSDIVMULTB                      EQU 1291                    ; 0X50B
 SYSDIVMULTB_H                    EQU 1292                    ; 0X50C
 SYSDIVMULTX                      EQU 1282                    ; 0X502
 SYSDIVMULTX_H                    EQU 1283                    ; 0X503
 SYSLONGDIVMULTA                  EQU 1316                    ; 0X524
 SYSLONGDIVMULTA_E                EQU 1319                    ; 0X527
 SYSLONGDIVMULTA_H                EQU 1317                    ; 0X525
 SYSLONGDIVMULTA_U                EQU 1318                    ; 0X526
 SYSLONGDIVMULTB                  EQU 1320                    ; 0X528
 SYSLONGDIVMULTB_E                EQU 1323                    ; 0X52B
 SYSLONGDIVMULTB_H                EQU 1321                    ; 0X529
 SYSLONGDIVMULTB_U                EQU 1322                    ; 0X52A
 SYSLONGDIVMULTX                  EQU 1324                    ; 0X52C
 SYSLONGDIVMULTX_E                EQU 1327                    ; 0X52F
 SYSLONGDIVMULTX_H                EQU 1325                    ; 0X52D
 SYSLONGDIVMULTX_U                EQU 1326                    ; 0X52E
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
 SYSPRINTDATAHANDLER              EQU 1328                    ; 0X530
 SYSPRINTDATAHANDLER_H            EQU 1329                    ; 0X531
 SYSPRINTTEMP                     EQU 1330                    ; 0X532
 SYSREPEATTEMP1                   EQU 1331                    ; 0X533
 SYSREPEATTEMP1_H                 EQU 1332                    ; 0X534
 SYSREPEATTEMP3                   EQU 1333                    ; 0X535
 SYSREPEATTEMP4                   EQU 1334                    ; 0X536
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 4813                    ; 0X12CD
 SYSSTRINGPARAM2                  EQU 4764                    ; 0X129C
 SYSSTRINGTEMP                    EQU 1335                    ; 0X537
 SYSTEMP1                         EQU 1336                    ; 0X538
 SYSTEMP1_E                       EQU 1339                    ; 0X53B
 SYSTEMP1_H                       EQU 1337                    ; 0X539
 SYSTEMP1_U                       EQU 1338                    ; 0X53A
 SYSTEMP2                         EQU 1340                    ; 0X53C
 SYSTEMP2_H                       EQU 1341                    ; 0X53D
 SYSVALTEMP                       EQU 1342                    ; 0X53E
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 SYSWORDTEMPX                     EQU 1280                    ; 0X500
 SYSWORDTEMPX_H                   EQU 1281                    ; 0X501
 SYS_HEF_BUFFERHANDLER            EQU 1343                    ; 0X53F
 SYS_HEF_BUFFERHANDLER_H          EQU 1344                    ; 0X540
 WORD1                            EQU 1345                    ; 0X541
 WORD1_H                          EQU 1346                    ; 0X542
 WORD2                            EQU 1347                    ; 0X543
 WORD2_H                          EQU 1348                    ; 0X544
 WORD3                            EQU 1349                    ; 0X545
 WORD3_H                          EQU 1350                    ; 0X546
 WORD4                            EQU 1351                    ; 0X547
 WORD4_H                          EQU 1352                    ; 0X548
 _GIE_SAVE                        EQU 1353                    ; 0X549
 _HEF_ABS_ADDR                    EQU 1354                    ; 0X54A
 _HEF_ABS_ADDR_E                  EQU 1357                    ; 0X54D
 _HEF_ABS_ADDR_H                  EQU 1355                    ; 0X54B
 _HEF_ABS_ADDR_U                  EQU 1356                    ; 0X54C
 _HEF_BLOCKNUM                    EQU 1358                    ; 0X54E
 _HEF_BUFFER                      EQU 4862                    ; 0X12FE
 _HEF_COUNT                       EQU 1359                    ; 0X54F
 _HEF_COUNT_H                     EQU 1360                    ; 0X550
 _HEF_DATABYTE                    EQU 1361                    ; 0X551
 _HEF_DATAWORD                    EQU 1362                    ; 0X552
 _HEF_DATAWORD_H                  EQU 1363                    ; 0X553
 _HEF_INDEX                       EQU 1364                    ; 0X554
 _HEF_INDEX_H                     EQU 1365                    ; 0X555
 _HEF_OFFSET                      EQU 1366                    ; 0X556
 _HEF_OFFSET_H                    EQU 1367                    ; 0X557
 _HEF_REL_ADDR                    EQU 1368                    ; 0X558
 _HEXPICAS                        EQU 4760                    ; 0X1298

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYS_HEXPICAS_0                   EQU 4760
 SYS_HEXPICAS_1                   EQU 4761
 SYS_HEXPICAS_2                   EQU 4762

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
;''  This demonstration shows the SAF values on the Serial Terminal.
;''
;'' This lesson will provide code for writing and reading values onto
;'' the on-board SAF. SAF is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The SAF is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' This will show the value of the SAF on the serial Terminal.
;''
;'' There are several system Constants available for use with SAF. These are:
;''
;''   SAF_BYTES                 The number of Bytes of SAF Memory
;''   SAF_ROWSIZE_BYTES         The number of Bytes in a Block of SAFM
;''   SAF_NUM_BLOCKS            The number blocks of SAFM  (Either 2 or 4)
;''   SAF_START_ADDRESS         The Absolute Address of the Start of SAFM
;''   SAF_BLOCK0_ADDR           The Absolute Address of the Start of SAF Block 0
;''   SAF_BLOCK1_ADDR           The Absolute Address of the Start of SAF Block 1
;''   SAF_BLOCK2_ADDR           The Absolute Address of the Start of SAF Block 2
;''   SAF_BLOCK3_ADDR           The Absolute Address of the Start of SAF Block 3
;''
;''  The most useful of these is  SAF_ROWSIZE_BYTES.  This constant should be
;''  used to size the necessary buffer array used with SAF commands
;''
;''      Example:  Dim MyBufffer(SAF_ROWSIZE_BYTES)
;''
;''  Sometimes it may be necessary to know the SAF block  and offset where
;''  a relative address resides. This can be calculated as follows:
;''
;''      Block number = relative address / SAF_ROWSIZE_BYTES
;''
;''      offset =  relative address % SAF_ROWSIZE_BYTES
;''
;''     Example:
;''
;''    Relative address = 184
;''
;''    Blocknum = 184 /  64  =  2   (integer math)
;''    offset =   184 %  64  =  56  (Modulo divide)
;''
;''   So a byte of data stored in rel address 184 is
;''   located in the 56th  location of block 2
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
;Dim Rel_Address, numbytes, DataByte, Index as Byte
;Dim NVM_Address as Long  ' Absolute Address
;Dim DataWord as Word
;Dim IndexWord as Word
;Dim MyBuffer(SAF_ROWSIZE_BYTES)
;Wait 200 ms 'Stabilize
	MOVLW	200
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;------- Main Program Starts Here --------------
;'' Store 8 Bytes of Data in SAF Memory using SAFWriteBlock
;'' MyBuffer is sized using the system constant SAF_ROWSIZE_BYTES
;''------------------------------------------------------------------
;Fill the latches with data to clear RAM BUFFER! Else, the RAM BUFFER for write operations may contain random data
;repeat ChipWriteFlashBlockSize
	CLRF	SYSREPEATTEMP1,ACCESS
	MOVLW	1
	MOVWF	SYSREPEATTEMP1_H,ACCESS
SYSREPEATLOOP1:
;TABLAT = 0xFF   'Set to 0xFF as this the default for 18F SAF memory
	SETF	TABLAT,ACCESS
;TBLWT*+
	TBLWT*+
;end repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP1
	DECFSZ	SYSREPEATTEMP1_H,F,ACCESS
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;Write  8 Bytes of data into the buffer/array
;MyBuffer = 0x20, 0x2C, 0x58, 0x5B,  0x4D, 0x4E, 0x3F, 0x63
	LFSR	0,MYBUFFER
	MOVLW	8
	MOVWF	POSTINC0,ACCESS
	MOVLW	32
	MOVWF	POSTINC0,ACCESS
	MOVLW	44
	MOVWF	POSTINC0,ACCESS
	MOVLW	88
	MOVWF	POSTINC0,ACCESS
	MOVLW	91
	MOVWF	POSTINC0,ACCESS
	MOVLW	77
	MOVWF	POSTINC0,ACCESS
	MOVLW	78
	MOVWF	POSTINC0,ACCESS
	MOVLW	63
	MOVWF	POSTINC0,ACCESS
	MOVLW	99
	MOVWF	POSTINC0,ACCESS
;Write the 8 bytes to SAF Block 0
;numbytes = 8
	MOVLW	8
	MOVWF	NUMBYTES,ACCESS
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "Buffer test: Three lines should read the same."
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE1
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE1
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerPrintCRLF 1
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "Buffer being sent to SAF        : "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE2
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE2
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;For index = 1 to numbytes
	CLRF	INDEX,ACCESS
	MOVLW	1
	SUBWF	NUMBYTES,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND1
SYSFORLOOP1:
	INCF	INDEX,F,ACCESS
;Hserprint "0x"+hex(MyBuffer(index))
	LFSR	0,MYBUFFER
	MOVF	INDEX,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;Hsersend 32 'space
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;Next
	MOVF	NUMBYTES,W,ACCESS
	SUBWF	INDEX,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;SAFWriteBlock (0, MyBuffer, numbytes)
	CLRF	_HEF_BLOCKNUM,ACCESS
	MOVLW	LOW MYBUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER,ACCESS
	MOVLW	HIGH MYBUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER_H,ACCESS
	MOVFF	NUMBYTES,_HEF_COUNT
	CLRF	_HEF_COUNT_H,ACCESS
	CALL	SAFWRITEBLOCK
;Clear the buffer
;For IndexWord = 0 to SAF_ROWSIZE_BYTES-1
	SETF	INDEXWORD,ACCESS
	SETF	INDEXWORD_H,ACCESS
SYSFORLOOP2:
	INCF	INDEXWORD,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	INDEXWORD_H,F,ACCESS
;MyBuffer(IndexWord) = 0xFF
	LFSR	0,MYBUFFER
	MOVF	INDEXWORD,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	INDEXWORD_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	SETF	INDF0,ACCESS
;Next
	MOVFF	INDEXWORD,SYSWORDTEMPA
	MOVFF	INDEXWORD_H,SYSWORDTEMPA_H
	SETF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;*** Read the 8 stored bytes using SAFReadBlock ***
;SAFReadBlock (0, MyBuffer, numbytes)
	CLRF	_HEF_BLOCKNUM,ACCESS
	MOVLW	LOW MYBUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER,ACCESS
	MOVLW	HIGH MYBUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER_H,ACCESS
	MOVFF	NUMBYTES,_HEF_COUNT
	CLRF	_HEF_COUNT_H,ACCESS
	RCALL	SAFREADBLOCK
;Output the 8 bytes to a terminal
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "Buffer being read back from SAF : "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE4
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE4
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;For index = 1 to numbytes
	CLRF	INDEX,ACCESS
	MOVLW	1
	SUBWF	NUMBYTES,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND3
SYSFORLOOP3:
	INCF	INDEX,F,ACCESS
;Hserprint "0x"+hex(MyBuffer(index))
	LFSR	0,MYBUFFER
	MOVF	INDEX,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;Hsersend 32 'space
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;Next
	MOVF	NUMBYTES,W,ACCESS
	SUBWF	INDEX,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
;*** Read the stored bytes using SAFRead ***
;The relative memory address or location is
;offset by 1 relative to the buffer address
;HserprintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "Direct read to SAF address      : "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE5
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE5
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;For rel_address = 0 to 7
	SETF	REL_ADDRESS,ACCESS
SYSFORLOOP4:
	INCF	REL_ADDRESS,F,ACCESS
;SAFRead (Rel_Address, Databyte)
	MOVFF	REL_ADDRESS,_HEF_REL_ADDR
	RCALL	SAFREAD384
	MOVFF	_HEF_DATABYTE,DATABYTE
;Hserprint "0x"+hex(DataByte)
	MOVFF	DATABYTE,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;hsersend 32 'space
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;Next
	MOVLW	7
	SUBWF	REL_ADDRESS,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
;HserprintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "SAF Dump "
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE6
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE6
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;SAFM_Dump
	RCALL	SAFM_DUMP
;=========================================================
;'' Store 4 Words  of Data in SAF Memory using SAFWrite
;''------------------------------------------------------
;Dim Word1, Word2, Word3, Word4 as Word
;Word1 = 0x5BAF
	MOVLW	175
	MOVWF	WORD1,ACCESS
	MOVLW	91
	MOVWF	WORD1_H,ACCESS
;Word2 = 0x1F0
	MOVLW	240
	MOVWF	WORD2,ACCESS
	MOVLW	1
	MOVWF	WORD2_H,ACCESS
;Word3 = 0xD271
	MOVLW	113
	MOVWF	WORD3,ACCESS
	MOVLW	210
	MOVWF	WORD3_H,ACCESS
;Word4 = 0x4321
	MOVLW	33
	MOVWF	WORD4,ACCESS
	MOVLW	67
	MOVWF	WORD4_H,ACCESS
;HserprintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerPrint "Send word to address x08 - 0x0C - should be same"
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE7
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE7
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE7
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HserprintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HSerprint "0x"+hex(Word1_h)
	MOVFF	WORD1_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint      hex(Word1)
	MOVFF	WORD1,SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerSend 32
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;HSerprint "0x"+hex(Word2_h)
	MOVFF	WORD2_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint      hex(Word2)
	MOVFF	WORD2,SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerSend 32
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;HSerprint "0x"+hex(Word3_h)
	MOVFF	WORD3_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	RCALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint      hex(Word3)
	MOVFF	WORD3,SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerSend 32
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;HSerprint "0x"+hex(Word4_h)
	MOVFF	WORD4_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	RCALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint      hex(Word4)
	MOVFF	WORD4,SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerSend 32
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;Write the words staring at saf location 8
;Which is the next address past the 8 bytes
;SAFwriteWord (8, Word1)   ' use even numbered adresses
	MOVLW	8
	MOVWF	_HEF_REL_ADDR,ACCESS
	MOVFF	WORD1,_HEF_DATAWORD
	MOVFF	WORD1_H,_HEF_DATAWORD_H
	RCALL	SAFWRITEWORD
;SAFwriteWord (10, Word2)
	MOVLW	10
	MOVWF	_HEF_REL_ADDR,ACCESS
	MOVFF	WORD2,_HEF_DATAWORD
	MOVFF	WORD2_H,_HEF_DATAWORD_H
	RCALL	SAFWRITEWORD
;SAFwriteWord (12, Word3)
	MOVLW	12
	MOVWF	_HEF_REL_ADDR,ACCESS
	MOVFF	WORD3,_HEF_DATAWORD
	MOVFF	WORD3_H,_HEF_DATAWORD_H
	RCALL	SAFWRITEWORD
;SAFwriteWord (14, Word4)
	MOVLW	14
	MOVWF	_HEF_REL_ADDR,ACCESS
	MOVFF	WORD4,_HEF_DATAWORD
	MOVFF	WORD4_H,_HEF_DATAWORD_H
	RCALL	SAFWRITEWORD
;Read the Words using SAFReadWord & output to terminal
;Rel_Address = 8
	MOVLW	8
	MOVWF	REL_ADDRESS,ACCESS
;HserprintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;Repeat 4
	MOVLW	4
	MOVWF	SYSREPEATTEMP1,ACCESS
SYSREPEATLOOP2:
;SAFReadWord(Rel_Address, DataWord)
	MOVFF	REL_ADDRESS,_HEF_REL_ADDR
	RCALL	SAFREADWORD386
	MOVFF	_HEF_DATAWORD,DATAWORD
	MOVFF	_HEF_DATAWORD_H,DATAWORD_H
;HSerprint "0x"+hex(DataWord_h)
	MOVFF	DATAWORD_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,_HEXPICAS
	RCALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint      hex(DataWord)
	MOVFF	DATAWORD,SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;Hsersend 32
	MOVLW	32
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND284
;Rel_Address +=2  'increment address by 2
	MOVLW	2
	ADDWF	REL_ADDRESS,F,ACCESS
;End repeat
	DECFSZ	SYSREPEATTEMP1,F,ACCESS
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;HSerprintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;SAFM_DUMP
	RCALL	SAFM_DUMP
;=========================================================
;end
	BRA	BASPROGRAMEND
;
;; This subroutine displays the SAF Flash Memory on a terminal
;; Words in reverse byte order relative to address
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

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT295:
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
	RCALL	HSERSEND285
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (1405)
HSERPRINT296:
;OutValueTemp = 0
	CLRF	OUTVALUETEMP,ACCESS
;IF SerPrintVal >= 100 Then
	MOVLW	100
	SUBWF	SERPRINTVAL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	ENDIF19
;OutValueTemp = SerPrintVal / 100
	MOVFF	SERPRINTVAL,SYSBYTETEMPA
	MOVLW	100
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W,ACCESS
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND285
;End If
ENDIF19:
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	MOVFF	OUTVALUETEMP,SYSBYTETEMPB
	CLRF	SYSBYTETEMPA,ACCESS
	RCALL	SYSCOMPLESSTHAN
	MOVFF	SYSBYTETEMPX,SYSTEMP2
	MOVFF	SERPRINTVAL,SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVF	SYSTEMP2,W,ACCESS
	IORWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	BTFSS	SYSTEMP1,0,ACCESS
	BRA	ENDIF20
;OutValueTemp = SerPrintVal / 10
	MOVFF	SERPRINTVAL,SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W,ACCESS
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND285
;End If
ENDIF20:
;HSerSend(SerPrintVal + 48 ,comport)
	MOVLW	48
	ADDWF	SERPRINTVAL,W,ACCESS
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND285
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVFF	HSERPRINTCRLFCOUNT,SYSREPEATTEMP4
	MOVF	SYSREPEATTEMP4,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND4
SYSREPEATLOOP4:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND285
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA,ACCESS
	RCALL	HSERSEND285
;end Repeat
	DECFSZ	SYSREPEATTEMP4,F,ACCESS
	BRA	SYSREPEATLOOP4
SYSREPEATLOOPEND4:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (759)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSS PIR4,U1TXIF,ACCESS
	BTFSS	PIR4,1,ACCESS
	BRA	SYSWAITLOOP1
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP2:
BANKSEL	U1ERRIR
;A8: ASM Source was:  BTFSS U1ERRIR,TXMTIF,BANKED
	BTFSS	U1ERRIR,7,BANKED
	BRA	SYSWAITLOOP2
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
HSERSEND285:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF30
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP4:
;A8: ASM Source was:  BTFSS PIR4,U1TXIF,ACCESS
	BTFSS	PIR4,1,ACCESS
	BRA	SYSWAITLOOP4
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP5:
BANKSEL	U1ERRIR
;A8: ASM Source was:  BTFSS U1ERRIR,TXMTIF,BANKED
	BTFSS	U1ERRIR,7,BANKED
	BRA	SYSWAITLOOP5
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
ENDIF30:
	RETURN

;********************************************************************************

;SOURCE: 280_SHOWING_SAF_DATA_TO_SERIAL_TERMINAL.GCB (67)
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

;SOURCE: SAF.H (432)
SAFERASEBLOCK:
;_HEF_ABS_ADDR = HEF_START_ADDR + (HEF_ROWSIZE_BYTES * _HEF_BlockNum)
	MOVFF	_HEF_BLOCKNUM,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,SYSTEMP2
	MOVFF	SYSWORDTEMPX_H,SYSTEMP2_H
	MOVLW	0
	ADDWF	SYSTEMP2,W,ACCESS
	MOVWF	_HEF_ABS_ADDR,ACCESS
	MOVLW	255
	ADDWFC	SYSTEMP2_H,W,ACCESS
	MOVWF	_HEF_ABS_ADDR_H,ACCESS
	CLRF	_HEF_ABS_ADDR_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	_HEF_ABS_ADDR_U,F,ACCESS
	CLRF	_HEF_ABS_ADDR_E,ACCESS
;_GIE_SAVE = INTCON0.GIE  'Save interrupt setting
	CLRF	_GIE_SAVE,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	INCF	_GIE_SAVE,F,ACCESS
;INTCON0.GIE = 0 'Disable interrupts
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;For Q41 series
;NVMADRU = _HEF_ABS_ADDR_U
	MOVFF	_HEF_ABS_ADDR_U,NVMADRU
;NVMADRH = _HEF_ABS_ADDR_H
	MOVFF	_HEF_ABS_ADDR_H,NVMADRH
;NVMADRL = _HEF_ABS_ADDR
;A6: ASM Source was:  MOVFF _HEF_ABS_ADDR,NVMADRL
	MOVFF	_HEF_ABS_ADDR,NVMADR
;NVMCON1 = 6 ; Erase operations
	MOVLW	6
	MOVWF	NVMCON1,BANKED
;NVMLOCK = 0x55
	MOVLW	85
	MOVWF	NVMLOCK,BANKED
;NVMLOCK = 0xAA
	MOVLW	170
	MOVWF	NVMLOCK,BANKED
;GO_NVMCON0 = 1
;A8: ASM Source was:  BSF NVMCON0,GO_NVMCON0,BANKED
	BSF	NVMCON0,0,BANKED
;wait while GO_NVMCON0 = 1
SYSWAITLOOP6:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP6
;NVMCON1 = NVMCON1 and 0XF8
	MOVLW	248
	ANDWF	NVMCON1,F,BANKED
;NOP
	NOP
;NOP
	NOP
;INTCON0.GIE = _GIE_SAVE    ' Restore saved interrupt setting
	BTFSC	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	BTFSS	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	RETURN

;********************************************************************************

;SOURCE: 280_SHOWING_SAF_DATA_TO_SERIAL_TERMINAL.GCB (231)
SAFM_DUMP:
;Dim Blocknum as Byte
;NVM_Address  = SAF_START_ADDR
	CLRF	NVM_ADDRESS,ACCESS
	SETF	NVM_ADDRESS_H,ACCESS
	CLRF	NVM_ADDRESS_U,ACCESS
	CLRF	NVM_ADDRESS_E,ACCESS
;BlockNum = 0
	CLRF	BLOCKNUM,ACCESS
;Repeat SAF_WORDS    ;128 times
	MOVLW	128
	MOVWF	SYSREPEATTEMP3,ACCESS
SYSREPEATLOOP3:
;If NVM_Address % SAF_ROWSIZE_BYTES = 0 then
	MOVFF	NVM_ADDRESS,SYSLONGTEMPA
	MOVFF	NVM_ADDRESS_H,SYSLONGTEMPA_H
	MOVFF	NVM_ADDRESS_U,SYSLONGTEMPA_U
	MOVFF	NVM_ADDRESS_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPX,SYSTEMP1
	MOVFF	SYSLONGTEMPX_H,SYSTEMP1_H
	MOVFF	SYSLONGTEMPX_U,SYSTEMP1_U
	MOVFF	SYSLONGTEMPX_E,SYSTEMP1_E
	MOVFF	SYSTEMP1,SYSLONGTEMPA
	MOVFF	SYSTEMP1_H,SYSLONGTEMPA_H
	MOVFF	SYSTEMP1_U,SYSLONGTEMPA_U
	MOVFF	SYSTEMP1_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF8
;If BlockNum > 0 then   HSERPRINTCRLF
	MOVF	BLOCKNUM,W,ACCESS
	SUBLW	0
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF10
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
ENDIF10:
;HSerprintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;HserPrint "Block"
	LFSR	1,SYSSTRINGPARAM2
	MOVLW	LOW STRINGTABLE8
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE8
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE8
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;HSerprint BlockNum
	MOVFF	BLOCKNUM,SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT296
;HSerprint "  1 0   3 2   5 4   7 6   9 8   B A   D C   F E"
	LFSR	1,SYSSTRINGPARAM2
	MOVLW	LOW STRINGTABLE9
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE9
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE9
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;BlockNum++
	INCF	BLOCKNUM,F,ACCESS
;End if
ENDIF8:
;IF NVM_Address  % 16 = 0 then
	MOVFF	NVM_ADDRESS,SYSLONGTEMPA
	MOVFF	NVM_ADDRESS_H,SYSLONGTEMPA_H
	MOVFF	NVM_ADDRESS_U,SYSLONGTEMPA_U
	MOVFF	NVM_ADDRESS_E,SYSLONGTEMPA_E
	MOVLW	16
	MOVWF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPX,SYSTEMP1
	MOVFF	SYSLONGTEMPX_H,SYSTEMP1_H
	MOVFF	SYSLONGTEMPX_U,SYSTEMP1_U
	MOVFF	SYSLONGTEMPX_E,SYSTEMP1_E
	MOVFF	SYSTEMP1,SYSLONGTEMPA
	MOVFF	SYSTEMP1_H,SYSLONGTEMPA_H
	MOVFF	SYSTEMP1_U,SYSLONGTEMPA_U
	MOVFF	SYSTEMP1_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF9
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINTCRLF
;hserprint hex(NVM_Address_H)
	MOVFF	NVM_ADDRESS_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;hserprint hex(NVM_Address)
	MOVFF	NVM_ADDRESS,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;hserprint "    "
	LFSR	1,SYSSTRINGPARAM2
	MOVLW	LOW STRINGTABLE10
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE10
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE10
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;end if
ENDIF9:
;Rel_Address = NVM_ADDRESS - SAF_START_ADDR
	MOVLW	0
	SUBWF	NVM_ADDRESS,W,ACCESS
	MOVWF	REL_ADDRESS,ACCESS
;SAFReadWord(Rel_Address,DataWord)
	MOVFF	REL_ADDRESS,_HEF_REL_ADDR
	RCALL	SAFREADWORD386
	MOVFF	_HEF_DATAWORD,DATAWORD
	MOVFF	_HEF_DATAWORD_H,DATAWORD_H
;hserprint hex(DataWord_H)
	MOVFF	DATAWORD_H,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;hserprint hex(DataWord)
	MOVFF	DATAWORD,SYSVALTEMP
	RCALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;hserprint "  "
	LFSR	1,SYSSTRINGPARAM2
	MOVLW	LOW STRINGTABLE11
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE11
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE11
	MOVWF	TBLPTRU,ACCESS
	RCALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER,ACCESS
	MOVLW	HIGH SYSSTRINGPARAM2
	MOVWF	SYSPRINTDATAHANDLER_H,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	RCALL	HSERPRINT295
;NVM_Address+=2 ' Next "WORD"
	MOVLW	2
	ADDWF	NVM_ADDRESS,F,ACCESS
	MOVLW	0
	ADDWFC	NVM_ADDRESS_H,F,ACCESS
	MOVLW	0
	ADDWFC	NVM_ADDRESS_U,F,ACCESS
	MOVLW	0
	ADDWFC	NVM_ADDRESS_E,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP3,F,ACCESS
	BRA	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
;HserPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT,ACCESS
	MOVLW	1
	MOVWF	COMPORT,ACCESS
	BRA	HSERPRINTCRLF

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: SAF.H (188)
SAFREAD384:
;overloaded sub byte only
;_HEF_ABS_ADDR = HEF_START_ADDR + _HEF_REL_ADDR
	MOVLW	0
	ADDWF	_HEF_REL_ADDR,W,ACCESS
	MOVWF	_HEF_ABS_ADDR,ACCESS
	CLRF	SYSTEMP2,ACCESS
	MOVLW	255
	ADDWFC	SYSTEMP2,W,ACCESS
	MOVWF	_HEF_ABS_ADDR_H,ACCESS
	CLRF	_HEF_ABS_ADDR_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	_HEF_ABS_ADDR_U,F,ACCESS
	CLRF	_HEF_ABS_ADDR_E,ACCESS
;TBLPTRU = _HEF_ABS_ADDR_U
	MOVFF	_HEF_ABS_ADDR_U,TBLPTRU
;TBLPTRH = _HEF_ABS_ADDR_H
	MOVFF	_HEF_ABS_ADDR_H,TBLPTRH
;TBLPTRL = _HEF_ABS_ADDR
;A6: ASM Source was:  MOVFF _HEF_ABS_ADDR,TBLPTRL
	MOVFF	_HEF_ABS_ADDR,TBLPTR
;TBLRD*
	TBLRD*
;_HEF_DataByte = TABLAT
	MOVFF	TABLAT,_HEF_DATABYTE
	RETURN

;********************************************************************************

;SOURCE: SAF.H (341)
SAFREADBLOCK:
;Dim _HEF_Count as Word
;This subroutine returns in _HEF_Buffer array the [_HEF_Count] byte values
;stored in SAF given its row/block #
;Reads a row of SAF Data and puts it into a array/buffer
;for later use
;_HEF_ABS_ADDR =  HEF_START_ADDR + (_HEF_BlockNum * HEF_ROWSIZE_BYTES)
	MOVFF	_HEF_BLOCKNUM,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,SYSTEMP1
	MOVFF	SYSWORDTEMPX_H,SYSTEMP1_H
	MOVLW	0
	ADDWF	SYSTEMP1,W,ACCESS
	MOVWF	_HEF_ABS_ADDR,ACCESS
	MOVLW	255
	ADDWFC	SYSTEMP1_H,W,ACCESS
	MOVWF	_HEF_ABS_ADDR_H,ACCESS
	CLRF	_HEF_ABS_ADDR_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	_HEF_ABS_ADDR_U,F,ACCESS
	CLRF	_HEF_ABS_ADDR_E,ACCESS
;NVMCON1 = 0 ; point to Program Flash Memory Q10 series
	CLRF	NVMCON1,BANKED
;TBLPTRU = _HEF_ABS_ADDR_U
	MOVFF	_HEF_ABS_ADDR_U,TBLPTRU
;TBLPTRH = _HEF_ABS_ADDR_H
	MOVFF	_HEF_ABS_ADDR_H,TBLPTRH
;TBLPTRL = _HEF_ABS_ADDR
;A6: ASM Source was:  MOVFF _HEF_ABS_ADDR,TBLPTRL
	MOVFF	_HEF_ABS_ADDR,TBLPTR
;for  _HEF_Index = 1 to _HEF_Count -1
	CLRF	_HEF_INDEX,ACCESS
	CLRF	_HEF_INDEX_H,ACCESS
	MOVLW	1
	SUBWF	_HEF_COUNT,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	0
	SUBWFB	_HEF_COUNT_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	MOVFF	SYSTEMP1,SYSWORDTEMPA
	MOVFF	SYSTEMP1_H,SYSWORDTEMPA_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND7
SYSFORLOOP7:
	INCF	_HEF_INDEX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	_HEF_INDEX_H,F,ACCESS
;TBLRD*+ ; read into TABLAT and increment
	TBLRD*+
;_HEF_Buffer(_HEF_Index) = TABLAT
	MOVF	_HEF_INDEX,W,ACCESS
	ADDWF	SYS_HEF_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	_HEF_INDEX_H,W,ACCESS
	ADDWFC	SYS_HEF_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	TABLAT,INDF0
;next
	MOVLW	1
	SUBWF	_HEF_COUNT,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	0
	SUBWFB	_HEF_COUNT_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVFF	_HEF_INDEX,SYSWORDTEMPA
	MOVFF	_HEF_INDEX_H,SYSWORDTEMPA_H
	MOVFF	SYSTEMP1,SYSWORDTEMPB
	MOVFF	SYSTEMP1_H,SYSWORDTEMPB_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP7
SYSFORLOOPEND7:
;Get last byte
;TBLRD*
	TBLRD*
;_HEF_Buffer(_HEF_Index+1) = TABLAT
	MOVLW	1
	ADDWF	_HEF_INDEX,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVLW	0
	ADDWFC	_HEF_INDEX_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVF	SYSTEMP1,W,ACCESS
	ADDWF	SYS_HEF_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	SYSTEMP1_H,W,ACCESS
	ADDWFC	SYS_HEF_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	TABLAT,INDF0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: SAF.H (290)
SAFREADWORD386:
;_HEF_ABS_ADDR = HEF_START_ADDR + _HEF_REL_ADDR
	MOVLW	0
	ADDWF	_HEF_REL_ADDR,W,ACCESS
	MOVWF	_HEF_ABS_ADDR,ACCESS
	CLRF	SYSTEMP2,ACCESS
	MOVLW	255
	ADDWFC	SYSTEMP2,W,ACCESS
	MOVWF	_HEF_ABS_ADDR_H,ACCESS
	CLRF	_HEF_ABS_ADDR_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	_HEF_ABS_ADDR_U,F,ACCESS
	CLRF	_HEF_ABS_ADDR_E,ACCESS
;TBLPTRU = _HEF_ABS_ADDR_U
	MOVFF	_HEF_ABS_ADDR_U,TBLPTRU
;TBLPTRH = _HEF_ABS_ADDR_H
	MOVFF	_HEF_ABS_ADDR_H,TBLPTRH
;TBLPTRL = _HEF_ABS_ADDR
;A6: ASM Source was:  MOVFF _HEF_ABS_ADDR,TBLPTRL
	MOVFF	_HEF_ABS_ADDR,TBLPTR
;TBLRD*+
	TBLRD*+
;_HEF_DataWord = TABLAT
	MOVFF	TABLAT,_HEF_DATAWORD
	CLRF	_HEF_DATAWORD_H,ACCESS
;TBLRD*
	TBLRD*
;_HEF_DataWord_H = TABLAT
	MOVFF	TABLAT,_HEF_DATAWORD_H
	RETURN

;********************************************************************************

;SOURCE: SAF.H (540)
SAFWRITEBLOCK:
;This subroutine writes _HEF_Count from the _HEF_Buffer() array
;at a given row # of the HEM
;Dim _HEF_Count as Word
;Calculate Base Address of NVM Erase Block
;_HEF_ABS_ADDR =  HEF_START_ADDR + (_HEF_BlockNum * HEF_ROWSIZE_BYTES)
	MOVFF	_HEF_BLOCKNUM,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,SYSTEMP2
	MOVFF	SYSWORDTEMPX_H,SYSTEMP2_H
	MOVLW	0
	ADDWF	SYSTEMP2,W,ACCESS
	MOVWF	_HEF_ABS_ADDR,ACCESS
	MOVLW	255
	ADDWFC	SYSTEMP2_H,W,ACCESS
	MOVWF	_HEF_ABS_ADDR_H,ACCESS
	CLRF	_HEF_ABS_ADDR_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	_HEF_ABS_ADDR_U,F,ACCESS
	CLRF	_HEF_ABS_ADDR_E,ACCESS
;Erase the entire row - Call sub
;SAFEraseBlock (_HEF_BlockNum)
	RCALL	SAFERASEBLOCK
;_GIE_SAVE = INTCON0.GIE    'Save interrupt
	CLRF	_GIE_SAVE,ACCESS
;A8: ASM Source was:  BTFSC INTCON0,GIE,ACCESS
	BTFSC	INTCON0,7,ACCESS
	INCF	_GIE_SAVE,F,ACCESS
;INTCON0.GIE = 0           'disable interrupts
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
;TBLPTRU = _HEF_ABS_ADDR_U
	MOVFF	_HEF_ABS_ADDR_U,TBLPTRU
;TBLPTRH = _HEF_ABS_ADDR_H
	MOVFF	_HEF_ABS_ADDR_H,TBLPTRH
;TBLPTRL = _HEF_ABS_ADDR
;A6: ASM Source was:  MOVFF _HEF_ABS_ADDR,TBLPTRL
	MOVFF	_HEF_ABS_ADDR,TBLPTR
;NVMCON1 = 5                ' Page Write operations
	MOVLW	5
	MOVWF	NVMCON1,BANKED
;Fill the latches with data
;For _HEF_Index = 1 to _HEF_Count -1
	CLRF	_HEF_INDEX,ACCESS
	CLRF	_HEF_INDEX_H,ACCESS
	MOVLW	1
	SUBWF	_HEF_COUNT,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVLW	0
	SUBWFB	_HEF_COUNT_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	MOVFF	SYSTEMP2,SYSWORDTEMPA
	MOVFF	SYSTEMP2_H,SYSWORDTEMPA_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND8
SYSFORLOOP8:
	INCF	_HEF_INDEX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	_HEF_INDEX_H,F,ACCESS
;TABLAT = _HEF_Buffer(_HEF_Index)
	MOVF	_HEF_INDEX,W,ACCESS
	ADDWF	SYS_HEF_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	_HEF_INDEX_H,W,ACCESS
	ADDWFC	SYS_HEF_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,TABLAT
;TBLWT*+
	TBLWT*+
;Next
	MOVLW	1
	SUBWF	_HEF_COUNT,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVLW	0
	SUBWFB	_HEF_COUNT_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVFF	_HEF_INDEX,SYSWORDTEMPA
	MOVFF	_HEF_INDEX_H,SYSWORDTEMPA_H
	MOVFF	SYSTEMP2,SYSWORDTEMPB
	MOVFF	SYSTEMP2_H,SYSWORDTEMPB_H
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP8
SYSFORLOOPEND8:
;last byte
;TABLAT =  _HEF_Buffer(_HEF_Index +1)
	MOVLW	1
	ADDWF	_HEF_INDEX,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVLW	0
	ADDWFC	_HEF_INDEX_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVF	SYSTEMP2,W,ACCESS
	ADDWF	SYS_HEF_BUFFERHANDLER,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVF	SYSTEMP2_H,W,ACCESS
	ADDWFC	SYS_HEF_BUFFERHANDLER_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,TABLAT
;TBLWT*
	TBLWT*
;NVMLOCK = 0x55
	MOVLW	85
	MOVWF	NVMLOCK,BANKED
;NVMLOCK = 0xAA
	MOVLW	170
	MOVWF	NVMLOCK,BANKED
;GO_NVMCON0 =1
;A8: ASM Source was:  BSF NVMCON0,GO_NVMCON0,BANKED
	BSF	NVMCON0,0,BANKED
;wait while GO_NVMCON0 = 1
SYSWAITLOOP3:
;A8: ASM Source was:  BTFSC NVMCON0,GO_NVMCON0,BANKED
	BTFSC	NVMCON0,0,BANKED
	BRA	SYSWAITLOOP3
;NVMCON1 = NVMCON1 and 0XF8
	MOVLW	248
	ANDWF	NVMCON1,F,BANKED
;INTCON0.GIE = _GIE_SAVE     'restore saved interrupt
	BTFSC	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS
	BTFSS	_GIE_SAVE,0,ACCESS
;A8: ASM Source was:  BCF INTCON0,GIE,ACCESS
	BCF	INTCON0,7,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SAF.H (726)
SAFWRITEWORD:
;Writes a single WORD to 18F SAF Memory
;at relative locations [_HEF_REL_ADDR]
;where each address is an even number.
;
;Existing data in the row of [_HEF_REL_ADDR] is preserved
;Calculate block number
;_HEF_BlockNum = _HEF_REL_ADDR / HEF_ROWSIZE_BYTES
	MOVFF	_HEF_REL_ADDR,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,_HEF_BLOCKNUM
;Calculate offset in block/row
;_HEF_Offset = _HEF_REL_ADDR % HEF_ROWSIZE_BYTES
	MOVFF	_HEF_REL_ADDR,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPX,_HEF_OFFSET
	MOVFF	SYSWORDTEMPX_H,_HEF_OFFSET_H
;Save data previously stored in row#
;SAFReadBlock(_HEF_BlockNum, _HEF_Buffer(), HEF_ROWSIZE_BYTES)
	MOVLW	LOW _HEF_BUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _HEF_BUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER_H,ACCESS
	CLRF	_HEF_COUNT,ACCESS
	MOVLW	1
	MOVWF	_HEF_COUNT_H,ACCESS
	RCALL	SAFREADBLOCK
;Update buffer with DataValue at offset
;_HEF_Buffer(_HEF_Offset + 1) = _HEF_DataWord
	LFSR	0,_HEF_BUFFER
	MOVF	_HEF_OFFSET,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,W,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,W,ACCESS
	ADDWF	FSR0,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	_HEF_OFFSET_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
	ADDWFC	FSR0H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVLW	1
	ADDWF	SYSTEMP2,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	_HEF_DATAWORD,INDF0
;_HEF_Buffer(_HEF_Offset + 2) = _HEF_DataWord_H
	LFSR	0,_HEF_BUFFER
	MOVF	_HEF_OFFSET,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,W,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,W,ACCESS
	ADDWF	FSR0,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	_HEF_OFFSET_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,W,ACCESS
	ADDWFC	FSR0H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVLW	2
	ADDWF	SYSTEMP2,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,ACCESS
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	_HEF_DATAWORD_H,INDF0
;Write back the updated row buffer to  HEFM
;SAFwriteBlock(_HEF_BlockNum, _HEF_Buffer(), HEF_ROWSIZE_BYTES)
	MOVLW	LOW _HEF_BUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER,ACCESS
	MOVLW	HIGH _HEF_BUFFER
	MOVWF	SYS_HEF_BUFFERHANDLER_H,ACCESS
	CLRF	_HEF_COUNT,ACCESS
	MOVLW	1
	MOVWF	_HEF_COUNT_H,ACCESS
	BRA	SAFWRITEBLOCK

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

;SOURCE: SYSTEM.H (3035)
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	SETF	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	CPFSLT	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
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

;SOURCE: SYSTEM.H (1276)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length for ChipFamily 16 support
;movff INDF0, SysCalcTempA
	MOVFF	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	MOVFF	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	BRA	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;movf INDF0, W
	MOVF	INDF0, W,ACCESS
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	ADDWF	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;return
	RETURN
SYSSTRINGCOPY:
;Copy character
;movff PREINC0, PREINC1
	MOVFF	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	BRA	SYSSTRINGCOPY
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2644)
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP,ACCESS
SYSDIV8START:
;bcf STATUS, C
;A8: ASM Source was:  BCF STATUS, C,ACCESS
	BCF	STATUS,0,ACCESS
;rlf SysByteTempA, F
	RLCF	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	RLCF	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
;goto Div8NotNeg
	BRA	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	BRA	SYSDIV8START
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
	BRA	ENDIF28
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
;exit sub
	RETURN
;end if
ENDIF28:
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
	BRA	ENDIF29
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	ADDWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	ADDWFC	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF29:
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
	BRA	ENDIF14
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF14:
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
	BRA	ENDIF15
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
ENDIF15:
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

;SOURCE: SYSTEM.H (2467)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	MULWF	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
;A2: ASM Source was:  MOVFF PRODL, SYSWORDTEMPX
;A4: ASM Source was:  MOVFF PRODL, SYSWORDTEMPX
	MOVFF	PROD, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	MOVFF	PRODH, SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	MULWF	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
;A2: ASM Source was:  MOVF PRODL, W,ACCESS
;A5: ASM Source was:  MOVF PRODL, W,ACCESS
	MOVF	PROD, W,ACCESS
;addwf SysWordTempX_H, F
	ADDWF	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	MULWF	SYSWORDTEMPB,ACCESS
;movf PRODL, W
;A2: ASM Source was:  MOVF PRODL, W,ACCESS
;A5: ASM Source was:  MOVF PRODL, W,ACCESS
	MOVF	PROD, W,ACCESS
;addwf SysWordTempX_H, F
	ADDWF	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	MOVF	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	MULWF	SYSWORDTEMPB_H,ACCESS
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
	DB	46,66,117,102,102,101,114,32,116,101,115,116,58,32,84,104,114,101,101,32,108,105
	DB	110,101,115,32,115,104,111,117,108,100,32,114,101,97,100,32,116,104,101,32,115,97
	DB	109,101,46

	ALIGN	2;X3

STRINGTABLE2:
	DB	34,66,117,102,102,101,114,32,98,101,105,110,103,32,115,101,110,116,32,116,111,32
	DB	83,65,70,32,32,32,32,32,32,32,32,58,32

	ALIGN	2;X3

STRINGTABLE3:
	DB	2,48,120

	ALIGN	2;X3

STRINGTABLE4:
	DB	34,66,117,102,102,101,114,32,98,101,105,110,103,32,114,101,97,100,32,98,97,99
	DB	107,32,102,114,111,109,32,83,65,70,32,58,32

	ALIGN	2;X3

STRINGTABLE5:
	DB	34,68,105,114,101,99,116,32,114,101,97,100,32,116,111,32,83,65,70,32,97,100,100,114
	DB	101,115,115,32,32,32,32,32,32,58,32

	ALIGN	2;X3

STRINGTABLE6:
	DB	9,83,65,70,32,68,117,109,112,32

	ALIGN	2;X3

STRINGTABLE7:
	DB	48,83,101,110,100,32,119,111,114,100,32,116,111,32,97,100,100,114,101,115,115,32
	DB	120,48,56,32,45,32,48,120,48,67,32,45,32,115,104,111,117,108,100,32,98,101,32,115
	DB	97,109,101

	ALIGN	2;X3

STRINGTABLE8:
	DB	5,66,108,111,99,107

	ALIGN	2;X3

STRINGTABLE9:
	DB	47,32,32,49,32,48,32,32,32,51,32,50,32,32,32,53,32,52,32,32,32,55,32,54,32,32
	DB	32,57,32,56,32,32,32,66,32,65,32,32,32,68,32,67,32,32,32,70,32,69

	ALIGN	2;X3

STRINGTABLE10:
	DB	4,32,32,32,32

	ALIGN	2;X3

STRINGTABLE11:
	DB	2,32,32

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
	BRA	ENDIF11
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF11:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_2
	MOVWF	SYS_HEXPICAS_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
SYSFORLOOP5:
	INCF	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	RRCF	SYSVALTEMP,F,ACCESS
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W,ACCESS
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF13
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF13:
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
