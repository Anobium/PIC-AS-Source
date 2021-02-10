;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\220_i2c_glcd_sprites_using_ssd1306.S"
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
 CHARCODE                         EQU 1291                    ; 0X50B
 CHARCOL                          EQU 1292                    ; 0X50C
 CHARCOLS                         EQU 1294                    ; 0X50E
 CHARCOL_H                        EQU 1293                    ; 0X50D
 CHARLOCX                         EQU 1295                    ; 0X50F
 CHARLOCX_H                       EQU 1296                    ; 0X510
 CHARLOCY                         EQU 1297                    ; 0X511
 CHARLOCY_H                       EQU 1298                    ; 0X512
 CHARROW                          EQU 1299                    ; 0X513
 CHARROWS                         EQU 1301                    ; 0X515
 CHARROW_H                        EQU 1300                    ; 0X514
 COL                              EQU 1302                    ; 0X516
 CURRCHARCOL                      EQU 1303                    ; 0X517
 CURRCHARROW                      EQU 1304                    ; 0X518
 CURRCHARVAL                      EQU 1305                    ; 0X519
 CURX                             EQU 1306                    ; 0X51A
 CURY                             EQU 1307                    ; 0X51B
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 DIRX                             EQU 1308                    ; 0X51C
 DIRY                             EQU 1309                    ; 0X51D
 DRAWLINE                         EQU 1310                    ; 0X51E
 DRAWLINE_H                       EQU 1311                    ; 0X51F
 GLCDBACKGROUND                   EQU 1312                    ; 0X520
 GLCDBACKGROUND_H                 EQU 1313                    ; 0X521
 GLCDBITNO                        EQU 1314                    ; 0X522
 GLCDCHANGE                       EQU 1315                    ; 0X523
 GLCDCOLOUR                       EQU 1316                    ; 0X524
 GLCDCOLOUR_H                     EQU 1317                    ; 0X525
 GLCDDATATEMP                     EQU 1318                    ; 0X526
 GLCDFNTDEFAULT                   EQU 1319                    ; 0X527
 GLCDFNTDEFAULTHEIGHT             EQU 1320                    ; 0X528
 GLCDFNTDEFAULTSIZE               EQU 1321                    ; 0X529
 GLCDFONTWIDTH                    EQU 1322                    ; 0X52A
 GLCDFOREGROUND                   EQU 1323                    ; 0X52B
 GLCDFOREGROUND_H                 EQU 1324                    ; 0X52C
 GLCDHICHANGE                     EQU 1325                    ; 0X52D
 GLCDLOCHANGE                     EQU 1326                    ; 0X52E
 GLCDPRINTLEN                     EQU 1327                    ; 0X52F
 GLCDPRINTLOC                     EQU 1328                    ; 0X530
 GLCDPRINTLOC_H                   EQU 1329                    ; 0X531
 GLCDPRINT_STRING_COUNTER         EQU 1330                    ; 0X532
 GLCDROTATEBITS                   EQU 1331                    ; 0X533
 GLCDTEMP                         EQU 1332                    ; 0X534
 GLCDTEMP_H                       EQU 1333                    ; 0X535
 GLCDX                            EQU 1334                    ; 0X536
 GLCDY                            EQU 1335                    ; 0X537
 GLCD_YORDINATE                   EQU 1336                    ; 0X538
 GLCD_YORDINATE_H                 EQU 1337                    ; 0X539
 HI2C1LASTERROR                   EQU 1338                    ; 0X53A
 HI2C1STATEMACHINE                EQU 1339                    ; 0X53B
 HI2CACKPOLLSTATE                 EQU 1340                    ; 0X53C
 HI2CCURRENTMODE                  EQU 1341                    ; 0X53D
 HI2CWAITMSSPTIMEOUT              EQU 1342                    ; 0X53E
 I2CBYTE                          EQU 1343                    ; 0X53F
 LINECOLOUR                       EQU 1344                    ; 0X540
 LINECOLOUR_H                     EQU 1345                    ; 0X541
 LINEX1                           EQU 1346                    ; 0X542
 LINEX1_H                         EQU 1347                    ; 0X543
 LINEX2                           EQU 1348                    ; 0X544
 LINEX2_H                         EQU 1349                    ; 0X545
 LINEY1                           EQU 1350                    ; 0X546
 LINEY1_H                         EQU 1351                    ; 0X547
 LINEY2                           EQU 1352                    ; 0X548
 LINEY2_H                         EQU 1353                    ; 0X549
 LOCX                             EQU 1354                    ; 0X54A
 LOCY                             EQU 1355                    ; 0X54B
 OLDX                             EQU 1356                    ; 0X54C
 OLDY                             EQU 1357                    ; 0X54D
 POSCHARX                         EQU 1358                    ; 0X54E
 POSCHARX_H                       EQU 1359                    ; 0X54F
 POSCHARY                         EQU 1360                    ; 0X550
 PRINTLOCX                        EQU 1361                    ; 0X551
 PRINTLOCX_H                      EQU 1362                    ; 0X552
 PRINTLOCY                        EQU 1363                    ; 0X553
 PRINTLOCY_H                      EQU 1364                    ; 0X554
 RANDOM                           EQU 1365                    ; 0X555
 RANDOMSEED                       EQU 1366                    ; 0X556
 RANDOMSEED_H                     EQU 1367                    ; 0X557
 RANDOMTEMP                       EQU 1368                    ; 0X558
 RANDOMTEMP_H                     EQU 1369                    ; 0X559
 ROW                              EQU 1370                    ; 0X55A
 SSD1306SENDBYTE                  EQU 1371                    ; 0X55B
 SSD1306_BUFFERALIAS              EQU 4351                    ; 0X10FF
 SSD1306_BUFFERLOCATIONCALC       EQU 1372                    ; 0X55C
 SSD1306_BUFFERLOCATIONCALC_H     EQU 1373                    ; 0X55D
 SSD1306_PAGE                     EQU 1374                    ; 0X55E
 STRINGPOINTER                    EQU 1375                    ; 0X55F
 SWAP4                            EQU 1376                    ; 0X560
 SWAP4IN                          EQU 1377                    ; 0X561
 SYSBYTETEMPA                     EQU 1285                    ; 0X505
 SYSBYTETEMPB                     EQU 1289                    ; 0X509
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSLCDPRINTDATAHANDLER           EQU 1378                    ; 0X562
 SYSLCDPRINTDATAHANDLER_H         EQU 1379                    ; 0X563
 SYSREPEATTEMP1                   EQU 1380                    ; 0X564
 SYSREPEATTEMP10                  EQU 1381                    ; 0X565
 SYSREPEATTEMP5                   EQU 1382                    ; 0X566
 SYSREPEATTEMP8                   EQU 1383                    ; 0X567
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 4333                    ; 0X10ED
 SYSTEMP1                         EQU 1384                    ; 0X568
 SYSTEMP1_H                       EQU 1385                    ; 0X569
 SYSTEMP2                         EQU 1386                    ; 0X56A
 SYSTEMP2_H                       EQU 1387                    ; 0X56B
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504
 SYSWAITTEMPUS                    EQU 1285                    ; 0X505
 SYSWAITTEMPUS_H                  EQU 1286                    ; 0X506
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258

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
	CALL	INITSYS
	CALL	INITPPS
	CALL	HI2CINIT
	CALL	INITGLCD_SSD1306
	CALL	INITRANDOM

;START OF THE MAIN PROGRAM
;''
;''This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;''
;''This program shows how to draw sprites on an SSD1306 I2C device.
;''Only support I2C and Full GLCD Mode - supported from v0.98 onwards
;''
;''The #define 'spritechoice' defines the sprite to be managed.
;''You can define your own in the sprite tables. Each table is 8 pixles vertical - col1 to col8 in each table.
;''
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.6.2
;PinManager data: v1.81.0
;Generated for 18f16q41
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18f16q41
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
;#DEFINE SWITCHIN      PORTA.2
;Dir     SWITCHIN      In
	BSF	TRISA,2,ACCESS
;Setup Serial port
;#DEFINE USART_BAUD_RATE 9600
;#DEFINE USART_TX_BLOCKING
;Define I2C settings
;#DEFINE HI2C_BAUD_RATE 125
;#DEFINE HI2C_DATA PORTB.4
;#DEFINE HI2C_CLOCK PORTB.6
;Initialise I2C - note for the I2C module the ports need to be set to IN
;Dir HI2C_DATA Out
	BCF	TRISB,4,ACCESS
