;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\200_i2c_glcd_using_ssd1306_128_32.S"
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
 BYTENUMBER                       EQU 1297                    ; 0X511
 CCOUNT                           EQU 1298                    ; 0X512
 CHARCODE                         EQU 1299                    ; 0X513
 CHARCOL                          EQU 1300                    ; 0X514
 CHARCOLS                         EQU 1302                    ; 0X516
 CHARCOL_H                        EQU 1301                    ; 0X515
 CHARLOCX                         EQU 1303                    ; 0X517
 CHARLOCX_H                       EQU 1304                    ; 0X518
 CHARLOCY                         EQU 1305                    ; 0X519
 CHARLOCY_H                       EQU 1306                    ; 0X51A
 CHARROW                          EQU 1307                    ; 0X51B
 CHARROWS                         EQU 1309                    ; 0X51D
 CHARROW_H                        EQU 1308                    ; 0X51C
 CHR                              EQU 5206                    ; 0X1456
 COL                              EQU 1310                    ; 0X51E
 CURRCHARCOL                      EQU 1311                    ; 0X51F
 CURRCHARROW                      EQU 1312                    ; 0X520
 CURRCHARVAL                      EQU 1313                    ; 0X521
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 DRAWLINE                         EQU 1314                    ; 0X522
 DRAWLINE_H                       EQU 1315                    ; 0X523
 FILLED_ELLIPSE                   EQU 1316                    ; 0X524
 GLCDBACKGROUND                   EQU 1317                    ; 0X525
 GLCDBACKGROUND_H                 EQU 1318                    ; 0X526
 GLCDBITNO                        EQU 1319                    ; 0X527
 GLCDCHANGE                       EQU 1320                    ; 0X528
 GLCDCOLOUR                       EQU 1321                    ; 0X529
 GLCDCOLOUR_H                     EQU 1322                    ; 0X52A
 GLCDDATATEMP                     EQU 1323                    ; 0X52B
 GLCDFNTDEFAULT                   EQU 1324                    ; 0X52C
 GLCDFNTDEFAULTHEIGHT             EQU 1325                    ; 0X52D
 GLCDFNTDEFAULTSIZE               EQU 1326                    ; 0X52E
 GLCDFONTWIDTH                    EQU 1327                    ; 0X52F
 GLCDFOREGROUND                   EQU 1328                    ; 0X530
 GLCDFOREGROUND_H                 EQU 1329                    ; 0X531
 GLCDPRINTLEN                     EQU 1330                    ; 0X532
 GLCDPRINTLOC                     EQU 1331                    ; 0X533
 GLCDPRINTLOC_H                   EQU 1332                    ; 0X534
 GLCDPRINT_STRING_COUNTER         EQU 1333                    ; 0X535
 GLCDTEMP                         EQU 1334                    ; 0X536
 GLCDTEMP_H                       EQU 1335                    ; 0X537
 GLCDX                            EQU 1336                    ; 0X538
 GLCDY                            EQU 1337                    ; 0X539
 GLCDY_TEMP                       EQU 1338                    ; 0X53A
 GLCD_EX2                         EQU 1339                    ; 0X53B
 GLCD_EX2_E                       EQU 1342                    ; 0X53E
 GLCD_EX2_H                       EQU 1340                    ; 0X53C
 GLCD_EX2_U                       EQU 1341                    ; 0X53D
 GLCD_EY2                         EQU 1343                    ; 0X53F
 GLCD_EY2_E                       EQU 1346                    ; 0X542
 GLCD_EY2_H                       EQU 1344                    ; 0X540
 GLCD_EY2_U                       EQU 1345                    ; 0X541
 GLCD_FX2                         EQU 1347                    ; 0X543
 GLCD_FX2_E                       EQU 1350                    ; 0X546
 GLCD_FX2_H                       EQU 1348                    ; 0X544
 GLCD_FX2_U                       EQU 1349                    ; 0X545
 GLCD_FY2                         EQU 1351                    ; 0X547
 GLCD_FY2_E                       EQU 1354                    ; 0X54A
 GLCD_FY2_H                       EQU 1352                    ; 0X548
 GLCD_FY2_U                       EQU 1353                    ; 0X549
 GLCD_PP                          EQU 1355                    ; 0X54B
 GLCD_PP_E                        EQU 1358                    ; 0X54E
 GLCD_PP_H                        EQU 1356                    ; 0X54C
 GLCD_PP_TEMP                     EQU 1359                    ; 0X54F
 GLCD_PP_TEMP_E                   EQU 1362                    ; 0X552
 GLCD_PP_TEMP_H                   EQU 1360                    ; 0X550
 GLCD_PP_TEMP_U                   EQU 1361                    ; 0X551
 GLCD_PP_U                        EQU 1357                    ; 0X54D
 GLCD_PX                          EQU 1363                    ; 0X553
 GLCD_PX_E                        EQU 1366                    ; 0X556
 GLCD_PX_H                        EQU 1364                    ; 0X554
 GLCD_PX_U                        EQU 1365                    ; 0X555
 GLCD_PY                          EQU 1367                    ; 0X557
 GLCD_PY_E                        EQU 1370                    ; 0X55A
 GLCD_PY_H                        EQU 1368                    ; 0X558
 GLCD_PY_U                        EQU 1369                    ; 0X559
 GLCD_RX2                         EQU 1371                    ; 0X55B
 GLCD_RX2_H                       EQU 1372                    ; 0X55C
 GLCD_RY2                         EQU 1373                    ; 0X55D
 GLCD_RY2_H                       EQU 1374                    ; 0X55E
 GLCD_XX                          EQU 1375                    ; 0X55F
 GLCD_XX_H                        EQU 1376                    ; 0X560
 GLCD_YORDINATE                   EQU 1377                    ; 0X561
 GLCD_YORDINATE_H                 EQU 1378                    ; 0X562
 GLCD_YY                          EQU 1379                    ; 0X563
 GLCD_YY1                         EQU 1381                    ; 0X565
 GLCD_YY_H                        EQU 1380                    ; 0X564
 HI2C1LASTERROR                   EQU 1382                    ; 0X566
 HI2C1STATEMACHINE                EQU 1383                    ; 0X567
 HI2CACKPOLLSTATE                 EQU 1384                    ; 0X568
 HI2CCURRENTMODE                  EQU 1385                    ; 0X569
 HI2CWAITMSSPTIMEOUT              EQU 1386                    ; 0X56A
 I2CBYTE                          EQU 1387                    ; 0X56B
 INXRADIUS                        EQU 1388                    ; 0X56C
 INXRADIUS_H                      EQU 1389                    ; 0X56D
 INYRADIUS                        EQU 1390                    ; 0X56E
 INYRADIUS_H                      EQU 1391                    ; 0X56F
 LCDVALUE                         EQU 1392                    ; 0X570
 LCDVALUE_E                       EQU 1395                    ; 0X573
 LCDVALUE_H                       EQU 1393                    ; 0X571
 LCDVALUE_U                       EQU 1394                    ; 0X572
 LINECOLOUR                       EQU 1396                    ; 0X574
 LINECOLOUR_H                     EQU 1397                    ; 0X575
 LINEDIFFX                        EQU 1398                    ; 0X576
 LINEDIFFX_H                      EQU 1399                    ; 0X577
 LINEDIFFX_X2                     EQU 1400                    ; 0X578
 LINEDIFFX_X2_H                   EQU 1401                    ; 0X579
 LINEDIFFY                        EQU 1402                    ; 0X57A
 LINEDIFFY_H                      EQU 1403                    ; 0X57B
 LINEDIFFY_X2                     EQU 1404                    ; 0X57C
 LINEDIFFY_X2_H                   EQU 1405                    ; 0X57D
 LINEERR                          EQU 1406                    ; 0X57E
 LINEERR_H                        EQU 1407                    ; 0X57F
 LINESTEPX                        EQU 1408                    ; 0X580
 LINESTEPX_H                      EQU 1409                    ; 0X581
 LINESTEPY                        EQU 1410                    ; 0X582
 LINESTEPY_H                      EQU 1411                    ; 0X583
 LINEX1                           EQU 1412                    ; 0X584
 LINEX1_H                         EQU 1413                    ; 0X585
 LINEX2                           EQU 1414                    ; 0X586
 LINEX2_H                         EQU 1415                    ; 0X587
 LINEY1                           EQU 1416                    ; 0X588
 LINEY1_H                         EQU 1417                    ; 0X589
 LINEY2                           EQU 1418                    ; 0X58A
 LINEY2_H                         EQU 1419                    ; 0X58B
 LOCX                             EQU 1420                    ; 0X58C
 LOCY                             EQU 1421                    ; 0X58D
 LONGNUMBER                       EQU 1422                    ; 0X58E
 LONGNUMBER_E                     EQU 1425                    ; 0X591
 LONGNUMBER_H                     EQU 1423                    ; 0X58F
 LONGNUMBER_U                     EQU 1424                    ; 0X590
 OUTSTRING                        EQU 5165                    ; 0X142D
 PAD                              EQU 5124                    ; 0X1404
 POSCHARX                         EQU 1426                    ; 0X592
 POSCHARX_H                       EQU 1427                    ; 0X593
 POSCHARY                         EQU 1428                    ; 0X594
 PRINTLOCX                        EQU 1429                    ; 0X595
 PRINTLOCX_H                      EQU 1430                    ; 0X596
 PRINTLOCY                        EQU 1431                    ; 0X597
 PRINTLOCY_H                      EQU 1432                    ; 0X598
 RADIUSERR                        EQU 1433                    ; 0X599
 RADIUSERR_H                      EQU 1434                    ; 0X59A
 READAD                           EQU 1435                    ; 0X59B
 ROW                              EQU 1436                    ; 0X59C
 SSD1306SENDBYTE                  EQU 1437                    ; 0X59D
 SSD1306_BUFFERALIAS              EQU 5247                    ; 0X147F
 SSD1306_BUFFERLOCATIONCALC       EQU 1438                    ; 0X59E
 SSD1306_BUFFERLOCATIONCALC_H     EQU 1439                    ; 0X59F
 STR                              EQU 5091                    ; 0X13E3
 STRINGLOCX                       EQU 1440                    ; 0X5A0
 STRINGPOINTER                    EQU 1441                    ; 0X5A1
 SYSARRAYTEMP1                    EQU 1442                    ; 0X5A2
 SYSARRAYTEMP2                    EQU 1443                    ; 0X5A3
 SYSBYTETEMPA                     EQU 1285                    ; 0X505
 SYSBYTETEMPB                     EQU 1289                    ; 0X509
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSCALCTEMPA_E                   EQU 1288                    ; 0X508
 SYSCALCTEMPA_H                   EQU 1286                    ; 0X506
 SYSCALCTEMPA_U                   EQU 1287                    ; 0X507
 SYSCALCTEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPX_H                   EQU 1281                    ; 0X501
 SYSCHAR                          EQU 1444                    ; 0X5A4
 SYSCHARCOUNT                     EQU 1445                    ; 0X5A5
 SYSCHARSHANDLER                  EQU 1446                    ; 0X5A6
 SYSCHARSHANDLER_H                EQU 1447                    ; 0X5A7
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
 SYSLCDPRINTDATAHANDLER           EQU 1448                    ; 0X5A8
 SYSLCDPRINTDATAHANDLER_H         EQU 1449                    ; 0X5A9
 SYSLONGDIVMULTA                  EQU 1450                    ; 0X5AA
 SYSLONGDIVMULTA_E                EQU 1453                    ; 0X5AD
 SYSLONGDIVMULTA_H                EQU 1451                    ; 0X5AB
 SYSLONGDIVMULTA_U                EQU 1452                    ; 0X5AC
 SYSLONGDIVMULTB                  EQU 1454                    ; 0X5AE
 SYSLONGDIVMULTB_E                EQU 1457                    ; 0X5B1
 SYSLONGDIVMULTB_H                EQU 1455                    ; 0X5AF
 SYSLONGDIVMULTB_U                EQU 1456                    ; 0X5B0
 SYSLONGDIVMULTX                  EQU 1458                    ; 0X5B2
 SYSLONGDIVMULTX_E                EQU 1461                    ; 0X5B5
 SYSLONGDIVMULTX_H                EQU 1459                    ; 0X5B3
 SYSLONGDIVMULTX_U                EQU 1460                    ; 0X5B4
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
 SYSPRINTBUFFER                   EQU 5097                    ; 0X13E9
 SYSPRINTBUFFLEN                  EQU 1462                    ; 0X5B6
 SYSREPEATTEMP1                   EQU 1463                    ; 0X5B7
 SYSREPEATTEMP2                   EQU 1464                    ; 0X5B8
 SYSREPEATTEMP4                   EQU 1465                    ; 0X5B9
 SYSSIGNBYTE                      EQU 1293                    ; 0X50D
 SYSSTRDATA                       EQU 1466                    ; 0X5BA
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 5108                    ; 0X13F4
 SYSSTRINGTEMP                    EQU 1467                    ; 0X5BB
 SYSSTRLEN                        EQU 1468                    ; 0X5BC
 SYSSYSINSTRING3HANDLER           EQU 1469                    ; 0X5BD
 SYSSYSINSTRING3HANDLER_H         EQU 1470                    ; 0X5BE
 SYSSYSINSTRINGHANDLER            EQU 1471                    ; 0X5BF
 SYSSYSINSTRINGHANDLER_H          EQU 1472                    ; 0X5C0
 SYSTEMP1                         EQU 1473                    ; 0X5C1
 SYSTEMP1_E                       EQU 1476                    ; 0X5C4
 SYSTEMP1_H                       EQU 1474                    ; 0X5C2
 SYSTEMP1_U                       EQU 1475                    ; 0X5C3
 SYSTEMP2                         EQU 1477                    ; 0X5C5
 SYSTEMP2_H                       EQU 1478                    ; 0X5C6
 SYSTEMP3                         EQU 1479                    ; 0X5C7
 SYSTEMP3_H                       EQU 1480                    ; 0X5C8
 SYSVALTEMP                       EQU 1481                    ; 0X5C9
 SYSVALTEMP_H                     EQU 1482                    ; 0X5CA
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504
 SYSWAITTEMPUS                    EQU 1285                    ; 0X505
 SYSWAITTEMPUS_H                  EQU 1286                    ; 0X506
 SYSWORDTEMPA                     EQU 1285                    ; 0X505
 SYSWORDTEMPA_H                   EQU 1286                    ; 0X506
 SYSWORDTEMPB                     EQU 1289                    ; 0X509
 SYSWORDTEMPB_H                   EQU 1290                    ; 0X50A
 SYSWORDTEMPX                     EQU 1280                    ; 0X500
 SYSWORDTEMPX_H                   EQU 1281                    ; 0X501
 WORDNUMBER                       EQU 1483                    ; 0X5CB
 WORDNUMBER_H                     EQU 1484                    ; 0X5CC
 XCHAR                            EQU 1485                    ; 0X5CD
 XOFFSET                          EQU 1486                    ; 0X5CE
 XOFFSET_H                        EQU 1487                    ; 0X5CF
 XRADIUS                          EQU 1488                    ; 0X5D0
 XRADIUS_H                        EQU 1489                    ; 0X5D1
 YOFFSET                          EQU 1490                    ; 0X5D2
 YOFFSET_H                        EQU 1491                    ; 0X5D3
 YORDINATE                        EQU 1492                    ; 0X5D4
 _GLCDPAGE                        EQU 1493                    ; 0X5D5

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYSCHR_0                         EQU 5206
 SYSCHR_1                         EQU 5207
 SYSPAD_0                         EQU 5124
 SYSREADADBYTE                    EQU 1435
 SYSSTR_0                         EQU 5091

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
;''This demonstration program is a simple GLCD demonstration of the SSD1306 GLCD capabilities.
;''
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The SSD1306 controller a small graphical OLED, suitable for a lot of various projects.
;''The display is 38*17 mm, with an active display surface of 0.96inches , and a 128*32 pixel resolution.
;''The display is easy to interface, using an I2C type of communication.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''
;''This version is compatible will all version of Great Cow BASIC but only version greater than v0.98.00 support low memory GLCD modes.
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
;' IO:    ----SCL-----SDA------------------
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
;For this solution we can set the TSCL period to Zero as the Stop condition must be held for TSCL after Stop transition
;#define HI2CITSCLWaitPeriod 0
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;#DEFINE GLCD_TYPE GLCD_TYPE_SSD1306_32
;#DEFINE GLCD_I2C_Address 0x78
;----- Define variables
;These constants allow you to change the GLCD memory usage.
;We have set this demonstration to use only 128bytes of RAM for GLCD operations.
;#DEFINE GLCD_TYPE_SSD1306_LOWMEMORY_GLCD_MODE
;#DEFINE GLCD_TYPE_SSD1306_CHARACTER_MODE_ONLY
;#DEFINE GLCD_PROTECTOVERRUN
;Dim BYTENUMBER, CCOUNT As Byte
;CCount = 0
	CLRF	CCOUNT,ACCESS
