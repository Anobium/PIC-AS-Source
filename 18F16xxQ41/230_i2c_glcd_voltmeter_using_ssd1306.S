;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\230_i2c_glcd_voltmeter_using_ssd1306.S"
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
 ADCVAL                           EQU 1294                    ; 0X50E
 ADCVAL_H                         EQU 1295                    ; 0X50F
 ADREADPORT                       EQU 1296                    ; 0X510
 ANGLE                            EQU 1297                    ; 0X511
 ANGLE_H                          EQU 1298                    ; 0X512
 ASC                              EQU 1299                    ; 0X513
 CHARCODE                         EQU 1300                    ; 0X514
 CHARCOL                          EQU 1301                    ; 0X515
 CHARCOLS                         EQU 1303                    ; 0X517
 CHARCOL_H                        EQU 1302                    ; 0X516
 CHARLOCX                         EQU 1304                    ; 0X518
 CHARLOCX_H                       EQU 1305                    ; 0X519
 CHARLOCY                         EQU 1306                    ; 0X51A
 CHARLOCY_H                       EQU 1307                    ; 0X51B
 CHARROW                          EQU 1308                    ; 0X51C
 CHARROWS                         EQU 1310                    ; 0X51E
 CHARROW_H                        EQU 1309                    ; 0X51D
 COL                              EQU 1311                    ; 0X51F
 COS                              EQU 1312                    ; 0X520
 COS_H                            EQU 1313                    ; 0X521
 CURRCHARCOL                      EQU 1314                    ; 0X522
 CURRCHARROW                      EQU 1315                    ; 0X523
 CURRCHARVAL                      EQU 1316                    ; 0X524
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 DRAWLINE                         EQU 1317                    ; 0X525
 DRAWLINE_H                       EQU 1318                    ; 0X526
 GLCDBACKGROUND                   EQU 1319                    ; 0X527
 GLCDBACKGROUND_H                 EQU 1320                    ; 0X528
 GLCDBITNO                        EQU 1321                    ; 0X529
 GLCDCHANGE                       EQU 1322                    ; 0X52A
 GLCDCOLOUR                       EQU 1323                    ; 0X52B
 GLCDCOLOUR_H                     EQU 1324                    ; 0X52C
 GLCDDATATEMP                     EQU 1325                    ; 0X52D
 GLCDFNTDEFAULT                   EQU 1326                    ; 0X52E
 GLCDFNTDEFAULTHEIGHT             EQU 1327                    ; 0X52F
 GLCDFNTDEFAULTSIZE               EQU 1328                    ; 0X530
 GLCDFONTWIDTH                    EQU 1329                    ; 0X531
 GLCDFOREGROUND                   EQU 1330                    ; 0X532
 GLCDFOREGROUND_H                 EQU 1331                    ; 0X533
 GLCDPRINTLEN                     EQU 1332                    ; 0X534
 GLCDPRINTLOC                     EQU 1333                    ; 0X535
 GLCDPRINTLOC_H                   EQU 1334                    ; 0X536
 GLCDPRINT_STRING_COUNTER         EQU 1335                    ; 0X537
 GLCDTEMP                         EQU 1336                    ; 0X538
 GLCDTEMP_H                       EQU 1337                    ; 0X539
 GLCDX                            EQU 1338                    ; 0X53A
 GLCDY                            EQU 1339                    ; 0X53B
 GLCD_YORDINATE                   EQU 1340                    ; 0X53C
 GLCD_YORDINATE_H                 EQU 1341                    ; 0X53D
 HI2C1LASTERROR                   EQU 1342                    ; 0X53E
 HI2C1STATEMACHINE                EQU 1343                    ; 0X53F
 HI2CACKPOLLSTATE                 EQU 1344                    ; 0X540
 HI2CCURRENTMODE                  EQU 1345                    ; 0X541
 HI2CWAITMSSPTIMEOUT              EQU 1346                    ; 0X542
 I2CBYTE                          EQU 1347                    ; 0X543
 LEFT                             EQU 4310                    ; 0X10D6
 LINECOLOUR                       EQU 1348                    ; 0X544
 LINECOLOUR_H                     EQU 1349                    ; 0X545
 LINEDIFFX                        EQU 1350                    ; 0X546
 LINEDIFFX_H                      EQU 1351                    ; 0X547
 LINEDIFFX_X2                     EQU 1352                    ; 0X548
 LINEDIFFX_X2_H                   EQU 1353                    ; 0X549
 LINEDIFFY                        EQU 1354                    ; 0X54A
 LINEDIFFY_H                      EQU 1355                    ; 0X54B
 LINEDIFFY_X2                     EQU 1356                    ; 0X54C
 LINEDIFFY_X2_H                   EQU 1357                    ; 0X54D
 LINEERR                          EQU 1358                    ; 0X54E
 LINEERR_H                        EQU 1359                    ; 0X54F
 LINESTEPX                        EQU 1360                    ; 0X550
 LINESTEPX_H                      EQU 1361                    ; 0X551
 LINESTEPY                        EQU 1362                    ; 0X552
 LINESTEPY_H                      EQU 1363                    ; 0X553
 LINEX1                           EQU 1364                    ; 0X554
 LINEX1_H                         EQU 1365                    ; 0X555
 LINEX2                           EQU 1366                    ; 0X556
 LINEX2_H                         EQU 1367                    ; 0X557
 LINEY1                           EQU 1368                    ; 0X558
 LINEY1_H                         EQU 1369                    ; 0X559
 LINEY2                           EQU 1370                    ; 0X55A
 LINEY2_H                         EQU 1371                    ; 0X55B
 LOCX                             EQU 1372                    ; 0X55C
 LOCY                             EQU 1373                    ; 0X55D
 L_CALIBRATE                      EQU 1374                    ; 0X55E
 L_CALIBRATE_H                    EQU 1375                    ; 0X55F
 L_FROMHIGH                       EQU 1376                    ; 0X560
 L_FROMHIGH_H                     EQU 1377                    ; 0X561
 L_FROMLOW                        EQU 1378                    ; 0X562
 L_FROMLOW_H                      EQU 1379                    ; 0X563
 L_MAP                            EQU 1380                    ; 0X564
 L_MAP_H                          EQU 1381                    ; 0X565
 L_SYSCALC                        EQU 1382                    ; 0X566
 L_SYSCALCF                       EQU 1384                    ; 0X568
 L_SYSCALCF_E                     EQU 1387                    ; 0X56B
 L_SYSCALCF_H                     EQU 1385                    ; 0X569
 L_SYSCALCF_U                     EQU 1386                    ; 0X56A
 L_SYSCALC_H                      EQU 1383                    ; 0X567
 L_TOHIGH                         EQU 1388                    ; 0X56C
 L_TOHIGH_H                       EQU 1389                    ; 0X56D
 L_TOLOW                          EQU 1390                    ; 0X56E
 L_TOLOW_H                        EQU 1391                    ; 0X56F
 MID                              EQU 4269                    ; 0X10AD
 OLD_ANGLE                        EQU 1392                    ; 0X570
 OLD_ANGLE_H                      EQU 1393                    ; 0X571
 OLD_XEND                         EQU 1394                    ; 0X572
 OLD_YEND                         EQU 1395                    ; 0X573
 POSCHARX                         EQU 1396                    ; 0X574
 POSCHARX_H                       EQU 1397                    ; 0X575
 POSCHARY                         EQU 1398                    ; 0X576
 PRINTLOCX                        EQU 1399                    ; 0X577
 PRINTLOCX_H                      EQU 1400                    ; 0X578
 PRINTLOCY                        EQU 1401                    ; 0X579
 PRINTLOCY_H                      EQU 1402                    ; 0X57A
 RADIUS                           EQU 1403                    ; 0X57B
 READAD                           EQU 1404                    ; 0X57C
 ROW                              EQU 1405                    ; 0X57D
 SCALE                            EQU 1406                    ; 0X57E
 SCALE_H                          EQU 1407                    ; 0X57F
 SIN                              EQU 1408                    ; 0X580
 SIN_H                            EQU 1409                    ; 0X581
 SSD1306SENDBYTE                  EQU 1410                    ; 0X582
 SSD1306_BUFFERALIAS              EQU 4351                    ; 0X10FF
 SSD1306_BUFFERLOCATIONCALC       EQU 1411                    ; 0X583
 SSD1306_BUFFERLOCATIONCALC_H     EQU 1412                    ; 0X584
 STR                              EQU 4263                    ; 0X10A7
 STRINGPOINTER                    EQU 1413                    ; 0X585
 SYSARRAYTEMP1                    EQU 1414                    ; 0X586
 SYSARRAYTEMP2                    EQU 1415                    ; 0X587
 SYSBYTETEMPA                     EQU 1285                    ; 0X505
 SYSBYTETEMPB                     EQU 1289                    ; 0X509
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSCALCTEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPX_H                   EQU 1281                    ; 0X501
 SYSCHAR                          EQU 1416                    ; 0X588
 SYSCHARCOUNT                     EQU 1417                    ; 0X589
 SYSCHARSTART                     EQU 1418                    ; 0X58A
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSDIVMULTA                      EQU 1287                    ; 0X507
 SYSDIVMULTA_H                    EQU 1288                    ; 0X508
 SYSDIVMULTB                      EQU 1291                    ; 0X50B
 SYSDIVMULTB_H                    EQU 1292                    ; 0X50C
 SYSDIVMULTX                      EQU 1282                    ; 0X502
 SYSDIVMULTX_H                    EQU 1283                    ; 0X503
 SYSINTEGERTEMPA                  EQU 1285                    ; 0X505
 SYSINTEGERTEMPA_H                EQU 1286                    ; 0X506
 SYSINTEGERTEMPB                  EQU 1289                    ; 0X509
 SYSINTEGERTEMPB_H                EQU 1290                    ; 0X50A
 SYSINTEGERTEMPX                  EQU 1280                    ; 0X500
 SYSINTEGERTEMPX_H                EQU 1281                    ; 0X501
 SYSLCDPRINTDATAHANDLER           EQU 1419                    ; 0X58B
 SYSLCDPRINTDATAHANDLER_H         EQU 1420                    ; 0X58C
 SYSLONGDIVMULTA                  EQU 1421                    ; 0X58D
 SYSLONGDIVMULTA_E                EQU 1424                    ; 0X590
 SYSLONGDIVMULTA_H                EQU 1422                    ; 0X58E
 SYSLONGDIVMULTA_U                EQU 1423                    ; 0X58F
 SYSLONGDIVMULTB                  EQU 1425                    ; 0X591
 SYSLONGDIVMULTB_E                EQU 1428                    ; 0X594
 SYSLONGDIVMULTB_H                EQU 1426                    ; 0X592
 SYSLONGDIVMULTB_U                EQU 1427                    ; 0X593
 SYSLONGDIVMULTX                  EQU 1429                    ; 0X595
 SYSLONGDIVMULTX_E                EQU 1432                    ; 0X598
 SYSLONGDIVMULTX_H                EQU 1430                    ; 0X596
 SYSLONGDIVMULTX_U                EQU 1431                    ; 0X597
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
 SYSREPEATTEMP1                   EQU 1433                    ; 0X599
 SYSREPEATTEMP4                   EQU 1434                    ; 0X59A
 SYSSIGNBYTE                      EQU 1293                    ; 0X50D
 SYSSTRDATA                       EQU 1435                    ; 0X59B
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 4255                    ; 0X109F
 SYSSTRINGTEMP                    EQU 1436                    ; 0X59C
 SYSSYSINSTRINGAHANDLER           EQU 1437                    ; 0X59D
 SYSSYSINSTRINGAHANDLER_H         EQU 1438                    ; 0X59E
 SYSSYSINSTRINGHANDLER            EQU 1439                    ; 0X59F
 SYSSYSINSTRINGHANDLER_H          EQU 1440                    ; 0X5A0
 SYSTEMP1                         EQU 1441                    ; 0X5A1
 SYSTEMP1_E                       EQU 1444                    ; 0X5A4
 SYSTEMP1_H                       EQU 1442                    ; 0X5A2
 SYSTEMP1_U                       EQU 1443                    ; 0X5A3
 SYSTEMP2                         EQU 1445                    ; 0X5A5
 SYSTEMP2_H                       EQU 1446                    ; 0X5A6
 SYSVALTEMP                       EQU 1447                    ; 0X5A7
 SYSVALTEMP_H                     EQU 1448                    ; 0X5A8
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPUS                    EQU 1285                    ; 0X505
 SYSWAITTEMPUS_H                  EQU 1286                    ; 0X506
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 SYSWORDTEMPX                     EQU 1280                    ; 0X500
 SYSWORDTEMPX_H                   EQU 1281                    ; 0X501
 TRIG_ARG1                        EQU 1449                    ; 0X5A9
 TRIG_ARG1_H                      EQU 1450                    ; 0X5AA
 TRIG_ARG2                        EQU 1451                    ; 0X5AB
 TRIG_ARG2_H                      EQU 1452                    ; 0X5AC
 TRIG_I                           EQU 1453                    ; 0X5AD
 TRIG_REF                         EQU 1454                    ; 0X5AE
 TRIG_REF_H                       EQU 1455                    ; 0X5AF
 TRIG_SIGN                        EQU 1456                    ; 0X5B0
 TRIG_SIGN_H                      EQU 1457                    ; 0X5B1
 TRIG_VAL                         EQU 1458                    ; 0X5B2
 TRIG_VAL_H                       EQU 1459                    ; 0X5B3
 VOLTS                            EQU 4258                    ; 0X10A2
 XCENTRE                          EQU 1460                    ; 0X5B4
 XEND                             EQU 1461                    ; 0X5B5
 YCENTRE                          EQU 1462                    ; 0X5B6
 YEND                             EQU 1463                    ; 0X5B7

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYSLEFT_0                        EQU 4310
 SYSMID_0                         EQU 4269
 SYSREADADBYTE                    EQU 1404
 SYSSCALEWORD                     EQU 1406
 SYSSCALEWORD_H                   EQU 1407
 SYSSTR_0                         EQU 4263

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