;Dir HI2C_CLOCK Out
	BCF	TRISB,6,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;#DEFINE GLCD_TYPE GLCD_TYPE_SSD1306
;#DEFINE GLCD_I2C_Address 0x78
;These constants allow you to change the GLCD memory usage.
;#DEFINE GLCD_PROTECTOVERRUN
;*******************************************************************************************
;Select the sprite and the user delay
;#DEFINE spritechoice 2
;3ms is limit of user visual perception
;#DEFINE spritedelay 2 ms
;*******************************************************************************************
;Draw initial screen
;Box 0,0,127,63
	CLRF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	CLRF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	127
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	63
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	RCALL	BOX
;GLCDPrint ( 2, 36, "Great Cow BASIC")
	MOVLW	2
	MOVWF	PRINTLOCX,ACCESS
	CLRF	PRINTLOCX_H,ACCESS
	MOVLW	36
	MOVWF	PRINTLOCY,ACCESS
	CLRF	PRINTLOCY_H,ACCESS
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT6
;GLCDPrint ( 2, 46, "GLCD Library 2021")
	MOVLW	2
	MOVWF	PRINTLOCX,ACCESS
	CLRF	PRINTLOCX_H,ACCESS
	MOVLW	46
	MOVWF	PRINTLOCY,ACCESS
	CLRF	PRINTLOCY_H,ACCESS
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT6
;GLCDPrint ( 2, 54, "Sprite Support")
	MOVLW	2
	MOVWF	PRINTLOCX,ACCESS
	CLRF	PRINTLOCX_H,ACCESS
	MOVLW	54
	MOVWF	PRINTLOCY,ACCESS
	CLRF	PRINTLOCY_H,ACCESS
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT6
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;GLCDCLS
	RCALL	GLCDCLS_SSD1306
;Box 0,0,127,63
	CLRF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	CLRF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	127
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	63
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	RCALL	BOX
;dimension and initialise variables
;Dim oldx, oldy As Byte
;Dim curx, cury As Byte
;Dim dirx, diry As Byte
;curx = 63
	MOVLW	63
	MOVWF	CURX,ACCESS
;cury = 31
	MOVLW	31
	MOVWF	CURY,ACCESS
;oldx = curx
	MOVFF	CURX,OLDX
;oldy = cury
	MOVFF	CURY,OLDY
;Draw initial sprite
;GLCDDrawSprite_SSD1306 curx,cury, spritechoice, GLCDForeground
	MOVFF	CURX,GLCDX
	MOVFF	CURY,GLCDY
	MOVLW	2
	MOVWF	CHARCODE,ACCESS
	RCALL	GLCDDRAWSPRITE_SSD1306
;Set initial direction
;If Random > 127 Then
	CALL	FN_RANDOM
	MOVF	RANDOM,W,ACCESS
	SUBLW	127
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ELSE1_1
;dirx=1
	MOVLW	1
	MOVWF	DIRX,ACCESS
;Else
	BRA	ENDIF1
ELSE1_1:
;dirx=255
	SETF	DIRX,ACCESS
;End If
ENDIF1:
;If Random > 127 Then
	CALL	FN_RANDOM
	MOVF	RANDOM,W,ACCESS
	SUBLW	127
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ELSE2_1
;diry=1
	MOVLW	1
	MOVWF	DIRY,ACCESS
;Else
	BRA	ENDIF2
ELSE2_1:
;diry=255
	SETF	DIRY,ACCESS
;End If
ENDIF2:
;Dir portc.0 Out
	BCF	TRISC,0,ACCESS
;Do
SYSDOLOOP_S1:
;handle bounce
;If  curx>0 AND curx<119  Then
	MOVFF	CURX,SYSBYTETEMPB
	CLRF	SYSBYTETEMPA,ACCESS
	CALL	SYSCOMPLESSTHAN
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	CURX,SYSBYTETEMPA
	MOVLW	119
	MOVWF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPLESSTHAN
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ANDWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ELSE3_1
;oldx = curx
	MOVFF	CURX,OLDX
;curx=curx+dirx
	MOVF	DIRX,W,ACCESS
	ADDWF	CURX,F,ACCESS
;Else
	BRA	ENDIF3
ELSE3_1:
;If dirx = 1 Then
	DECF	DIRX,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE5_1
;dirx=255
	SETF	DIRX,ACCESS
;Else
	BRA	ENDIF5
ELSE5_1:
;dirx=1
	MOVLW	1
	MOVWF	DIRX,ACCESS
;End If
ENDIF5:
;oldx = curx
	MOVFF	CURX,OLDX
;curx=curx+dirx
	MOVF	DIRX,W,ACCESS
	ADDWF	CURX,F,ACCESS
;End If
ENDIF3:
;If cury >1 AND cury<55 Then
	MOVFF	CURY,SYSBYTETEMPB
	MOVLW	1
	MOVWF	SYSBYTETEMPA,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	CURY,SYSBYTETEMPA
	MOVLW	55
	MOVWF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPLESSTHAN
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ANDWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ELSE4_1
;oldy = cury
	MOVFF	CURY,OLDY
;cury=cury+diry
	MOVF	DIRY,W,ACCESS
	ADDWF	CURY,F,ACCESS
;Else
	BRA	ENDIF4
ELSE4_1:
;If diry = 1 Then
	DECF	DIRY,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE6_1
;diry=255
	SETF	DIRY,ACCESS
;Else
	BRA	ENDIF6
ELSE6_1:
;diry=1
	MOVLW	1
	MOVWF	DIRY,ACCESS
;End If
ENDIF6:
;oldy = cury
	MOVFF	CURY,OLDY
;cury=cury+diry
	MOVF	DIRY,W,ACCESS
	ADDWF	CURY,F,ACCESS
;End If
ENDIF4:
;end of handle bounce
;draw sprite
;GLCDDrawSprite_SSD1306 oldx,oldy, spritechoice
	MOVFF	OLDX,GLCDX
	MOVFF	OLDY,GLCDY
	MOVLW	2
	MOVWF	CHARCODE,ACCESS
	BANKSEL	0
	RCALL	GLCDDRAWSPRITE_SSD1306
;GLCDDrawSprite_SSD1306 curx,cury, spritechoice
	MOVFF	CURX,GLCDX
	MOVFF	CURY,GLCDY
	MOVLW	2
	MOVWF	CHARCODE,ACCESS
	RCALL	GLCDDRAWSPRITE_SSD1306
;pulse output for scope
;RC1 = !RC1
	BANKSEL	SYSTEMP1
	CLRF	SYSTEMP1,BANKED