;Dim longNumber As Long
;max value = 4294967290
;longNumber = 0
	BANKSEL	LONGNUMBER
	CLRF	LONGNUMBER,BANKED
	CLRF	LONGNUMBER_H,BANKED
	CLRF	LONGNUMBER_U,BANKED
	CLRF	LONGNUMBER_E,BANKED
;Dim wordNumber, adcval, ldrval As Word
;Dim outstring As String
;wordNumber = 0
	CLRF	WORDNUMBER,BANKED
	CLRF	WORDNUMBER_H,BANKED
;byteNumber = 0
	CLRF	BYTENUMBER,ACCESS
;Dir PORTB.1 Out
	BCF	TRISB,1,ACCESS
;Dir PORTB.5 Out
	BCF	TRISB,5,ACCESS
;Dir PORTB.0 In
	BSF	TRISB,0,ACCESS
;----- Main program
;GLCD_Open_PageTransaction 0,3
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	SETF	_GLCDPAGE,BANKED
SYSFORLOOP1:
	INCF	_GLCDPAGE,F,BANKED
;GLCDPrint 0, 0,   "Great Cow BASIC"
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	CLRF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint (0, 16, "Anobium 2021")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	16
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE2
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE2
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint (76, 16, GLCD_WIDTH )
	MOVLW	76
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	16
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	128
	MOVWF	LCDVALUE,BANKED
	CLRF	LCDVALUE_H,BANKED
	CLRF	LCDVALUE_U,BANKED
	CLRF	LCDVALUE_E,BANKED
	BANKSEL	0
	CALL	GLCDPRINT7
;GLCDPrint (96, 16, "*" )
	MOVLW	96
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	16
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE3
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE3
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE3
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint (104, 16, GLCD_HEIGHT )
	MOVLW	104
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	16
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	32
	MOVWF	LCDVALUE,BANKED
	CLRF	LCDVALUE_H,BANKED
	CLRF	LCDVALUE_U,BANKED
	CLRF	LCDVALUE_E,BANKED
	BANKSEL	0
	CALL	GLCDPRINT7
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX,BANKED
	MOVF	_GLCDPAGE,W,BANKED
	MULLW	8
;A2: ASM Source was:  MOVFF PRODL,LOCY
;A4: ASM Source was:  MOVFF PRODL,LOCY
	MOVFF	PROD,LOCY
	BANKSEL	0
	CALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC,BANKED
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP2:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,I2CBYTE
	BANKSEL	0
	CALL	SI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
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
	CLRF	INDF0,ACCESS
;next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	CALL	SI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS,ACCESS
	BANKSEL	0
	CALL	DELAY_S
;GLCDCLS
	CALL	GLCDCLS_SSD1306
;GLCD_Open_PageTransaction 0, 3
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	BANKSEL	_GLCDPAGE
	SETF	_GLCDPAGE,BANKED
SYSFORLOOP3:
	INCF	_GLCDPAGE,F,BANKED
;GLCDPrint 0, 0,   "Version 0.98.07"
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	CLRF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE4
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE4
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE4
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint (0, 16, "LM GLCD MODE")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	16
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE5
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE5
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE5
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX,BANKED
	MOVF	_GLCDPAGE,W,BANKED
	MULLW	8
;A2: ASM Source was:  MOVFF PRODL,LOCY
;A4: ASM Source was:  MOVFF PRODL,LOCY
	MOVFF	PROD,LOCY
	BANKSEL	0
	RCALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC,BANKED
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP4:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,I2CBYTE
	BANKSEL	0
	CALL	SI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
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
	CLRF	INDF0,ACCESS
;next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	CALL	SI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS,ACCESS
	BANKSEL	0
	CALL	DELAY_S
;GLCDCLS
	CALL	GLCDCLS_SSD1306
;Do Forever
SYSDOLOOP_S1:
;For CCount = 31 To 127
	MOVLW	30
	MOVWF	CCOUNT,ACCESS
SYSFORLOOP5:
	INCF	CCOUNT,F,ACCESS
;Prepare a string
;outString = Str( CCount )
	MOVFF	CCOUNT,SYSVALTEMP
	BANKSEL	SYSVALTEMP_H
	CLRF	SYSVALTEMP_H,BANKED
	BANKSEL	0
	CALL	FN_STR
	LFSR	1,OUTSTRING
	LFSR	0,STR
	CALL	SYSCOPYSTRING
;adcval = ReadAD ( AN0 )
	CLRF	ADREADPORT,ACCESS
	CALL	FN_READAD443
	MOVFF	SYSREADADBYTE,ADCVAL
	CLRF	ADCVAL_H,ACCESS
;Prepare the static components of the screen
;GLCD_Open_PageTransaction 0,3
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	BANKSEL	_GLCDPAGE
	SETF	_GLCDPAGE,BANKED
SYSFORLOOP6:
	INCF	_GLCDPAGE,F,BANKED
;Print some text
;GLCDPrint ( 1,   1, "PrintStr")
	MOVLW	1
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	1
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE7
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE7
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE7
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;Print some more text
;GLCDPrint ( 64,  1, "@")
	MOVLW	64
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	1
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE8
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE8
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE8
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;Print chip speed
;GLCDPrint ( 72,  1, ChipMHz)
	MOVLW	72
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	1
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	64
	MOVWF	LCDVALUE,BANKED
	CLRF	LCDVALUE_H,BANKED
	CLRF	LCDVALUE_U,BANKED
	CLRF	LCDVALUE_E,BANKED
	BANKSEL	0
	CALL	GLCDPRINT7
;Print some text
;GLCDPrint ( 86, 1, "Mhz")
	MOVLW	86
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	1
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE9
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE9
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE9
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;Draw some text
;GLCDDrawString( 1,11,"DrawStr")
	MOVLW	1
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX,BANKED
	MOVLW	11
	MOVWF	CHARLOCY,ACCESS
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE10
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE10
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE10
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSCHARSHANDLER_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	GLCDDRAWSTRING
;Draw a box
;Box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1
	BANKSEL	LINEX1
	CLRF	LINEX1,BANKED
	CLRF	LINEX1_H,BANKED
	CLRF	LINEY1,BANKED
	CLRF	LINEY1_H,BANKED
	MOVLW	127
	MOVWF	LINEX2,BANKED
	CLRF	LINEX2_H,BANKED
	MOVLW	31
	MOVWF	LINEY2,BANKED
	CLRF	LINEY2_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	RCALL	BOX
;Draw a box
;Box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1
	MOVLW	123
	BANKSEL	LINEX1
	MOVWF	LINEX1,BANKED
	CLRF	LINEX1_H,BANKED
	MOVLW	27
	MOVWF	LINEY1,BANKED
	CLRF	LINEY1_H,BANKED
	MOVLW	127
	MOVWF	LINEX2,BANKED
	CLRF	LINEX2_H,BANKED
	MOVLW	31
	MOVWF	LINEY2,BANKED
	CLRF	LINEY2_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	RCALL	BOX