;START OF THE MAIN PROGRAM
;''
;''This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities and Maths/Trig capabilities.
;''
;''This program demonstrates the basic primatives a voltmeter on a Graphical LCD (GLCD)
;'':
;''You can change the microcontroller, the GLCD and the analogue port.
;''
;''To change the microcontroller simply change the #chip statement
;''To change the GLCD replace GLCD definition
;''To change the analogue port change the ADCChannelSelected constant
;''
;''************************************************************************
;''@author  StanC & EvanV
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
;analogue port selection
;#DEFINE ADCChannelSelected AN0
;#DEFINE ADSpeed LowSpeed
;#DEFINE GLCD_TYPE GLCD_TYPE_SSD1306
;#DEFINE GLCD_I2C_Address 0x78
;These constants allow you to change the GLCD memory usage.
;#DEFINE GLCD_PROTECTOVERRUN
;*******************************************************************************************
;Dim radius,xcentre,ycentre,xend,old_xend,yend,old_yend As Byte
;Dim angle,old_angle,adcval As Word
;Dim volts As String * 4
;xcentre=63
	MOVLW	63
	BANKSEL	XCENTRE
	MOVWF	XCENTRE,BANKED
;ycentre=58
	MOVLW	58
	MOVWF	YCENTRE,BANKED
;draw dial
;GLCDCLS
	BANKSEL	0
	CALL	GLCDCLS_SSD1306
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
;For radius=144 To 141
	MOVLW	145
	BANKSEL	RADIUS
	MOVWF	RADIUS,BANKED
SYSFORLOOP1:
	DECF	RADIUS,F,BANKED
;dial
	BANKSEL	0
	RCALL	DIAL
;Next radius
	BANKSEL	RADIUS
	MOVF	RADIUS,W,BANKED
	SUBLW	141
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;GLCDDrawChar (5,40,Asc("0")):GLCDDrawChar (115,40,Asc("5"))
	MOVLW	5
	MOVWF	CHARLOCX,ACCESS
	CLRF	CHARLOCX_H,ACCESS
	MOVLW	40
	MOVWF	CHARLOCY,ACCESS
	CLRF	CHARLOCY_H,ACCESS
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE1
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE1
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSSYSINSTRINGAHANDLER
	MOVWF	SYSSYSINSTRINGAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSSYSINSTRINGAHANDLER_H,BANKED
	MOVLW	1
	MOVWF	SYSCHAR,BANKED
	BANKSEL	0
	RCALL	FN_ASC
	MOVFF	ASC,CHARCODE
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	GLCDDRAWCHAR_SSD1306
	MOVLW	115
	MOVWF	CHARLOCX,ACCESS
	CLRF	CHARLOCX_H,ACCESS
	MOVLW	40
	MOVWF	CHARLOCY,ACCESS
	CLRF	CHARLOCY_H,ACCESS
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
	BANKSEL	SYSSYSINSTRINGAHANDLER
	MOVWF	SYSSYSINSTRINGAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSSYSINSTRINGAHANDLER_H,BANKED
	MOVLW	1
	MOVWF	SYSCHAR,BANKED
	BANKSEL	0
	RCALL	FN_ASC
	MOVFF	ASC,CHARCODE
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	GLCDDRAWCHAR_SSD1306
;radius=120
	MOVLW	120
	BANKSEL	RADIUS
	MOVWF	RADIUS,BANKED
;angle=1
	MOVLW	1
	MOVWF	ANGLE,ACCESS
	CLRF	ANGLE_H,ACCESS
;anglecheck
	BANKSEL	0
	RCALL	ANGLECHECK
;Do
SYSDOLOOP_S1:
;old_angle=angle
	MOVFF	ANGLE,OLD_ANGLE
	MOVFF	ANGLE_H,OLD_ANGLE_H
;--- DVM
;adcval=ReadAD(ADCChannelSelected)
	CLRF	ADREADPORT,ACCESS
	CALL	FN_READAD450
	MOVFF	SYSREADADBYTE,ADCVAL
	CLRF	ADCVAL_H,ACCESS
;adcval = scale( adcval, 0, 210, 0, 196 )
	MOVFF	ADCVAL,L_MAP
	MOVFF	ADCVAL_H,L_MAP_H
	BANKSEL	L_FROMLOW
	CLRF	L_FROMLOW,BANKED
	CLRF	L_FROMLOW_H,BANKED
	MOVLW	210
	MOVWF	L_FROMHIGH,BANKED
	CLRF	L_FROMHIGH_H,BANKED
	CLRF	L_TOLOW,BANKED
	CLRF	L_TOLOW_H,BANKED
	MOVLW	196
	MOVWF	L_TOHIGH,BANKED
	CLRF	L_TOHIGH_H,BANKED
	CLRF	L_CALIBRATE,ACCESS
	CLRF	L_CALIBRATE_H,ACCESS
	BANKSEL	0
	CALL	FN_SCALE518
	MOVFF	SYSSCALEWORD,ADCVAL
	MOVFF	SYSSCALEWORD_H,ADCVAL_H
;angle=adcval/2
	MOVFF	ADCVAL,SYSWORDTEMPA
	MOVFF	ADCVAL_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,ANGLE
	MOVFF	SYSWORDTEMPA_H,ANGLE_H
;
;adcval=adcval*100
	MOVFF	ADCVAL,SYSWORDTEMPA
	MOVFF	ADCVAL_H,SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,ADCVAL
	MOVFF	SYSWORDTEMPX_H,ADCVAL_H