;A8: ASM Source was:  BTFSC PORTC,RC1,ACCESS
	BTFSC	PORTC,1,ACCESS
	INCF	SYSTEMP1,F,BANKED
	COMF	SYSTEMP1,F,BANKED
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
	BTFSC	SYSTEMP1,0,BANKED
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;user delay
;so you can see it!
;Wait spritedelay
	MOVLW	2
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	BANKSEL	0
	RCALL	DELAY_MS
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	BRA	BASPROGRAMEND
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;sprite shape data
;----- Support methods.  Subroutines and Functions
;
;Dim HI2C1StateMachine as byte
;Dim HI2CACKPOLLSTATE  as Byte
;Dim HI2C1lastError as Byte
;
;#define I2C1_GOOD             0
;#define I2C1_FAIL_TIMEOUT     1
;#define I2C1_TXBE_TIMEOUT     2
;#define I2C1_START_TIMEOUT    4
;#define I2C1_RESTART_TIMEOUT  8
;#define I2C1_RXBF_TIMEOUT     16
;#define I2C1_ACK_TIMEOUT      32
;#define I2C1_MDR_TIMEOUT      64
;#define I2C1_STOP_TIMEOUT     128
;
;Sub SI2CInit
;
;Dir HI2C_DATA out
;Dir HI2C_CLOCK out
;
;I2C1CON1 = 0x80
;I2C1CON2 = 0x21
;I2C1CLK =  0x03
;I2C1CON0 = 0x04
;
;I2C1PIR = 0    ;Clear all the error flags
;I2C1ERR = 0
;I2C1CON0.EN=1
;
;
;I2C1CON2.ACNT = 0
;I2C1CON2.ABD=0
;I2C1CON0.MDR=1
;
;'Initialise correct state
;SI2CStart
;SI2CSend ( 0xff )
;SI2CStop
;
;#define HI2CIStopWaitPeriod 70
;
;End sub
;
;Sub SI2CStart
;
;HI2C1StateMachine = 1
;HI2CWaitMSSPTimeout = false
;HI2C1lastError = I2C1_GOOD
;
;End Sub
;
;Sub SI2CReStart
;
;HI2C1StateMachine = 3
;HI2CWaitMSSPTimeout = false
;
;End Sub
;
;Sub SI2CStop
;
;HI2C1StateMachine = 0
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1PIR.PCIF = 1 then
;SI2Cwait4Stop
;wait HI2CIStopWaitPeriod us
;exit sub
;
;else
;wait 1 us
;
;end if
;loop
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
;
;End Sub
;
;
;Sub SI2CSend ( in I2Cbyte )
;'This is now a state Machine to cater for the new approach with the I2C module
;
;Select Case HI2C1StateMachine
;
;
;case 2  'send data
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1STAT1.TXBE = 1 then
;
;I2C1CNT = 1
;I2C1TXB = I2Cbyte
;SI2CWait4Ack
;SI2Cwait4MDR
;
;exit Sub
;
;else
;
;wait 1 us
;
;end if
;loop
;
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_TXBE_TIMEOUT
;
;
;case 1  'A start
;
;I2C1STAT1.CLRBF = 1
;I2C1CNT = 0
;I2C1PIR.SCIF = 0
;I2C1ADB1 = I2Cbyte
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1PIR.SCIF = 1 then
;HI2C1StateMachine = 2  'Set state Machine to send data
;HI2CAckPollState = I2C1CON1.5
;exit Sub
;
;else
;I2C1CON0.S = 1
;wait 1 us
;
;end if
;loop
;
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_START_TIMEOUT
;
;case 3  'A restart
;
;'wait for hardware machine to settle
;wait while I2C1STAT0.MMA = 1
;
;I2C1CNT = 0
;I2C1ADB1 = I2Cbyte
;I2C1PIR.SCIF = 0
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1PIR.SCIF = 1 then
;HI2C1StateMachine = 2  'Set state Machine to send data
;HI2CAckPollState = I2C1CON1.5
;exit Sub
;
;else
;I2C1CON0.S = 1
;I2C1CON0.RSEN=0
;wait 1 us
;
;end if
;loop
;
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_RESTART_TIMEOUT
;
;end select
;
;End Sub
;
;
;Sub SI2CReceive (Out I2CByte, Optional In HI2CGetAck = 1 )
;
;I2C1CNT = 255
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1STAT1.RXBF = 1 then
;
;I2CByte = I2C1RXB
;exit Sub
;
;else
;
;wait 1 us
;
;end if
;loop
;
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_RXBF_TIMEOUT
;
;
;
;End Sub
;
;Sub SI2CWait4Ack
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1CON1.ACKSTAT = 0 then
;
;HI2CAckPollState = I2C1CON1.ACKSTAT
;exit sub
;
;else
;
;wait 1 us
;
;end if
;loop
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_ACK_TIMEOUT
;' HI2CWaitMSSPTimeout is now TRUE = 255
;End Sub
;
;
;
;Sub SI2Cwait4MDR
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1CON0.MDR = 0 then
;
;exit sub
;
;else
;
;wait 1 us
;
;end if
;loop
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_MDR_TIMEOUT
;' HI2CWaitMSSPTimeout is now TRUE = 255
;End Sub
;
;
;Sub SI2Cwait4Stop
;
;HI2CWaitMSSPTimeout = 0
;
;do while HI2CWaitMSSPTimeout < 255
;
;HI2CWaitMSSPTimeout++
;
;if I2C1PIR.PCIF = 1 then
;
;exit sub
;
;else
;
;wait 1 us
;
;end if
;loop
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
;' HI2CWaitMSSPTimeout is now TRUE = 255
;End Sub
;asm showdebug  GGLCD SSD1306 buffer is 1024bytes
;#DEFINE DO_SH1106         GLCD_DO
;#DEFINE SCK_SH1106        GLCD_SCK
;#DEFINE DC_SH1106         GLCD_DC
;#DEFINE CS_SH1106         GLCD_CS
;#DEFINE RESET_SH1106      GLCD_RESET
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

;SOURCE: GLCD.H (1442)
BOX:
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	MOVFF	LINEX1,SYSWORDTEMPB
	MOVFF	LINEX1_H,SYSWORDTEMPB_H
	MOVFF	LINEX2,SYSWORDTEMPA
	MOVFF	LINEX2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF16
;GLCDTemp = LineX1
	MOVFF	LINEX1,GLCDTEMP
	MOVFF	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	MOVFF	LINEX2,LINEX1
	MOVFF	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	MOVFF	GLCDTEMP,LINEX2
	MOVFF	GLCDTEMP_H,LINEX2_H
;End If
ENDIF16:
;If LineY1 > LineY2 Then
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF17
;GLCDTemp = LineY1
	MOVFF	LINEY1,GLCDTEMP
	MOVFF	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	MOVFF	LINEY2,LINEY1
	MOVFF	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	MOVFF	GLCDTEMP,LINEY2
	MOVFF	GLCDTEMP_H,LINEY2_H
;End If
ENDIF17:
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	MOVLW	1
	SUBWF	LINEX1,W,ACCESS
	MOVWF	DRAWLINE,ACCESS
	MOVLW	0
	SUBWFB	LINEX1_H,W,ACCESS
	MOVWF	DRAWLINE_H,ACCESS
	MOVFF	LINEX1,SYSWORDTEMPB
	MOVFF	LINEX1_H,SYSWORDTEMPB_H
	MOVFF	LINEX2,SYSWORDTEMPA
	MOVFF	LINEX2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND5
SYSFORLOOP5:
	INCF	DRAWLINE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	MOVFF	DRAWLINE,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;PSet DrawLine, LineY2, LineColour
	MOVFF	DRAWLINE,GLCDX
	MOVFF	LINEY2,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;Next
	MOVFF	DRAWLINE,SYSWORDTEMPA
	MOVFF	DRAWLINE_H,SYSWORDTEMPA_H
	MOVFF	LINEX2,SYSWORDTEMPB
	MOVFF	LINEX2_H,SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	MOVLW	1
	SUBWF	LINEY1,W,ACCESS
	MOVWF	DRAWLINE,ACCESS
	MOVLW	0
	SUBWFB	LINEY1_H,W,ACCESS
	MOVWF	DRAWLINE_H,ACCESS
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND6
SYSFORLOOP6:
	INCF	DRAWLINE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	MOVFF	LINEX1,GLCDX
	MOVFF	DRAWLINE,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;PSet LineX2, DrawLine, LineColour
	MOVFF	LINEX2,GLCDX
	MOVFF	DRAWLINE,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;Next
	MOVFF	DRAWLINE,SYSWORDTEMPA
	MOVFF	DRAWLINE_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP6
SYSFORLOOPEND6:
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (1032)
CURSOR_POSITION_SSD1306:
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	MOVFF	LOCY,POSCHARY
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP8
	MOVWF	SYSREPEATTEMP8,BANKED
SYSREPEATLOOP8:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate PosCharY Right
	RRCF	POSCHARY,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP8,F,BANKED
	BRA	SYSREPEATLOOP8
SYSREPEATLOOPEND8:
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	MOVLW	176
	ADDWF	POSCHARY,W,ACCESS
	MOVWF	SSD1306SENDBYTE,ACCESS
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	MOVLW	15
	ANDWF	LOCX,W,ACCESS
	MOVWF	POSCHARX,ACCESS
	CLRF	POSCHARX_H,ACCESS
;Write_Command_SSD1306( PosCharX )
	MOVFF	POSCHARX,SSD1306SENDBYTE
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	MOVFF	LOCX,POSCHARX
	CLRF	POSCHARX_H,ACCESS
;Repeat 4
	MOVLW	4
	BANKSEL	SYSREPEATTEMP8
	MOVWF	SYSREPEATTEMP8,BANKED
SYSREPEATLOOP9:
;Set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate PosCharX Right
	RRCF	POSCHARX_H,F,ACCESS
	RRCF	POSCHARX,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP8,F,BANKED
	BRA	SYSREPEATLOOP9