;Draw a circle
;Circle( 44,24,5)
	MOVLW	44
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	24
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	5
	MOVWF	INXRADIUS,BANKED
	CLRF	INXRADIUS_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	MOVFF	GLCD_YORDINATE,YORDINATE
	BANKSEL	0
	RCALL	CIRCLE
;Draw a line
;Line 0,GLCD_HEIGHT-1,44,19
	BANKSEL	LINEX1
	CLRF	LINEX1,BANKED
	CLRF	LINEX1_H,BANKED
	MOVLW	31
	MOVWF	LINEY1,BANKED
	CLRF	LINEY1_H,BANKED
	MOVLW	44
	MOVWF	LINEX2,BANKED
	CLRF	LINEX2_H,BANKED
	MOVLW	19
	MOVWF	LINEY2,BANKED
	CLRF	LINEY2_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	_LINE
;GLCDPrint ( 75 ,  20,  "ADC:"+Pad(Str(adcval),4 ) )
	MOVLW	75
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	20
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	ADCVAL,SYSVALTEMP
	MOVFF	ADCVAL_H,SYSVALTEMP_H
	BANKSEL	0
	CALL	FN_STR
	MOVLW	LOW STR
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH STR
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	4
	MOVWF	SYSSTRLEN,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE57
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE57
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE57
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSSYSINSTRING3HANDLER
	MOVWF	SYSSYSINSTRING3HANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSSYSINSTRING3HANDLER_H,BANKED
	BANKSEL	0
	CALL	FN_PAD
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	MOVLW	LOW STRINGTABLE11
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE11
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE11
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,PAD
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;Draw a Box
;Box (3,24,6,27)
	MOVLW	3
	BANKSEL	LINEX1
	MOVWF	LINEX1,BANKED
	CLRF	LINEX1_H,BANKED
	MOVLW	24
	MOVWF	LINEY1,BANKED
	CLRF	LINEY1_H,BANKED
	MOVLW	6
	MOVWF	LINEX2,BANKED
	CLRF	LINEX2_H,BANKED
	MOVLW	27
	MOVWF	LINEY2,BANKED
	CLRF	LINEY2_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	RCALL	BOX
;Draw a string
;GLCDDrawString(44, 11, CHR(CCount)+"="+Pad(outString,3) )
	MOVLW	44
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX,BANKED
	MOVLW	11
	MOVWF	CHARLOCY,ACCESS
	MOVFF	CCOUNT,SYSCHAR
	BANKSEL	0
	RCALL	FN_CHR
	MOVLW	LOW OUTSTRING
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH OUTSTRING
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	3
	MOVWF	SYSSTRLEN,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE57
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE57
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE57
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSSYSINSTRING3HANDLER
	MOVWF	SYSSYSINSTRING3HANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSSYSINSTRING3HANDLER_H,BANKED
	BANKSEL	0
	CALL	FN_PAD
	LFSR	1,SYSSTRINGPARAM1
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,CHR
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE12
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE12
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE12
	MOVWF	TBLPTRU,ACCESS
	CALL	SYSREADSTRINGPART
	LFSR	0,PAD
	CALL	SYSCOPYSTRINGPART
	LFSR	0,SYSSTRINGPARAM1
	MOVFF	SYSSTRINGLENGTH, INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSCHARSHANDLER_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	GLCDDRAWSTRING
;Ellipse 118, 6, 7, 4
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	6
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	7
	MOVWF	INXRADIUS,BANKED
	CLRF	INXRADIUS_H,BANKED
	MOVLW	4
	MOVWF	INYRADIUS,BANKED
	CLRF	INYRADIUS_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	ELLIPSE
;If adcval > 127 Then
	MOVFF	ADCVAL,SYSWORDTEMPB
	MOVFF	ADCVAL_H,SYSWORDTEMPB_H
	MOVLW	127
	MOVWF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE5_1
;FilledEllipse 118, 6, 5, 2
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	6
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	5
	MOVWF	INXRADIUS,BANKED
	CLRF	INXRADIUS_H,BANKED
	MOVLW	2
	MOVWF	INYRADIUS,BANKED
	CLRF	INYRADIUS_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	FILLEDELLIPSE
;Else
	BRA	ENDIF5
ELSE5_1:
;FilledEllipse 118, 6, 5, 2, GLCDBackground
	MOVLW	118
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	6
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	5
	MOVWF	INXRADIUS,BANKED
	CLRF	INXRADIUS_H,BANKED
	MOVLW	2
	MOVWF	INYRADIUS,BANKED
	CLRF	INYRADIUS_H,BANKED
	MOVFF	GLCDBACKGROUND,LINECOLOUR
	MOVFF	GLCDBACKGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	FILLEDELLIPSE
;End If
ENDIF5:
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	BANKSEL	LOCX
	CLRF	LOCX,BANKED
	MOVF	_GLCDPAGE,W,BANKED
	MULLW	8
;A2: ASM Source was:  MOVFF PRODL,LOCY
;A4: ASM Source was:  MOVFF PRODL,LOCY
	MOVFF	PROD,LOCY
	BANKSEL	0
	RCALL	CURSOR_POSITION_SSD1306
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC,BANKED
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP7:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	LFSR	0,SSD1306_BUFFERALIAS
	MOVF	SSD1306_BUFFERLOCATIONCALC,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W,BANKED
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,I2CBYTE
	BANKSEL	0
	CALL	SI2CSEND
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
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
	CLRF	INDF0,ACCESS
;next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP7
SYSFORLOOPEND7:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	CALL	SI2CSTOP
;next
	MOVLW	3
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP6
SYSFORLOOPEND6:
;longNumber = longNumber + 7
	MOVLW	7
	ADDWF	LONGNUMBER,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_H,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_U,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_E,F,BANKED
;Next
	MOVLW	127
	SUBWF	CCOUNT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	BRA	BASPROGRAMEND
;asm showdebug  GLCD SSD1306 buffer is 128bytes
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
	BANKSEL	LINEX1
	SUBWF	LINEX1,W,BANKED
	MOVWF	DRAWLINE,ACCESS
	MOVLW	0
	SUBWFB	LINEX1_H,W,BANKED
	MOVWF	DRAWLINE_H,ACCESS
	MOVFF	LINEX1,SYSWORDTEMPB
	MOVFF	LINEX1_H,SYSWORDTEMPB_H
	MOVFF	LINEX2,SYSWORDTEMPA
	MOVFF	LINEX2_H,SYSWORDTEMPA_H
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND11
SYSFORLOOP11:
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
	BRA	SYSFORLOOP11
SYSFORLOOPEND11:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	MOVLW	1
	BANKSEL	LINEY1
	SUBWF	LINEY1,W,BANKED
	MOVWF	DRAWLINE,ACCESS
	MOVLW	0
	SUBWFB	LINEY1_H,W,BANKED
	MOVWF	DRAWLINE_H,ACCESS
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND12
SYSFORLOOP12:
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
	BRA	SYSFORLOOP12
SYSFORLOOPEND12:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (536)
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	MOVLW	0
	BANKSEL	SYSCHAR
	SUBWF	SYSCHAR,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF78
;Chr(0) = 0
	BANKSEL	SYSCHR_0
	CLRF	SYSCHR_0,BANKED
;Exit Function
	BANKSEL	0
	RETURN
;End If
ENDIF78:
;Chr(0) = 1
	MOVLW	1
	BANKSEL	SYSCHR_0
	MOVWF	SYSCHR_0,BANKED
;Copy characters
;Chr(1) = SysChar
	MOVFFL	SYSCHAR,SYSCHR_1
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1489)
CIRCLE:
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	MOVFF	INXRADIUS,XRADIUS
	MOVFF	INXRADIUS_H,XRADIUS_H
;radiusErr = -(xradius/2)
	MOVFF	XRADIUS,SYSINTEGERTEMPA
	MOVFF	XRADIUS_H,SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSDIVSUBINT
	MOVFF	SYSINTEGERTEMPA,SYSTEMP1
	MOVFF	SYSINTEGERTEMPA_H,SYSTEMP1_H
	BANKSEL	SYSTEMP1
	COMF	SYSTEMP1,W,BANKED
	MOVWF	RADIUSERR,BANKED
	COMF	SYSTEMP1_H,W,BANKED
	MOVWF	RADIUSERR_H,BANKED
	INCF	RADIUSERR,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	RADIUSERR_H,F,BANKED
;Do While xradius >=  yordinate
SYSDOLOOP_S3:
	MOVFF	XRADIUS,SYSINTEGERTEMPA
	MOVFF	XRADIUS_H,SYSINTEGERTEMPA_H
	MOVFF	YORDINATE,SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	YORDINATE,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	YORDINATE,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	YORDINATE,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	YORDINATE,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;yordinate ++
	BANKSEL	YORDINATE
	INCF	YORDINATE,F,BANKED
;If radiusErr < 0 Then
	MOVFF	RADIUSERR,SYSINTEGERTEMPA
	MOVFF	RADIUSERR_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE22_1
;radiusErr = radiusErr + 2 * yordinate + 1
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	MULLW	2
;A2: ASM Source was:  MOVF PRODL,W,ACCESS
;A5: ASM Source was:  MOVF PRODL,W,ACCESS
	MOVF	PROD,W,ACCESS
	ADDWF	RADIUSERR,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	0
	ADDWFC	RADIUSERR_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	RADIUSERR,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	RADIUSERR_H,BANKED
;else
	BRA	ENDIF22
ELSE22_1:
;xradius --
	MOVLW	1
	BANKSEL	XRADIUS
	SUBWF	XRADIUS,F,BANKED
	MOVLW	0
	SUBWFB	XRADIUS_H,F,BANKED
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	MOVF	XRADIUS,W,BANKED
	SUBWF	YORDINATE,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	CLRF	SYSTEMP2,BANKED
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP3,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W,BANKED
	MOVWF	SYSTEMP3_H,BANKED
	MOVFF	SYSTEMP3,SYSINTEGERTEMPA
	MOVFF	SYSTEMP3_H,SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUBINT
	MOVF	SYSINTEGERTEMPX,W,ACCESS
	BANKSEL	RADIUSERR
	ADDWF	RADIUSERR,F,BANKED
	MOVF	SYSINTEGERTEMPX_H,W,ACCESS
	ADDWFC	RADIUSERR_H,F,BANKED
;end if
ENDIF22:
;Loop
	BRA	SYSDOLOOP_S3
SYSDOLOOP_E3:
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
	BANKSEL	LOCX
	ANDWF	LOCX,W,BANKED
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
	MOVWF	SYSTEMP2,BANKED
	CLRF	SYSTEMP2_H,BANKED
	MOVLW	16
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	POSCHARX,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	POSCHARX_H,BANKED
;Write_Command_SSD1306 ( PosCharX )
	MOVFF	POSCHARX,SSD1306SENDBYTE
	BANKSEL	0
	GOTO	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: GLCD.H (3575)
DRAWELLIPSEROUTINE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;Version 1.01 (14/04/2019) by Giuseppe D'Elia
;draws an ellipse outline at location (xoffset, yoffset) if filled_ellipse = 0
;draws a filled ellipse at location (xoffset, yoffset) if filled_ellipse = 1
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;IF Inxradius = Inyradius THEN
;IF filled_ellipse = 0 THEN
;Circle Xoffset, Yoffset, Inxradius, LineColour
;ELSE
;FilledCircle Xoffset, Yoffset, Inxradius, LineColour
;END IF
;GLCD_exit sub
;END IF
;IF Inxradius<2 THEN exit sub
	MOVFF	INXRADIUS,SYSWORDTEMPA
	MOVFF	INXRADIUS_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	RETURN