;adcval=adcval/51
	MOVFF	ADCVAL,SYSWORDTEMPA
	MOVFF	ADCVAL_H,SYSWORDTEMPA_H
	MOVLW	51
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,ADCVAL
	MOVFF	SYSWORDTEMPA_H,ADCVAL_H
;volts=Str(adcval)
	MOVFF	ADCVAL,SYSVALTEMP
	MOVFF	ADCVAL_H,SYSVALTEMP_H
	CALL	FN_STR
	LFSR	1,VOLTS
	LFSR	0,STR
	CALL	SYSCOPYSTRING
;If adcval<10 Then
	MOVFF	ADCVAL,SYSWORDTEMPA
	MOVFF	ADCVAL_H,SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF2
;volts="0.0"+Left(volts,1,1)
	MOVLW	LOW VOLTS
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH VOLTS
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	1
	MOVWF	SYSCHARCOUNT,BANKED
	BANKSEL	0
	CALL	FN_LEFT
	LFSR	1,VOLTS
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
	LFSR	0,LEFT
	CALL	SYSCOPYSTRINGPART
	LFSR	0,VOLTS
	MOVFF	SYSSTRINGLENGTH, INDF0
;Goto volt_format_done
	BRA	VOLT_FORMAT_DONE
;End If
ENDIF2:
;If adcval<100 Then
	MOVFF	ADCVAL,SYSWORDTEMPA
	MOVFF	ADCVAL_H,SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE3_1
;volts="0."+Mid(volts,1,2)
	MOVLW	LOW VOLTS
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH VOLTS
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	1
	MOVWF	SYSCHARSTART,BANKED
	MOVLW	2
	MOVWF	SYSCHARCOUNT,BANKED
	BANKSEL	0
	CALL	FN_MID
	LFSR	1,VOLTS
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE4
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE4
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,MID
	CALL	SYSCOPYSTRINGPART
	LFSR	0,VOLTS
	MOVFF	SYSSTRINGLENGTH, INDF0
;Else
	BRA	ENDIF3
ELSE3_1:
;volts=Left(volts,1,1)+"."+Mid(volts,2,2)
	MOVLW	LOW VOLTS
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH VOLTS
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	1
	MOVWF	SYSCHARCOUNT,BANKED
	BANKSEL	0
	CALL	FN_LEFT
	MOVLW	LOW VOLTS
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH VOLTS
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	2
	MOVWF	SYSCHARSTART,BANKED
	MOVLW	2
	MOVWF	SYSCHARCOUNT,BANKED
	BANKSEL	0
	CALL	FN_MID
	LFSR	1,VOLTS
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,LEFT
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE5
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE5
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,MID
	CALL	SYSCOPYSTRINGPART
	LFSR	0,VOLTS
	MOVFF	SYSSTRINGLENGTH, INDF0
;End If
ENDIF3:
VOLT_FORMAT_DONE:
;---
;anglecheck
	RCALL	ANGLECHECK
;old_xend = xcentre + radius  * sin (old_angle)/255
	MOVFF	OLD_ANGLE,TRIG_ARG2
	MOVFF	OLD_ANGLE_H,TRIG_ARG2_H
	CALL	FN_SIN
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	SIN,SYSINTEGERTEMPB
	MOVFF	SIN_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP1
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP1_H
	MOVFF	SYSTEMP1,SYSINTEGERTEMPA
	MOVFF	SYSTEMP1_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W,ACCESS
	BANKSEL	XCENTRE
	ADDWF	XCENTRE,W,BANKED
	MOVWF	OLD_XEND,BANKED
;old_yend = ycentre - radius  * cos (old_angle)/255
	MOVFF	OLD_ANGLE,TRIG_ARG2
	MOVFF	OLD_ANGLE_H,TRIG_ARG2_H
	BANKSEL	0
	RCALL	FN_COS
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	COS,SYSINTEGERTEMPB
	MOVFF	COS_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP1
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP1_H
	MOVFF	SYSTEMP1,SYSINTEGERTEMPA
	MOVFF	SYSTEMP1_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W,ACCESS
	BANKSEL	YCENTRE
	SUBWF	YCENTRE,W,BANKED
	MOVWF	OLD_YEND,BANKED
;xend = xcentre + radius  * sin (angle)/255
	MOVFF	ANGLE,TRIG_ARG2
	MOVFF	ANGLE_H,TRIG_ARG2_H
	BANKSEL	0
	CALL	FN_SIN
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	SIN,SYSINTEGERTEMPB
	MOVFF	SIN_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP1
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP1_H
	MOVFF	SYSTEMP1,SYSINTEGERTEMPA
	MOVFF	SYSTEMP1_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W,ACCESS
	BANKSEL	XCENTRE
	ADDWF	XCENTRE,W,BANKED
	MOVWF	XEND,BANKED
;yend = ycentre - radius  * cos (angle)/255
	MOVFF	ANGLE,TRIG_ARG2
	MOVFF	ANGLE_H,TRIG_ARG2_H
	BANKSEL	0
	RCALL	FN_COS
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	COS,SYSINTEGERTEMPB
	MOVFF	COS_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP1
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP1_H
	MOVFF	SYSTEMP1,SYSINTEGERTEMPA
	MOVFF	SYSTEMP1_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W,ACCESS
	BANKSEL	YCENTRE
	SUBWF	YCENTRE,W,BANKED
	MOVWF	YEND,BANKED
;If old_angle<>angle Then
	MOVFF	OLD_ANGLE,SYSWORDTEMPA
	MOVFF	OLD_ANGLE_H,SYSWORDTEMPA_H
	MOVFF	ANGLE,SYSWORDTEMPB
	MOVFF	ANGLE_H,SYSWORDTEMPB_H
	BANKSEL	0
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF4
;-- update screen if volts has changed
;erase old needle
;Line (xcentre,ycentre,old_xend,old_yend,0)
	MOVFF	XCENTRE,LINEX1
	CLRF	LINEX1_H,ACCESS
	MOVFF	YCENTRE,LINEY1
	CLRF	LINEY1_H,ACCESS
	MOVFF	OLD_XEND,LINEX2
	CLRF	LINEX2_H,ACCESS
	MOVFF	OLD_YEND,LINEY2
	CLRF	LINEY2_H,ACCESS
	CLRF	LINECOLOUR,ACCESS
	CLRF	LINECOLOUR_H,ACCESS
	CALL	_LINE
;draw V
;Line (55,22,63,38):Line (63,38,71,22)
	MOVLW	55
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	22
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	63
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	38
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	_LINE
	MOVLW	63
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	38
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	71
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	22
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	_LINE
;print new voltage
;print Voltage
;GLCDPrint (50,10,volts,1)
	MOVLW	50
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	10
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	LOW VOLTS
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH VOLTS
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	MOVLW	1
	MOVWF	LINECOLOUR,ACCESS
	CLRF	LINECOLOUR_H,ACCESS
	BANKSEL	0
	CALL	GLCDPRINT12
;draw new needle
;Line (xcentre,ycentre,xend,yend,1)
	MOVFF	XCENTRE,LINEX1
	CLRF	LINEX1_H,ACCESS
	MOVFF	YCENTRE,LINEY1
	CLRF	LINEY1_H,ACCESS
	MOVFF	XEND,LINEX2
	CLRF	LINEX2_H,ACCESS
	MOVFF	YEND,LINEY2
	CLRF	LINEY2_H,ACCESS
	MOVLW	1
	MOVWF	LINECOLOUR,ACCESS
	CLRF	LINECOLOUR_H,ACCESS
	CALL	_LINE
;Wait 20 ms
	MOVLW	20
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;End If
ENDIF4:
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;end main
;
;
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

;SOURCE: 230_I2C_GLCD_VOLTMETER_USING_SSD1306.GCB (194)
ANGLECHECK:
;If angle>127 Then
	MOVFF	ANGLE,SYSWORDTEMPB
	MOVFF	ANGLE_H,SYSWORDTEMPB_H
	MOVLW	127
	MOVWF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE7_1
;angle =angle-127
	MOVLW	127
	SUBWF	ANGLE,F,ACCESS
	MOVLW	0
	SUBWFB	ANGLE_H,F,ACCESS
;Else
	BRA	ENDIF7
ELSE7_1:
;angle =296+angle
	MOVLW	40
	ADDWF	ANGLE,F,ACCESS
	MOVLW	1
	ADDWFC	ANGLE_H,F,ACCESS
;End If
ENDIF7:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (523)
FN_ASC:
;Asc = 0
	CLRF	ASC,ACCESS