SYSREPEATLOOPEND9:
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	MOVLW	15
	ANDWF	POSCHARX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	CLRF	SYSTEMP2_H,BANKED
	MOVLW	16
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	POSCHARX,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	POSCHARX_H,ACCESS
;Write_Command_SSD1306 ( PosCharX )
	MOVFF	POSCHARX,SSD1306SENDBYTE
	BANKSEL	0
	GOTO	WRITE_COMMAND_SSD1306

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

GLCDCHARCOL3:
	MOVLW	113
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEGLCDCHARCOL3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEGLCDCHARCOL3
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEGLCDCHARCOL3
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEGLCDCHARCOL3:
	DB	112,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	DB	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	DB	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	DB	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	DB	144,16,120,56,120,136,24,136,0,0,0,32,120
	ALIGN	2;X4

;********************************************************************************

GLCDCHARCOL4:
	MOVLW	113
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEGLCDCHARCOL4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEGLCDCHARCOL4
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEGLCDCHARCOL4
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEGLCDCHARCOL4:
	DB	112,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	DB	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	DB	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	DB	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	DB	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68
	ALIGN	2;X4

;********************************************************************************

GLCDCHARCOL5:
	MOVLW	113
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEGLCDCHARCOL5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEGLCDCHARCOL5
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEGLCDCHARCOL5
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEGLCDCHARCOL5:
	DB	112,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	DB	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	DB	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	DB	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	DB	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	DB	66
	ALIGN	2;X4

;********************************************************************************

GLCDCHARCOL6:
	MOVLW	113
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEGLCDCHARCOL6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEGLCDCHARCOL6
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEGLCDCHARCOL6
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEGLCDCHARCOL6:
	DB	112,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	DB	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	DB	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	DB	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	DB	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68
	ALIGN	2;X4

;********************************************************************************

GLCDCHARCOL7:
	MOVLW	113
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEGLCDCHARCOL7
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEGLCDCHARCOL7
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEGLCDCHARCOL7
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEGLCDCHARCOL7:
	DB	112,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	DB	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	DB	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	DB	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	DB	120,136,120,136,0,0,0,16,120
	ALIGN	2;X4

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (419)
GLCDCLS_SSD1306:
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	CLRF	GLCD_YORDINATE,ACCESS
	CLRF	GLCD_YORDINATE_H,ACCESS
;For SSD1306_BufferLocationCalc = 1 to GLCD_HEIGHT * GLCD_WIDTH / 8
	CLRF	SSD1306_BUFFERLOCATIONCALC,ACCESS
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
SYSFORLOOP7:
	INCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	CLRF	INDF0,ACCESS
;Next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	4
	MOVWF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP7
SYSFORLOOPEND7:
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	MOVLW	248
	MOVWF	SSD1306_BUFFERLOCATIONCALC,ACCESS
	SETF	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
SYSFORLOOP8:
	MOVLW	8
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	MOVLW	0
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	CLRF	LOCX,ACCESS
	MOVFF	SSD1306_BUFFERLOCATIONCALC,LOCY
	RCALL	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	CALL	SI2CSEND
;For GLCDTemp = 0 to 127
	SETF	GLCDTEMP,ACCESS
SYSFORLOOP9:
	INCF	GLCDTEMP,F,ACCESS
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVFF	GLCDBACKGROUND,I2CBYTE
	CALL	SI2CSEND
;Next
	MOVLW	127
	SUBWF	GLCDTEMP,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP9
SYSFORLOOPEND9:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	CALL	SI2CSTOP
;Next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	MOVLW	63
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP8
SYSFORLOOPEND8:
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	CLRF	LOCX,ACCESS
	CLRF	LOCY,ACCESS
	RCALL	CURSOR_POSITION_SSD1306
;PrintLocX =0
	CLRF	PRINTLOCX,ACCESS
;PrintLocY =0
	CLRF	PRINTLOCY,ACCESS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (467)
GLCDDRAWCHAR_SSD1306:
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	MOVFF	LINECOLOUR,SYSWORDTEMPA
	MOVFF	LINECOLOUR_H,SYSWORDTEMPA_H
	MOVFF	GLCDFOREGROUND,SYSWORDTEMPB
	MOVFF	GLCDFOREGROUND_H,SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF27
;Inverted Colours
;GLCDBackground = 1
	MOVLW	1
	MOVWF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	CLRF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF27:
;dim CharCol, CharRow as word
;CharCode -= 15
	MOVLW	15
	SUBWF	CHARCODE,F,ACCESS
;CharCol=0
	CLRF	CHARCOL,ACCESS
	CLRF	CHARCOL_H,ACCESS
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	MOVFF	CHARLOCX,LOCX
	MOVFF	CHARLOCY,LOCY
	RCALL	CURSOR_POSITION_SSD1306
;1.14 Added transaction
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	MOVFF	CHARCODE,SYSBYTETEMPA
	MOVLW	178
	MOVWF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	CHARCODE,SYSBYTETEMPB
	MOVLW	202
	MOVWF	SYSBYTETEMPA,ACCESS
	CALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ANDWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF28
;CharLocY=CharLocY-1
	MOVLW	1
	SUBWF	CHARLOCY,F,ACCESS
	MOVLW	0
	SUBWFB	CHARLOCY_H,F,ACCESS
;end if
ENDIF28:
;For CurrCharCol = 1 to 5
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP10:
	INCF	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SYSSELECT4CASE1:
	DECF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE2
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL3
	MOVWF	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	BRA	SYSSELECTEND4
SYSSELECT4CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE3
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL4
	MOVWF	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	BRA	SYSSELECTEND4
SYSSELECT4CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE4
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL5
	MOVWF	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	BRA	SYSSELECTEND4
SYSSELECT4CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE5
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL6
	MOVWF	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	BRA	SYSSELECTEND4
SYSSELECT4CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND4
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL7
	MOVWF	CURRCHARVAL,ACCESS
;End Select
SYSSELECTEND4:
;Full Memory GLCD mode
;CharRow=0
	CLRF	CHARROW,ACCESS
	CLRF	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
	CLRF	CURRCHARROW,ACCESS
SYSFORLOOP11:
	INCF	CURRCHARROW,F,ACCESS
;CharColS=0
	CLRF	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
	CLRF	COL,ACCESS
	MOVLW	1
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND12
SYSFORLOOP12:
	INCF	COL,F,ACCESS
;CharRowS=0
	CLRF	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
	CLRF	ROW,ACCESS
	MOVLW	1
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND13
SYSFORLOOP13:
	INCF	ROW,F,ACCESS
;if CurrCharVal.0=1 then
	BTFSS	CURRCHARVAL,0,ACCESS
	BRA	ELSE31_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	CHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARROWS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;Else
	BRA	ENDIF31
ELSE31_1:
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	CHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARROWS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;End if
ENDIF31:
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	MOVF	GLCDFONTWIDTH,W,ACCESS
	MULWF	GLCDFNTDEFAULTSIZE,ACCESS
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	GLCDX,ACCESS
	MOVF	CHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARROWS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;CharRowS +=1
	INCF	CHARROWS,F,ACCESS
;Next Row
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	SUBWF	ROW,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP13
SYSFORLOOPEND13:
;CharColS +=1
	INCF	CHARCOLS,F,ACCESS
;Next Col
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	SUBWF	COL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP12
SYSFORLOOPEND12:
;Rotate CurrCharVal Right
	RRCF	CURRCHARVAL,F,ACCESS
;CharRow +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	CHARROW,F,ACCESS
	MOVLW	0
	ADDWFC	CHARROW_H,F,ACCESS
;Next
	MOVLW	8
	SUBWF	CURRCHARROW,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP11
SYSFORLOOPEND11:
;CharCol +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	CHARCOL,F,ACCESS
	MOVLW	0
	ADDWFC	CHARCOL_H,F,ACCESS
;1.14 Low Memory GLCD mode
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Next
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP10
SYSFORLOOPEND10:
;****** OLED Font set handler
;1.14 Added transaction
;Restore
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: 220_I2C_GLCD_SPRITES_USING_SSD1306.GCB (202)
GLCDDRAWSPRITE_SSD1306:
;Dim CurrCharVal, CurrCharCol, SSD1306_Page, GLCDHiChange, GLCDLoChange, GLCDRotateBits, GLCDTemp As Byte
;Calculate device row
;SSD1306_Page = GLCDY
	MOVFF	GLCDY,SSD1306_PAGE
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP1
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP1:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SSD1306_Page Right
	RRCF	SSD1306_PAGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;SSD1306_Page is now the correct ROW