;IF Inyradius<2 THEN exit sub
	MOVFF	INYRADIUS,SYSWORDTEMPA
	MOVFF	INYRADIUS_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	RETURN
;dim GLCD_xx, GLCD_yy, GLCD_rx2, GLCD_ry2 as Word
;dim  GLCD_fx2, GLCD_fy2, GLCD_ex2, GLCD_ey2 as Long
;dim GLCD_px, GLCD_py, GLCD_pp, GLCD_pp_temp as Long
;GLCD_rx2 = Inxradius * Inxradius
	MOVFF	INXRADIUS,SYSWORDTEMPA
	MOVFF	INXRADIUS_H,SYSWORDTEMPA_H
	MOVFF	INXRADIUS,SYSWORDTEMPB
	MOVFF	INXRADIUS_H,SYSWORDTEMPB_H
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,GLCD_RX2
	MOVFF	SYSWORDTEMPX_H,GLCD_RX2_H
;GLCD_ry2 = Inyradius * Inyradius
	MOVFF	INYRADIUS,SYSWORDTEMPA
	MOVFF	INYRADIUS_H,SYSWORDTEMPA_H
	MOVFF	INYRADIUS,SYSWORDTEMPB
	MOVFF	INYRADIUS_H,SYSWORDTEMPB_H
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,GLCD_RY2
	MOVFF	SYSWORDTEMPX_H,GLCD_RY2_H
;GLCD_fx2 = 4 * GLCD_rx2
;GLCD_fx2 = GLCD_rx2 + GLCD_rx2
	MOVF	GLCD_RX2,W,ACCESS
	ADDWF	GLCD_RX2,W,ACCESS
	MOVWF	GLCD_FX2,ACCESS
	MOVF	GLCD_RX2_H,W,ACCESS
	ADDWFC	GLCD_RX2_H,W,ACCESS
	MOVWF	GLCD_FX2_H,ACCESS
	CLRF	GLCD_FX2_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	GLCD_FX2_U,F,ACCESS
	CLRF	GLCD_FX2_E,ACCESS
;GLCD_fx2 = GLCD_fx2 + GLCD_fx2
	MOVF	GLCD_FX2,W,ACCESS
	ADDWF	GLCD_FX2,F,ACCESS
	MOVF	GLCD_FX2_H,W,ACCESS
	ADDWFC	GLCD_FX2_H,F,ACCESS
	MOVF	GLCD_FX2_U,W,ACCESS
	ADDWFC	GLCD_FX2_U,F,ACCESS
	MOVF	GLCD_FX2_E,W,ACCESS
	ADDWFC	GLCD_FX2_E,F,ACCESS
;GLCD_fy2 = 4 * GLCD_ry2
;GLCD_fy2 = GLCD_ry2 + GLCD_ry2
	MOVF	GLCD_RY2,W,ACCESS
	ADDWF	GLCD_RY2,W,ACCESS
	MOVWF	GLCD_FY2,ACCESS
	MOVF	GLCD_RY2_H,W,ACCESS
	ADDWFC	GLCD_RY2_H,W,ACCESS
	MOVWF	GLCD_FY2_H,ACCESS
	CLRF	GLCD_FY2_U,ACCESS
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	GLCD_FY2_U,F,ACCESS
	CLRF	GLCD_FY2_E,ACCESS
;GLCD_fy2 = GLCD_fy2 + GLCD_fy2
	MOVF	GLCD_FY2,W,ACCESS
	ADDWF	GLCD_FY2,F,ACCESS
	MOVF	GLCD_FY2_H,W,ACCESS
	ADDWFC	GLCD_FY2_H,F,ACCESS
	MOVF	GLCD_FY2_U,W,ACCESS
	ADDWFC	GLCD_FY2_U,F,ACCESS
	MOVF	GLCD_FY2_E,W,ACCESS
	ADDWFC	GLCD_FY2_E,F,ACCESS
;GLCD_ex2 = 2 * GLCD_fx2
;GLCD_ex2 = GLCD_fx2 + GLCD_fx2
	MOVF	GLCD_FX2,W,ACCESS
	ADDWF	GLCD_FX2,W,ACCESS
	MOVWF	GLCD_EX2,ACCESS
	MOVF	GLCD_FX2_H,W,ACCESS
	ADDWFC	GLCD_FX2_H,W,ACCESS
	MOVWF	GLCD_EX2_H,ACCESS
	MOVF	GLCD_FX2_U,W,ACCESS
	ADDWFC	GLCD_FX2_U,W,ACCESS
	MOVWF	GLCD_EX2_U,ACCESS
	MOVF	GLCD_FX2_E,W,ACCESS
	ADDWFC	GLCD_FX2_E,W,ACCESS
	MOVWF	GLCD_EX2_E,ACCESS
;GLCD_ey2 = 2 * GLCD_fy2
;GLCD_ey2 = GLCD_fy2 + GLCD_fy2
	MOVF	GLCD_FY2,W,ACCESS
	ADDWF	GLCD_FY2,W,ACCESS
	MOVWF	GLCD_EY2,ACCESS
	MOVF	GLCD_FY2_H,W,ACCESS
	ADDWFC	GLCD_FY2_H,W,ACCESS
	MOVWF	GLCD_EY2_H,ACCESS
	MOVF	GLCD_FY2_U,W,ACCESS
	ADDWFC	GLCD_FY2_U,W,ACCESS
	MOVWF	GLCD_EY2_U,ACCESS
	MOVF	GLCD_FY2_E,W,ACCESS
	ADDWFC	GLCD_FY2_E,W,ACCESS
	MOVWF	GLCD_EY2_E,ACCESS
;GLCD_xx = 0
	CLRF	GLCD_XX,ACCESS
	BANKSEL	GLCD_XX_H
	CLRF	GLCD_XX_H,BANKED
;GLCD_yy = Inyradius
	MOVFF	INYRADIUS,GLCD_YY
	MOVFF	INYRADIUS_H,GLCD_YY_H
;GLCD_px = 0
	CLRF	GLCD_PX,ACCESS
	CLRF	GLCD_PX_H,ACCESS
	CLRF	GLCD_PX_U,ACCESS
	CLRF	GLCD_PX_E,ACCESS
;GLCD_py = GLCD_ex2 * GLCD_yy
	MOVFF	GLCD_EX2,SYSLONGTEMPA
	MOVFF	GLCD_EX2_H,SYSLONGTEMPA_H
	MOVFF	GLCD_EX2_U,SYSLONGTEMPA_U
	MOVFF	GLCD_EX2_E,SYSLONGTEMPA_E
	MOVFF	GLCD_YY,SYSLONGTEMPB
	MOVFF	GLCD_YY_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PY
	MOVFF	SYSLONGTEMPX_H,GLCD_PY_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PY_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PY_E
;GLCD_pp = 2 + GLCD_fy2 -  GLCD_fx2 * Inyradius + GLCD_rx2
;GLCD_pp_temp = GLCD_fx2 * Inyradius
	MOVFF	GLCD_FX2,SYSLONGTEMPA
	MOVFF	GLCD_FX2_H,SYSLONGTEMPA_H
	MOVFF	GLCD_FX2_U,SYSLONGTEMPA_U
	MOVFF	GLCD_FX2_E,SYSLONGTEMPA_E
	MOVFF	INYRADIUS,SYSLONGTEMPB
	MOVFF	INYRADIUS_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_fy2
	MOVLW	2
	ADDWF	GLCD_FY2,W,ACCESS
	MOVWF	GLCD_PP,ACCESS
	MOVLW	0
	ADDWFC	GLCD_FY2_H,W,ACCESS
	MOVWF	GLCD_PP_H,ACCESS
	MOVLW	0
	ADDWFC	GLCD_FY2_U,W,ACCESS
	MOVWF	GLCD_PP_U,ACCESS
	MOVLW	0
	ADDWFC	GLCD_FY2_E,W,ACCESS
	MOVWF	GLCD_PP_E,ACCESS
;GLCD_pp = GLCD_pp + GLCD_rx2
	MOVF	GLCD_RX2,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_RX2_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVLW	0
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVLW	0
	ADDWFC	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W,ACCESS
	SUBWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PP_TEMP_H,W,ACCESS
	SUBWFB	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PP_TEMP_U,W,ACCESS
	SUBWFB	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PP_TEMP_E,W,ACCESS
	SUBWFB	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE25_1
;Draw_Ellipse_Points
	RCALL	DRAW_ELLIPSE_POINTS
;ELSE
	BRA	ENDIF25
ELSE25_1:
;Draw_Filled_Ellipse_Points
	RCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF25:
;DO WHILE GLCD_px < GLCD_py
SYSDOLOOP_S4:
	MOVFF	GLCD_PX,SYSLONGTEMPA
	MOVFF	GLCD_PX_H,SYSLONGTEMPA_H
	MOVFF	GLCD_PX_U,SYSLONGTEMPA_U
	MOVFF	GLCD_PX_E,SYSLONGTEMPA_E
	MOVFF	GLCD_PY,SYSLONGTEMPB
	MOVFF	GLCD_PY_H,SYSLONGTEMPB_H
	MOVFF	GLCD_PY_U,SYSLONGTEMPB_U
	MOVFF	GLCD_PY_E,SYSLONGTEMPB_E
	CALL	SYSCOMPLESSTHAN32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E4
;GLCD_xx++
	INCF	GLCD_XX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BANKSEL	GLCD_XX_H
	INCF	GLCD_XX_H,F,BANKED
;GLCD_px = GLCD_px + GLCD_ey2
	MOVF	GLCD_EY2,W,ACCESS
	ADDWF	GLCD_PX,F,ACCESS
	MOVF	GLCD_EY2_H,W,ACCESS
	ADDWFC	GLCD_PX_H,F,ACCESS
	MOVF	GLCD_EY2_U,W,ACCESS
	ADDWFC	GLCD_PX_U,F,ACCESS
	MOVF	GLCD_EY2_E,W,ACCESS
	ADDWFC	GLCD_PX_E,F,ACCESS
;IF GLCD_pp_E.7 = 0 THEN
	BTFSC	GLCD_PP_E,7,ACCESS
	BRA	ENDIF26
;GLCD_yy--
	MOVLW	1
	BANKSEL	GLCD_YY
	SUBWF	GLCD_YY,F,BANKED
	MOVLW	0
	SUBWFB	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	MOVF	GLCD_EX2,W,ACCESS
	SUBWF	GLCD_PY,F,ACCESS
	MOVF	GLCD_EX2_H,W,ACCESS
	SUBWFB	GLCD_PY_H,F,ACCESS
	MOVF	GLCD_EX2_U,W,ACCESS
	SUBWFB	GLCD_PY_U,F,ACCESS
	MOVF	GLCD_EX2_E,W,ACCESS
	SUBWFB	GLCD_PY_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_py
	MOVF	GLCD_PY,W,ACCESS
	SUBWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PY_H,W,ACCESS
	SUBWFB	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PY_U,W,ACCESS
	SUBWFB	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PY_E,W,ACCESS
	SUBWFB	GLCD_PP_E,F,ACCESS
;END IF
ENDIF26:
;GLCD_pp = GLCD_pp + GLCD_fy2 + GLCD_px
;GLCD_pp = GLCD_pp + GLCD_fy2
	MOVF	GLCD_FY2,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_FY2_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_FY2_U,W,ACCESS
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_FY2_E,W,ACCESS
	ADDWFC	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp + GLCD_px
	MOVF	GLCD_PX,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PX_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PX_U,W,ACCESS
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PX_E,W,ACCESS
	ADDWFC	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE27_1
;Draw_Ellipse_Points
	BANKSEL	0
	RCALL	DRAW_ELLIPSE_POINTS
;ELSE
	BRA	ENDIF27
ELSE27_1:
;Draw_Filled_Ellipse_Points
	BANKSEL	0
	RCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF27:
;LOOP
	BRA	SYSDOLOOP_S4
SYSDOLOOP_E4:
;GLCD_pp = 2 + GLCD_ry2 * (2 * GLCD_xx + 1) * (2 * GLCD_xx + 1) + GLCD_fx2 * (GLCD_yy - 1) * (GLCD_yy - 1) -  GLCD_fx2 * GLCD_ry2
;change GLCD_xx and GLCD_yy to do calculation
;GLCD_xx = GLCD_xx + GLCD_xx
	MOVF	GLCD_XX,W,ACCESS
	ADDWF	GLCD_XX,F,ACCESS
	BANKSEL	GLCD_XX_H
	MOVF	GLCD_XX_H,W,BANKED
	ADDWFC	GLCD_XX_H,F,BANKED
;GLCD_xx++
	INCF	GLCD_XX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	GLCD_XX_H,F,BANKED
;GLCD_yy--
	MOVLW	1
	SUBWF	GLCD_YY,F,BANKED
	MOVLW	0
	SUBWFB	GLCD_YY_H,F,BANKED
;GLCD_pp_temp = GLCD_xx * GLCD_xx
	MOVFF	GLCD_XX,SYSLONGTEMPA
	MOVFF	GLCD_XX_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	GLCD_XX,SYSLONGTEMPB
	MOVFF	GLCD_XX_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_ry2 * GLCD_pp_temp
	MOVFF	GLCD_RY2,SYSLONGTEMPA
	MOVFF	GLCD_RY2_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	GLCD_PP_TEMP,SYSLONGTEMPB
	MOVFF	GLCD_PP_TEMP_H,SYSLONGTEMPB_H
	MOVFF	GLCD_PP_TEMP_U,SYSLONGTEMPB_U
	MOVFF	GLCD_PP_TEMP_E,SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_pp_temp
	MOVLW	2
	ADDWF	GLCD_PP_TEMP,W,ACCESS
	MOVWF	GLCD_PP,ACCESS
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_H,W,ACCESS
	MOVWF	GLCD_PP_H,ACCESS
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_U,W,ACCESS
	MOVWF	GLCD_PP_U,ACCESS
	MOVLW	0
	ADDWFC	GLCD_PP_TEMP_E,W,ACCESS
	MOVWF	GLCD_PP_E,ACCESS
;GLCD_pp_temp = GLCD_yy * GLCD_yy
	MOVFF	GLCD_YY,SYSLONGTEMPA
	MOVFF	GLCD_YY_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	GLCD_YY,SYSLONGTEMPB
	MOVFF	GLCD_YY_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_fx2 * GLCD_pp_temp
	MOVFF	GLCD_FX2,SYSLONGTEMPA
	MOVFF	GLCD_FX2_H,SYSLONGTEMPA_H
	MOVFF	GLCD_FX2_U,SYSLONGTEMPA_U
	MOVFF	GLCD_FX2_E,SYSLONGTEMPA_E
	MOVFF	GLCD_PP_TEMP,SYSLONGTEMPB
	MOVFF	GLCD_PP_TEMP_H,SYSLONGTEMPB_H
	MOVFF	GLCD_PP_TEMP_U,SYSLONGTEMPB_U
	MOVFF	GLCD_PP_TEMP_E,SYSLONGTEMPB_E
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp + GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PP_TEMP_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PP_TEMP_U,W,ACCESS
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PP_TEMP_E,W,ACCESS
	ADDWFC	GLCD_PP_E,F,ACCESS
;GLCD_pp_temp = GLCD_fx2 * GLCD_ry2
	MOVFF	GLCD_FX2,SYSLONGTEMPA
	MOVFF	GLCD_FX2_H,SYSLONGTEMPA_H
	MOVFF	GLCD_FX2_U,SYSLONGTEMPA_U
	MOVFF	GLCD_FX2_E,SYSLONGTEMPA_E
	MOVFF	GLCD_RY2,SYSLONGTEMPB
	MOVFF	GLCD_RY2_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	CALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,GLCD_PP_TEMP
	MOVFF	SYSLONGTEMPX_H,GLCD_PP_TEMP_H
	MOVFF	SYSLONGTEMPX_U,GLCD_PP_TEMP_U
	MOVFF	SYSLONGTEMPX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	MOVF	GLCD_PP_TEMP,W,ACCESS
	SUBWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PP_TEMP_H,W,ACCESS
	SUBWFB	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PP_TEMP_U,W,ACCESS
	SUBWFB	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PP_TEMP_E,W,ACCESS
	SUBWFB	GLCD_PP_E,F,ACCESS
;restore original GLCD_xx and GLCD_yy values
;GLCD_xx--
	MOVLW	1
	SUBWF	GLCD_XX,F,ACCESS
	MOVLW	0
	BANKSEL	GLCD_XX_H
	SUBWFB	GLCD_XX_H,F,BANKED
;GLCD_xx/2
;set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate GLCD_xx_H right
	RRCF	GLCD_XX_H,F,BANKED
;rotate GLCD_xx right
	RRCF	GLCD_XX_H,F,BANKED
	RRCF	GLCD_XX,F,ACCESS
;GLCD_yy++
	INCF	GLCD_YY,F,BANKED
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	GLCD_YY_H,F,BANKED
;DO WHILE GLCD_yy > 0
SYSDOLOOP_S5:
	MOVFF	GLCD_YY,SYSWORDTEMPB
	MOVFF	GLCD_YY_H,SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E5
;GLCD_yy--
	MOVLW	1
	BANKSEL	GLCD_YY
	SUBWF	GLCD_YY,F,BANKED
	MOVLW	0
	SUBWFB	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	MOVF	GLCD_EX2,W,ACCESS
	SUBWF	GLCD_PY,F,ACCESS
	MOVF	GLCD_EX2_H,W,ACCESS
	SUBWFB	GLCD_PY_H,F,ACCESS
	MOVF	GLCD_EX2_U,W,ACCESS
	SUBWFB	GLCD_PY_U,F,ACCESS
	MOVF	GLCD_EX2_E,W,ACCESS
	SUBWFB	GLCD_PY_E,F,ACCESS
;IF GLCD_pp_E.7 = 1 THEN
	BTFSS	GLCD_PP_E,7,ACCESS
	BRA	ENDIF28
;GLCD_xx++
	INCF	GLCD_XX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	GLCD_XX_H,F,BANKED
;GLCD_px = GLCD_px + GLCD_ey2
	MOVF	GLCD_EY2,W,ACCESS
	ADDWF	GLCD_PX,F,ACCESS
	MOVF	GLCD_EY2_H,W,ACCESS
	ADDWFC	GLCD_PX_H,F,ACCESS
	MOVF	GLCD_EY2_U,W,ACCESS
	ADDWFC	GLCD_PX_U,F,ACCESS
	MOVF	GLCD_EY2_E,W,ACCESS
	ADDWFC	GLCD_PX_E,F,ACCESS
;GLCD_pp = GLCD_pp + GLCD_px
	MOVF	GLCD_PX,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PX_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PX_U,W,ACCESS
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PX_E,W,ACCESS
	ADDWFC	GLCD_PP_E,F,ACCESS
;END IF
ENDIF28:
;GLCD_pp = GLCD_pp + GLCD_fx2 - GLCD_py
;GLCD_pp = GLCD_pp + GLCD_fx2
	MOVF	GLCD_FX2,W,ACCESS
	ADDWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_FX2_H,W,ACCESS
	ADDWFC	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_FX2_U,W,ACCESS
	ADDWFC	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_FX2_E,W,ACCESS
	ADDWFC	GLCD_PP_E,F,ACCESS
;GLCD_pp = GLCD_pp - GLCD_py
	MOVF	GLCD_PY,W,ACCESS
	SUBWF	GLCD_PP,F,ACCESS
	MOVF	GLCD_PY_H,W,ACCESS
	SUBWFB	GLCD_PP_H,F,ACCESS
	MOVF	GLCD_PY_U,W,ACCESS
	SUBWFB	GLCD_PP_U,F,ACCESS
	MOVF	GLCD_PY_E,W,ACCESS
	SUBWFB	GLCD_PP_E,F,ACCESS
;IF filled_ellipse = 0 THEN
	MOVF	FILLED_ELLIPSE,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE29_1
;Draw_Ellipse_Points
	BANKSEL	0
	RCALL	DRAW_ELLIPSE_POINTS
;ELSE
	BRA	ENDIF29
ELSE29_1:
;Draw_Filled_Ellipse_Points
	BANKSEL	0
	RCALL	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF29:
;LOOP
	BRA	SYSDOLOOP_S5