;Get length of string, don't try _asc ing if it's empty
;SysCharCount = SysInStringA(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGAHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGAHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGAHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGAHANDLER_H,FSR0H
	MOVFF	INDF0,SYSCHARCOUNT
;If SysCharCount = 0 Then Exit Function
	BANKSEL	SYSCHARCOUNT
	MOVF	SYSCHARCOUNT,F,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF75
	BANKSEL	0
	RETURN
ENDIF75:
;if Syschar > SysCharCount Then Exit Function
	MOVF	SYSCHAR,W,BANKED
	SUBWF	SYSCHARCOUNT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF76
	BANKSEL	0
	RETURN
ENDIF76:
;Get first char of string, only first character is of interest, Syschar if provided
;Asc = SysInStringA( Syschar )
	MOVF	SYSCHAR,W,BANKED
	ADDWF	SYSSYSINSTRINGAHANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGAHANDLER_H,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	INDF0,ASC
	BANKSEL	0
	RETURN

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
	BRA	ENDIF15
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
ENDIF15:
;If LineY1 > LineY2 Then
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF16
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
ENDIF16:
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

;SOURCE: TRIG2PLACES.H (74)
FN_COS:
;return cosine of angle
;if trig_arg2 < 0 then               ;cosine is an even function,
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF10
;trig_arg2 = -1 * trig_arg2        ;so negate negative angle
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	SETF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,TRIG_ARG2
	MOVFF	SYSINTEGERTEMPX_H,TRIG_ARG2_H
;end if
ENDIF10:
;trig_arg2 = trig_arg2 mod 360       ;reduce to 0 to 359 degrees
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	MOVLW	104
	MOVWF	SYSINTEGERTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVFF	SYSINTEGERTEMPX,TRIG_ARG2
	MOVFF	SYSINTEGERTEMPX_H,TRIG_ARG2_H
;trig_sign = 1                       ;assume result is positive
	MOVLW	1
	BANKSEL	TRIG_SIGN
	MOVWF	TRIG_SIGN,BANKED
	CLRF	TRIG_SIGN_H,BANKED
;if trig_arg2>90 and trig_arg2<270 then
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPB
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPB_H
	MOVLW	90
	MOVWF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHANINT
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	MOVLW	14
	MOVWF	SYSINTEGERTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHANINT
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ANDWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF11
;trig_sign = -1                    ;but negative in II and III
	SETF	TRIG_SIGN,BANKED
	SETF	TRIG_SIGN_H,BANKED
;end if
ENDIF11:
;trig_arg2 = trig_ref(trig_arg2)     ;get the trig_reference angle
	MOVFF	TRIG_ARG2,TRIG_ARG1
	MOVFF	TRIG_ARG2_H,TRIG_ARG1_H
	BANKSEL	0
	CALL	FN_TRIG_REF
	MOVFF	TRIG_REF,TRIG_ARG2
	MOVFF	TRIG_REF_H,TRIG_ARG2_H
;trig_arg2 = [integer]90 - trig_arg2 ;use cofunction identity
	BANKSEL	TRIG_ARG2
	MOVF	TRIG_ARG2,W,BANKED
	SUBLW	90
	MOVWF	TRIG_ARG2,BANKED
	CLRF	SYSTEMP1,BANKED
	MOVF	TRIG_ARG2_H,W,BANKED
	SUBWFB	SYSTEMP1,W,BANKED
	MOVWF	TRIG_ARG2_H,BANKED
;trig_i = [byte]trig_arg2+1          ;index into the table
	INCF	TRIG_ARG2,W,BANKED
	MOVWF	TRIG_I,BANKED
;readTable sineTab, trig_i, trig_val
	MOVFF	TRIG_I,SYSSTRINGA
	BANKSEL	0
	CALL	SINETAB
	BANKSEL	TRIG_VAL
	MOVWF	TRIG_VAL,BANKED
	CLRF	TRIG_VAL_H,BANKED
;cos = trig_sign * [integer]trig_val  ;create final result
	MOVFF	TRIG_SIGN,SYSINTEGERTEMPA
	MOVFF	TRIG_SIGN_H,SYSINTEGERTEMPA_H
	MOVFF	TRIG_VAL,SYSINTEGERTEMPB
	MOVFF	TRIG_VAL_H,SYSINTEGERTEMPB_H
	BANKSEL	0
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,COS
	MOVFF	SYSINTEGERTEMPX_H,COS_H
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
	BANKSEL	SYSREPEATTEMP4
	MOVWF	SYSREPEATTEMP4,BANKED
SYSREPEATLOOP4:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate PosCharY Right
	RRCF	POSCHARY,F,BANKED
;End Repeat
	DECFSZ	SYSREPEATTEMP4,F,BANKED
	BRA	SYSREPEATLOOP4
SYSREPEATLOOPEND4:
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	MOVLW	176
	ADDWF	POSCHARY,W,BANKED
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	MOVLW	15
	ANDWF	LOCX,W,ACCESS
	BANKSEL	POSCHARX
	MOVWF	POSCHARX,BANKED
	CLRF	POSCHARX_H,BANKED
;Write_Command_SSD1306( PosCharX )
	MOVFF	POSCHARX,SSD1306SENDBYTE
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	MOVFF	LOCX,POSCHARX
	BANKSEL	POSCHARX_H
	CLRF	POSCHARX_H,BANKED
;Repeat 4
	MOVLW	4
	MOVWF	SYSREPEATTEMP4,BANKED
SYSREPEATLOOP5:
;Set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate PosCharX Right
	RRCF	POSCHARX_H,F,BANKED
	RRCF	POSCHARX,F,BANKED
;End Repeat
	DECFSZ	SYSREPEATTEMP4,F,BANKED
	BRA	SYSREPEATLOOP5
SYSREPEATLOOPEND5:
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	MOVLW	15
	ANDWF	POSCHARX,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	CLRF	SYSTEMP1_H,BANKED
	MOVLW	16
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	POSCHARX,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	POSCHARX_H,BANKED
;Write_Command_SSD1306 ( PosCharX )
	MOVFF	POSCHARX,SSD1306SENDBYTE
	BANKSEL	0
	GOTO	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: 230_I2C_GLCD_VOLTMETER_USING_SSD1306.GCB (184)
DIAL:
;For angle= 296 To 359
	MOVLW	39
	MOVWF	ANGLE,ACCESS
	MOVLW	1
	MOVWF	ANGLE_H,ACCESS
SYSFORLOOP2:
	INCF	ANGLE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	ANGLE_H,F,ACCESS
;plotdial
	CALL	PLOTDIAL
;Next angle
	MOVFF	ANGLE,SYSWORDTEMPA
	MOVFF	ANGLE_H,SYSWORDTEMPA_H
	MOVLW	103
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;
;For angle= 0 To 63
	SETF	ANGLE,ACCESS
	SETF	ANGLE_H,ACCESS
SYSFORLOOP3:
	INCF	ANGLE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	ANGLE_H,F,ACCESS
;plotdial
	CALL	PLOTDIAL
;Next angle
	MOVFF	ANGLE,SYSWORDTEMPA
	MOVFF	ANGLE_H,SYSWORDTEMPA_H
	MOVLW	63
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
	RETURN

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	52
	MOVWF	DELAYTEMP,ACCESS
DELAYUS0:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS0
	DECFSZ	SYSWAITTEMP10US, F,ACCESS
	BRA	D10US_START
	RETURN

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
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC,BANKED
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP7:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
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
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP7
SYSFORLOOPEND7:
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	MOVLW	248
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC,BANKED
	SETF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP8:
	MOVLW	8
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	MOVLW	0
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	CLRF	LOCX,ACCESS
	MOVFF	SSD1306_BUFFERLOCATIONCALC,LOCY
	BANKSEL	0
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
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX,BANKED
;PrintLocY =0
	CLRF	PRINTLOCY,BANKED
	BANKSEL	0
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
	BRA	ENDIF26
;Inverted Colours
;GLCDBackground = 1
	MOVLW	1
	MOVWF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	CLRF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF26:
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
	BRA	ENDIF27
;CharLocY=CharLocY-1
	MOVLW	1
	SUBWF	CHARLOCY,F,ACCESS
	MOVLW	0
	SUBWFB	CHARLOCY_H,F,ACCESS
;end if
ENDIF27:
;For CurrCharCol = 1 to 5
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP10:
	INCF	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SYSSELECT1CASE1:
	DECF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE2
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL3
	MOVWF	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE3
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL4
	MOVWF	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE4
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL5
	MOVWF	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE5
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL6
	MOVWF	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	BRA	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND1
	MOVFF	CHARCODE,SYSSTRINGA
	BANKSEL	0
	RCALL	GLCDCHARCOL7
	MOVWF	CURRCHARVAL,ACCESS
;End Select
SYSSELECTEND1:
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
	BANKSEL	ROW
	CLRF	ROW,BANKED
	MOVLW	1
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND13
SYSFORLOOP13:
	INCF	ROW,F,BANKED
;if CurrCharVal.0=1 then
	BTFSS	CURRCHARVAL,0,ACCESS
	BRA	ELSE30_1
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, LineColour
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
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
	BRA	ENDIF30
ELSE30_1:
;PSet [word]CharLocX + CharCol + CharColS, [word]CharLocY + CharRow + CharRowS, GLCDBackground
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
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
ENDIF30:
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
	BANKSEL	ROW
	SUBWF	ROW,W,BANKED
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

;OVERLOADED SIGNATURE: WORD:WORD:STRING:WORD:, SOURCE: GLCD.H (963)
GLCDPRINT12:
;Dim GLCDPrintLoc as word
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
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter), LineColour
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
	RCALL	DELAY_MS
;HI2CMode Master
	MOVLW	12
	MOVWF	HI2CCURRENTMODE,ACCESS
	RCALL	HI2CMODE
;Wait 15 ms  'wait for power-up and reset
	MOVLW	15
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	MOVLW	174
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	MOVLW	46
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	MOVLW	213
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	MOVLW	128
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	MOVLW	168
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	MOVLW	63
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	MOVLW	211
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                   ' no offset
	BANKSEL	SSD1306SENDBYTE
	CLRF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	MOVLW	141
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	MOVLW	20
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	MOVLW	32
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	MOVLW	16
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	MOVLW	161
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	MOVLW	200
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	MOVLW	218
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x12)                                 '64 pixels
	MOVLW	18
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	MOVLW	129
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	MOVLW	207
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	MOVLW	217
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	MOVLW	241
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	MOVLW	219
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(0x40)
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	MOVLW	164
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	MOVLW	166
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	CALL	WRITE_COMMAND_SSD1306
;Clear screen Here
;GLCDCLS_SSD1306
	RCALL	GLCDCLS_SSD1306
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	MOVLW	175
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE,BANKED
	BANKSEL	0
	GOTO	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: 230_I2C_GLCD_VOLTMETER_USING_SSD1306.GCB (36)
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