;Calculate buffer element
;SSD1306_BufferLocationCalc = GLCDY AND 0xF8
	MOVLW	248
	ANDWF	GLCDY,W,ACCESS
	MOVWF	SSD1306_BUFFERLOCATIONCALC,ACCESS
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
;Repeat 4
	MOVLW	4
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP2:
;Set c Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SSD1306_BufferLocationCalc Left
	RLCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	RLCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;SSD1306_BufferLocationCalc = (SSD1306_BufferLocationCalc OR GLCDX)
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	IORWF	GLCDX,W,ACCESS
	MOVWF	SSD1306_BUFFERLOCATIONCALC,ACCESS
;Increment as we do not use element 0 in the array
;SSD1306_BufferLocationCalc++
	INCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;SSD1306_BufferLocationCalc is now the correct buffer element
;is the y position of Sprite on a ROW positin 0?
;If ( GLCDY mod 8 ) = 0 Then
	MOVFF	GLCDY,SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB,ACCESS
	BANKSEL	0
	CALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	SYSTEMP1,SYSBYTETEMPA
	CLRF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPEQUAL
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE9_1
;uses GLDX and SS1306_Page variables
;Cursor_Position_SSD1306_Fast
;Macro Source: 220_i2c_glcd_sprites_using_ssd1306.gcb (431)
;Dim I2CByte As Byte
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0xB0 + SSD1306_Page
	MOVLW	176
	ADDWF	SSD1306_PAGE,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	MOVLW	15
	ANDWF	GLCDX,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	MOVFF	GLCDX,SWAP4IN
	CALL	FN_SWAP4
	MOVLW	15
	BANKSEL	SWAP4
	ANDWF	SWAP4,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	16
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	BANKSEL	0
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;Read 8 pixels value into CurrCharVal then write to display
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;For CurrCharCol = 1 To 8
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP1:
	INCF	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, CurrCharVal
SYSSELECT1CASE1:
	DECF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE2
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE1
	MOVWF	CURRCHARVAL,ACCESS
;Case 2: ReadTable sprite2, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE3
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE2
	MOVWF	CURRCHARVAL,ACCESS
;Case 3: ReadTable sprite3, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE4
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE3
	MOVWF	CURRCHARVAL,ACCESS
;Case 4: ReadTable sprite4, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE5
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE4
	MOVWF	CURRCHARVAL,ACCESS
;Case 5: ReadTable sprite5, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE6
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE5
	MOVWF	CURRCHARVAL,ACCESS
;Case 6: ReadTable sprite6, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	6
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE7
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE6
	MOVWF	CURRCHARVAL,ACCESS
;Case 7: ReadTable sprite7, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	7
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE8
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE7
	MOVWF	CURRCHARVAL,ACCESS
;Case 8: ReadTable sprite8, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND1
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	SPRITE8
	MOVWF	CURRCHARVAL,ACCESS
;End Select
SYSSELECTEND1:
;Xor pixels into buffer
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR CurrCharVal
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVF	INDF0,W,ACCESS
	XORWF	CURRCHARVAL,W,ACCESS
	MOVWF	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	GLCDTEMP,INDF0
;Write buffer this will Increment the device point as part of the write operation
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVFF	GLCDTEMP,I2CBYTE
	RCALL	SI2CSEND
;Increment buffer by 1 to match device Increment
;SSD1306_BufferLocationCalc++
	INCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;Next
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	RCALL	SI2CSTOP
;Else
	BRA	ENDIF9
ELSE9_1:
;handle TOP portion of the sprite as we are NOT at 0 pixel of a ROW
;send the TOP pixels
;Cursor_Position_SSD1306_Fast
;Macro Source: 220_i2c_glcd_sprites_using_ssd1306.gcb (431)
;Dim I2CByte As Byte
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0xB0 + SSD1306_Page
	MOVLW	176
	ADDWF	SSD1306_PAGE,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	MOVLW	15
	ANDWF	GLCDX,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	MOVFF	GLCDX,SWAP4IN
	CALL	FN_SWAP4
	MOVLW	15
	BANKSEL	SWAP4
	ANDWF	SWAP4,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	16
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	BANKSEL	0
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;For CurrCharCol = 1 To 8
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP2:
	INCF	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
SYSSELECT2CASE1:
	DECF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE2
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE1
	MOVWF	GLCDHICHANGE,ACCESS
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE3
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE2
	MOVWF	GLCDHICHANGE,ACCESS
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE4
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE3
	MOVWF	GLCDHICHANGE,ACCESS
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE5
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE4
	MOVWF	GLCDHICHANGE,ACCESS
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE6
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE5
	MOVWF	GLCDHICHANGE,ACCESS
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE6:
	MOVLW	6
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE7
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE6
	MOVWF	GLCDHICHANGE,ACCESS
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE7:
	MOVLW	7
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE8
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE7
	MOVWF	GLCDHICHANGE,ACCESS
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	BRA	SYSSELECTEND2
SYSSELECT2CASE8:
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND2
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE8
	MOVWF	GLCDHICHANGE,ACCESS
;End Select
SYSSELECTEND2:
;handle top row
;GLCDRotateBits = GLCDY AND 7
	MOVLW	7
	ANDWF	GLCDY,W,ACCESS
	MOVWF	GLCDROTATEBITS,ACCESS
;Repeat GLCDRotateBits
	MOVFF	GLCDROTATEBITS,SYSREPEATTEMP1
	BANKSEL	SYSREPEATTEMP1
	MOVF	SYSREPEATTEMP1,F,BANKED
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND3
SYSREPEATLOOP3:
;Set c Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate GLCDHiChange Left
	RLCF	GLCDHICHANGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR GLCDHiChange
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVF	INDF0,W,ACCESS
	XORWF	GLCDHICHANGE,W,ACCESS
	MOVWF	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	GLCDTEMP,INDF0
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVFF	GLCDTEMP,I2CBYTE
	BANKSEL	0
	RCALL	SI2CSEND
;SSD1306_BufferLocationCalc++
	INCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;Next
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	RCALL	SI2CSTOP
;handle BOTTOM pixels of the sprite
;Increment to the next ROW
;SSD1306_Page++
	INCF	SSD1306_PAGE,F,ACCESS
;Cursor_Position_SSD1306_Fast
;Macro Source: 220_i2c_glcd_sprites_using_ssd1306.gcb (431)
;Dim I2CByte As Byte
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0xB0 + SSD1306_Page
	MOVLW	176
	ADDWF	SSD1306_PAGE,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;lower nibble
;I2CByte = ( GLCDX  & 0x0f )
	MOVLW	15
	ANDWF	GLCDX,W,ACCESS
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;I2CByte = ( SWAP4(GLCDX) & 0x0F ) + 0x10
	MOVFF	GLCDX,SWAP4IN
	RCALL	FN_SWAP4
	MOVLW	15
	BANKSEL	SWAP4
	ANDWF	SWAP4,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	16
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	I2CBYTE,ACCESS
;HI2CSend I2CByte
	BANKSEL	0
	RCALL	SI2CSEND
;HI2CStop
	RCALL	SI2CSTOP
;Move buffer pointet to the next row/buffer which is 128 bytes, but, the top half of the buffer has been write... 8 bytes.
;So 128-8 = 120
;SSD1306_BufferLocationCalc = SSD1306_BufferLocationCalc  + 120
	MOVLW	120
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	MOVLW	0
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;For CurrCharCol = 1 To 8
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP3:
	INCF	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable sprite1, CharCode, GLCDHiChange
SYSSELECT3CASE1:
	DECF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE2
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE1
	MOVWF	GLCDHICHANGE,ACCESS
;Case 2: ReadTable sprite2, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE3
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE2
	MOVWF	GLCDHICHANGE,ACCESS
;Case 3: ReadTable sprite3, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE4
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE3
	MOVWF	GLCDHICHANGE,ACCESS
;Case 4: ReadTable sprite4, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE5
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE4
	MOVWF	GLCDHICHANGE,ACCESS