SYSDOLOOP_E5:
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (3711)
DRAW_ELLIPSE_POINTS:
;dim LineColour as word
;Pset ((xoffset + GLCD_xx), (yoffset + GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset + GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (yoffset - GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset + GLCD_xx), (yoffset - GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	GOTO	PSET_SSD1306

;********************************************************************************

;SOURCE: GLCD.H (3720)
DRAW_FILLED_ELLIPSE_POINTS:
;dim LineColour as word
;FOR GLCD_yy1 = (yoffset) to (yoffset + 2 * GLCD_yy)
	BANKSEL	YOFFSET
	DECF	YOFFSET,W,BANKED
	MOVWF	GLCD_YY1,BANKED
	MOVF	GLCD_YY,W,BANKED
	MULLW	2
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVFF	YOFFSET,SYSBYTETEMPB
	MOVFF	SYSTEMP2,SYSBYTETEMPA
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND13
SYSFORLOOP13:
	BANKSEL	GLCD_YY1
	INCF	GLCD_YY1,F,BANKED
;Pset ((xoffset + GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	SUBWF	GLCD_YY1,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;Pset ((xoffset - GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	MOVF	GLCD_XX,W,ACCESS
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	GLCD_YY,W,BANKED
	SUBWF	GLCD_YY1,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1306
;NEXT
	BANKSEL	GLCD_YY
	MOVF	GLCD_YY,W,BANKED
	MULLW	2
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVFF	GLCD_YY1,SYSBYTETEMPA
	MOVFF	SYSTEMP2,SYSBYTETEMPB
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP13
SYSFORLOOPEND13:
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

;SOURCE: GLCD.H (3551)
ELLIPSE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws an ellipse outline at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 0
	CLRF	FILLED_ELLIPSE,ACCESS
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	BRA	DRAWELLIPSEROUTINE

;********************************************************************************

;SOURCE: GLCD.H (3563)
FILLEDELLIPSE:
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws a filled ellipse at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 1
	MOVLW	1
	MOVWF	FILLED_ELLIPSE,ACCESS
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	BRA	DRAWELLIPSEROUTINE

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
	BANKSEL	GLCD_YORDINATE
	CLRF	GLCD_YORDINATE,BANKED
	CLRF	GLCD_YORDINATE_H,BANKED
;For SSD1306_BufferLocationCalc = 0 to 128
	SETF	SSD1306_BUFFERLOCATIONCALC,BANKED
	SETF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP14:
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
	MOVLW	128
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP14
SYSFORLOOPEND14:
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	MOVLW	248
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC,BANKED
	SETF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
SYSFORLOOP15:
	MOVLW	8
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F,BANKED
	MOVLW	0
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	CLRF	LOCX,BANKED
	MOVFF	SSD1306_BUFFERLOCATIONCALC,LOCY
	BANKSEL	0
	CALL	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;For GLCDTemp = 0 to 127
	SETF	GLCDTEMP,ACCESS
SYSFORLOOP16:
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
	BRA	SYSFORLOOP16
SYSFORLOOPEND16:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	CALL	SI2CSTOP
;Next
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPA
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPA_H
	MOVLW	31
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP15
SYSFORLOOPEND15:
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	BANKSEL	LOCX
	CLRF	LOCX,BANKED
	CLRF	LOCY,BANKED
	BANKSEL	0
	CALL	CURSOR_POSITION_SSD1306
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
;if GLCDfntDefaultSize = 1 then
	DECF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF36
;test if character lies within current page
;GLCDY_Temp = CharLocY + 7
	MOVLW	7
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	GLCDY_TEMP,ACCESS
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP1
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP1:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate GLCDY_Temp Right
	RRCF	GLCDY_TEMP,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;IF GLCDY_Temp <> _GLCDPage THEN
	MOVF	_GLCDPAGE,W,BANKED
	SUBWF	GLCDY_TEMP,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ENDIF47
;GLCDY_Temp = GLCDY_Temp - 1
	DECF	GLCDY_TEMP,F,ACCESS
;IF GLCDY_Temp <> _GLCDPage THEN
	MOVF	_GLCDPAGE,W,BANKED
	SUBWF	GLCDY_TEMP,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ENDIF48
;EXIT SUB
	BANKSEL	0
	RETURN
;END IF
ENDIF48:
;END IF
ENDIF47:
;end if
ENDIF36:
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	MOVFF	LINECOLOUR,SYSWORDTEMPA
	MOVFF	LINECOLOUR_H,SYSWORDTEMPA_H
	MOVFF	GLCDFOREGROUND,SYSWORDTEMPB
	MOVFF	GLCDFOREGROUND_H,SYSWORDTEMPB_H
	BANKSEL	0
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF37
;Inverted Colours
;GLCDBackground = 1
	MOVLW	1
	MOVWF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 0
	CLRF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
;end if
ENDIF37:
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
	CALL	CURSOR_POSITION_SSD1306
;1.14 Added transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	CALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
;HI2CSend 0x40
	MOVLW	64
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	CALL	SI2CSEND
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
	BRA	ENDIF38
;CharLocY=CharLocY-1
	MOVLW	1
	SUBWF	CHARLOCY,F,ACCESS
	MOVLW	0
	SUBWFB	CHARLOCY_H,F,ACCESS
;end if
ENDIF38:
;For CurrCharCol = 1 to 5
	CLRF	CURRCHARCOL,ACCESS
SYSFORLOOP17:
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
;1.14 Low Memory GLCD mode
;CharRow=0
	CLRF	CHARROW,ACCESS
	CLRF	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
	CLRF	CURRCHARROW,ACCESS
SYSFORLOOP18:
	INCF	CURRCHARROW,F,ACCESS
;CharColS=0
	CLRF	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
	CLRF	COL,ACCESS
	MOVLW	1
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND19
SYSFORLOOP19:
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
	BRA	SYSFORLOOPEND20
SYSFORLOOP20:
	INCF	ROW,F,BANKED
;GLCDY = [word]CharLocY + CharRow + CharRowS
	MOVF	CHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARROWS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDY,ACCESS
;if CurrCharVal.0=1 then
	BTFSS	CURRCHARVAL,0,ACCESS
	BRA	ELSE41_1
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, LineColour
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;Else
	BRA	ENDIF41
ELSE41_1:
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, GLCDBackground
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;End if
ENDIF41:
;End if
;CharRowS +=1
	INCF	CHARROWS,F,ACCESS
;Put out a white intercharacter pixel/space
;if ( CharCol + CharColS ) = ( GLCDFontWidth * GLCDfntDefaultsize) - GLCDfntDefaultsize - 1 then
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	CHARCOL,W,ACCESS
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2,BANKED
	MOVLW	0
	ADDWFC	CHARCOL_H,W,ACCESS
	MOVWF	SYSTEMP2_H,BANKED
	MOVF	GLCDFONTWIDTH,W,ACCESS
	MULWF	GLCDFNTDEFAULTSIZE,ACCESS
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	SUBWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP3,BANKED
	DECF	SYSTEMP3,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVFF	SYSTEMP2,SYSWORDTEMPA
	MOVFF	SYSTEMP2_H,SYSWORDTEMPA_H
	MOVFF	SYSTEMP1,SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF42
;PSet [word]CharLocX + CharCol + CharColS + 1, [word]CharLocY + CharRow+CharRowS -1, GLCDBackground
	MOVF	CHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARCOLS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	INCF	SYSTEMP2,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	CHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	SYSTEMP1,BANKED
	MOVF	CHARROWS,W,ACCESS
	ADDWF	SYSTEMP1,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	DECF	SYSTEMP2,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	RCALL	PSET_SSD1306
;end if
ENDIF42:
;Next Row
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	BANKSEL	ROW
	SUBWF	ROW,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP20
SYSFORLOOPEND20:
;CharColS +=1
	INCF	CHARCOLS,F,ACCESS
;Next Col
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	SUBWF	COL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP19
SYSFORLOOPEND19:
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
	BRA	SYSFORLOOP18
SYSFORLOOPEND18:
;CharCol +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	CHARCOL,F,ACCESS
	MOVLW	0
	ADDWFC	CHARCOL_H,F,ACCESS
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Ensure this is not called with in Low memory mode
;Next
	MOVLW	5
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP17
SYSFORLOOPEND17:
;****** OLED Font set handler
;1.14 Added transaction
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	BANKSEL	0
	CALL	SI2CSTOP
;Restore
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1238)
GLCDDRAWSTRING:
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	MOVFF	STRINGLOCX,GLCDPRINTLOC
	CLRF	GLCDPRINTLOC_H,ACCESS
;for xchar = 1 to Chars(0)
	BANKSEL	XCHAR
	CLRF	XCHAR,BANKED
;A6: ASM Source was:  MOVFF SYSCHARSHANDLER,AFSR0
	MOVFF	SYSCHARSHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSCHARSHANDLER_H,AFSR0_H
	MOVFF	SYSCHARSHANDLER_H,FSR0H
	MOVLW	1
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND10
SYSFORLOOP10:
	INCF	XCHAR,F,BANKED
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	MOVFF	GLCDPRINTLOC,CHARLOCX
	MOVFF	GLCDPRINTLOC_H,CHARLOCX_H
	MOVF	XCHAR,W,BANKED
	ADDWF	SYSCHARSHANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSCHARSHANDLER_H,W,BANKED
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
;next
;A6: ASM Source was:  MOVFF SYSCHARSHANDLER,AFSR0
	MOVFF	SYSCHARSHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSCHARSHANDLER_H,AFSR0_H
	MOVFF	SYSCHARSHANDLER_H,FSR0H
	MOVF	INDF0,W,ACCESS
	SUBWF	XCHAR,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP10
SYSFORLOOPEND10:
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:STRING:, SOURCE: GLCD.H (934)
GLCDPRINT4:
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
	BRA	SYSFORLOOPEND8
SYSFORLOOP8:
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
	BRA	SYSFORLOOP8
SYSFORLOOPEND8:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVFF	GLCDPRINTLOC,PRINTLOCX
	MOVFF	GLCDPRINTLOC_H,PRINTLOCX_H
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:LONG:, SOURCE: GLCD.H (1047)
GLCDPRINT7:
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	BANKSEL	SYSPRINTBUFFLEN
	CLRF	SYSPRINTBUFFLEN,BANKED
;Do
SYSDOLOOP_S2:
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	BANKSEL	SYSPRINTBUFFLEN
	INCF	SYSPRINTBUFFLEN,F,BANKED
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	LFSR	0,SYSPRINTBUFFER
	MOVF	SYSPRINTBUFFLEN,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	LCDVALUE,SYSLONGTEMPA
	MOVFF	LCDVALUE_H,SYSLONGTEMPA_H
	MOVFF	LCDVALUE_U,SYSLONGTEMPA_U
	MOVFF	LCDVALUE_E,SYSLONGTEMPA_E
	MOVLW	10
	MOVWF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	BANKSEL	0
	CALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPX,INDF0
;LCDValue = SysCalcTempA
	MOVFF	SYSCALCTEMPA,LCDVALUE
	MOVFF	SYSCALCTEMPA_H,LCDVALUE_H
	MOVFF	SYSCALCTEMPA_U,LCDVALUE_U
	MOVFF	SYSCALCTEMPA_E,LCDVALUE_E
;Loop While LCDValue <> 0
	MOVFF	LCDVALUE,SYSLONGTEMPA
	MOVFF	LCDVALUE_H,SYSLONGTEMPA_H
	MOVFF	LCDVALUE_U,SYSLONGTEMPA_U
	MOVFF	LCDVALUE_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	CALL	SYSCOMPEQUAL32
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_S2
SYSDOLOOP_E2:
;Display
;GLCDPrintLoc = PrintLocX
	MOVFF	PRINTLOCX,GLCDPRINTLOC
	MOVFF	PRINTLOCX_H,GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
	BANKSEL	SYSPRINTBUFFLEN
	INCF	SYSPRINTBUFFLEN,W,BANKED
	MOVWF	GLCDPRINT_STRING_COUNTER,ACCESS
	MOVLW	1
	SUBWF	SYSPRINTBUFFLEN,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND9
SYSFORLOOP9:
	DECF	GLCDPRINT_STRING_COUNTER,F,ACCESS
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	MOVFF	GLCDPRINTLOC,CHARLOCX
	MOVFF	GLCDPRINTLOC_H,CHARLOCX_H
	MOVFF	PRINTLOCY,CHARLOCY
	MOVFF	PRINTLOCY_H,CHARLOCY_H
	LFSR	0,SYSPRINTBUFFER
	MOVF	GLCDPRINT_STRING_COUNTER,W,ACCESS
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVLW	48
	ADDWF	INDF0,W,ACCESS
	MOVWF	CHARCODE,ACCESS
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
	MOVF	GLCDPRINT_STRING_COUNTER,W,ACCESS
	SUBLW	1
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP9
SYSFORLOOPEND9:
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
	BANKSEL	HI2CCURRENTMODE
	CLRF	HI2CCURRENTMODE,BANKED
;Initialise the I2C module
;SI2CInit
	BANKSEL	0
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
	BANKSEL	HI2CCURRENTMODE
	MOVWF	HI2CCURRENTMODE,BANKED
	BANKSEL	0
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
;Write_Command_SSD1306(0x1f)                                 '32 pixels
	MOVLW	31
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
;Write_Command_SSD1306(0x02)                                 '32 pixels
	MOVLW	2
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

;SOURCE: 200_I2C_GLCD_USING_SSD1306_128_32.GCB (33)
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

;SOURCE: STRING.H (582)
FN_PAD:
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	BANKSEL	SYSSTRLEN
	MOVF	SYSSTRLEN,W,BANKED
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ELSE79_1
;SysCharCount = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	LFSR	1,PAD
	MOVLW	LOW STRINGTABLE90
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE90
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE90
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	CALL	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND21
SYSFORLOOP21:
	INCF	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
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
	MOVFF	POSTINC0,SYSARRAYTEMP1
	MOVFF	SYSARRAYTEMP1,SYSARRAYTEMP2
	LFSR	0,PAD
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
	BRA	SYSFORLOOP21
SYSFORLOOPEND21:
;For SysStringTemp = SysCharCount+1 to SysStrLen
	INCF	SYSCHARCOUNT,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	DECF	SYSTEMP1,W,BANKED
	MOVWF	SYSSTRINGTEMP,BANKED
	INCF	SYSCHARCOUNT,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVFF	SYSTEMP1,SYSBYTETEMPB
	MOVFF	SYSSTRLEN,SYSBYTETEMPA
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND22
SYSFORLOOP22:
	BANKSEL	SYSSTRINGTEMP
	INCF	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString3(1)
	MOVLW	1
	ADDWF	SYSSYSINSTRING3HANDLER,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0,ACCESS
;A4: ASM Source was:  MOVWF AFSR0,ACCESS
	MOVWF	FSR0,ACCESS
	MOVLW	0
	ADDWFC	SYSSYSINSTRING3HANDLER_H,W,BANKED
;A2: ASM Source was:  MOVWF AFSR0_H,ACCESS
;A4: ASM Source was:  MOVWF AFSR0_H,ACCESS
	MOVWF	FSR0H,ACCESS
	MOVFF	POSTINC0,SYSARRAYTEMP2
	MOVFF	SYSARRAYTEMP2,SYSARRAYTEMP1
	LFSR	0,PAD
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
	MOVF	SYSSTRLEN,W,BANKED
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP22
SYSFORLOOPEND22:
;set new length to PAD
;Pad(0) = SysStrLen
	MOVFFL	SYSSTRLEN,SYSPAD_0
;else
	BRA	ENDIF79
ELSE79_1:
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	CLRF	SYSSTRINGTEMP,BANKED
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVLW	1
	SUBWF	INDF0,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND23
SYSFORLOOP23:
	INCF	SYSSTRINGTEMP,F,BANKED
;Pad(SysStringTemp) = SysInString(SysStringTemp)
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
	MOVFF	POSTINC0,SYSARRAYTEMP1
	MOVFF	SYSARRAYTEMP1,SYSARRAYTEMP2
	LFSR	0,PAD
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
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVF	INDF0,W,ACCESS
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP23
SYSFORLOOPEND23:
;PAD(0) = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	POSTINC0,SYSARRAYTEMP1
	MOVFFL	SYSARRAYTEMP1,SYSPAD_0
;End If
ENDIF79:
	BANKSEL	0
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
	MOVLW	32
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F,ACCESS
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	IORWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF49
;exit sub
	BANKSEL	0
	RETURN
;end if
ENDIF49:
;1.14 Addresses correct device horizonal page
;Is YPOS addressing the page we need?
;SSD1306_BufferLocationCalc = GLCDY
;Repeat 3
;Set C Off
;Rotate SSD1306_BufferLocationCalc Right
;End Repeat
;if SSD1306_BufferLocationCalc = _GLCDPage then
;GLCDY_Temp = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;GLCDY_Temp = GLCDY
	MOVFF	GLCDY,GLCDY_TEMP
;Repeat 3
	MOVLW	3
	MOVWF	SYSREPEATTEMP2,BANKED
SYSREPEATLOOP2:
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate GLCDY_Temp Right
	RRCF	GLCDY_TEMP,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP2,F,BANKED
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;if GLCDY_Temp = _GLCDPage then
	MOVF	_GLCDPAGE,W,BANKED
	SUBWF	GLCDY_TEMP,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE50_1
;Mod the YPOS to get the correct pixel with the page
;GLCDY = GLCDY mod 8
	MOVFF	GLCDY,SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB,ACCESS
	BANKSEL	0
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPX,GLCDY
;Else
	BRA	ENDIF50
ELSE50_1:
;Exit if not the page we are looking for
;exit sub
	BANKSEL	0
	RETURN
;end if
ENDIF50:
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;SSD1306_BufferLocationCalc = GLCDX + 1
	MOVLW	1
	ADDWF	GLCDX,W,ACCESS
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC,BANKED
	CLRF	SSD1306_BUFFERLOCATIONCALC_H,BANKED
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F,BANKED
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	MOVFF	SSD1306_BUFFERLOCATIONCALC,SYSWORDTEMPB
	MOVFF	SSD1306_BUFFERLOCATIONCALC_H,SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA,ACCESS
	MOVLW	16
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
	BRA	ELSE52_1
;GLCDChange = 254
	MOVLW	254
	MOVWF	GLCDCHANGE,ACCESS
;Set C On
;A8: ASM Source was:  BSF STATUS,C,ACCESS
	BSF	STATUS,0,ACCESS
;Else
	BRA	ENDIF52
ELSE52_1:
;GLCDChange = 1
	MOVLW	1
	MOVWF	GLCDCHANGE,ACCESS
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;End If
ENDIF52:
;Repeat GLCDBitNo
	MOVFF	GLCDBITNO,SYSREPEATTEMP2
	MOVF	SYSREPEATTEMP2,F,BANKED
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	SYSREPEATLOOPEND3
SYSREPEATLOOP3:
;Rotate GLCDChange Left
	RLCF	GLCDCHANGE,F,ACCESS
;End Repeat
	DECFSZ	SYSREPEATTEMP2,F,BANKED
	BRA	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0,ACCESS
	BRA	ELSE53_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	ANDWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;Else
	BRA	ENDIF53
ELSE53_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	MOVF	GLCDDATATEMP,W,ACCESS
	IORWF	GLCDCHANGE,W,ACCESS
	MOVWF	GLCDDATATEMP,ACCESS
;End If
ENDIF53:
;added 1.14 to isolate from full glcd mode
;restore address the correct page by adjustng the Y
;GLCDY = GLCDY + ( 8 * _GLCDPage )
	MOVF	_GLCDPAGE,W,BANKED
	MULLW	8
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	GLCDY,F,ACCESS
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
	BRA	ENDIF54
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
;end if
ENDIF54:
;revised 1.14 to isolate from low memory mode
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD443:
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
;SET ADCS OFF  'ADCON0.4
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 15    'FOSC/16
	MOVLW	15
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
	BANKSEL	I2CBYTE
	SETF	I2CBYTE,BANKED
	BANKSEL	0
	RCALL	SI2CSEND
;SI2CStop
	RCALL	SI2CSTOP
;HI2CCurrentMode = 0
	BANKSEL	HI2CCURRENTMODE
	CLRF	HI2CCURRENTMODE,BANKED
	BANKSEL	0
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
	BANKSEL	HI2C1STATEMACHINE
	SUBWF	HI2C1STATEMACHINE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE2
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S9:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E9
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait for this event
;if I2C1STAT1.TXBE = 1 then
BANKSEL	I2C1STAT1
;A8: ASM Source was:  BTFSS I2C1STAT1,TXBE,BANKED
	BTFSS	I2C1STAT1,5,BANKED
	BRA	ELSE88_1
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
	BRA	ENDIF88
ELSE88_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS4:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS4
;end if
ENDIF88:
;loop
	BRA	SYSDOLOOP_S9
SYSDOLOOP_E9:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_TXBE_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF89
	MOVLW	2
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF89:
;case 1  'A start
	BRA	SYSSELECTEND3
SYSSELECT3CASE2:
	DECF	HI2C1STATEMACHINE,W,BANKED
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
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S10:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E10
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait for this event
;if I2C1PIR.SCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE90_1
;HI2C1StateMachine = 2  'Set state Machine to send data
	MOVLW	2
	BANKSEL	HI2C1STATEMACHINE
	MOVWF	HI2C1STATEMACHINE,BANKED
;HI2CAckPollState = I2C1CON1.5
	CLRF	HI2CACKPOLLSTATE,BANKED
BANKSEL	I2C1CON1
	BTFSS	I2C1CON1,5,BANKED
	BRA	ENDIF94
	BANKSEL	HI2CACKPOLLSTATE
	INCF	HI2CACKPOLLSTATE,F,BANKED
ENDIF94:
;exit Sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF90
ELSE90_1:
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
ENDIF90:
;loop
	BRA	SYSDOLOOP_S10
SYSDOLOOP_E10:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_START_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF91
	MOVLW	4
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF91:
;case 3  'A restart
	BRA	SYSSELECTEND3
SYSSELECT3CASE3:
	MOVLW	3
	SUBWF	HI2C1STATEMACHINE,W,BANKED
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
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S11:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E11
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait for this event
;if I2C1PIR.SCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,SCIF,BANKED
	BTFSS	I2C1PIR,0,BANKED
	BRA	ELSE92_1
;HI2C1StateMachine = 2  'Set state Machine to send data
	MOVLW	2
	BANKSEL	HI2C1STATEMACHINE
	MOVWF	HI2C1STATEMACHINE,BANKED
;HI2CAckPollState = I2C1CON1.5
	CLRF	HI2CACKPOLLSTATE,BANKED
BANKSEL	I2C1CON1
	BTFSS	I2C1CON1,5,BANKED
	BRA	ENDIF95
	BANKSEL	HI2CACKPOLLSTATE
	INCF	HI2CACKPOLLSTATE,F,BANKED
ENDIF95:
;exit Sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF92
ELSE92_1:
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
ENDIF92:
;loop
	BRA	SYSDOLOOP_S11
SYSDOLOOP_E11:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_RESTART_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF93
	MOVLW	8
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF93:
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
	BANKSEL	HI2C1STATEMACHINE
	MOVWF	HI2C1STATEMACHINE,BANKED
;HI2CWaitMSSPTimeout = false
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;Clear the error state variable
;HI2C1lastError = I2C1_GOOD
	CLRF	HI2C1LASTERROR,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (811)
SI2CSTOP:
;asm showdebug  Redirected for K42 family probalby called HI2CStop
;asm showdebug  This method sets the registers and register bits to generate the I2C  STOP signal
;Waits up to 254us then set the error state
;HI2C1StateMachine = 0
	BANKSEL	HI2C1STATEMACHINE
	CLRF	HI2C1STATEMACHINE,BANKED
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S8:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E8
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait till this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE86_1
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
	BRA	ENDIF86
ELSE86_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS3:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS3
;end if
ENDIF86:
;loop
	BRA	SYSDOLOOP_S8
SYSDOLOOP_E8:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF87
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF87:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (971)
SI2CWAIT4ACK:
;HI2CWaitMSSPTimeout = 0
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S12:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E12
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait for this event
;if I2C1CON1.ACKSTAT = 0 then
BANKSEL	I2C1CON1
;A8: ASM Source was:  BTFSC I2C1CON1,ACKSTAT,BANKED
	BTFSC	I2C1CON1,5,BANKED
	BRA	ELSE96_1
;Set status
;HI2CAckPollState = I2C1CON1.ACKSTAT
	BANKSEL	HI2CACKPOLLSTATE
	CLRF	HI2CACKPOLLSTATE,BANKED
BANKSEL	I2C1CON1
;A8: ASM Source was:  BTFSS I2C1CON1,ACKSTAT,BANKED
	BTFSS	I2C1CON1,5,BANKED
	BRA	ENDIF98
	BANKSEL	HI2CACKPOLLSTATE
	INCF	HI2CACKPOLLSTATE,F,BANKED
ENDIF98:
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF96
ELSE96_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS7:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS7
;end if
ENDIF96:
;loop
	BRA	SYSDOLOOP_S12
SYSDOLOOP_E12:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_ACK_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF97
	MOVLW	32
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF97:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (996)
SI2CWAIT4MDR:
;HI2CWaitMSSPTimeout = 0
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S13:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E13
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;wait for this event
;if I2C1CON0.MDR = 0 then
BANKSEL	I2C1CON0
;A8: ASM Source was:  BTFSC I2C1CON0,MDR,BANKED
	BTFSC	I2C1CON0,3,BANKED
	BRA	ELSE99_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF99
ELSE99_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS8:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS8
;end if
ENDIF99:
;loop
	BRA	SYSDOLOOP_S13
SYSDOLOOP_E13:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_MDR_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF100
	MOVLW	64
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF100:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (1019)
SI2CWAIT4STOP:
;HI2CWaitMSSPTimeout = 0
	BANKSEL	HI2CWAITMSSPTIMEOUT
	CLRF	HI2CWAITMSSPTIMEOUT,BANKED
;waits up to 254us then creates error message
;do while HI2CWaitMSSPTimeout < 255
SYSDOLOOP_S14:
	MOVLW	255
	BANKSEL	HI2CWAITMSSPTIMEOUT
	SUBWF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E14
;HI2CWaitMSSPTimeout++
	INCF	HI2CWAITMSSPTIMEOUT,F,BANKED
;Wait for this event
;if I2C1PIR.PCIF = 1 then
BANKSEL	I2C1PIR
;A8: ASM Source was:  BTFSS I2C1PIR,PCIF,BANKED
	BTFSS	I2C1PIR,2,BANKED
	BRA	ELSE101_1
;exit sub
	BANKSEL	0
	RETURN
;else
	BRA	ENDIF101
ELSE101_1:
;wait 1 us
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS9:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS9
;end if
ENDIF101:
;loop
	BRA	SYSDOLOOP_S14
SYSDOLOOP_E14:
;if HI2CWaitMSSPTimeout = 255 then HI2C1lastError = HI2C1lastError or I2C1_STOP_TIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF102
	MOVLW	128
	IORWF	HI2C1LASTERROR,F,BANKED
ENDIF102:
;HI2CWaitMSSPTimeout is now TRUE = 255
	BANKSEL	0
	RETURN

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
	BRA	ENDIF74
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
ENDIF74:
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
	BRA	ENDIF75
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
ENDIF75:
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
	BRA	ENDIF76
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
ENDIF76:
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
	BRA	ENDIF77
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
ENDIF77:
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
	BRA	ELSE71_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF72
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	RETURN
;End If
ENDIF72:
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
	BRA	ENDIF71
ELSE71_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	RETURN
;End If
;End If
ENDIF71:
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
	BRA	ENDIF106
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
;exit sub
	RETURN
;end if
ENDIF106:
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
	BRA	ENDIF107
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	ADDWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	ADDWFC	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF107:
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
	BRA	ENDIF69
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF69:
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
	BRA	ENDIF70
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
ENDIF70:
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
	BRA	ENDIF66
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF66:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF67
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF67:
;Call word divide routine
;SysDivSub16
	RCALL	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF68
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
ENDIF68:
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
	BRA	ENDIF64
	MOVF	SYSLONGDIVMULTA,W,BANKED
	ADDWF	SYSLONGDIVMULTX,F,BANKED
	MOVF	SYSLONGDIVMULTA_H,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_H,F,BANKED
	MOVF	SYSLONGDIVMULTA_U,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_U,F,BANKED
	MOVF	SYSLONGDIVMULTA_E,W,BANKED
	ADDWFC	SYSLONGDIVMULTX_E,F,BANKED
ENDIF64:
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
	BRA	ENDIF61
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF61:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF62
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF62:
;Call word multiply routine
;SysMultSub16
	RCALL	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF63
	COMF	SYSINTEGERTEMPX,F,ACCESS
	COMF	SYSINTEGERTEMPX_H,F,ACCESS
	INCF	SYSINTEGERTEMPX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF63:
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
	DB	12,65,110,111,98,105,117,109,32,50,48,50,49

	ALIGN	2;X3

STRINGTABLE3:
	DB	1,42

	ALIGN	2;X3

STRINGTABLE4:
	DB	15,86,101,114,115,105,111,110,32,48,46,57,56,46,48,55

	ALIGN	2;X3

STRINGTABLE5:
	DB	12,76,77,32,71,76,67,68,32,77,79,68,69

	ALIGN	2;X3

STRINGTABLE7:
	DB	8,80,114,105,110,116,83,116,114

	ALIGN	2;X3

STRINGTABLE8:
	DB	1,64

	ALIGN	2;X3

STRINGTABLE9:
	DB	3,77,104,122

	ALIGN	2;X3

STRINGTABLE10:
	DB	7,68,114,97,119,83,116,114

	ALIGN	2;X3

STRINGTABLE11:
	DB	4,65,68,67,58

	ALIGN	2;X3

STRINGTABLE12:
	DB	1,61

	ALIGN	2;X3

STRINGTABLE57:
	DB	1,32

	ALIGN	2;X3

STRINGTABLE90:
	DB	0

	ALIGN	2;X3

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (216)
WRITE_COMMAND_SSD1306:
;HI2CStart
	RCALL	SI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE,BANKED
	BANKSEL	0
	RCALL	SI2CSEND
;HI2CSend 0x00
	BANKSEL	I2CBYTE
	CLRF	I2CBYTE,BANKED
	BANKSEL	0
	RCALL	SI2CSEND
;HI2CSend SSD1306SendByte
	MOVFF	SSD1306SENDBYTE,I2CBYTE
	RCALL	SI2CSEND
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
	BANKSEL	LINEDIFFX
	CLRF	LINEDIFFX,BANKED
	CLRF	LINEDIFFX_H,BANKED
;LineDiffY = 0
	CLRF	LINEDIFFY,BANKED
	CLRF	LINEDIFFY_H,BANKED
;LineStepX = 0
	CLRF	LINESTEPX,BANKED
	CLRF	LINESTEPX_H,BANKED
;LineStepY = 0
	CLRF	LINESTEPY,BANKED
	CLRF	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	CLRF	LINEDIFFX_X2,BANKED
	CLRF	LINEDIFFX_X2_H,BANKED
;LineDiffY_x2 = 0
	CLRF	LINEDIFFY_X2,BANKED
	CLRF	LINEDIFFY_X2_H,BANKED
;LineErr = 0
	CLRF	LINEERR,BANKED
	CLRF	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	MOVF	LINEX1,W,BANKED
	SUBWF	LINEX2,W,BANKED
	MOVWF	LINEDIFFX,BANKED
	MOVF	LINEX1_H,W,BANKED
	SUBWFB	LINEX2_H,W,BANKED
	MOVWF	LINEDIFFX_H,BANKED
;LineDiffY =  LineY2 -   LineY1
	MOVF	LINEY1,W,BANKED
	SUBWF	LINEY2,W,BANKED
	MOVWF	LINEDIFFY,BANKED
	MOVF	LINEY1_H,W,BANKED
	SUBWFB	LINEY2_H,W,BANKED
	MOVWF	LINEDIFFY_H,BANKED
;if (LineDiffX > 0) then
	MOVFF	LINEDIFFX,SYSINTEGERTEMPB
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE55_1
;LineStepX = 1
	MOVLW	1
	BANKSEL	LINESTEPX
	MOVWF	LINESTEPX,BANKED
	CLRF	LINESTEPX_H,BANKED
;else
	BRA	ENDIF55
ELSE55_1:
;LineStepX = -1
	BANKSEL	LINESTEPX
	SETF	LINESTEPX,BANKED
	SETF	LINESTEPX_H,BANKED
;end if
ENDIF55:
;if (LineDiffY > 0) then
	MOVFF	LINEDIFFY,SYSINTEGERTEMPB
	MOVFF	LINEDIFFY_H,SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA,ACCESS
	CLRF	SYSINTEGERTEMPA_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE56_1
;LineStepY = 1
	MOVLW	1
	BANKSEL	LINESTEPY
	MOVWF	LINESTEPY,BANKED
	CLRF	LINESTEPY_H,BANKED
;else
	BRA	ENDIF56
ELSE56_1:
;LineStepY = -1
	BANKSEL	LINESTEPY
	SETF	LINESTEPY,BANKED
	SETF	LINESTEPY_H,BANKED
;end if
ENDIF56:
;LineDiffX = LineStepX * LineDiffX
	MOVFF	LINESTEPX,SYSINTEGERTEMPA
	MOVFF	LINESTEPX_H,SYSINTEGERTEMPA_H
	MOVFF	LINEDIFFX,SYSINTEGERTEMPB
	MOVFF	LINEDIFFX_H,SYSINTEGERTEMPB_H
	BANKSEL	0
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
	BRA	ELSE57_1
;LineErr = LineDiffY_x2 - LineDiffX
	BANKSEL	LINEDIFFX
	MOVF	LINEDIFFX,W,BANKED
	SUBWF	LINEDIFFY_X2,W,BANKED
	MOVWF	LINEERR,BANKED
	MOVF	LINEDIFFX_H,W,BANKED
	SUBWFB	LINEDIFFY_X2_H,W,BANKED
	MOVWF	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SYSDOLOOP_S6:
	MOVFF	LINEX1,SYSWORDTEMPA
	MOVFF	LINEX1_H,SYSWORDTEMPA_H
	MOVFF	LINEX2,SYSWORDTEMPB
	MOVFF	LINEX2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E6
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;LineX1 += LineStepX
	BANKSEL	LINESTEPX
	MOVF	LINESTEPX,W,BANKED
	ADDWF	LINEX1,F,BANKED
	MOVF	LINESTEPX_H,W,BANKED
	ADDWFC	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	MOVFF	LINEERR,SYSINTEGERTEMPA
	MOVFF	LINEERR_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE58_1
;LineErr += LineDiffY_x2
	BANKSEL	LINEDIFFY_X2
	MOVF	LINEDIFFY_X2,W,BANKED
	ADDWF	LINEERR,F,BANKED
	MOVF	LINEDIFFY_X2_H,W,BANKED
	ADDWFC	LINEERR_H,F,BANKED
;else
	BRA	ENDIF58
ELSE58_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	BANKSEL	LINEDIFFX_X2
	MOVF	LINEDIFFX_X2,W,BANKED
	SUBWF	LINEDIFFY_X2,W,BANKED
	MOVWF	SYSTEMP3,BANKED
	MOVF	LINEDIFFX_X2_H,W,BANKED
	SUBWFB	LINEDIFFY_X2_H,W,BANKED
	MOVWF	SYSTEMP3_H,BANKED
	MOVF	SYSTEMP3,W,BANKED
	ADDWF	LINEERR,F,BANKED
	MOVF	SYSTEMP3_H,W,BANKED
	ADDWFC	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	MOVF	LINESTEPY,W,BANKED
	ADDWF	LINEY1,F,BANKED
	MOVF	LINESTEPY_H,W,BANKED
	ADDWFC	LINEY1_H,F,BANKED
;end if
ENDIF58:
;loop
	BRA	SYSDOLOOP_S6
SYSDOLOOP_E6:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;else
	BRA	ENDIF57
ELSE57_1:
;LineErr = LineDiffX_x2 - LineDiffY
	BANKSEL	LINEDIFFY
	MOVF	LINEDIFFY,W,BANKED
	SUBWF	LINEDIFFX_X2,W,BANKED
	MOVWF	LINEERR,BANKED
	MOVF	LINEDIFFY_H,W,BANKED
	SUBWFB	LINEDIFFX_X2_H,W,BANKED
	MOVWF	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SYSDOLOOP_S7:
	MOVFF	LINEY1,SYSWORDTEMPA
	MOVFF	LINEY1_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E7
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;LineY1 += LineStepY
	BANKSEL	LINESTEPY
	MOVF	LINESTEPY,W,BANKED
	ADDWF	LINEY1,F,BANKED
	MOVF	LINESTEPY_H,W,BANKED
	ADDWFC	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	MOVFF	LINEERR,SYSINTEGERTEMPA
	MOVFF	LINEERR_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	RCALL	SYSCOMPLESSTHANINT
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE59_1
;LineErr += LineDiffX_x2
	BANKSEL	LINEDIFFX_X2
	MOVF	LINEDIFFX_X2,W,BANKED
	ADDWF	LINEERR,F,BANKED
	MOVF	LINEDIFFX_X2_H,W,BANKED
	ADDWFC	LINEERR_H,F,BANKED
;else
	BRA	ENDIF59
ELSE59_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	BANKSEL	LINEDIFFY_X2
	MOVF	LINEDIFFY_X2,W,BANKED
	SUBWF	LINEDIFFX_X2,W,BANKED
	MOVWF	SYSTEMP3,BANKED
	MOVF	LINEDIFFY_X2_H,W,BANKED
	SUBWFB	LINEDIFFX_X2_H,W,BANKED
	MOVWF	SYSTEMP3_H,BANKED
	MOVF	SYSTEMP3,W,BANKED
	ADDWF	LINEERR,F,BANKED
	MOVF	SYSTEMP3_H,W,BANKED
	ADDWFC	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	MOVF	LINESTEPX,W,BANKED
	ADDWF	LINEX1,F,BANKED
	MOVF	LINESTEPX_H,W,BANKED
	ADDWFC	LINEX1_H,F,BANKED
;end if
ENDIF59:
;loop
	BRA	SYSDOLOOP_S7
SYSDOLOOP_E7:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEY1,GLCDY
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1306
;end if
ENDIF57:
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