;SOURCE: STRING.H (354)
FN_LEFT:
;Empty input?
;If SysInString(0) = 0 Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	INDF0,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF65
;Left(0) = 0
	BANKSEL	SYSLEFT_0
	CLRF	SYSLEFT_0,BANKED
;Exit Function
	BANKSEL	0
	RETURN
;End If
ENDIF65:
;Input length too high?
;If SysInString(0) < SysCharCount Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	BANKSEL	SYSCHARCOUNT
	MOVF	SYSCHARCOUNT,W,BANKED
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF66
;SysCharCount = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	INDF0,SYSCHARCOUNT
;End If
ENDIF66:
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	CLRF	SYSSTRINGTEMP,BANKED
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND14
SYSFORLOOP14:
	INCF	SYSSTRINGTEMP,F,BANKED
;Left(SysStringTemp) = SysInString(SysStringTemp)
	MOVF	SYSSTRINGTEMP,W,BANKED
	ADDWF	SYSSYSINSTRINGHANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	POSTINC0,SYSARRAYTEMP2
	MOVFF	SYSARRAYTEMP2,SYSARRAYTEMP1
	LFSR	0,LEFT
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
	MOVF	SYSCHARCOUNT,W,BANKED
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP14
SYSFORLOOPEND14:
;Left(0) = SysCharCount
	MOVFFL	SYSCHARCOUNT,SYSLEFT_0
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: STRING.H (393)
FN_MID:
;Empty input?
;If SysInString(0) = 0 Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	INDF0,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF69
;Mid(0) = 0
	BANKSEL	SYSMID_0
	CLRF	SYSMID_0,BANKED
;Exit Function
	BANKSEL	0
	RETURN
;End If
ENDIF69:
;Starting position too low?
;If SysCharStart < 1 Then SysCharStart = 1
	MOVLW	1
	BANKSEL	SYSCHARSTART
	SUBWF	SYSCHARSTART,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF70
	MOVLW	1
	MOVWF	SYSCHARSTART,BANKED
ENDIF70:
;Starting position too high?
;If SysCharStart > SysInString(0) Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	SYSCHARSTART,W,BANKED
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF71
;Mid(0) = 0
	BANKSEL	SYSMID_0
	CLRF	SYSMID_0,BANKED
;Exit Function
	BANKSEL	0
	RETURN
;End If
ENDIF71:
;Input length too high?
;SysCharStart -= 1
	DECF	SYSCHARSTART,F,BANKED
;SysStringTemp = SysInString(0) - SysCharStart 'Max number of characters
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	SYSCHARSTART,W,BANKED
	SUBWF	INDF0,W,ACCESS
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysCharCount > SysStringTemp Then
	MOVF	SYSCHARCOUNT,W,BANKED
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
;SysCharCount = SysStringTemp
	MOVFF	SYSSTRINGTEMP,SYSCHARCOUNT
;End If
;Copy characters
;For SysStringTemp = 1 To SysCharCount
	CLRF	SYSSTRINGTEMP,BANKED
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND15
SYSFORLOOP15:
	INCF	SYSSTRINGTEMP,F,BANKED