;Case 5: ReadTable sprite5, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE6
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE5
	MOVWF	GLCDHICHANGE,ACCESS
;Case 6: ReadTable sprite6, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE6:
	MOVLW	6
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE7
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE6
	MOVWF	GLCDHICHANGE,ACCESS
;Case 7: ReadTable sprite7, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE7:
	MOVLW	7
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE8
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE7
	MOVWF	GLCDHICHANGE,ACCESS
;Case 8: ReadTable sprite8, CharCode, GLCDHiChange
	BRA	SYSSELECTEND3
SYSSELECT3CASE8:
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND3
	MOVFF	CHARCODE,SYSSTRINGA
	RCALL	SPRITE8
	MOVWF	GLCDHICHANGE,ACCESS
;End Select
SYSSELECTEND3:
;GLCDLoChange = 0
	CLRF	GLCDLOCHANGE,ACCESS
;Repeat GLCDRotateBits
	MOVFF	GLCDROTATEBITS,SYSREPEATTEMP1
	BANKSEL	SYSREPEATTEMP1
	MOVF	SYSREPEATTEMP1,F,BANKED
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND4
SYSREPEATLOOP4:
;Set c Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;as bits move to left C is set... moving in GLCDLoChange in the next command
;Rotate GLCDHiChange Left
	RLCF	GLCDHICHANGE,F,ACCESS
;Rotate GLCDLoChange Left
	RLCF	GLCDLOCHANGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP4
SYSREPEATLOOPEND4:
;GLCDTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc) XOR GLCDLoChange
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVF	INDF0,W,ACCESS
	XORWF	GLCDLOCHANGE,W,ACCESS
	MOVWF	GLCDTEMP,ACCESS
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDTemp
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	GLCDTEMP,INDF0
;Write_Transaction_Data_SSD1306(GLCDTemp)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVFF	GLCDTEMP,I2CBYTE
	BANKSEL	0
	RCALL	SI2CSEND
;SSD1306_BufferLocationCalc++
	INCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;Next
	MOVLW	8
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	RCALL	SI2CSTOP
;End If
ENDIF9:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:STRING:, SOURCE: GLCD.H (934)
GLCDPRINT6:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
;A6: ASM Source was:  MOVFF SYSLCDPRINTDATAHANDLER,AFSR0
	MOVFF	SYSLCDPRINTDATAHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSLCDPRINTDATAHANDLER_H,AFSR0_H
	MOVFF	SYSLCDPRINTDATAHANDLER_H,FSR0H
	MOVFF	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	MOVF	GLCDPRINTLEN,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	RETURN
;GLCDPrintLoc = PrintLocX
	MOVFF	PRINTLOCX,GLCDPRINTLOC
	MOVFF	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	CLRF	GLCDPRINT_STRING_COUNTER,ACCESS
	MOVLW	1
	SUBWF	GLCDPRINTLEN,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	MOVFF	GLCDPRINTLOC,CHARLOCX
	MOVFF	GLCDPRINTLOC_H,CHARLOCX_H
	MOVFF	PRINTLOCY,CHARLOCY
	MOVFF	PRINTLOCY_H,CHARLOCY_H
	MOVF	GLCDPRINT_STRING_COUNTER,W,ACCESS
	BANKSEL	SYSLCDPRINTDATAHANDLER
	ADDWF	SYSLCDPRINTDATAHANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSLCDPRINTDATAHANDLER_H,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,CHARCODE
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	RCALL	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W,ACCESS
	MULWF	GLCDFNTDEFAULTSIZE,ACCESS
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	GLCDPRINTLOC,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	MOVLW	0
	ADDWFC	GLCDPRINTLOC_H,W,ACCESS
	MOVWF	SYSTEMP2_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	GLCDPRINTLOC,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	GLCDPRINTLOC_H,ACCESS
;Next
	MOVF	GLCDPRINTLEN,W,ACCESS
	SUBWF	GLCDPRINT_STRING_COUNTER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVFF	GLCDPRINTLOC,PRINTLOCX
	MOVFF	GLCDPRINTLOC_H,PRINTLOCX_H
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (698)
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE,ACCESS
;Initialise the I2C module
;SI2CInit
	BRA	SI2CINIT

;********************************************************************************

;SOURCE: HWI2C.H (249)
HI2CMODE:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (309)
INITGLCD_SSD1306:
;Colours //Set these first
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
;GLCDFontWidth = 5
	MOVLW	5
	MOVWF	GLCDFONTWIDTH,ACCESS
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	MOVLW	7
	MOVWF	GLCDFNTDEFAULTHEIGHT,ACCESS
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	CLRF	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	MOVLW	1
	MOVWF	GLCDFNTDEFAULTSIZE,ACCESS
;wait 255 ms             'added to ensure the charge pump and power is operational.
	SETF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	CALL	DELAY_MS
;HI2CMode Master
	MOVLW	12
	MOVWF	HI2CCURRENTMODE,ACCESS
	RCALL	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	MOVLW	15
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	CALL	DELAY_MS
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	MOVLW	174
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	MOVLW	46
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	MOVLW	213
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	MOVLW	128
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	MOVLW	168
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	MOVLW	63
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	MOVLW	211
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	CLRF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	MOVLW	64
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	MOVLW	141
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	MOVLW	20
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	MOVLW	32
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	MOVLW	16
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	MOVLW	161
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	MOVLW	200
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	MOVLW	218
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	MOVLW	18
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	MOVLW	129
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	MOVLW	207
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	MOVLW	217
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	MOVLW	241
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	MOVLW	219
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	MOVLW	64
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	MOVLW	164
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	MOVLW	166
	MOVWF	SSD1306SENDBYTE,ACCESS
	RCALL	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	RCALL	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	MOVLW	175
	MOVWF	SSD1306SENDBYTE,ACCESS
	BRA	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: 220_I2C_GLCD_SPRITES_USING_SSD1306.GCB (32)
INITPPS:
;Module: I2C1
;I2C1SDAPPS = 0x0C;   //RB4->I2C1:SDA1;
	MOVLW	12
BANKSEL	I2C1SDAPPS
	MOVWF	I2C1SDAPPS,BANKED
;RB6PPS = 0x21;   //RB6->I2C1:SCL1;
	MOVLW	33
	MOVWF	RB6PPS,BANKED
;RB4PPS = 0x22;   //RB4->I2C1:SDA1;
	MOVLW	34
	MOVWF	RB4PPS,BANKED
;I2C1SCLPPS = 0x0E;   //RB6->I2C1:SCL1;
	MOVLW	14
	MOVWF	I2C1SCLPPS,BANKED
;Module: UART pin directions
;Dir PORTC.6 Out    ' Make TX1 pin an output
	BCF	TRISC,6,ACCESS
;Module: UART1
;RC6PPS = 0x0010    'TX1 > RC6
	MOVLW	16
	MOVWF	RC6PPS,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: RANDOM.H (28)
INITRANDOM:
;Dim RandomSeed As Word
;RandomSeed = RandStart
	MOVLW	231
	MOVWF	RANDOMSEED,ACCESS
	MOVLW	230
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

;SOURCE: GLCD_SSD1306.H (875)
PSET_SSD1306:
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;anything off screen with be rejected
;if GLCDX => GLCD_WIDTH OR GLCDY => GLCD_HEIGHT Then
	MOVFF	GLCDX,SYSBYTETEMPA
	MOVLW	128
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	GLCDY,SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	IORWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF36
;exit sub
	BANKSEL	0
	RETURN
;end if
ENDIF36:
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	MOVFF	GLCDY,SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
;Repeat 3
	MOVLW	3
	MOVWF	SYSREPEATTEMP5,BANKED
SYSREPEATLOOP5:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SSD1306_BufferLocationCalc Right
	RRCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
	RRCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP5,F,BANKED
	BRA	SYSREPEATLOOP5
SYSREPEATLOOPEND5:
;faster than * 128
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Repeat 7
	MOVLW	7
	MOVWF	SYSREPEATTEMP5,BANKED
SYSREPEATLOOP6:
;Rotate SSD1306_BufferLocationCalc Left
	RLCF	SSD1306_BUFFERLOCATIONCALC,F,ACCESS
	RLCF	SSD1306_BUFFERLOCATIONCALC_H,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP5,F,BANKED
	BRA	SYSREPEATLOOP6