;Mid(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	MOVF	SYSSTRINGTEMP,W,BANKED
	ADDWF	SYSCHARSTART,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	ADDWF	SYSSYSINSTRINGHANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	POSTINC0,SYSARRAYTEMP1
	MOVFF	SYSARRAYTEMP1,SYSARRAYTEMP2
	LFSR	0,MID
	MOVF	SYSSTRINGTEMP,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	SYSARRAYTEMP2,POSTINC0
;Next
	MOVF	SYSCHARCOUNT,W,BANKED
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP15
SYSFORLOOPEND15:
;Mid(0) = SysCharCount
	MOVFFL	SYSCHARCOUNT,SYSMID_0
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: 230_I2C_GLCD_VOLTMETER_USING_SSD1306.GCB (178)
PLOTDIAL:
;xend = 63 + radius  * sin (angle)/255
	MOVFF	ANGLE,TRIG_ARG2
	MOVFF	ANGLE_H,TRIG_ARG2_H
	RCALL	FN_SIN
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	SIN,SYSINTEGERTEMPB
	MOVFF	SIN_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP2
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP2_H
	MOVFF	SYSTEMP2,SYSINTEGERTEMPA
	MOVFF	SYSTEMP2_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVLW	63
	ADDWF	SYSINTEGERTEMPA,W,ACCESS
	BANKSEL	XEND
	MOVWF	XEND,BANKED
;yend = 58 - radius  * cos (angle)/255
	MOVFF	ANGLE,TRIG_ARG2
	MOVFF	ANGLE_H,TRIG_ARG2_H
	BANKSEL	0
	CALL	FN_COS
	MOVFF	RADIUS,SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	MOVFF	COS,SYSINTEGERTEMPB
	MOVFF	COS_H,SYSINTEGERTEMPB_H
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SYSTEMP2
	MOVFF	SYSINTEGERTEMPX_H,SYSTEMP2_H
	MOVFF	SYSTEMP2,SYSINTEGERTEMPA
	MOVFF	SYSTEMP2_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVF	SYSINTEGERTEMPA,W,ACCESS
	SUBLW	58
	BANKSEL	YEND
	MOVWF	YEND,BANKED
;Pset (xend,yend,1)
	MOVFF	XEND,GLCDX
	MOVFF	YEND,GLCDY
	MOVLW	1
	MOVWF	GLCDCOLOUR,ACCESS
	CLRF	GLCDCOLOUR_H,ACCESS
	BANKSEL	0
	BRA	PSET_SSD1306

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
	CALL	SYSCOMPLESSTHAN
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
	BRA	ENDIF35
;exit sub
	BANKSEL	0
	RETURN
;end if
ENDIF35:
;1.14 Addresses correct device horizonal page
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;SSD1306_BufferLocationCalc = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;SSD1306_BufferLocationCalc = GLCDY
	MOVFF	GLCDY,SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
;Repeat 3
	MOVLW	3
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP1:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SSD1306_BufferLocationCalc Right
	RRCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
	RRCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;faster than * 128
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Repeat 7
	MOVLW	7
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP2:
;Rotate SSD1306_BufferLocationCalc Left
	RLCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	RLCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;SSD1306_BufferLocationCalc = GLCDX + SSD1306_BufferLocationCalc + 1
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
	ADDWF	GLCDX,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	CLRF	SYSTEMP2,BANKED
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
	ADDWFC	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SSD1306_BUFFERLOCATIONCALC,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
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
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
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
	BRA	ELSE37_1
;GLCDChange = 254
	MOVLW	254
	MOVWF	GLCDCHANGE,ACCESS
;Set C On
;A8: ASM Source was:  BSF STATUS,C,ACCESS
	BSF	STATUS,0,ACCESS
;Else
	BRA	ENDIF37
ELSE37_1:
;GLCDChange = 1
	MOVLW	1
	MOVWF	GLCDCHANGE,ACCESS
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;End If
ENDIF37:
;Repeat GLCDBitNo
	MOVFF	GLCDBITNO,SYSREPEATTEMP1
	MOVF	SYSREPEATTEMP1,F,BANKED
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND3
SYSREPEATLOOP3:
;Rotate GLCDChange Left
	RLCF	GLCDCHANGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0,ACCESS
	BRA	ELSE38_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	ANDWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;Else
	BRA	ENDIF38
ELSE38_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	IORWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;End If
ENDIF38:
;added 1.14 to isolate from full glcd mode
;revised 1.14 to isolate from low memory mode
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVF	GLCDDATATEMP,W,ACCESS
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ENDIF39
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
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
	CALL	WRITE_DATA_SSD1306
;end if
ENDIF39:
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD450:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	MOVFF	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SYSSELECT2CASE1:
	MOVF	ADREADPORT,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE2:
	DECF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	BRA	SYSSELECTEND2
SYSSELECT2CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND2
BANKSEL	ANSELC
	BSF	ANSELC,7,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND2:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
	MOVWF	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  ' ADCON0.4
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 31    ' FOSC/32
	MOVLW	31
	MOVWF	ADCLK,BANKED
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;Set ADFM0 OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	MOVFF	ADREADPORT,ADPCH
;Enable A/D
;SET ADON ON
;A8: ASM Source was:  BSF ADCON0,ADON,BANKED
	BSF	ADCON0,7,BANKED
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US,ACCESS
	BANKSEL	0
	CALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;A8: ASM Source was:  BSF ADCON0,GO_NOT_DONE,BANKED
	BSF	ADCON0,0,BANKED
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE,BANKED
	BTFSC	ADCON0,0,BANKED
	BRA	SYSWAITLOOP1
;Switch off A/D
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
;ReadAD = ADRESH
	MOVFF	ADRESH,READAD
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (263)
FN_SCALE518:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	BANKSEL	L_FROMLOW
	MOVF	L_FROMLOW,W,BANKED
	SUBWF	L_MAP,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVF	L_FROMLOW_H,W,BANKED
	SUBWFB	L_MAP_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVF	L_TOLOW,W,BANKED
	SUBWF	L_TOHIGH,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVF	L_TOLOW_H,W,BANKED
	SUBWFB	L_TOHIGH_H,W,BANKED
	MOVWF	SYSTEMP2_H,BANKED
	MOVFF	SYSTEMP1,SYSLONGTEMPA
	MOVFF	SYSTEMP1_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	SYSTEMP2,SYSLONGTEMPB
	MOVFF	SYSTEMP2_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	BANKSEL	0
	RCALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,L_SYSCALCF
	MOVFF	SYSLONGTEMPX_H,L_SYSCALCF_H
	MOVFF	SYSLONGTEMPX_U,L_SYSCALCF_U
	MOVFF	SYSLONGTEMPX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	BANKSEL	L_FROMLOW
	MOVF	L_FROMLOW,W,BANKED
	SUBWF	L_FROMHIGH,W,BANKED
	MOVWF	L_SYSCALC,BANKED
	MOVF	L_FROMLOW_H,W,BANKED
	SUBWFB	L_FROMHIGH_H,W,BANKED
	MOVWF	L_SYSCALC_H,BANKED
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	MOVFF	L_SYSCALCF,SYSLONGTEMPA
	MOVFF	L_SYSCALCF_H,SYSLONGTEMPA_H
	MOVFF	L_SYSCALCF_U,SYSLONGTEMPA_U
	MOVFF	L_SYSCALCF_E,SYSLONGTEMPA_E
	MOVFF	L_SYSCALC,SYSLONGTEMPB
	MOVFF	L_SYSCALC_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,SYSTEMP1
	MOVFF	SYSLONGTEMPA_H,SYSTEMP1_H
	MOVFF	SYSLONGTEMPA_U,SYSTEMP1_U
	MOVFF	SYSLONGTEMPA_E,SYSTEMP1_E
	BANKSEL	L_TOLOW
	MOVF	L_TOLOW,W,BANKED
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVF	L_TOLOW_H,W,BANKED
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	SYSTEMP2_H,BANKED
	MOVF	L_CALIBRATE,W,ACCESS
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	SCALE,BANKED
	MOVF	L_CALIBRATE_H,W,ACCESS
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	SCALE_H,BANKED
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
SYSSELECT3CASE1:
	MOVLW	2
	SUBWF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE2
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
;if I2C1STAT1.TXBE = 1 then
BANKSEL	I2C1STAT1
;A8: ASM Source was:  BTFSS I2C1STAT1,TXBE,BANKED
	BTFSS	I2C1STAT1,5,BANKED
	BRA	ELSE79_1
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
	BRA	ENDIF79
ELSE79_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS4:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS4
;end if
ENDIF79:
;loop
	BRA	SYSDOLOOP_S5
SYSDOLOOP_E5:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_TXBE_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF80
	MOVLW	2
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF80:
;case 1  'A start
	BRA	SYSSELECTEND3
SYSSELECT3CASE2:
	DECF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE3
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
SYSDOLOOP_S6:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E6
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.SCIF = 1 then
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE81_1
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
	BRA	ENDIF81
ELSE81_1:
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
ENDIF81:
;loop
	BRA	SYSDOLOOP_S6
SYSDOLOOP_E6:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_START_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF82
	MOVLW	4
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF82:
;case 3  'A restart
	BRA	SYSSELECTEND3
SYSSELECT3CASE3:
	MOVLW	3
	SUBWF	HI2C1STATEMACHINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND3
;wait for hardware machine to settle
;wait while I2C1STAT0.MMA = 1
SYSWAITLOOP2:
BANKSEL	I2C1STAT0
;A8: ASM Source was:  BTFSC I2C1STAT0,MMA,BANKED
	BTFSC	I2C1STAT0,5,BANKED
	BRA	SYSWAITLOOP2
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
SYSDOLOOP_S7:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E7
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.SCIF = 1 then
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE83_1
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
	BRA	ENDIF83
ELSE83_1:
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
ENDIF83:
;loop
	BRA	SYSDOLOOP_S7
SYSDOLOOP_E7:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_RESTART_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF84
	MOVLW	8
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF84:
;end select
SYSSELECTEND3:
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
SYSDOLOOP_S4:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E4
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait till this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE77_1
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
	BRA	ENDIF77
ELSE77_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS3:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS3
;end if
ENDIF77:
;loop
	BRA	SYSDOLOOP_S4
SYSDOLOOP_E4:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF78
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF78:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (971)
SI2CWAIT4ACK:
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
;if I2C1CON1.ACKSTAT = 0 then
BANKSEL	I2C1CON1
;A8: ASM Source was:  BTFSC I2C1CON1,ACKSTAT,BANKED
	BTFSC	I2C1CON1,5,BANKED
	BRA	ELSE87_1
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
	BRA	ENDIF87
ELSE87_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS7:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS7
;end if
ENDIF87:
;loop
	BRA	SYSDOLOOP_S8
SYSDOLOOP_E8:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_ACK_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF88
	MOVLW	32
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF88:
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
SYSDOLOOP_S9:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E9
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;wait for this event
;if I2C1CON0.MDR = 0 then
BANKSEL	I2C1CON0
;A8: ASM Source was:  BTFSC I2C1CON0,MDR,BANKED
	BTFSC	I2C1CON0,3,BANKED
	BRA	ELSE90_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF90
ELSE90_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS8:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS8
;end if
ENDIF90:
;loop
	BRA	SYSDOLOOP_S9
SYSDOLOOP_E9:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_MDR_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF91
	MOVLW	64
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF91:
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
SYSDOLOOP_S10:
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E10
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,ACCESS
;Wait for this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE92_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF92
ELSE92_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS9:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS9
;end if
ENDIF92:
;loop
	BRA	SYSDOLOOP_S10
SYSDOLOOP_E10:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF93
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,ACCESS
ENDIF93:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: TRIG2PLACES.H (49)
FN_SIN:
;return sine of angle
;if trig_arg2 < 0 then               ;sine is an odd function,
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE8_1
;trig_sign = -1                    ;so change sign of result
	BANKSEL	TRIG_SIGN
	SETF	TRIG_SIGN,BANKED
	SETF	TRIG_SIGN_H,BANKED
;trig_arg2 = -1 * trig_arg2        ;and negate negative angle
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	SETF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,TRIG_ARG2
	MOVFF	SYSINTEGERTEMPX_H,TRIG_ARG2_H
;else
	BRA	ENDIF8
ELSE8_1:
;trig_sign = 1                     ;else a positive angle
	MOVLW	1
	BANKSEL	TRIG_SIGN
	MOVWF	TRIG_SIGN,BANKED
	CLRF	TRIG_SIGN_H,BANKED
;end if
ENDIF8:
;trig_arg2 = trig_arg2 mod 360       ;reduce to 0 to 359 degrees
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPA
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPA_H
	MOVLW	104
	MOVWF	SYSINTEGERTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUBINT
	MOVFF	SYSINTEGERTEMPX,TRIG_ARG2
	MOVFF	SYSINTEGERTEMPX_H,TRIG_ARG2_H
;if trig_arg2 > 180 then
	MOVFF	TRIG_ARG2,SYSINTEGERTEMPB
	MOVFF	TRIG_ARG2_H,SYSINTEGERTEMPB_H
	MOVLW	180
	MOVWF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF9
;trig_sign = -1 * trig_sign        ;negative in III and IV
	MOVFF	TRIG_SIGN,SYSINTEGERTEMPA
	MOVFF	TRIG_SIGN_H,SYSINTEGERTEMPA_H
	SETF	SYSINTEGERTEMPB,ACCESS
	SETF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,TRIG_SIGN
	MOVFF	SYSINTEGERTEMPX_H,TRIG_SIGN_H
;end if
ENDIF9:
;trig_arg2 = trig_ref(trig_arg2)     ;get the reference angle
	MOVFF	TRIG_ARG2,TRIG_ARG1
	MOVFF	TRIG_ARG2_H,TRIG_ARG1_H
	RCALL	FN_TRIG_REF
	MOVFF	TRIG_REF,TRIG_ARG2
	MOVFF	TRIG_REF_H,TRIG_ARG2_H
;trig_i = [byte]trig_arg2+1          ;index into the table
	BANKSEL	TRIG_ARG2
	INCF	TRIG_ARG2,W,BANKED
	MOVWF	TRIG_I,BANKED
;readTable sineTab, trig_i, trig_val
	MOVFF	TRIG_I,SYSSTRINGA
	BANKSEL	0
	RCALL	SINETAB
	BANKSEL	TRIG_VAL
	MOVWF	TRIG_VAL,BANKED
	CLRF	TRIG_VAL_H,BANKED
;sin = trig_sign * [integer]trig_val ;create final result
	MOVFF	TRIG_SIGN,SYSINTEGERTEMPA
	MOVFF	TRIG_SIGN_H,SYSINTEGERTEMPA_H
	MOVFF	TRIG_VAL,SYSINTEGERTEMPB
	MOVFF	TRIG_VAL_H,SYSINTEGERTEMPB_H
	BANKSEL	0
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,SIN
	MOVFF	SYSINTEGERTEMPX_H,SIN_H
	RETURN

;********************************************************************************

SINETAB:
	MOVLW	92
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLESINETAB
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLESINETAB
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLESINETAB
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLESINETAB:
	DB	91,0,2,3,5,7,9,10,12,14,16,17,19,21,22,24,26,28,29,31,33,34,36,37,39,41,42,44
	DB	45,47,48,50,52,53,54,56,57,59,60,62,63,64,66,67,68,69,71,72,73,74,75,77,78,79
	DB	80,81,82,83,84,85,86,87,87,88,89,90,91,91,92,93,93,94,95,95,96,96,97,97,97,98
	DB	98,98,99,99,99,99,100,100,100,100,100,100
	ALIGN	2;X4

;********************************************************************************

;SOURCE: STRING.H (75)
FN_STR:
;SysCharCount = 0
	BANKSEL	SYSCHARCOUNT
	CLRF	SYSCHARCOUNT,BANKED
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF61
;SysStrData = SysValTemp / 10000
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SYSVALTEMP
	MOVFF	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	LFSR	0,STR
	MOVF	SYSCHARCOUNT,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	SYSSTRDATA,W,BANKED
	MOVWF	INDF0,ACCESS
;Goto SysValThousands
	BRA	SYSVALTHOUSANDS
;End If
ENDIF61:
;Thousands
;IF SysValTemp >= 1000 then
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF62
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SYSVALTEMP
	MOVFF	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	LFSR	0,STR
	MOVF	SYSCHARCOUNT,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	SYSSTRDATA,W,BANKED
	MOVWF	INDF0,ACCESS
;Goto SysValHundreds
	BRA	SYSVALHUNDREDS
;End If
ENDIF62:
;Hundreds
;IF SysValTemp >= 100 then
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF63
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SYSVALTEMP
	MOVFF	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	LFSR	0,STR
	MOVF	SYSCHARCOUNT,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	SYSSTRDATA,W,BANKED
	MOVWF	INDF0,ACCESS
;Goto SysValTens
	BRA	SYSVALTENS
;End If
ENDIF63:
;Tens
;IF SysValTemp >= 10 Then
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF64
SYSVALTENS:
;SysStrData = SysValTemp / 10
	MOVFF	SYSVALTEMP,SYSWORDTEMPA
	MOVFF	SYSVALTEMP_H,SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SYSVALTEMP
	MOVFF	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	LFSR	0,STR
	MOVF	SYSCHARCOUNT,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	SYSSTRDATA,W,BANKED
	MOVWF	INDF0,ACCESS
;End If
ENDIF64:
;Ones
;SysCharCount += 1
	BANKSEL	SYSCHARCOUNT
	INCF	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	LFSR	0,STR
	MOVF	SYSCHARCOUNT,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	SYSVALTEMP,W,BANKED
	MOVWF	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	MOVFF	SYSCALCTEMPX,SYSVALTEMP
	MOVFF	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	MOVFFL	SYSCHARCOUNT,SYSSTR_0
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

;SOURCE: SYSTEM.H (3217)
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	BTFSS	SYSINTEGERTEMPA_H,7,ACCESS
	BRA	ELSE58_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF59
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	RETURN
;End If
ENDIF59:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,W,ACCESS
	MOVWF	SYSDIVMULTA,ACCESS
	COMF	SYSINTEGERTEMPA_H,W,ACCESS
	MOVWF	SYSDIVMULTA_H,ACCESS
	INCF	SYSDIVMULTA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,W,ACCESS
	MOVWF	SYSINTEGERTEMPA,ACCESS
	COMF	SYSINTEGERTEMPB_H,W,ACCESS
	MOVWF	SYSINTEGERTEMPA_H,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	MOVFF	SYSDIVMULTA,SYSINTEGERTEMPB
	MOVFF	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	BRA	ENDIF58
ELSE58_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	RETURN
;End If
;End If
ENDIF58:
;Test High, exit if more
;movf SysIntegerTempA_H,W
	MOVF	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	SUBWF	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	MOVF	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	SUBWF	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	BNC	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	MOVF	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	SUBWF	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
;return
	RETURN
SCLTINTTRUE:
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
	BRA	ENDIF51
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
;exit sub
	RETURN
;end if
ENDIF51:
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
	BRA	ENDIF52
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	ADDWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	ADDWFC	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF52:
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
	BANKSEL	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX,BANKED
	CLRF	SYSLONGDIVMULTX_H,BANKED
	CLRF	SYSLONGDIVMULTX_U,BANKED
	CLRF	SYSLONGDIVMULTX_E,BANKED
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
	BANKSEL	0
	RCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF56
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF56:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP,ACCESS
SYSDIV32START:
;set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SysLongDivMultA Left
	BANKSEL	SYSLONGDIVMULTA
	RLCF	SYSLONGDIVMULTA,F,BANKED
	RLCF	SYSLONGDIVMULTA_H,F,BANKED
	RLCF	SYSLONGDIVMULTA_U,F,BANKED
	RLCF	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	RLCF	SYSLONGDIVMULTX,F,BANKED
	RLCF	SYSLONGDIVMULTX_H,F,BANKED
	RLCF	SYSLONGDIVMULTX_U,F,BANKED
	RLCF	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,BANKED
	SUBWF	SYSLONGDIVMULTX,F,BANKED
	MOVF	SYSLONGDIVMULTB_H,W,BANKED
	SUBWFB	SYSLONGDIVMULTX_H,F,BANKED
	MOVF	SYSLONGDIVMULTB_U,W,BANKED
	SUBWFB	SYSLONGDIVMULTX_U,F,BANKED
	MOVF	SYSLONGDIVMULTB_E,W,BANKED
	SUBWFB	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF57
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,BANKED
	ADDWF	SYSLONGDIVMULTX,F,BANKED
	MOVF	SYSLONGDIVMULTB_H,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_H,F,BANKED
	MOVF	SYSLONGDIVMULTB_U,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_U,F,BANKED
	MOVF	SYSLONGDIVMULTB_E,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF57:
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
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2766)
SYSDIVSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W,ACCESS
	XORWF	SYSINTEGERTEMPB_H,W,ACCESS
	MOVWF	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7,ACCESS
	BRA	ENDIF53
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF53:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF54
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF54:
;Call word divide routine
;SysDivSub16
	RCALL	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF55
;SysIntegerTempA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	COMF	SYSINTEGERTEMPX,F,ACCESS
	COMF	SYSINTEGERTEMPX_H,F,ACCESS
	INCF	SYSINTEGERTEMPX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF55:
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
	BANKSEL	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX,BANKED
	CLRF	SYSLONGDIVMULTX_H,BANKED
	CLRF	SYSLONGDIVMULTX_U,BANKED
	CLRF	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BANKSEL	SYSLONGDIVMULTB
	BTFSS	SYSLONGDIVMULTB,0,BANKED
	BRA	ENDIF49
	MOVF	SYSLONGDIVMULTA,W,BANKED
	ADDWF	SYSLONGDIVMULTX,F,BANKED
	MOVF	SYSLONGDIVMULTA_H,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_H,F,BANKED
	MOVF	SYSLONGDIVMULTA_U,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_U,F,BANKED
	MOVF	SYSLONGDIVMULTA_E,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_E,F,BANKED
ENDIF49:
;set STATUS.C OFF
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultB right
	RRCF	SYSLONGDIVMULTB_E,F,BANKED
	RRCF	SYSLONGDIVMULTB_U,F,BANKED
	RRCF	SYSLONGDIVMULTB_H,F,BANKED
	RRCF	SYSLONGDIVMULTB,F,BANKED
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultA left
	RLCF	SYSLONGDIVMULTA,F,BANKED
	RLCF	SYSLONGDIVMULTA_H,F,BANKED
	RLCF	SYSLONGDIVMULTA_U,F,BANKED
	RLCF	SYSLONGDIVMULTA_E,F,BANKED
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVFF	SYSLONGDIVMULTB,SYSLONGTEMPB
	MOVFF	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	MOVFF	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	MOVFF	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	BANKSEL	0
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

;SOURCE: SYSTEM.H (2565)
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W,ACCESS
	XORWF	SYSINTEGERTEMPB_H,W,ACCESS
	MOVWF	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7,ACCESS
	BRA	ENDIF46
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF46:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF47
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF47:
;Call word multiply routine
;SysMultSub16
	RCALL	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF48
	COMF	SYSINTEGERTEMPX,F,ACCESS
	COMF	SYSINTEGERTEMPX_H,F,ACCESS
	INCF	SYSINTEGERTEMPX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF48:
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
	DB	1,48

	ALIGN	2;X3

STRINGTABLE2:
	DB	1,53

	ALIGN	2;X3

STRINGTABLE3:
	DB	3,48,46,48

	ALIGN	2;X3

STRINGTABLE4:
	DB	2,48,46

	ALIGN	2;X3

STRINGTABLE5:
	DB	1,46

	ALIGN	2;X3

;********************************************************************************

;SOURCE: TRIG2PLACES.H (29)
FN_TRIG_REF:
;create reference angle (0 to 90) for the argument
;if (trig_arg1 > 270) then           ;Quadrant IV
	MOVFF	TRIG_ARG1,SYSINTEGERTEMPB
	MOVFF	TRIG_ARG1_H,SYSINTEGERTEMPB_H
	MOVLW	14
	MOVWF	SYSINTEGERTEMPA,ACCESS
	MOVLW	1
	MOVWF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE94_1
;trig_ref = 360 - trig_arg1
	BANKSEL	TRIG_ARG1
	MOVF	TRIG_ARG1,W,BANKED
	SUBLW	104
	MOVWF	TRIG_REF,BANKED
	MOVLW	1
	MOVWF	SYSTEMP1,BANKED
	MOVF	TRIG_ARG1_H,W,BANKED
	SUBWFB	SYSTEMP1,W,BANKED
	MOVWF	TRIG_REF_H,BANKED
;else
	BRA	ENDIF94
ELSE94_1:
;if (trig_arg1 > 180) then         ;Quadrant III
	MOVFF	TRIG_ARG1,SYSINTEGERTEMPB
	MOVFF	TRIG_ARG1_H,SYSINTEGERTEMPB_H
	MOVLW	180
	MOVWF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE95_1
;trig_ref = trig_arg1 - 180
	MOVLW	180
	BANKSEL	TRIG_ARG1
	SUBWF	TRIG_ARG1,W,BANKED
	MOVWF	TRIG_REF,BANKED
	MOVLW	0
	SUBWFB	TRIG_ARG1_H,W,BANKED
	MOVWF	TRIG_REF_H,BANKED
;else                              ;Quadrant II
	BRA	ENDIF95
ELSE95_1:
;if (trig_arg1 > 90) then
	MOVFF	TRIG_ARG1,SYSINTEGERTEMPB
	MOVFF	TRIG_ARG1_H,SYSINTEGERTEMPB_H
	MOVLW	90
	MOVWF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE96_1
;trig_ref = 180 - trig_arg1
	BANKSEL	TRIG_ARG1
	MOVF	TRIG_ARG1,W,BANKED
	SUBLW	180
	MOVWF	TRIG_REF,BANKED
	CLRF	SYSTEMP1,BANKED
	MOVF	TRIG_ARG1_H,W,BANKED
	SUBWFB	SYSTEMP1,W,BANKED
	MOVWF	TRIG_REF_H,BANKED