SYSREPEATLOOPEND6:
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
	ADDWF	GLCDX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	CLRF	SYSTEMP1,BANKED
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
	ADDWFC	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP2_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	SSD1306_BUFFERLOCATIONCALC,ACCESS
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	SSD1306_BUFFERLOCATIONCALC_H,ACCESS
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPB
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA,ACCESS
	MOVLW	32
	MOVWF	SYSWORDTEMPA_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
;exit sub
	RETURN
;end if
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	MOVLW	7
	ANDWF	GLCDY,W,ACCESS
	MOVWF	GLCDBITNO,ACCESS
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0,ACCESS
	BRA	ELSE38_1
;GLCDChange = 254
	MOVLW	254
	MOVWF	GLCDCHANGE,ACCESS
;Set C On
;A8: ASM Source was:  BSF STATUS,C,ACCESS
	BSF	STATUS,0,ACCESS
;Else
	BRA	ENDIF38
ELSE38_1:
;GLCDChange = 1
	MOVLW	1
	MOVWF	GLCDCHANGE,ACCESS
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;End If
ENDIF38:
;Repeat GLCDBitNo
	MOVFF	GLCDBITNO,SYSREPEATTEMP5
	BANKSEL	SYSREPEATTEMP5
	MOVF	SYSREPEATTEMP5,F,BANKED
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND7
SYSREPEATLOOP7:
;Rotate GLCDChange Left
	RLCF	GLCDCHANGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP5,F,BANKED
	BRA	SYSREPEATLOOP7
SYSREPEATLOOPEND7:
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0,ACCESS
	BRA	ELSE39_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	ANDWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;Else
	BRA	ENDIF39
ELSE39_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	IORWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;End If
ENDIF39:
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVF	GLCDDATATEMP,W,ACCESS
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ENDIF40
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,ACCESS
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	GLCDDATATEMP,INDF0
;Cursor_Position_SSD1306 ( GLCDX, GLCDY )
	MOVFF	GLCDX,LOCX
	MOVFF	GLCDY,LOCY
	BANKSEL	0
	CALL	CURSOR_POSITION_SSD1306
;Write_Data_SSD1306 ( GLCDDataTemp )
	MOVFF	GLCDDATATEMP,SSD1306SENDBYTE
	RCALL	WRITE_DATA_SSD1306
;end if
ENDIF40:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: RANDOM.H (34)
FN_RANDOM:
;Repeat 7
	MOVLW	7
	BANKSEL	SYSREPEATTEMP10
	MOVWF	SYSREPEATTEMP10,BANKED
SYSREPEATLOOP10:
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
	MOVWF	SYSTEMP2,BANKED
	CLRF	SYSTEMP2_H,BANKED
	COMF	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	COMF	SYSTEMP2_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	SYSTEMP2_H,BANKED
	CLRF	SYSTEMP1,BANKED
	MOVLW	180
	ANDWF	SYSTEMP2_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVF	RANDOMTEMP,W,ACCESS
	XORWF	SYSTEMP1,W,BANKED
	MOVWF	RANDOMSEED,ACCESS
	MOVF	RANDOMTEMP_H,W,ACCESS
	XORWF	SYSTEMP1_H,W,BANKED
	MOVWF	RANDOMSEED_H,ACCESS
;Random = Random Xor RandomSeed_H
	MOVF	RANDOM,W,ACCESS
	XORWF	RANDOMSEED_H,W,ACCESS
	MOVWF	RANDOM,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP10,F,BANKED
	BRA	SYSREPEATLOOP10
SYSREPEATLOOPEND10:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (763)
SI2CINIT:
;asm showdebug  This method sets the MSSP modules for K42s family chips
;Dir HI2C_DATA out
	BCF	TRISB,4,ACCESS
;Dir HI2C_CLOCK out
	BCF	TRISB,6,ACCESS
;I2C1CON1 = I2C1I2C1CON1Default
	MOVLW	128
BANKSEL	I2C1CON1
	MOVWF	I2C1CON1,BANKED
;I2C1CON2 = I2C1I2C1CON2Default
	MOVLW	33
	MOVWF	I2C1CON2,BANKED
;I2C1CLK =  I2C1CLOCKSOURCE
	MOVLW	3
	MOVWF	I2C1CLK,BANKED
;I2C1CON0 = I2C1I2C1CON0Default
	MOVLW	4
	MOVWF	I2C1CON0,BANKED
;I2C1PIR = 0    ;Clear all the error flags
	CLRF	I2C1PIR,BANKED
;I2C1ERR = 0
	CLRF	I2C1ERR,BANKED
;I2C1CON0.EN=1
;A8: ASM Source was:  BSF I2C1CON0,EN,BANKED
	BSF	I2C1CON0,7,BANKED
;Commence I2C protocol
;I2C1CON2.ACNT = 0
;A8: ASM Source was:  BCF I2C1CON2,ACNT,BANKED
	BCF	I2C1CON2,7,BANKED
;I2C1CON2.ABD=0
;A8: ASM Source was:  BCF I2C1CON2,ABD,BANKED
	BCF	I2C1CON2,4,BANKED
;I2C1CON0.MDR=1
;A8: ASM Source was:  BSF I2C1CON0,MDR,BANKED
	BSF	I2C1CON0,3,BANKED
;Initialise correct state of I2C module. Not sure why this is needed but it is. Microchip failed to explain why this is required. But, it is.
;SI2CStart
	BANKSEL	0
	RCALL	SI2CSTART
;SI2CSend ( 0xff )
	SETF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;SI2CStop
	RCALL	SI2CSTOP
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE,ACCESS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (840)
SI2CSEND:
;asm showdebug  Redirected for K42 family probalby called HI2CSend
;asm showdebug  This method sets the registers and register bits to send I2C data
;This is now a state Machine to cater for the new approach with the I2C module
;Select Case HI2C1StateMachine
;case 2  'send data
SYSSELECT5CASE1:
	MOVLW	2
	SUBWF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT5CASE2
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S3:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E3
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1STAT1.TXBE = 1 then
BANKSEL	I2C1STAT1
;A8: ASM Source was:  BTFSS I2C1STAT1,TXBE,BANKED
	BTFSS	I2C1STAT1,5,BANKED
	BRA	ELSE43_1
;Set the byte count to 1, place outbyte in register, and wait for hardware state machine
;I2C1CNT = 1
	MOVLW	1
	MOVWF	I2C1CNTL,BANKED
;I2C1TXB = I2Cbyte
	MOVFF	I2CBYTE,I2C1TXB
;SI2CWait4Ack
	BANKSEL	0
	RCALL	SI2CWAIT4ACK
;SI2Cwait4MDR
	RCALL	SI2CWAIT4MDR
;exit Sub
	RETURN
;else
	BRA	ENDIF43
ELSE43_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS4:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS4
;end if
ENDIF43:
;loop
	BRA	SYSDOLOOP_S3
SYSDOLOOP_E3:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_TXBE_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF44
	MOVLW	2
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF44:
;case 1  'A start
	BRA	SYSSELECTEND5
SYSSELECT5CASE2:
	DECF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT5CASE3
;Clear the output buffers, set byte count to zero, clear event and place Slave Address in register
;I2C1STAT1.CLRBF = 1
BANKSEL	I2C1STAT1
;A8: ASM Source was:  BSF I2C1STAT1,CLRBF,BANKED
	BSF	I2C1STAT1,2,BANKED
;I2C1CNT = 0
	CLRF	I2C1CNTL,BANKED
;I2C1PIR.SCIF = 0
;A8: ASM Source was:  BCF I2C1PIR,SCIF,BANKED
	BCF	I2C1PIR,0,BANKED
;I2C1ADB1 = I2Cbyte
	MOVFF	I2CBYTE,I2C1ADB1
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S4:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E4
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.SCIF = 1 then
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE45_1
;HI2C1StateMachine = 2  'Set state Machine to send data
	MOVLW	2
	MOVWF	HI2C1STATEMACHINE,ACCESS
;HI2CAckPollState = I2C1CON1.5
	CLRF	HI2CACKPOLLSTATE,ACCESS
	BTFSC	I2C1CON1,5,BANKED
	INCF	HI2CACKPOLLSTATE,F,ACCESS