;else
	BRA	ENDIF96
ELSE96_1:
;trig_ref = trig_arg1          ;Quadrant I by default
	MOVFF	TRIG_ARG1,TRIG_REF
	MOVFF	TRIG_ARG1_H,TRIG_REF_H
;end if
ENDIF96:
;end if
ENDIF95:
;end if
ENDIF94:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (216)
WRITE_COMMAND_SSD1306:
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE,ACCESS
	CALL	SI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE,ACCESS
	CALL	SI2CSEND
;HI2CSend SSD1306SendByte
	MOVFF	SSD1306SENDBYTE,I2CBYTE
	CALL	SI2CSEND
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
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE,ACCESS
	CALL	SI2CSEND
;HI2CSend SSD1306SendByte
	MOVFF	SSD1306SENDBYTE,I2CBYTE
	CALL	SI2CSEND
;HI2CStop
	BRA	SI2CSTOP

;********************************************************************************

;SOURCE: PICAS.H (26)
_LINE:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	CLRF	LINEDIFFX,ACCESS
	CLRF	LINEDIFFX_H,ACCESS
;LineDiffY = 0
	CLRF	LINEDIFFY,ACCESS
	CLRF	LINEDIFFY_H,ACCESS
;LineStepX = 0
	CLRF	LINESTEPX,ACCESS
	CLRF	LINESTEPX_H,ACCESS
;LineStepY = 0
	CLRF	LINESTEPY,ACCESS
	CLRF	LINESTEPY_H,ACCESS
;LineDiffX_x2 = 0
	CLRF	LINEDIFFX_X2,ACCESS
	CLRF	LINEDIFFX_X2_H,ACCESS
;LineDiffY_x2 = 0
	CLRF	LINEDIFFY_X2,ACCESS
	CLRF	LINEDIFFY_X2_H,ACCESS
;LineErr = 0
	CLRF	LINEERR,ACCESS
	CLRF	LINEERR_H,ACCESS
;LineDiffX =  LineX2 -   LineX1
	MOVF	LINEX1,W,ACCESS
	SUBWF	LINEX2,W,ACCESS
	MOVWF	LINEDIFFX,ACCESS
	MOVF	LINEX1_H,W,ACCESS
	SUBWFB	LINEX2_H,W,ACCESS
	MOVWF	LINEDIFFX_H,ACCESS
;LineDiffY =  LineY2 -   LineY1
	MOVF	LINEY1,W,ACCESS
	SUBWF	LINEY2,W,ACCESS
	MOVWF	LINEDIFFY,ACCESS
	MOVF	LINEY1_H,W,ACCESS
	SUBWFB	LINEY2_H,W,ACCESS
	MOVWF	LINEDIFFY_H,ACCESS
;if (LineDiffX > 0) then
	MOVFF	LINEDIFFX,SYSINTEGERTEMPB
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE40_1
;LineStepX = 1
	MOVLW	1
	MOVWF	LINESTEPX,ACCESS
	CLRF	LINESTEPX_H,ACCESS
;else
	BRA	ENDIF40
ELSE40_1:
;LineStepX = -1
	SETF	LINESTEPX,ACCESS
	SETF	LINESTEPX_H,ACCESS
;end if
ENDIF40:
;if (LineDiffY > 0) then
	MOVFF	LINEDIFFY,SYSINTEGERTEMPB
	MOVFF	LINEDIFFY_H,SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE41_1
;LineStepY = 1
	MOVLW	1
	MOVWF	LINESTEPY,ACCESS
	CLRF	LINESTEPY_H,ACCESS
;else
	BRA	ENDIF41
ELSE41_1:
;LineStepY = -1
	SETF	LINESTEPY,ACCESS
	SETF	LINESTEPY_H,ACCESS
;end if
ENDIF41:
;LineDiffX = LineStepX * LineDiffX
	MOVFF	LINESTEPX,SYSINTEGERTEMPA
	MOVFF	LINESTEPX_H,SYSINTEGERTEMPA_H
	MOVFF	LINEDIFFX,SYSINTEGERTEMPB
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPB_H
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,LINEDIFFX
	MOVFF	SYSINTEGERTEMPX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	MOVFF	LINESTEPY,SYSINTEGERTEMPA
	MOVFF	LINESTEPY_H,SYSINTEGERTEMPA_H
	MOVFF	LINEDIFFY,SYSINTEGERTEMPB
	MOVFF	LINEDIFFY_H,SYSINTEGERTEMPB_H
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,LINEDIFFY
	MOVFF	SYSINTEGERTEMPX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	MOVFF	LINEDIFFX,SYSINTEGERTEMPA
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,LINEDIFFX_X2
	MOVFF	SYSINTEGERTEMPX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	MOVFF	LINEDIFFY,SYSINTEGERTEMPA
	MOVFF	LINEDIFFY_H,SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,LINEDIFFY_X2
	MOVFF	SYSINTEGERTEMPX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	MOVFF	LINEDIFFX,SYSINTEGERTEMPA
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPA_H
	MOVFF	LINEDIFFY,SYSINTEGERTEMPB
	MOVFF	LINEDIFFY_H,SYSINTEGERTEMPB_H
	RCALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE42_1
;LineErr = LineDiffY_x2 - LineDiffX
	MOVF	LINEDIFFX,W,ACCESS
	SUBWF	LINEDIFFY_X2,W,ACCESS
	MOVWF	LINEERR,ACCESS
	MOVF	LINEDIFFX_H,W,ACCESS
	SUBWFB	LINEDIFFY_X2_H,W,ACCESS
	MOVWF	LINEERR_H,ACCESS
;do while (   LineX1 <>  LineX2 )
SYSDOLOOP_S2:
	MOVFF	LINEX1,SYSWORDTEMPA
	MOVFF	LINEX1_H,SYSWORDTEMPA_H
	MOVFF	LINEX2,SYSWORDTEMPB
	MOVFF	LINEX2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E2
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;LineX1 += LineStepX
	MOVF	LINESTEPX,W,ACCESS
	ADDWF	LINEX1,F,ACCESS
	MOVF	LINESTEPX_H,W,ACCESS
	ADDWFC	LINEX1_H,F,ACCESS
;if ( LineErr < 0) then
	MOVFF	LINEERR,SYSINTEGERTEMPA
	MOVFF	LINEERR_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE43_1
;LineErr += LineDiffY_x2
	MOVF	LINEDIFFY_X2,W,ACCESS
	ADDWF	LINEERR,F,ACCESS
	MOVF	LINEDIFFY_X2_H,W,ACCESS
	ADDWFC	LINEERR_H,F,ACCESS
;else
	BRA	ENDIF43
ELSE43_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	MOVF	LINEDIFFX_X2,W,ACCESS
	SUBWF	LINEDIFFY_X2,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	MOVF	LINEDIFFX_X2_H,W,ACCESS
	SUBWFB	LINEDIFFY_X2_H,W,ACCESS
	MOVWF	SYSTEMP1_H,BANKED
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	LINEERR,F,ACCESS
	MOVF	SYSTEMP1_H,W,BANKED
	ADDWFC	LINEERR_H,F,ACCESS
;LineY1 += LineStepY
	MOVF	LINESTEPY,W,ACCESS
	ADDWF	LINEY1,F,ACCESS
	MOVF	LINESTEPY_H,W,ACCESS
	ADDWFC	LINEY1_H,F,ACCESS
;end if
ENDIF43:
;loop
	BRA	SYSDOLOOP_S2
SYSDOLOOP_E2:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;else
	BRA	ENDIF42
ELSE42_1:
;LineErr = LineDiffX_x2 - LineDiffY
	MOVF	LINEDIFFY,W,ACCESS
	SUBWF	LINEDIFFX_X2,W,ACCESS
	MOVWF	LINEERR,ACCESS
	MOVF	LINEDIFFY_H,W,ACCESS
	SUBWFB	LINEDIFFX_X2_H,W,ACCESS
	MOVWF	LINEERR_H,ACCESS
;do while (   LineY1 <>  LineY2)
SYSDOLOOP_S3:
	MOVFF	LINEY1,SYSWORDTEMPA
	MOVFF	LINEY1_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E3
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;LineY1 += LineStepY
	MOVF	LINESTEPY,W,ACCESS
	ADDWF	LINEY1,F,ACCESS
	MOVF	LINESTEPY_H,W,ACCESS
	ADDWFC	LINEY1_H,F,ACCESS
;if ( LineErr < 0) then
	MOVFF	LINEERR,SYSINTEGERTEMPA
	MOVFF	LINEERR_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE44_1
;LineErr += LineDiffX_x2
	MOVF	LINEDIFFX_X2,W,ACCESS
	ADDWF	LINEERR,F,ACCESS
	MOVF	LINEDIFFX_X2_H,W,ACCESS
	ADDWFC	LINEERR_H,F,ACCESS
;else
	BRA	ENDIF44
ELSE44_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	MOVF	LINEDIFFY_X2,W,ACCESS
	SUBWF	LINEDIFFX_X2,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	MOVF	LINEDIFFY_X2_H,W,ACCESS
	SUBWFB	LINEDIFFX_X2_H,W,ACCESS
	MOVWF	SYSTEMP1_H,BANKED
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	LINEERR,F,ACCESS
	MOVF	SYSTEMP1_H,W,BANKED
	ADDWFC	LINEERR_H,F,ACCESS
;LineX1 += LineStepX
	MOVF	LINESTEPX,W,ACCESS
	ADDWF	LINEX1,F,ACCESS
	MOVF	LINESTEPX_H,W,ACCESS
	ADDWFC	LINEX1_H,F,ACCESS
;end if
ENDIF44:
;loop
	BRA	SYSDOLOOP_S3
SYSDOLOOP_E3:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;end if
ENDIF42:
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