;exit Sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF45
ELSE45_1:
;Set to start
;I2C1CON0.S = 1
;A8: ASM Source was:  BSF I2C1CON0,S,BANKED
	BSF	I2C1CON0,5,BANKED
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS5:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS5
;end if
ENDIF45:
;loop
	BRA	SYSDOLOOP_S4
SYSDOLOOP_E4:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_START_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF46
	MOVLW	4
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF46:
;case 3  'A restart
	BRA	SYSSELECTEND5
SYSSELECT5CASE3:
	MOVLW	3
	SUBWF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND5
;wait for hardware machine to settle
;wait while I2C1STAT0.MMA = 1
SYSWAITLOOP1:
BANKSEL	I2C1STAT0
;A8: ASM Source was:  BTFSC I2C1STAT0,MMA,BANKED
	BTFSC	I2C1STAT0,5,BANKED
	BRA	SYSWAITLOOP1
;set count to zero, place Slave address in register and clear event
;I2C1CNT = 0
	CLRF	I2C1CNTL,BANKED
;I2C1ADB1 = I2Cbyte
	MOVFF	I2CBYTE,I2C1ADB1
;I2C1PIR.SCIF = 0
;A8: ASM Source was:  BCF I2C1PIR,SCIF,BANKED
	BCF	I2C1PIR,0,BANKED
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S5:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E5
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.SCIF = 1 then
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE47_1
;HI2C1StateMachine = 2  'Set state Machine to send data
	MOVLW	2
	MOVWF	HI2C1STATEMACHINE,ACCESS
;HI2CAckPollState = I2C1CON1.5
	CLRF	HI2CACKPOLLSTATE,ACCESS
	BTFSC	I2C1CON1,5,BANKED
	INCF	HI2CACKPOLLSTATE,F,ACCESS
;exit Sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF47
ELSE47_1:
;Set as Start and Clear Restart
;I2C1CON0.S = 1
;A8: ASM Source was:  BSF I2C1CON0,S,BANKED
	BSF	I2C1CON0,5,BANKED
;I2C1CON0.RSEN=0
;A8: ASM Source was:  BCF I2C1CON0,RSEN,BANKED
	BCF	I2C1CON0,6,BANKED
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS6:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS6
;end if
ENDIF47:
;loop
	BRA	SYSDOLOOP_S5
SYSDOLOOP_E5:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_RESTART_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF48
	MOVLW	8
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF48:
;end select
SYSSELECTEND5:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (792)
SI2CSTART:
;asm showdebug  Redirected for K42 family probalby called HI2CStart
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal. Master_mode only.
;HI2C1StateMachine = 1
	MOVLW	1
	MOVWF	HI2C1STATEMACHINE,ACCESS
;HI2CWaitMSSPTimeout = false
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;Clear the error state variable
;HI2C1lastError = I2C1_GOOD
	CLRF	HI2C1LASTERROR,ACCESS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (811)
SI2CSTOP:
;asm showdebug  Redirected for K42 family probalby called HI2CStop
;asm showdebug  This method sets the registers and register bits to generate the I2C  STOP signal
;Waits up to 254us then set the error state
;HI2C1StateMachine = 0
	CLRF	HI2C1STATEMACHINE,ACCESS
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S2:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E2
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait till this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE41_1
;SI2Cwait4Stop
	BANKSEL	0
	RCALL	SI2CWAIT4STOP
;TSCL wait, part of the specificiation of the I2C Module
;wait HI2CITSCLWaitPeriod us
	MOVLW	1
	MOVWF	DELAYTEMP2,ACCESS
DELAYUSO1:
	CLRF	DELAYTEMP,ACCESS
DELAYUS1:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS1
	DECFSZ	DELAYTEMP2,F,ACCESS
	BRA	DELAYUSO1
	MOVLW	116
	MOVWF	DELAYTEMP,ACCESS
DELAYUS2:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS2
;exit sub
	RETURN
;else
	BRA	ENDIF41
ELSE41_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS3:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS3
;end if
ENDIF41:
;loop
	BRA	SYSDOLOOP_S2
SYSDOLOOP_E2:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF42
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF42:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (971)
SI2CWAIT4ACK:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S6:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E6
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1CON1.ACKSTAT = 0 then
BANKSEL	I2C1CON1
;A8: ASM Source was:  BTFSC I2C1CON1,ACKSTAT,BANKED
	BTFSC	I2C1CON1,5,BANKED
	BRA	ELSE51_1
;Set status
;HI2CAckPollState = I2C1CON1.ACKSTAT
	CLRF	HI2CACKPOLLSTATE,ACCESS
;A8: ASM Source was:  BTFSC I2C1CON1,ACKSTAT,BANKED
	BTFSC	I2C1CON1,5,BANKED
	INCF	HI2CACKPOLLSTATE,F,ACCESS
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF51
ELSE51_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS7:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS7
;end if
ENDIF51:
;loop
	BRA	SYSDOLOOP_S6
SYSDOLOOP_E6:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_ACK_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF52
	MOVLW	32
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF52:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (996)
SI2CWAIT4MDR:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S7:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E7
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;wait for this event
;if I2C1CON0.MDR = 0 then
BANKSEL	I2C1CON0
;A8: ASM Source was:  BTFSC I2C1CON0,MDR,BANKED
	BTFSC	I2C1CON0,3,BANKED
	BRA	ELSE54_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF54
ELSE54_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS8:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS8
;end if
ENDIF54:
;loop
	BRA	SYSDOLOOP_S7
SYSDOLOOP_E7:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_MDR_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF55
	MOVLW	64
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF55:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (1019)
SI2CWAIT4STOP:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,ACCESS
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S8:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E8
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE56_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF56
ELSE56_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS9:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS9
;end if
ENDIF56:
;loop
	BRA	SYSDOLOOP_S8
SYSDOLOOP_E8:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF57
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF57:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

SPRITE1:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE1
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE1
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE1
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE1:
	DB	8,0,0,128,255,56,0,0,255
	ALIGN	2;X4

;********************************************************************************

SPRITE2:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE2
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE2
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE2:
	DB	8,0,60,64,255,68,0,60,195
	ALIGN	2;X4

;********************************************************************************

SPRITE3:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE3
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE3
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE3:
	DB	8,0,90,32,255,130,60,102,165
	ALIGN	2;X4

;********************************************************************************

SPRITE4:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE4
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE4
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE4:
	DB	8,0,90,16,255,24,60,90,165
	ALIGN	2;X4

;********************************************************************************

SPRITE5:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE5
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE5
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE5:
	DB	8,0,90,8,255,130,60,90,165
	ALIGN	2;X4

;********************************************************************************

SPRITE6:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE6
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE6
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE6:
	DB	8,0,90,4,255,68,60,102,165
	ALIGN	2;X4

;********************************************************************************

SPRITE7:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE7
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE7
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE7
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE7:
	DB	8,0,60,2,255,56,0,60,195
	ALIGN	2;X4

;********************************************************************************

SPRITE8:
	MOVLW	9
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESPRITE8
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESPRITE8
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESPRITE8
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESPRITE8:
	DB	8,0,0,1,255,0,0,0,255
	ALIGN	2;X4

;********************************************************************************

;SOURCE: STDBASIC.H (300)
FN_SWAP4:
;swapf Swap4In, W
	BANKSEL	SWAP4IN
	SWAPF	SWAP4IN, W,BANKED
;movwf swap4
	MOVWF	SWAP4,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2868)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	SETF	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	CPFSEQ	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
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
	DB	15,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67

	ALIGN	2;X3

STRINGTABLE2:
	DB	17,71,76,67,68,32,76,105,98,114,97,114,121,32,50,48,50,49

	ALIGN	2;X3

STRINGTABLE3:
	DB	14,83,112,114,105,116,101,32,83,117,112,112,111,114,116

	ALIGN	2;X3

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (216)
WRITE_COMMAND_SSD1306:
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend SSD1306SendByte
	MOVFF	SSD1306SENDBYTE,I2CBYTE
	RCALL	SI2CSEND
;HI2CStop
	BRA	SI2CSTOP

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (262)
WRITE_DATA_SSD1306:
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	RCALL	SI2CSEND
;HI2CSend SSD1306SendByte
	MOVFF	SSD1306SENDBYTE,I2CBYTE
	RCALL	SI2CSEND
;HI2CStop
	BRA	SI2CSTOP

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
