;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\260_spi_glcd_using_sss1331.S"
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
 BYTENUMBER                       EQU 1294                    ; 0X50E
 CCOUNT                           EQU 1295                    ; 0X50F
 CHARCODE                         EQU 1296                    ; 0X510
 CHARCOL                          EQU 1297                    ; 0X511
 CHARCOL_H                        EQU 1298                    ; 0X512
 CHARLOCX                         EQU 1299                    ; 0X513
 CHARLOCX_H                       EQU 1300                    ; 0X514
 CHARLOCY                         EQU 1301                    ; 0X515
 CHARLOCY_H                       EQU 1302                    ; 0X516
 COLSPERFONT                      EQU 1303                    ; 0X517
 CURRCHARCOL                      EQU 1304                    ; 0X518
 CURRCHARROW                      EQU 1305                    ; 0X519
 CURRCHARVAL                      EQU 1306                    ; 0X51A
 DDF_X                            EQU 1307                    ; 0X51B
 DDF_X_H                          EQU 1308                    ; 0X51C
 DDF_Y                            EQU 1309                    ; 0X51D
 DDF_Y_H                          EQU 1310                    ; 0X51E
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 DIM_STATE                        EQU 1311                    ; 0X51F
 DRAWLINE                         EQU 1312                    ; 0X520
 DRAWLINE_H                       EQU 1313                    ; 0X521
 FF                               EQU 1314                    ; 0X522
 FF_H                             EQU 1315                    ; 0X523
 FILLCIRCLEXX                     EQU 1316                    ; 0X524
 FILLCIRCLEYY                     EQU 1317                    ; 0X525
 GLCDBACKGROUND                   EQU 1318                    ; 0X526
 GLCDBACKGROUND_H                 EQU 1319                    ; 0X527
 GLCDCOLOUR                       EQU 1320                    ; 0X528
 GLCDCOLOUR_H                     EQU 1321                    ; 0X529
 GLCDDEVICEHEIGHT                 EQU 1322                    ; 0X52A
 GLCDDEVICEHEIGHT_H               EQU 1323                    ; 0X52B
 GLCDDEVICEWIDTH                  EQU 1324                    ; 0X52C
 GLCDDEVICEWIDTH_H                EQU 1325                    ; 0X52D
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
 GLCDX_H                          EQU 1339                    ; 0X53B
 GLCDY                            EQU 1340                    ; 0X53C
 GLCDY_H                          EQU 1341                    ; 0X53D
 GLCD_YORDINATE                   EQU 1342                    ; 0X53E
 GLCD_YORDINATE_H                 EQU 1343                    ; 0X53F
 INXRADIUS                        EQU 1344                    ; 0X540
 INXRADIUS_H                      EQU 1345                    ; 0X541
 LCDVALUE                         EQU 1346                    ; 0X542
 LCDVALUE_E                       EQU 1349                    ; 0X545
 LCDVALUE_H                       EQU 1347                    ; 0X543
 LCDVALUE_U                       EQU 1348                    ; 0X544
 LINECOLOUR                       EQU 1350                    ; 0X546
 LINECOLOUR_H                     EQU 1351                    ; 0X547
 LINEDIFFX                        EQU 1352                    ; 0X548
 LINEDIFFX_H                      EQU 1353                    ; 0X549
 LINEDIFFX_X2                     EQU 1354                    ; 0X54A
 LINEDIFFX_X2_H                   EQU 1355                    ; 0X54B
 LINEDIFFY                        EQU 1356                    ; 0X54C
 LINEDIFFY_H                      EQU 1357                    ; 0X54D
 LINEDIFFY_X2                     EQU 1358                    ; 0X54E
 LINEDIFFY_X2_H                   EQU 1359                    ; 0X54F
 LINEERR                          EQU 1360                    ; 0X550
 LINEERR_H                        EQU 1361                    ; 0X551
 LINESTEPX                        EQU 1362                    ; 0X552
 LINESTEPX_H                      EQU 1363                    ; 0X553
 LINESTEPY                        EQU 1364                    ; 0X554
 LINESTEPY_H                      EQU 1365                    ; 0X555
 LINEX1                           EQU 1366                    ; 0X556
 LINEX1_H                         EQU 1367                    ; 0X557
 LINEX2                           EQU 1368                    ; 0X558
 LINEX2_H                         EQU 1369                    ; 0X559
 LINEY1                           EQU 1370                    ; 0X55A
 LINEY1_H                         EQU 1371                    ; 0X55B
 LINEY2                           EQU 1372                    ; 0X55C
 LINEY2_H                         EQU 1373                    ; 0X55D
 LOCALCHARCODE                    EQU 1374                    ; 0X55E
 LOCALCHARCODE_H                  EQU 1375                    ; 0X55F
 LONGNUMBER                       EQU 1376                    ; 0X560
 LONGNUMBER_E                     EQU 1379                    ; 0X563
 LONGNUMBER_H                     EQU 1377                    ; 0X561
 LONGNUMBER_U                     EQU 1378                    ; 0X562
 OLDGLCDFONTWIDTH                 EQU 1380                    ; 0X564
 OUTSTRING                        EQU 5335                    ; 0X14D7
 PAD                              EQU 5294                    ; 0X14AE
 PRINTLOCX                        EQU 1381                    ; 0X565
 PRINTLOCX_H                      EQU 1382                    ; 0X566
 PRINTLOCY                        EQU 1383                    ; 0X567
 PRINTLOCY_H                      EQU 1384                    ; 0X568
 RADIUSERR                        EQU 1385                    ; 0X569
 RADIUSERR_H                      EQU 1386                    ; 0X56A
 ROWSPERFONT                      EQU 1387                    ; 0X56B
 SPICLOCKMODE                     EQU 1388                    ; 0X56C
 SPICURRENTMODE                   EQU 1389                    ; 0X56D
 SPIRXDATA                        EQU 1390                    ; 0X56E
 SPITXDATA                        EQU 1391                    ; 0X56F
 SSD1331BYTESTOSEND               EQU 1392                    ; 0X570
 SSD1331BYTESTOSENDCOUNTER        EQU 1393                    ; 0X571
 SSD1331ROTATION                  EQU 1394                    ; 0X572
 SSD1331SENDBYTE                  EQU 1395                    ; 0X573
 SSD1331_COMMAND                  EQU 5264                    ; 0X1490
 STR                              EQU 5247                    ; 0X147F
 STRINGLOCX                       EQU 1396                    ; 0X574
 STRINGLOCX_H                     EQU 1397                    ; 0X575
 STRINGPOINTER                    EQU 1398                    ; 0X576
 SYSARRAYTEMP1                    EQU 1399                    ; 0X577
 SYSARRAYTEMP2                    EQU 1400                    ; 0X578
 SYSBYTETEMPA                     EQU 1285                    ; 0X505
 SYSBYTETEMPB                     EQU 1289                    ; 0X509
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPA                     EQU 1285                    ; 0X505
 SYSCALCTEMPA_E                   EQU 1288                    ; 0X508
 SYSCALCTEMPA_H                   EQU 1286                    ; 0X506
 SYSCALCTEMPA_U                   EQU 1287                    ; 0X507
 SYSCALCTEMPX                     EQU 1280                    ; 0X500
 SYSCALCTEMPX_H                   EQU 1281                    ; 0X501
 SYSCHARCOUNT                     EQU 1401                    ; 0X579
 SYSCHARSHANDLER                  EQU 1402                    ; 0X57A
 SYSCHARSHANDLER_H                EQU 1403                    ; 0X57B
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
 SYSLCDPRINTDATAHANDLER           EQU 1404                    ; 0X57C
 SYSLCDPRINTDATAHANDLER_H         EQU 1405                    ; 0X57D
 SYSLONGDIVMULTA                  EQU 1406                    ; 0X57E
 SYSLONGDIVMULTA_E                EQU 1409                    ; 0X581
 SYSLONGDIVMULTA_H                EQU 1407                    ; 0X57F
 SYSLONGDIVMULTA_U                EQU 1408                    ; 0X580
 SYSLONGDIVMULTB                  EQU 1410                    ; 0X582
 SYSLONGDIVMULTB_E                EQU 1413                    ; 0X585
 SYSLONGDIVMULTB_H                EQU 1411                    ; 0X583
 SYSLONGDIVMULTB_U                EQU 1412                    ; 0X584
 SYSLONGDIVMULTX                  EQU 1414                    ; 0X586
 SYSLONGDIVMULTX_E                EQU 1417                    ; 0X589
 SYSLONGDIVMULTX_H                EQU 1415                    ; 0X587
 SYSLONGDIVMULTX_U                EQU 1416                    ; 0X588
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
 SYSPRINTBUFFER                   EQU 5253                    ; 0X1485
 SYSPRINTBUFFLEN                  EQU 1418                    ; 0X58A
 SYSREPEATTEMP1                   EQU 1419                    ; 0X58B
 SYSREPEATTEMP2                   EQU 1420                    ; 0X58C
 SYSREPEATTEMP2_H                 EQU 1421                    ; 0X58D
 SYSSIGNBYTE                      EQU 1293                    ; 0X50D
 SYSSTRDATA                       EQU 1422                    ; 0X58E
 SYSSTRINGA                       EQU 1287                    ; 0X507
 SYSSTRINGA_H                     EQU 1288                    ; 0X508
 SYSSTRINGLENGTH                  EQU 1286                    ; 0X506
 SYSSTRINGPARAM1                  EQU 5277                    ; 0X149D
 SYSSTRINGTEMP                    EQU 1423                    ; 0X58F
 SYSSTRLEN                        EQU 1424                    ; 0X590
 SYSSYSINSTRING3HANDLER           EQU 1425                    ; 0X591
 SYSSYSINSTRING3HANDLER_H         EQU 1426                    ; 0X592
 SYSSYSINSTRINGHANDLER            EQU 1427                    ; 0X593
 SYSSYSINSTRINGHANDLER_H          EQU 1428                    ; 0X594
 SYSTEMP1                         EQU 1429                    ; 0X595
 SYSTEMP1_E                       EQU 1432                    ; 0X598
 SYSTEMP1_H                       EQU 1430                    ; 0X596
 SYSTEMP1_U                       EQU 1431                    ; 0X597
 SYSTEMP2                         EQU 1433                    ; 0X599
 SYSTEMP2_H                       EQU 1434                    ; 0X59A
 SYSTEMP3                         EQU 1435                    ; 0X59B
 SYSTEMP3_H                       EQU 1436                    ; 0X59C
 SYSVALTEMP                       EQU 1437                    ; 0X59D
 SYSVALTEMP_H                     EQU 1438                    ; 0X59E
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
 WORDNUMBER                       EQU 1439                    ; 0X59F
 WORDNUMBER_H                     EQU 1440                    ; 0X5A0
 XCHAR                            EQU 1441                    ; 0X5A1
 XOFFSET                          EQU 1442                    ; 0X5A2
 XOFFSET_H                        EQU 1443                    ; 0X5A3
 XRADIUS                          EQU 1444                    ; 0X5A4
 XRADIUS_H                        EQU 1445                    ; 0X5A5
 YCALC1                           EQU 1446                    ; 0X5A6
 YCALC1_H                         EQU 1447                    ; 0X5A7
 YCALC2                           EQU 1448                    ; 0X5A8
 YCALC2_H                         EQU 1449                    ; 0X5A9
 YOFFSET                          EQU 1450                    ; 0X5AA
 YOFFSET_H                        EQU 1451                    ; 0X5AB
 YORDINATE                        EQU 1452                    ; 0X5AC
 _HEXPICAS                        EQU 5243                    ; 0X147B

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 1257
 AFSR0_H                          EQU 1258
 SYSPAD_0                         EQU 5294
 SYSSSD1331_COMMAND_0             EQU 5264
 SYSSSD1331_COMMAND_1             EQU 5265
 SYSSSD1331_COMMAND_10            EQU 5274
 SYSSSD1331_COMMAND_2             EQU 5266
 SYSSSD1331_COMMAND_3             EQU 5267
 SYSSSD1331_COMMAND_4             EQU 5268
 SYSSSD1331_COMMAND_5             EQU 5269
 SYSSSD1331_COMMAND_6             EQU 5270
 SYSSSD1331_COMMAND_7             EQU 5271
 SYSSSD1331_COMMAND_8             EQU 5272
 SYSSSD1331_COMMAND_9             EQU 5273
 SYSSTR_0                         EQU 5247
 SYS_HEXPICAS_0                   EQU 5243
 SYS_HEXPICAS_1                   EQU 5244
 SYS_HEXPICAS_2                   EQU 5245

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
	CALL	INITGLCD_SSD1331

;START OF THE MAIN PROGRAM
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the SPI capabilities using an GLCD SSD1331.
;''It is a nice graphical LCD, suitable for a lot of various projects.
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;'':
;''This has been tested using the hardware and software SPI option.  If you change from hardware SPI when using PPS, you will need to power cycle the chip.
;'':
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    31.12.2020
;''********************************************************************************
;Chip Settings
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -------- -CS--DC-SW----------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    SCK-SCL-SDO-SDA----------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ----TX---------LED--LED-LED LED--
;'-----------------------------------------
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.6.2
;PinManager data: v1.81.0
;Generated for 18f16q41
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18f16q41
;Template comment at the end of the config file
;#define GLCD_TYPE GLCD_TYPE_SSD1331
;This is a PPS chip, so, needs to make the PPS match these assignments
;#DEFINE GLCD_DO     portB.5
;#DEFINE GLCD_SCK    portB.7
;Pin mappings for GLCD
;#DEFINE GLCD_DC     porta.4
;#DEFINE GLCD_CS     porta.5
;#DEFINE GLCD_RESET  porta.1
;
;Uncomment out the next line... enable or disable the PPS!!!
;#DEFINE SSD1331_HardwareSPI    ' remove/comment out if you want to use software SPI.0
;
;
;
;' ********************** DEMO REALLY STARTS HERE ************************************************
;GLCD selected OLED font set.
;#define GLCD_OLED_FONT
;#define GLCD_PROTECTOVERRUN
;GLCDfntDefaultsize = 1
	MOVLW	1
	MOVWF	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDCLS  ' supports GLCDBackground as default
;GLCDCLS  also support passing color parameter.
;GLCDCLS [color]
;GLCDRotate ( Landscape )
;
;Dim CCOUNT, BYTENUMBER, OLDFONT, OLDFONT as Byte
;CCount = 31
	MOVLW	31
	MOVWF	CCOUNT,ACCESS
;dim longNumber as long
;longNumber = 0 ' max value = 4294967290
	BANKSEL	LONGNUMBER
	CLRF	LONGNUMBER,BANKED
	CLRF	LONGNUMBER_H,BANKED
	CLRF	LONGNUMBER_U,BANKED
	CLRF	LONGNUMBER_E,BANKED
;dim wordNumber as Word
;dim outstring as string
;wordNumber = 0
	CLRF	WORDNUMBER,BANKED
	CLRF	WORDNUMBER_H,BANKED
;byteNumber = 0
	CLRF	BYTENUMBER,ACCESS
;GLCDSetContrast ( 0x80 )
	MOVLW	128
	MOVWF	DIM_STATE,ACCESS
	BANKSEL	0
	CALL	SETCONTRAST_SSD1331
;SetPowerMode_SSD1331(0x1A)                    'Explicit commmands for this device
	MOVLW	26
	MOVWF	DIM_STATE,ACCESS
	CALL	SETPOWERMODE_SSD1331
;SetBrightness_SSD1331( 0xFF )                 'Explicit commmands for this device - full brightness
	SETF	DIM_STATE,ACCESS
	CALL	SETBRIGHTNESS_SSD1331
;GLCDPrintStringLN "Great Cow BASIC"
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
	CALL	GLCDPRINTSTRINGLN
;GLCDPrintStringLN ""
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
	CALL	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "January 2021"
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
	CALL	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "SSD1331 GLCD"
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINTSTRINGLN
;GLCDPrintStringLN ""
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
	CALL	GLCDPRINTSTRINGLN
;GLCDPrintStringLN "by Anobium"
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINTSTRINGLN
;wait 5 s
	MOVLW	5
	MOVWF	SYSWAITTEMPS,ACCESS
	CALL	DELAY_S
;repeat 2
	MOVLW	2
	BANKSEL	SYSREPEATTEMP1
	MOVWF	SYSREPEATTEMP1,BANKED
SYSREPEATLOOP1:
;GLCDRotate ( Landscape )
	MOVLW	1
	MOVWF	SSD1331ROTATION,BANKED
	BANKSEL	0
	CALL	GLCDROTATE_SSD1331
;GLCDCLS SSD1331_BLUE
	MOVLW	31
	MOVWF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
	CALL	GLCDCLS_SSD1331
;GLCDForeground = SSD1331_MAROON
	CLRF	GLCDFOREGROUND,ACCESS
	MOVLW	128
	MOVWF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2, 2, "GLCDPrint String" )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE6
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE6
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
;GLCDForeground = SSD1331_WHITE
	SETF	GLCDFOREGROUND,ACCESS
	SETF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2, 12, "GLCDPrint String" )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	12
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE6
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE6
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
;GLCDForeground = SSD1331_RED
	CLRF	GLCDFOREGROUND,ACCESS
	MOVLW	248
	MOVWF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2,30, "GLCDPrint String" )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	30
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE6
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE6
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE6
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
;FilledBox 50,40,55,45,SSD1331_RED
	MOVLW	50
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	40
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	55
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	45
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	CLRF	LINECOLOUR,ACCESS
	MOVLW	248
	MOVWF	LINECOLOUR_H,ACCESS
	CALL	FILLEDBOX_SSD1331
;wait 2 s
	MOVLW	2
	MOVWF	SYSWAITTEMPS,ACCESS
	CALL	DELAY_S
;longNumber = 0xFFFFFFFF
	BANKSEL	LONGNUMBER
	SETF	LONGNUMBER,BANKED
	SETF	LONGNUMBER_H,BANKED
	SETF	LONGNUMBER_U,BANKED
	SETF	LONGNUMBER_E,BANKED
;wordNumber = 0xFFFF
	SETF	WORDNUMBER,BANKED
	SETF	WORDNUMBER_H,BANKED
;byteNumber = 0xFF
	SETF	BYTENUMBER,ACCESS
;GLCDRotate ( Portrait )
	MOVLW	4
	MOVWF	SSD1331ROTATION,BANKED
	BANKSEL	0
	CALL	GLCDROTATE_SSD1331
;GLCDCLS SSD1331_RED
	CLRF	GLCDBACKGROUND,ACCESS
	MOVLW	248
	MOVWF	GLCDBACKGROUND_H,ACCESS
	CALL	GLCDCLS_SSD1331
;GLCDForeground = SSD1331_MAROON
	CLRF	GLCDFOREGROUND,ACCESS
	MOVLW	128
	MOVWF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2, 2, bytenumber )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	BYTENUMBER,LCDVALUE
	CLRF	LCDVALUE_H,ACCESS
	CLRF	LCDVALUE_U,ACCESS
	CLRF	LCDVALUE_E,ACCESS
	BANKSEL	0
	CALL	GLCDPRINT7
;GLCDForeground = SSD1331_BLACK
	CLRF	GLCDFOREGROUND,ACCESS
	CLRF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2, 12, wordNumber )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	12
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	WORDNUMBER,LCDVALUE
	MOVFF	WORDNUMBER_H,LCDVALUE_H
	CLRF	LCDVALUE_U,ACCESS
	CLRF	LCDVALUE_E,ACCESS
	BANKSEL	0
	CALL	GLCDPRINT7
;GLCDForeground = SSD1331_CYAN
	SETF	GLCDFOREGROUND,ACCESS
	MOVLW	7
	MOVWF	GLCDFOREGROUND_H,ACCESS
;GLCDPrint ( 2,30, longnumber )
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	30
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	LONGNUMBER,LCDVALUE
	MOVFF	LONGNUMBER_H,LCDVALUE_H
	MOVFF	LONGNUMBER_U,LCDVALUE_U
	MOVFF	LONGNUMBER_E,LCDVALUE_E
	BANKSEL	0
	CALL	GLCDPRINT7
;wait 2 s
	MOVLW	2
	MOVWF	SYSWAITTEMPS,ACCESS
	CALL	DELAY_S
;end Repeat
	BANKSEL	SYSREPEATTEMP1
	DECFSZ	SYSREPEATTEMP1,F,BANKED
	BRA	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;GLCDCLS SSD1331_BLUE
	MOVLW	31
	MOVWF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
	BANKSEL	0
	CALL	GLCDCLS_SSD1331
;GLCDRotate ( Landscape )
	MOVLW	1
	BANKSEL	SSD1331ROTATION
	MOVWF	SSD1331ROTATION,BANKED
	BANKSEL	0
	CALL	GLCDROTATE_SSD1331
;GLCDForeground = SSD1331_White
	SETF	GLCDFOREGROUND,ACCESS
	SETF	GLCDFOREGROUND_H,ACCESS
;Prepare the static components of the screen
;GLCDPrint ( 2,   2, "SSD1331 Library")                         ; Print some text
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
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
;GLCDPrint ( 2,   9, "PrintStr")                                ; Print some text
	MOVLW	2
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	9
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
;GLCDPrint ( 64,  2, "@")                                       ; Print some more text
	MOVLW	64
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
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
;GLCDPrint ( 72,  2, ChipMhz)                                   ; Print chip speed
	MOVLW	72
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	64
	MOVWF	LCDVALUE,ACCESS
	CLRF	LCDVALUE_H,ACCESS
	CLRF	LCDVALUE_U,ACCESS
	CLRF	LCDVALUE_E,ACCESS
	BANKSEL	0
	CALL	GLCDPRINT7
;GLCDPrint ( 80,  2, "Mhz")                                     ; Print some text
	MOVLW	80
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	2
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
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
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDDrawString( 2,18,"DrawStr")                                 ; Draw some text
	MOVLW	2
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX,BANKED
	CLRF	STRINGLOCX_H,BANKED
	MOVLW	18
	MOVWF	CHARLOCY,ACCESS
	CLRF	CHARLOCY_H,ACCESS
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE11
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE11
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE11
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
	CALL	GLCDDRAWSTRING_SSD1331
;box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1                            ; Draw a box
	CLRF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	CLRF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	95
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	63
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	RCALL	BOX
;box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1    ; Draw a box
	MOVLW	91
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	59
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	95
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	63
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	RCALL	BOX
;Circle( 32,41,10)                                              ; Draw a circle
	MOVLW	32
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	41
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	10
	MOVWF	INXRADIUS,ACCESS
	CLRF	INXRADIUS_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	MOVFF	GLCD_YORDINATE,YORDINATE
	BANKSEL	0
	RCALL	CIRCLE
;line 50,31,0,31                                                ; Draw a line
	MOVLW	50
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	31
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	CLRF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	31
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	_LINE
;DO forever
SYSDOLOOP_S1:
;for CCount = 32 to 127
	MOVLW	31
	MOVWF	CCOUNT,ACCESS
SYSFORLOOP1:
	INCF	CCOUNT,F,ACCESS
;outstring = hex(longNumber_E )
	MOVFF	LONGNUMBER_E,SYSVALTEMP
	BANKSEL	0
	CALL	FN__HEXPICAS
	LFSR	1,OUTSTRING
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRING
;outstring = outstring+hex(longNumber_E )
	MOVFF	LONGNUMBER_E,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,OUTSTRING
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,OUTSTRING
	CALL	SYSCOPYSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,OUTSTRING
	MOVFF	SYSSTRINGLENGTH, INDF0
;outstring = outstring+hex(longNumber_H )
	MOVFF	LONGNUMBER_H,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,OUTSTRING
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,OUTSTRING
	CALL	SYSCOPYSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,OUTSTRING
	MOVFF	SYSSTRINGLENGTH, INDF0
;outstring = outstring+hex(longNumber )
	MOVFF	LONGNUMBER,SYSVALTEMP
	CALL	FN__HEXPICAS
	LFSR	1,OUTSTRING
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,OUTSTRING
	CALL	SYSCOPYSTRINGPART
	LFSR	0,_HEXPICAS
	CALL	SYSCOPYSTRINGPART
	LFSR	0,OUTSTRING
	MOVFF	SYSSTRINGLENGTH, INDF0
;outstring = outstring+"h"
	LFSR	1,OUTSTRING
	CLRF	SYSSTRINGLENGTH,ACCESS
	LFSR	0,OUTSTRING
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
	LFSR	0,OUTSTRING
	MOVFF	SYSSTRINGLENGTH, INDF0
;GLCDPrint ( 46 ,  36,  Outstring  )                        ; Print a HEX string
	MOVLW	46
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	36
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVLW	LOW OUTSTRING
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH OUTSTRING
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint ( 46 ,  44, pad(str(wordNumber), 6 ) )           ; Print a padded string
	MOVLW	46
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	44
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	WORDNUMBER,SYSVALTEMP
	MOVFF	WORDNUMBER_H,SYSVALTEMP_H
	BANKSEL	0
	CALL	FN_STR
	MOVLW	LOW STR
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH STR
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	6
	MOVWF	SYSSTRLEN,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE58
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE58
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE58
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
	MOVLW	LOW PAD
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH PAD
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;GLCDPrint ( 46 ,  52, pad(str(byteNumber), 4 ) )           ; Print a padded string
	MOVLW	46
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
	MOVLW	52
	MOVWF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
	MOVFF	BYTENUMBER,SYSVALTEMP
	CLRF	SYSVALTEMP_H,BANKED
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
	MOVLW	LOW STRINGTABLE58
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE58
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE58
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
	MOVLW	LOW PAD
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVWF	SYSLCDPRINTDATAHANDLER,BANKED
	MOVLW	HIGH PAD
	MOVWF	SYSLCDPRINTDATAHANDLER_H,BANKED
	BANKSEL	0
	CALL	GLCDPRINT4
;box (46,19,56,28)                                           ; Draw a Box
	MOVLW	46
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	19
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	56
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	28
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	RCALL	BOX
;GLCDDrawChar(49, 20, CCount )                               ; Draw a character
	MOVLW	49
	MOVWF	CHARLOCX,ACCESS
	CLRF	CHARLOCX_H,ACCESS
	MOVLW	20
	MOVWF	CHARLOCY,ACCESS
	CLRF	CHARLOCY_H,ACCESS
	MOVFF	CCOUNT,CHARCODE
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	GLCDDRAWCHAR_SSD1331
;outString = str( CCount )                                  ; Prepare a string
	MOVFF	CCOUNT,SYSVALTEMP
	BANKSEL	SYSVALTEMP_H
	CLRF	SYSVALTEMP_H,BANKED
	BANKSEL	0
	CALL	FN_STR
	LFSR	1,OUTSTRING
	LFSR	0,STR
	CALL	SYSCOPYSTRING
;GLCDDrawString(64, 19, pad(outString,5) )                   ; Draw a string
	MOVLW	64
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX,BANKED
	CLRF	STRINGLOCX_H,BANKED
	MOVLW	19
	MOVWF	CHARLOCY,ACCESS
	CLRF	CHARLOCY_H,ACCESS
	MOVLW	LOW OUTSTRING
	MOVWF	SYSSYSINSTRINGHANDLER,BANKED
	MOVLW	HIGH OUTSTRING
	MOVWF	SYSSYSINSTRINGHANDLER_H,BANKED
	MOVLW	5
	MOVWF	SYSSTRLEN,BANKED
	LFSR	1,SYSSTRINGPARAM1
	MOVLW	LOW STRINGTABLE58
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE58
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE58
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
	MOVLW	LOW PAD
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER,BANKED
	MOVLW	HIGH PAD
	MOVWF	SYSCHARSHANDLER_H,BANKED
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	BANKSEL	0
	CALL	GLCDDRAWSTRING_SSD1331
;filledbox 3,43,11,51, wordNumber                           ; Draw a filled box
	MOVLW	3
	MOVWF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	43
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	11
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	51
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	WORDNUMBER,LINECOLOUR
	MOVFF	WORDNUMBER_H,LINECOLOUR_H
	RCALL	FILLEDBOX_SSD1331
;FilledCircle( 32,41,8, longNumber )                   ; Draw a filled box
	MOVLW	32
	BANKSEL	XOFFSET
	MOVWF	XOFFSET,BANKED
	CLRF	XOFFSET_H,BANKED
	MOVLW	41
	MOVWF	YOFFSET,BANKED
	CLRF	YOFFSET_H,BANKED
	MOVLW	8
	MOVWF	XRADIUS,BANKED
	CLRF	XRADIUS_H,BANKED
	MOVFF	LONGNUMBER,LINECOLOUR
	MOVFF	LONGNUMBER_H,LINECOLOUR_H
	BANKSEL	0
	RCALL	FILLEDCIRCLE
;line 0,63,50,31                                            ; Draw a line
	CLRF	LINEX1,ACCESS
	CLRF	LINEX1_H,ACCESS
	MOVLW	63
	MOVWF	LINEY1,ACCESS
	CLRF	LINEY1_H,ACCESS
	MOVLW	50
	MOVWF	LINEX2,ACCESS
	CLRF	LINEX2_H,ACCESS
	MOVLW	31
	MOVWF	LINEY2,ACCESS
	CLRF	LINEY2_H,ACCESS
	MOVFF	GLCDFOREGROUND,LINECOLOUR
	MOVFF	GLCDFOREGROUND_H,LINECOLOUR_H
	CALL	_LINE
;Do some simple maths
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	MOVLW	7
	BANKSEL	LONGNUMBER
	ADDWF	LONGNUMBER,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_H,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_U,F,BANKED
	MOVLW	0
	ADDWFC	LONGNUMBER_E,F,BANKED
	MOVLW	3
	ADDWF	WORDNUMBER,F,BANKED
	MOVLW	0
	ADDWFC	WORDNUMBER_H,F,BANKED
	INCF	BYTENUMBER,F,ACCESS
;NEXT
	MOVLW	127
	SUBWF	CCOUNT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;LOOP
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;end
	BRA	BASPROGRAMEND
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
	BRA	ENDIF7
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
ENDIF7:
;If LineY1 > LineY2 Then
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF8
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
ENDIF8:
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
	BRA	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	DRAWLINE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	MOVFF	DRAWLINE,GLCDX
	MOVFF	DRAWLINE_H,GLCDX_H
	MOVFF	LINEY1,GLCDY
	MOVFF	LINEY1_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;PSet DrawLine, LineY2, LineColour
	MOVFF	DRAWLINE,GLCDX
	MOVFF	DRAWLINE_H,GLCDX_H
	MOVFF	LINEY2,GLCDY
	MOVFF	LINEY2_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;Next
	MOVFF	DRAWLINE,SYSWORDTEMPA
	MOVFF	DRAWLINE_H,SYSWORDTEMPA_H
	MOVFF	LINEX2,SYSWORDTEMPB
	MOVFF	LINEX2_H,SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP4
SYSFORLOOPEND4:
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
	BRA	SYSFORLOOPEND5
SYSFORLOOP5:
	INCF	DRAWLINE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEX1_H,GLCDX_H
	MOVFF	DRAWLINE,GLCDY
	MOVFF	DRAWLINE_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;PSet LineX2, DrawLine, LineColour
	MOVFF	LINEX2,GLCDX
	MOVFF	LINEX2_H,GLCDX_H
	MOVFF	DRAWLINE,GLCDY
	MOVFF	DRAWLINE_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;Next
	MOVFF	DRAWLINE,SYSWORDTEMPA
	MOVFF	DRAWLINE_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP5
SYSFORLOOPEND5:
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
	MOVF	XRADIUS_H,W,BANKED
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	YORDINATE,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	XRADIUS,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	YORDINATE,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	XRADIUS,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	YORDINATE,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	SUBWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	XRADIUS,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	YORDINATE,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W,BANKED
	ADDWF	XOFFSET,W,BANKED
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	GLCDX_H,ACCESS
	MOVF	XRADIUS,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
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
	BRA	ELSE13_1
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
	BRA	ENDIF13
ELSE13_1:
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
ENDIF13:
;Loop
	BRA	SYSDOLOOP_S3
SYSDOLOOP_E3:
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

;SOURCE: HWSPI.H (704)
FASTHWSPITRANSFER:
;Master mode only
;One byte transfer count
;SPI1TCNTL = 1
	MOVLW	1
;A2: ASM Source was:  MOVWF SPI1TCNTL,BANKED
;A4: ASM Source was:  MOVWF SPI1TCNTL,BANKED
	MOVWF	SPI1TCNT,BANKED
;SPI1TXB = SPITxData
	MOVFF	SPITXDATA,SPI1TXB
;wait while SPI1RXIF = SPI_RX_IN_PROGRESS
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSS PIR3,SPI1RXIF,ACCESS
	BTFSS	PIR3,0,ACCESS
	BRA	SYSWAITLOOP1
;SPIRxData = SPI1RXB
	MOVFF	SPI1RXB,SPIRXDATA
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (472)
FILLEDBOX_SSD1331:
;dim GLCDTemp, LineColour as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	MOVFF	LINEX1,SYSWORDTEMPB
	MOVFF	LINEX1_H,SYSWORDTEMPB_H
	MOVFF	LINEX2,SYSWORDTEMPA
	MOVFF	LINEX2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF27
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
ENDIF27:
;If LineY1 > LineY2 Then
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF28
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
ENDIF28:
;Draw lines going across
;For DrawLine = [byte]LineX1 To [byte]LineX2
	DECF	LINEX1,W,ACCESS
	MOVWF	DRAWLINE,ACCESS
	MOVF	LINEX1,W,ACCESS
	SUBWF	LINEX2,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND9
SYSFORLOOP9:
	INCF	DRAWLINE,F,ACCESS
;For GLCDTemp = LineY1 To LineY2
	MOVLW	1
	SUBWF	LINEY1,W,ACCESS
	MOVWF	GLCDTEMP,ACCESS
	MOVLW	0
	SUBWFB	LINEY1_H,W,ACCESS
	MOVWF	GLCDTEMP_H,ACCESS
	MOVFF	LINEY1,SYSWORDTEMPB
	MOVFF	LINEY1_H,SYSWORDTEMPB_H
	MOVFF	LINEY2,SYSWORDTEMPA
	MOVFF	LINEY2_H,SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND10
SYSFORLOOP10:
	INCF	GLCDTEMP,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	GLCDTEMP_H,F,ACCESS
;PSet DrawLine, GLCDTemp, [word]LineColour
	MOVFF	DRAWLINE,GLCDX
	CLRF	GLCDX_H,ACCESS
	MOVFF	GLCDTEMP,GLCDY
	MOVFF	GLCDTEMP_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;Next
	MOVFF	GLCDTEMP,SYSWORDTEMPA
	MOVFF	GLCDTEMP_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP10
SYSFORLOOPEND10:
;Next
	MOVF	LINEX2,W,ACCESS
	SUBWF	DRAWLINE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP9
SYSFORLOOPEND9:
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1522)
FILLEDCIRCLE:
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	SUBLW	1
	MOVWF	FF,ACCESS
	CLRF	SYSTEMP1,BANKED
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	SYSTEMP1,W,BANKED
	MOVWF	FF_H,ACCESS
;ddF_x = 1
	MOVLW	1
	MOVWF	DDF_X,ACCESS
	CLRF	DDF_X_H,ACCESS
;ddF_y = -2 * xradius
	MOVFF	XRADIUS,SYSINTEGERTEMPA
	MOVFF	XRADIUS_H,SYSINTEGERTEMPA_H
	MOVLW	254
	MOVWF	SYSINTEGERTEMPB,ACCESS
	SETF	SYSINTEGERTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUBINT
	MOVFF	SYSINTEGERTEMPX,DDF_Y
	MOVFF	SYSINTEGERTEMPX_H,DDF_Y_H
;FillCircleXX = 0
	CLRF	FILLCIRCLEXX,ACCESS
;FillCircleYY = xradius
	MOVFF	XRADIUS,FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W,BANKED
	ADDWF	YOFFSET,W,BANKED
	MOVWF	YCALC2,BANKED
	MOVF	XRADIUS_H,W,BANKED
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	YCALC2_H,BANKED
;YCalc1 = yoffset-xradius
	MOVF	XRADIUS,W,BANKED
	SUBWF	YOFFSET,W,BANKED
	MOVWF	YCALC1,BANKED
	MOVF	XRADIUS_H,W,BANKED
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	YCALC1_H,BANKED
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	MOVFF	XOFFSET,LINEX1
	MOVFF	XOFFSET_H,LINEX1_H
	MOVFF	YCALC1,LINEY1
	MOVFF	YCALC1_H,LINEY1_H
	MOVFF	XOFFSET,LINEX2
	MOVFF	XOFFSET_H,LINEX2_H
	MOVFF	YCALC2,LINEY2
	MOVFF	YCALC2_H,LINEY2_H
	BANKSEL	0
	CALL	_LINE
;do while (FillCircleXX < FillCircleYY)
SYSDOLOOP_S4:
	MOVF	FILLCIRCLEYY,W,ACCESS
	SUBWF	FILLCIRCLEXX,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	SYSDOLOOP_E4
;if ff >= 0 then
	MOVFF	FF,SYSINTEGERTEMPA
	MOVFF	FF_H,SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB,ACCESS
	CLRF	SYSINTEGERTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHANINT
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF14
;FillCircleYY--
	DECF	FILLCIRCLEYY,F,ACCESS
;ddF_y += 2
	MOVLW	2
	ADDWF	DDF_Y,F,ACCESS
	MOVLW	0
	ADDWFC	DDF_Y_H,F,ACCESS
;ff += ddF_y
	MOVF	DDF_Y,W,ACCESS
	ADDWF	FF,F,ACCESS
	MOVF	DDF_Y_H,W,ACCESS
	ADDWFC	FF_H,F,ACCESS
;end if
ENDIF14:
;FillCircleXX++
	INCF	FILLCIRCLEXX,F,ACCESS
;ddF_x += 2
	MOVLW	2
	ADDWF	DDF_X,F,ACCESS
	MOVLW	0
	ADDWFC	DDF_X_H,F,ACCESS
;ff += ddF_x
	MOVF	DDF_X,W,ACCESS
	ADDWF	FF,F,ACCESS
	MOVF	DDF_X_H,W,ACCESS
	ADDWFC	FF_H,F,ACCESS
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	MOVF	FILLCIRCLEXX,W,ACCESS
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W,BANKED
	MOVWF	LINEX1,ACCESS
	MOVLW	0
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	LINEX1_H,ACCESS
	MOVF	FILLCIRCLEYY,W,ACCESS
	ADDWF	YOFFSET,W,BANKED
	MOVWF	LINEY1,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	LINEY1_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	ADDWF	XOFFSET,W,BANKED
	MOVWF	LINEX2,ACCESS
	MOVLW	0
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	LINEX2_H,ACCESS
	MOVF	FILLCIRCLEYY,W,ACCESS
	SUBWF	YOFFSET,W,BANKED
	MOVWF	LINEY2,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	LINEY2_H,ACCESS
	BANKSEL	0
	CALL	_LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	MOVF	FILLCIRCLEXX,W,ACCESS
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W,BANKED
	MOVWF	LINEX1,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	LINEX1_H,ACCESS
	MOVF	FILLCIRCLEYY,W,ACCESS
	ADDWF	YOFFSET,W,BANKED
	MOVWF	LINEY1,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	LINEY1_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	SUBWF	XOFFSET,W,BANKED
	MOVWF	LINEX2,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	LINEX2_H,ACCESS
	MOVF	FILLCIRCLEYY,W,ACCESS
	SUBWF	YOFFSET,W,BANKED
	MOVWF	LINEY2,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	LINEY2_H,ACCESS
	BANKSEL	0
	CALL	_LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	MOVF	FILLCIRCLEYY,W,ACCESS
	BANKSEL	XOFFSET
	ADDWF	XOFFSET,W,BANKED
	MOVWF	LINEX1,ACCESS
	MOVLW	0
	ADDWFC	XOFFSET_H,W,BANKED
	MOVWF	LINEX1_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	ADDWF	YOFFSET,W,BANKED
	MOVWF	LINEY1,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	LINEY1_H,ACCESS
	MOVF	XOFFSET,W,BANKED
	ADDWF	FILLCIRCLEYY,W,ACCESS
	MOVWF	LINEX2,ACCESS
	CLRF	SYSTEMP1,BANKED
	MOVF	XOFFSET_H,W,BANKED
	ADDWFC	SYSTEMP1,W,BANKED
	MOVWF	LINEX2_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	SUBWF	YOFFSET,W,BANKED
	MOVWF	LINEY2,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	LINEY2_H,ACCESS
	BANKSEL	0
	CALL	_LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	MOVF	FILLCIRCLEYY,W,ACCESS
	BANKSEL	XOFFSET
	SUBWF	XOFFSET,W,BANKED
	MOVWF	LINEX1,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	LINEX1_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	ADDWF	YOFFSET,W,BANKED
	MOVWF	LINEY1,ACCESS
	MOVLW	0
	ADDWFC	YOFFSET_H,W,BANKED
	MOVWF	LINEY1_H,ACCESS
	MOVF	FILLCIRCLEYY,W,ACCESS
	SUBWF	XOFFSET,W,BANKED
	MOVWF	LINEX2,ACCESS
	MOVLW	0
	SUBWFB	XOFFSET_H,W,BANKED
	MOVWF	LINEX2_H,ACCESS
	MOVF	FILLCIRCLEXX,W,ACCESS
	SUBWF	YOFFSET,W,BANKED
	MOVWF	LINEY2,ACCESS
	MOVLW	0
	SUBWFB	YOFFSET_H,W,BANKED
	MOVWF	LINEY2_H,ACCESS
	BANKSEL	0
	CALL	_LINE
;loop
	BRA	SYSDOLOOP_S4
SYSDOLOOP_E4:
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (243)
GLCDCLS_SSD1331:
;dim PrintLocX, PrintLocY as word
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	CLRF	GLCD_YORDINATE,ACCESS
	CLRF	GLCD_YORDINATE_H,ACCESS
;PrintLocX = 0
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
;PrintLocY = 0
	CLRF	PRINTLOCY,BANKED
	CLRF	PRINTLOCY_H,BANKED
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
	MOVLW	37
	BANKSEL	SYSSSD1331_COMMAND_0
	MOVWF	SYSSSD1331_COMMAND_0,BANKED
;SSD1331_Command(1) = 0
	CLRF	SYSSSD1331_COMMAND_1,BANKED
;SSD1331_Command(2) = 0
	CLRF	SYSSSD1331_COMMAND_2,BANKED
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
	DECF	GLCDDEVICEWIDTH,W,ACCESS
	MOVWF	SYSSSD1331_COMMAND_3,BANKED
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
	DECF	GLCDDEVICEHEIGHT,W,ACCESS
	MOVWF	SYSSSD1331_COMMAND_4,BANKED
;SendMultipleCommand_SSD1331( 5 )
	MOVLW	5
	BANKSEL	SSD1331BYTESTOSEND
	MOVWF	SSD1331BYTESTOSEND,BANKED
	BANKSEL	0
	CALL	SENDMULTIPLECOMMAND_SSD1331
;wait SSD1331_GLCDCLS_Delay us
	MOVLW	10
	MOVWF	DELAYTEMP2,ACCESS
DELAYUSO3:
	CLRF	DELAYTEMP,ACCESS
DELAYUS3:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS3
	DECFSZ	DELAYTEMP2,F,ACCESS
	BRA	DELAYUSO3
	MOVLW	96
	MOVWF	DELAYTEMP,ACCESS
DELAYUS4:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS4
;SSD1331_Command(0) = SSD1331_GAC_FILL_ENABLE_DISABLE
	MOVLW	38
	BANKSEL	SYSSSD1331_COMMAND_0
	MOVWF	SYSSSD1331_COMMAND_0,BANKED
;SSD1331_Command(1) = 1     'fill 1, empty 0
	MOVLW	1
	MOVWF	SYSSSD1331_COMMAND_1,BANKED
;SendMultipleCommand_SSD1331( 2 )
	MOVLW	2
	BANKSEL	SSD1331BYTESTOSEND
	MOVWF	SSD1331BYTESTOSEND,BANKED
	BANKSEL	0
	CALL	SENDMULTIPLECOMMAND_SSD1331
;SSD1331_Command(0) = SSD1331_GAC_DRAW_RECTANGLE
	MOVLW	34
	BANKSEL	SYSSSD1331_COMMAND_0
	MOVWF	SYSSSD1331_COMMAND_0,BANKED
;SSD1331_Command(1) = 0
	CLRF	SYSSSD1331_COMMAND_1,BANKED
;SSD1331_Command(2) = 0
	CLRF	SYSSSD1331_COMMAND_2,BANKED
;if SSD1331Rotation.0 = 1 then
	BANKSEL	SSD1331ROTATION
	BTFSS	SSD1331ROTATION,0,BANKED
	BRA	ELSE15_1
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
	DECF	GLCDDEVICEWIDTH,W,ACCESS
	BANKSEL	SYSSSD1331_COMMAND_3
	MOVWF	SYSSSD1331_COMMAND_3,BANKED
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
	DECF	GLCDDEVICEHEIGHT,W,ACCESS
	MOVWF	SYSSSD1331_COMMAND_4,BANKED
;Else
	BRA	ENDIF15
ELSE15_1:
;SSD1331_Command(4) = SSD1331_GLCD_WIDTH-1
	DECF	GLCDDEVICEWIDTH,W,ACCESS
	BANKSEL	SYSSSD1331_COMMAND_4
	MOVWF	SYSSSD1331_COMMAND_4,BANKED
;SSD1331_Command(3) = SSD1331_GLCD_HEIGHT-1
	DECF	GLCDDEVICEHEIGHT,W,ACCESS
	MOVWF	SYSSSD1331_COMMAND_3,BANKED
;end if
ENDIF15:
;SSD1331_Command(5) = (GLCDBackground / 0x800 ) * 2    '((GLCDBackground>> 11) << 1)       ' Outline Blue
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	8
	MOVWF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSTEMP2
	MOVFF	SYSWORDTEMPA_H,SYSTEMP2_H
	MOVFF	SYSTEMP2,SYSWORDTEMPA
	MOVFF	SYSTEMP2_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSMULTSUB16
	MOVFFL	SYSWORDTEMPX,SYSSSD1331_COMMAND_5
;SSD1331_Command(6) = (GLCDBackground / 0x20 ) & 0x3f  '((GLCDBackground>> 5 ) & 0x3F)     ' Outline Green
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	MOVLW	32
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSTEMP2
	MOVFF	SYSWORDTEMPA_H,SYSTEMP2_H
	MOVLW	63
	BANKSEL	SYSTEMP2
	ANDWF	SYSTEMP2,W,BANKED
	BANKSEL	SYSSSD1331_COMMAND_6
	MOVWF	SYSSSD1331_COMMAND_6,BANKED
;SSD1331_Command(7) = (GLCDBackground * 2 ) & 0x3f     '((GLCDBackground<< 1 ) & 0x3F)     ' Outline Red
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,SYSTEMP2
	MOVFF	SYSWORDTEMPX_H,SYSTEMP2_H
	MOVLW	63
	BANKSEL	SYSTEMP2
	ANDWF	SYSTEMP2,W,BANKED
	BANKSEL	SYSSSD1331_COMMAND_7
	MOVWF	SYSSSD1331_COMMAND_7,BANKED
;SSD1331_Command(8) = (GLCDBackground / 0x800 ) * 2    '((GLCDBackground>> 11) << 1)       ' fill Blue
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB,ACCESS
	MOVLW	8
	MOVWF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSTEMP2
	MOVFF	SYSWORDTEMPA_H,SYSTEMP2_H
	MOVFF	SYSTEMP2,SYSWORDTEMPA
	MOVFF	SYSTEMP2_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSMULTSUB16
	MOVFFL	SYSWORDTEMPX,SYSSSD1331_COMMAND_8
;SSD1331_Command(9) = (GLCDBackground / 0x20 ) & 0x3f  '((GLCDBackground>> 5 ) & 0x3F)     ' fill Green
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	MOVLW	32
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPA,SYSTEMP2
	MOVFF	SYSWORDTEMPA_H,SYSTEMP2_H
	MOVLW	63
	BANKSEL	SYSTEMP2
	ANDWF	SYSTEMP2,W,BANKED
	BANKSEL	SYSSSD1331_COMMAND_9
	MOVWF	SYSSSD1331_COMMAND_9,BANKED
;SSD1331_Command(10)= (GLCDBackground * 2 ) & 0x3f     '((GLCDBackground<< 1 ) & 0x3F)     ' fill Red
	MOVFF	GLCDBACKGROUND,SYSWORDTEMPA
	MOVFF	GLCDBACKGROUND_H,SYSWORDTEMPA_H
	MOVLW	2
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,SYSTEMP2
	MOVFF	SYSWORDTEMPX_H,SYSTEMP2_H
	MOVLW	63
	BANKSEL	SYSTEMP2
	ANDWF	SYSTEMP2,W,BANKED
	BANKSEL	SYSSSD1331_COMMAND_10
	MOVWF	SYSSSD1331_COMMAND_10,BANKED
;SendMultipleCommand_SSD1331( 11 )
	MOVLW	11
	BANKSEL	SSD1331BYTESTOSEND
	MOVWF	SSD1331BYTESTOSEND,BANKED
	BANKSEL	0
	CALL	SENDMULTIPLECOMMAND_SSD1331
;wait SSD1331_GLCDCLS_Delay us
	MOVLW	10
	MOVWF	DELAYTEMP2,ACCESS
DELAYUSO5:
	CLRF	DELAYTEMP,ACCESS
DELAYUS5:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS5
	DECFSZ	DELAYTEMP2,F,ACCESS
	BRA	DELAYUSO5
	MOVLW	96
	MOVWF	DELAYTEMP,ACCESS
DELAYUS6:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS6
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (321)
GLCDDRAWCHAR_SSD1331:
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	MOVLW	15
	SUBWF	CHARCODE,F,ACCESS
;CharCol=0
	CLRF	CHARCOL,ACCESS
	CLRF	CHARCOL_H,ACCESS
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SYSSELECT1CASE1:
	DECF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE2
;CharCode = CharCode - 16
	MOVLW	16
	SUBWF	CHARCODE,F,ACCESS
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	OLEDFONT1INDEX
	MOVWF	LOCALCHARCODE,ACCESS
	MOVFF	CHARCODE,SYSSTRINGA
	CALL	OLEDFONT1INDEX_H
	MOVWF	LOCALCHARCODE_H,ACCESS
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	MOVFF	LOCALCHARCODE,SYSSTRINGA
	MOVFF	LOCALCHARCODE_H,SYSSTRINGA_H
	RCALL	OLEDFONT1DATA
	MOVWF	COLSPERFONT,ACCESS
;If the char is the ASC(32) a SPACE set the fontwidth =1 (not 2)
;if LocalCharCode = 1 then
	MOVFF	LOCALCHARCODE,SYSWORDTEMPA
	MOVFF	LOCALCHARCODE_H,SYSWORDTEMPA_H
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ELSE18_1
;GLCDFontWidth = 1
	MOVLW	1
	MOVWF	GLCDFONTWIDTH,ACCESS
;else
	BRA	ENDIF18
ELSE18_1:
;GLCDFontWidth = COLSperfont+1
	INCF	COLSPERFONT,W,ACCESS
	MOVWF	GLCDFONTWIDTH,ACCESS
;end if
ENDIF18:
;ROWSperfont = 7  'which is really 8 as we start at 0
	MOVLW	7
	BANKSEL	ROWSPERFONT
	MOVWF	ROWSPERFONT,BANKED
;case 2 'This is one font table
	BRA	SYSSELECTEND1
SYSSELECT1CASE2:
	MOVLW	2
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND1
;CharCode = CharCode - 17
	MOVLW	17
	SUBWF	CHARCODE,F,ACCESS
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	MOVFF	CHARCODE,SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H,ACCESS
	MOVLW	20
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSMULTSUB16
	MOVFF	SYSWORDTEMPX,LOCALCHARCODE
	MOVFF	SYSWORDTEMPX_H,LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	MOVLW	9
	MOVWF	COLSPERFONT,ACCESS
;ROWSperfont=15  'which is really 16 as we start at 0
	MOVLW	15
	BANKSEL	ROWSPERFONT
	MOVWF	ROWSPERFONT,BANKED
;End Select
SYSSELECTEND1:
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	SETF	CURRCHARCOL,ACCESS
	MOVLW	0
	SUBWF	COLSPERFONT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND7
SYSFORLOOP7:
	INCF	CURRCHARCOL,F,ACCESS
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	INCF	LOCALCHARCODE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	LOCALCHARCODE_H,F,ACCESS
;Select case GLCDfntDefaultSize
;case 1
SYSSELECT2CASE1:
	DECF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	MOVFF	LOCALCHARCODE,SYSSTRINGA
	MOVFF	LOCALCHARCODE_H,SYSSTRINGA_H
	BANKSEL	0
	RCALL	OLEDFONT1DATA
	MOVWF	CURRCHARVAL,ACCESS
;case 2
	BRA	SYSSELECTEND2
SYSSELECT2CASE2:
	MOVLW	2
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND2
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	MOVFF	LOCALCHARCODE,SYSSTRINGA
	MOVFF	LOCALCHARCODE_H,SYSSTRINGA_H
	BANKSEL	0
	CALL	OLEDFONT2
	MOVWF	CURRCHARVAL,ACCESS
;End Select
SYSSELECTEND2:
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	SETF	CURRCHARROW,ACCESS
	MOVLW	0
	BANKSEL	ROWSPERFONT
	SUBWF	ROWSPERFONT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND8
SYSFORLOOP8:
	INCF	CURRCHARROW,F,ACCESS
;Set the pixel
;If CurrCharVal.0 = 0 Then
	BTFSC	CURRCHARVAL,0,ACCESS
	BRA	ELSE21_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	MOVF	CURRCHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCX_H,W,ACCESS
	MOVWF	GLCDX_H,ACCESS
	MOVF	CURRCHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCY_H,W,ACCESS
	MOVWF	GLCDY_H,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;Else
	BRA	ENDIF21
ELSE21_1:
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	MOVF	CURRCHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	GLCDX,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCX_H,W,ACCESS
	MOVWF	GLCDX_H,ACCESS
	MOVF	CURRCHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCY_H,W,ACCESS
	MOVWF	GLCDY_H,ACCESS
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;End If
ENDIF21:
;Rotate CurrCharVal Right
	RRCF	CURRCHARVAL,F,ACCESS
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	MOVFF	GLCDFNTDEFAULTSIZE,SYSBYTETEMPA
	MOVLW	2
	MOVWF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPEQUAL
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	CURRCHARROW,SYSBYTETEMPA
	MOVLW	7
	MOVWF	SYSBYTETEMPB,ACCESS
	CALL	SYSCOMPEQUAL
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ANDWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF22
;LocalCharCode++
	INCF	LOCALCHARCODE,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	LOCALCHARCODE_H,F,ACCESS
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	MOVFF	LOCALCHARCODE,SYSSTRINGA
	MOVFF	LOCALCHARCODE_H,SYSSTRINGA_H
	BANKSEL	0
	CALL	OLEDFONT2
	MOVWF	CURRCHARVAL,ACCESS
;end if
ENDIF22:
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	MOVF	COLSPERFONT,W,ACCESS
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF23
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	MOVF	CURRCHARCOL,W,ACCESS
	ADDWF	CHARLOCX,W,ACCESS
	MOVWF	GLCDTEMP,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCX_H,W,ACCESS
	MOVWF	GLCDTEMP_H,ACCESS
;if GLCDfntDefaultSize = 2 then
	MOVLW	2
	SUBWF	GLCDFNTDEFAULTSIZE,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF26
;GLCDTemp++
	INCF	GLCDTEMP,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	GLCDTEMP_H,F,ACCESS
;end if
ENDIF26:
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	MOVFF	GLCDTEMP,GLCDX
	MOVFF	GLCDTEMP_H,GLCDX_H
	MOVF	CURRCHARROW,W,ACCESS
	ADDWF	CHARLOCY,W,ACCESS
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	ADDWFC	CHARLOCY_H,W,ACCESS
	MOVWF	GLCDY_H,ACCESS
	MOVFF	GLCDBACKGROUND,GLCDCOLOUR
	MOVFF	GLCDBACKGROUND_H,GLCDCOLOUR_H
	BANKSEL	0
	CALL	PSET_SSD1331
;end if
ENDIF23:
;Next
	BANKSEL	ROWSPERFONT
	MOVF	ROWSPERFONT,W,BANKED
	SUBWF	CURRCHARROW,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP8
SYSFORLOOPEND8:
;Next
	MOVF	COLSPERFONT,W,ACCESS
	SUBWF	CURRCHARCOL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP7
SYSFORLOOPEND7:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (291)
GLCDDRAWSTRING_SSD1331:
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	MOVFF	STRINGLOCX,GLCDPRINTLOC
	MOVFF	STRINGLOCX_H,GLCDPRINTLOC_H
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	MOVFF	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
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
	BRA	SYSFORLOOPEND6
SYSFORLOOP6:
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
	RCALL	GLCDDRAWCHAR_SSD1331
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
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
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	SUBWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDPRINTLOC,ACCESS
	MOVLW	0
	SUBWFB	SYSTEMP1_H,W,BANKED
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
	BRA	SYSFORLOOP6
SYSFORLOOPEND6:
;GLCDFontWidth = OldGLCDFontWidth
	MOVFF	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
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
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	MOVFF	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
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
	BRA	SYSFORLOOPEND2
SYSFORLOOP2:
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
	RCALL	GLCDDRAWCHAR_SSD1331
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
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
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	SUBWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDPRINTLOC,ACCESS
	MOVLW	0
	SUBWFB	SYSTEMP1_H,W,BANKED
	MOVWF	GLCDPRINTLOC_H,ACCESS
;Next
	MOVF	GLCDPRINTLEN,W,ACCESS
	SUBWF	GLCDPRINT_STRING_COUNTER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVFF	GLCDPRINTLOC,PRINTLOCX
	MOVFF	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	MOVFF	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
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
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	MOVFF	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
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
	BRA	SYSFORLOOPEND3
SYSFORLOOP3:
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
	RCALL	GLCDDRAWCHAR_SSD1331
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
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
	MOVF	GLCDFNTDEFAULTSIZE,W,ACCESS
	ADDWF	SYSTEMP2,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W,BANKED
	MOVWF	SYSTEMP1_H,BANKED
	MOVLW	1
	SUBWF	SYSTEMP1,W,BANKED
	MOVWF	GLCDPRINTLOC,ACCESS
	MOVLW	0
	SUBWFB	SYSTEMP1_H,W,BANKED
	MOVWF	GLCDPRINTLOC_H,ACCESS
;Next
	MOVF	GLCDPRINT_STRING_COUNTER,W,ACCESS
	SUBLW	1
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP3
SYSFORLOOPEND3:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVFF	GLCDPRINTLOC,PRINTLOCX
	MOVFF	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	MOVFF	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1193)
GLCDPRINTSTRINGLN:
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	MOVFF	SYSLCDPRINTDATAHANDLER,SYSLCDPRINTDATAHANDLER
	MOVFF	SYSLCDPRINTDATAHANDLER_H,SYSLCDPRINTDATAHANDLER_H
	RCALL	GLCDPRINT4
;Update the current X and Y position
;PrintLocX = 0
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX,BANKED
	CLRF	PRINTLOCX_H,BANKED
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod GLCD_HEIGHT
	MOVF	GLCDFNTDEFAULTHEIGHT,W,ACCESS
	MULWF	GLCDFNTDEFAULTSIZE,ACCESS
;A2: ASM Source was:  MOVFF PRODL,SYSTEMP1
;A4: ASM Source was:  MOVFF PRODL,SYSTEMP1
	MOVFF	PROD,SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	ADDWF	PRINTLOCY,W,BANKED
	MOVWF	SYSTEMP2,BANKED
	MOVLW	0
	ADDWFC	PRINTLOCY_H,W,BANKED
	MOVWF	SYSTEMP2_H,BANKED
	MOVFF	SYSTEMP2,SYSWORDTEMPA
	MOVFF	SYSTEMP2_H,SYSWORDTEMPA_H
	MOVLW	64
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	BANKSEL	0
	CALL	SYSDIVSUB16
	MOVFF	SYSWORDTEMPX,PRINTLOCY
	MOVFF	SYSWORDTEMPX_H,PRINTLOCY_H
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (681)
GLCDROTATE_SSD1331:
;SendCommand_SSD1331(SSD1331_Set_Column_Address) ' Column addr set
	MOVLW	21
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 0
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 SSD1331_GLCD_WIDTH-1
	DECF	GLCDDEVICEWIDTH,W,ACCESS
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(SSD1331_Set_Row_Address) ' Row addr set
	MOVLW	117
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 0
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 SSD1331_GLCD_HEIGHT-1
	DECF	GLCDDEVICEHEIGHT,W,ACCESS
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;repeat 4608
	BANKSEL	SYSREPEATTEMP2
	CLRF	SYSREPEATTEMP2,BANKED
	MOVLW	18
	MOVWF	SYSREPEATTEMP2_H,BANKED
SYSREPEATLOOP2:
;SendData_SSD1331( GLCDBackground_H )
	MOVFF	GLCDBACKGROUND_H,SSD1331SENDBYTE
	BANKSEL	0
	CALL	SENDDATA_SSD1331
;SendData_SSD1331( GLCDBackground )
	MOVFF	GLCDBACKGROUND,SSD1331SENDBYTE
	CALL	SENDDATA_SSD1331
;end Repeat
	BANKSEL	SYSREPEATTEMP2
	DECFSZ	SYSREPEATTEMP2,F,BANKED
	BRA	SYSREPEATLOOP2
	DECFSZ	SYSREPEATTEMP2_H,F,BANKED
	BRA	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;select case SSD1331Rotation
;case PORTRAIT
SYSSELECT3CASE1:
	MOVLW	4
	SUBWF	SSD1331ROTATION,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE2
;SSD1331_GLCD_WIDTH = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;Not requrired
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
;SSD1331_Command(1) = 0
;SSD1331_Command(2) = 0
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
;SendMultipleCommand_SSD1331( 5 )
;SendCommand_SSD1331(0xA0)
	MOVLW	160
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x60)
	MOVLW	96
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;case LANDSCAPE
	BRA	SYSSELECTEND3
SYSSELECT3CASE2:
	DECF	SSD1331ROTATION,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE3
;SSD1331_GLCD_WIDTH = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;Not requrired
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
;SSD1331_Command(1) = 0
;SSD1331_Command(2) = 0
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
;SendMultipleCommand_SSD1331( 5 )
;SendCommand_SSD1331(0xA0)    'Set remap & data format 0111 0000
	MOVLW	160
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x72)    ' RGB colour
	MOVLW	114
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;case PORTRAIT_REV
	BRA	SYSSELECTEND3
SYSSELECT3CASE3:
	MOVLW	2
	SUBWF	SSD1331ROTATION,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE4
;SSD1331_GLCD_WIDTH = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;Not requrired
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
;SSD1331_Command(1) = 0
;SSD1331_Command(2) = 0
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
;SendMultipleCommand_SSD1331( 5 )
;SendCommand_SSD1331(0xA0)
	MOVLW	160
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x72)
	MOVLW	114
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;case LANDSCAPE_REV
	BRA	SYSSELECTEND3
SYSSELECT3CASE4:
	MOVLW	3
	SUBWF	SSD1331ROTATION,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT3CASE5
;SSD1331_GLCD_WIDTH = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;Not requrired
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
;SSD1331_Command(1) = 0
;SSD1331_Command(2) = 0
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
;SendMultipleCommand_SSD1331( 5 )
;SendCommand_SSD1331(0xA0)
	MOVLW	160
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x60)
	MOVLW	96
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;case else
	BRA	SYSSELECTEND3
SYSSELECT3CASE5:
;SSD1331_GLCD_WIDTH = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;Not requrired
;SSD1331_Command(0) = SSD1331_GAC_CLEAR_WINDOW
;SSD1331_Command(1) = 0
;SSD1331_Command(2) = 0
;SSD1331_Command(3) = SSD1331_GLCD_WIDTH-1
;SSD1331_Command(4) = SSD1331_GLCD_HEIGHT-1
;SendMultipleCommand_SSD1331( 5 )
;SendCommand_SSD1331(0xA0)    'Set remap & data format 0111 0000
	MOVLW	160
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x72)    ' RGB colour
	MOVLW	114
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;end select
SYSSELECTEND3:
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (121)
INITGLCD_SSD1331:
;Mapped to global variables to same RAM
;dim SSD1331_GLCD_HEIGHT, SSD1331_GLCD_WIDTH as word
;Setup code for SSD1331 controllers
;Pin directions
;Dir SSD1331_CS Out
	BCF	TRISA,5,ACCESS
;Dir SSD1331_DC Out
	BCF	TRISA,4,ACCESS
;Dir SSD1331_RST Out
	BCF	TRISA,1,ACCESS
;Dir SSD1331_DO Out
	BCF	TRISB,5,ACCESS
;Dir SSD1331_SCK Out
	BCF	TRISB,7,ACCESS
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;SPIMode HWSPIMODESCRIPT, 0
	MOVLW	12
	BANKSEL	SPICURRENTMODE
	MOVWF	SPICURRENTMODE,BANKED
	CLRF	SPICLOCKMODE,BANKED
	BANKSEL	0
	CALL	SPIMODE686
;Set SSD1331_CS On
	BSF	LATA,5,ACCESS
;Set SSD1331_DC Off
	BCF	LATA,4,ACCESS
;Reset display
;Wait 200 ms
	MOVLW	200
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	CALL	DELAY_MS
;Set SSD1331_RST Off
	BCF	LATA,1,ACCESS
;Wait 200 us
	MOVLW	4
	MOVWF	DELAYTEMP2,ACCESS
DELAYUSO1:
	CLRF	DELAYTEMP,ACCESS
DELAYUS1:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS1
	DECFSZ	DELAYTEMP2,F,ACCESS
	BRA	DELAYUSO1
	MOVLW	38
	MOVWF	DELAYTEMP,ACCESS
DELAYUS2:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS2
;Set SSD1331_RST On
	BSF	LATA,1,ACCESS
;initialize sequence
;SendCommand_SSD1331(0xAE)    'OLED display OFF
	MOVLW	174
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xAE)    'OLED display OFF
	MOVLW	174
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xAE)    'OLED display OFF
	MOVLW	174
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x75)    ' Set Row Address */
	MOVLW	117
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x00)    ' Start = 0 */
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x3F)    ' End = 63 */
	MOVLW	63
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x15)    ' Set Column Address */
	MOVLW	21
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x00)    ' Start = 0 */
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x5F)    ' End = 95 */
	MOVLW	95
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xA0)    'Set remap & data format 0111 0000
	MOVLW	160
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x72)    ' RGB colour
	MOVLW	114
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xA1)    'set display start row RAM
	MOVLW	161
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x00)
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xA2)    'set display offset
	MOVLW	162
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x00)
	BANKSEL	SSD1331SENDBYTE
	CLRF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xA4)    'Set Display Mode
	MOVLW	164
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xA8)    'Set Multiplex Ratio
	MOVLW	168
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x3F)
	MOVLW	63
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xAD)    'Set Master Configuration
	MOVLW	173
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x8F)    '(External VCC Supply Selected)
	MOVLW	143
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xB0)    'Set Power Saving Mode
	MOVLW	176
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x1A)
	MOVLW	26
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xB1)    'Set Phase 1 & 2 Period Adjustment
	MOVLW	177
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x74)
	MOVLW	116
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xB3)    'Set Display Clock Divide Ratio / Oscillator Frequency
	MOVLW	179
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xD0)
	MOVLW	208
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x8A)    'Set Second Pre-charge Speed of Color A
	MOVLW	138
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x81)
	MOVLW	129
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x8B)    'Set Second Pre-charge Speed of Color B
	MOVLW	139
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x82)
	MOVLW	130
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x8C)    'Set Second Pre-charge Speed of Color C
	MOVLW	140
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x83)
	MOVLW	131
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xBB)    'Set Pre-charge Level
	MOVLW	187
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x3E)
	MOVLW	62
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xBE)    'Set VCOMH
	MOVLW	190
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x3E)
	MOVLW	62
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x87)    'Set Master Current Control
	MOVLW	135
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x0F)
	MOVLW	15
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x81)    'Set Contrast Control for Color &#129;gA&#129;h
	MOVLW	129
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x80)
	MOVLW	128
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x82)    'Set Contrast Control for Color &#129;gB&#129;h
	MOVLW	130
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x80)
	MOVLW	128
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x83)    'Set Contrast Control for Color &#129;gC&#129;h
	MOVLW	131
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0x80)
	MOVLW	128
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(0xAF)    'display ON
	MOVLW	175
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	CALL	SENDCOMMAND_SSD1331
;Default Colours
;GLCDForeground = SSD1331_WHITE
	SETF	GLCDFOREGROUND,ACCESS
	SETF	GLCDFOREGROUND_H,ACCESS
;GLCDBACKGROUND = SSD1331_BLACK
	CLRF	GLCDBACKGROUND,ACCESS
	CLRF	GLCDBACKGROUND_H,ACCESS
;Variables required for device
;SSD1331_GLCD_WIDTH = GLCD_WIDTH
	MOVLW	96
	MOVWF	GLCDDEVICEWIDTH,ACCESS
	CLRF	GLCDDEVICEWIDTH_H,ACCESS
;SSD1331_GLCD_HEIGHT = GLCD_HEIGHT
	MOVLW	64
	MOVWF	GLCDDEVICEHEIGHT,ACCESS
	CLRF	GLCDDEVICEHEIGHT_H,ACCESS
;GLCDFontWidth = 5
	MOVLW	5
	MOVWF	GLCDFONTWIDTH,ACCESS
;GLCDfntDefault = 0
	CLRF	GLCDFNTDEFAULT,ACCESS
;GLCDfntDefaultsize = 1
	MOVLW	1
	MOVWF	GLCDFNTDEFAULTSIZE,ACCESS
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	MOVLW	7
	MOVWF	GLCDFNTDEFAULTHEIGHT,ACCESS
;Prepare screen - this sets SSD1331Rotation
;GLCDRotate_SSD1331 ( LANDSCAPE )
	MOVLW	1
	BANKSEL	SSD1331ROTATION
	MOVWF	SSD1331ROTATION,BANKED
	BANKSEL	0
	RCALL	GLCDROTATE_SSD1331
;GLCDCLS
	GOTO	GLCDCLS_SSD1331

;********************************************************************************

;SOURCE: 260_SPI_GLCD_USING_SSS1331.GCB (51)
INITPPS:
;Module: SPI1
;RB7PPS = 0x001B    'SCK1 > RB7
	MOVLW	27
BANKSEL	RB7PPS
	MOVWF	RB7PPS,BANKED
;SPI1SCKPPS = 0x000F    'RB7 > SCK1 (bi-directional)
	MOVLW	15
	MOVWF	SPI1SCKPPS,BANKED
;RB5PPS = 0x001C    'SDO1 > RB5
	MOVLW	28
	MOVWF	RB5PPS,BANKED
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

OLEDFONT1DATA:
	MOVFF	SYSSTRINGA,SYSWORDTEMPA
	MOVFF	SYSSTRINGA_H,SYSWORDTEMPA_H
	MOVLW	165
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	1
	MOVWF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT1DATA
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT1DATA
	ADDWFC	SYSSTRINGA_H, W,ACCESS
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT1DATA
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT1DATA:
	DB	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	DB	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	DB	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	DB	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	DB	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	DB	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	DB	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	DB	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	DB	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	DB	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	DB	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	DB	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	DB	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	DB	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	DB	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1
	ALIGN	2;X4

;********************************************************************************

OLEDFONT1DATA_H:
	MOVFF	SYSSTRINGA,SYSWORDTEMPA
	MOVFF	SYSSTRINGA_H,SYSWORDTEMPA_H
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT1DATA_H
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT1DATA_H
	ADDWFC	SYSSTRINGA_H, W,ACCESS
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT1DATA_H
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT1DATA_H:
	DB	1
	ALIGN	2;X4

;********************************************************************************

OLEDFONT1INDEX:
	MOVLW	97
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT1INDEX
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT1INDEX
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT1INDEX
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT1INDEX:
	DB	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	DB	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	DB	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	DB	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	DB	155,159,164
	ALIGN	2;X4

;********************************************************************************

OLEDFONT1INDEX_H:
	MOVLW	97
	CPFSLT	SYSSTRINGA,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT1INDEX_H
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT1INDEX_H
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT1INDEX_H
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT1INDEX_H:
	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	DB	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	ALIGN	2;X4

;********************************************************************************

OLEDFONT2:
	MOVFF	SYSSTRINGA,SYSWORDTEMPA
	MOVFF	SYSSTRINGA_H,SYSWORDTEMPA_H
	MOVLW	145
	MOVWF	SYSWORDTEMPB,ACCESS
	MOVLW	7
	MOVWF	SYSWORDTEMPB_H,ACCESS
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT2
	ADDWFC	SYSSTRINGA_H, W,ACCESS
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT2
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT2:
	DB	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	DB	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	DB	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	DB	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	DB	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	DB	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	DB	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	DB	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	DB	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	DB	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	DB	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	DB	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	DB	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	DB	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	DB	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	DB	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	DB	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	DB	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	DB	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	DB	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	DB	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	DB	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	DB	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	DB	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	DB	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	DB	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	DB	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	DB	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	DB	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	DB	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	DB	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	DB	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	DB	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	DB	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	DB	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	DB	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	DB	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	DB	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	DB	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	DB	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	DB	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	DB	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	DB	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	DB	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	DB	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	DB	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	DB	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	DB	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	DB	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	DB	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	DB	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	DB	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	DB	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	DB	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	DB	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	DB	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	DB	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	DB	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	DB	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	DB	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208
	ALIGN	2;X4

;********************************************************************************

OLEDFONT2_H:
	MOVFF	SYSSTRINGA,SYSWORDTEMPA
	MOVFF	SYSSTRINGA_H,SYSWORDTEMPA_H
	MOVLW	1
	MOVWF	SYSWORDTEMPB,ACCESS
	CLRF	SYSWORDTEMPB_H,ACCESS
	RCALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0,ACCESS
	RETLW	0
	MOVF	SYSSTRINGA, W,ACCESS
	ADDLW	LOW TABLEOLEDFONT2_H
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH TABLEOLEDFONT2_H
	ADDWFC	SYSSTRINGA_H, W,ACCESS
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER TABLEOLEDFONT2_H
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	ADDLW	1
	MOVWF	TBLPTRU,ACCESS
	TBLRD*
	MOVF	TABLAT, W,ACCESS
	RETURN
TABLEOLEDFONT2_H:
	DB	7
	ALIGN	2;X4

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
	BRA	ELSE64_1
;SysCharCount = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	INDF0,SYSCHARCOUNT
;clear output string
;Pad=""
	LFSR	1,PAD
	MOVLW	LOW STRINGTABLE2
;A2: ASM Source was:  MOVWF TBLPTRL,ACCESS
;A4: ASM Source was:  MOVWF TBLPTRL,ACCESS
	MOVWF	TBLPTR,ACCESS
	MOVLW	HIGH STRINGTABLE2
	MOVWF	TBLPTRH,ACCESS
	MOVLW	UPPER STRINGTABLE2
	MOVWF	TBLPTRU,ACCESS
	BANKSEL	0
	RCALL	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOPEND13
SYSFORLOOP13:
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
	BRA	SYSFORLOOP13
SYSFORLOOPEND13:
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
	BRA	SYSFORLOOPEND14
SYSFORLOOP14:
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
	BRA	SYSFORLOOP14
SYSFORLOOPEND14:
;set new length to PAD
;Pad(0) = SysStrLen
	MOVFFL	SYSSTRLEN,SYSPAD_0
;else
	BRA	ENDIF64
ELSE64_1:
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
	BRA	SYSFORLOOPEND15
SYSFORLOOP15:
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
	BRA	SYSFORLOOP15
SYSFORLOOPEND15:
;PAD(0) = SysInString(0)
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER,AFSR0
	MOVFF	SYSSYSINSTRINGHANDLER,FSR0
;A6: ASM Source was:  MOVFF SYSSYSINSTRINGHANDLER_H,AFSR0_H
	MOVFF	SYSSYSINSTRINGHANDLER_H,FSR0H
	MOVFF	POSTINC0,SYSARRAYTEMP1
	MOVFFL	SYSARRAYTEMP1,SYSPAD_0
;End If
ENDIF64:
	BANKSEL	0
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (500)
PSET_SSD1331:
;dim GLCDTemp as word
;swap values to support rotation as this device DOES NOT SUPPORT Portrait! arcghhhh
;if SSD1331Rotation.0 = 0 then
	BANKSEL	SSD1331ROTATION
	BTFSC	SSD1331ROTATION,0,BANKED
	BRA	ENDIF33
;GLCDTemp = GLCDX
	MOVFF	GLCDX,GLCDTEMP
	MOVFF	GLCDX_H,GLCDTEMP_H
;GLCDX = GLCDY
	MOVFF	GLCDY,GLCDX
	MOVFF	GLCDY_H,GLCDX_H
;GLCDY = GLCDTemp
	MOVFF	GLCDTEMP,GLCDY
	MOVFF	GLCDTEMP_H,GLCDY_H
;GLCDY = SSD1331_GLCD_WIDTH - GLCDY - 1
	MOVF	GLCDY,W,ACCESS
	SUBWF	GLCDDEVICEWIDTH,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	MOVF	GLCDY_H,W,ACCESS
	SUBWFB	GLCDDEVICEWIDTH_H,W,ACCESS
	MOVWF	SYSTEMP2_H,BANKED
	MOVLW	1
	SUBWF	SYSTEMP2,W,BANKED
	MOVWF	GLCDY,ACCESS
	MOVLW	0
	SUBWFB	SYSTEMP2_H,W,BANKED
	MOVWF	GLCDY_H,ACCESS
;End if
ENDIF33:
;anything off screen with be rejected
;if GLCDX => SSD1331_GLCD_WIDTH OR GLCDY => SSD1331_GLCD_HEIGHT Then
	MOVFF	GLCDX,SYSWORDTEMPA
	MOVFF	GLCDX_H,SYSWORDTEMPA_H
	MOVFF	GLCDDEVICEWIDTH,SYSWORDTEMPB
	MOVFF	GLCDDEVICEWIDTH_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	MOVFF	GLCDY,SYSWORDTEMPA
	MOVFF	GLCDY_H,SYSWORDTEMPA_H
	MOVFF	GLCDDEVICEHEIGHT,SYSWORDTEMPB
	MOVFF	GLCDDEVICEHEIGHT_H,SYSWORDTEMPB_H
	RCALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F,ACCESS
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W,BANKED
	IORWF	SYSBYTETEMPX,W,ACCESS
	MOVWF	SYSTEMP2,BANKED
	BTFSS	SYSTEMP2,0,BANKED
	BRA	ENDIF34
;exit sub
	BANKSEL	0
	RETURN
;end if
ENDIF34:
;SendCommand_SSD1331(SSD1331_Set_Column_Address) ' Column addr set
	MOVLW	21
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 GLCDX
	MOVFF	GLCDX,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 GLCDX
	MOVFF	GLCDX,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(SSD1331_Set_Row_Address) ' Row addr set
	MOVLW	117
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 GLCDY
	MOVFF	GLCDY,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331 GLCDY
	MOVFF	GLCDY,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendData_SSD1331( GLCDColour_H )
	MOVFF	GLCDCOLOUR_H,SSD1331SENDBYTE
	RCALL	SENDDATA_SSD1331
;SendData_SSD1331( GLCDColour )
	MOVFF	GLCDCOLOUR,SSD1331SENDBYTE
	BRA	SENDDATA_SSD1331

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (574)
SENDCOMMAND_SSD1331:
;set SSD1331_CS OFF;
	BCF	LATA,5,ACCESS
;set SSD1331_DC OFF;
	BCF	LATA,4,ACCESS
;FastHWSPITransfer  SSD1331SendByte
	MOVFF	SSD1331SENDBYTE,SPITXDATA
	CALL	FASTHWSPITRANSFER
;set SSD1331_CS ON;
	BSF	LATA,5,ACCESS
;exit sub
	RETURN
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (649)
SENDDATA_SSD1331:
;set SSD1331_CS OFF;
	BCF	LATA,5,ACCESS
;set SSD1331_DC ON;
	BSF	LATA,4,ACCESS
;FastHWSPITransfer  SSD1331SendByte
	MOVFF	SSD1331SENDBYTE,SPITXDATA
	CALL	FASTHWSPITRANSFER
;set SSD1331_CS ON;
	BSF	LATA,5,ACCESS
;exit sub
	RETURN
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (533)
SENDMULTIPLECOMMAND_SSD1331:
;Dim SSD1331BytestoSendCounter, SSD1331SendByte as byte
;set SSD1331_CS OFF;
	BCF	LATA,5,ACCESS
;set SSD1331_DC OFF;
	BCF	LATA,4,ACCESS
;for SSD1331BytestoSendCounter = 0 to SSD1331BytestoSend - 1
	BANKSEL	SSD1331BYTESTOSENDCOUNTER
	SETF	SSD1331BYTESTOSENDCOUNTER,BANKED
	DECF	SSD1331BYTESTOSEND,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	CLRF	SYSBYTETEMPB,ACCESS
	MOVFF	SYSTEMP1,SYSBYTETEMPA
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOPEND11
SYSFORLOOP11:
	BANKSEL	SSD1331BYTESTOSENDCOUNTER
	INCF	SSD1331BYTESTOSENDCOUNTER,F,BANKED
;FastHWSPITransfer  SSD1331_Command( SSD1331BytestoSendCounter )
	LFSR	0,SSD1331_COMMAND
	MOVF	SSD1331BYTESTOSENDCOUNTER,W,BANKED
;A2: ASM Source was:  ADDWF AFSR0,F,ACCESS
;A5: ASM Source was:  ADDWF AFSR0,F,ACCESS
	ADDWF	FSR0,F,ACCESS
	MOVLW	0
;A2: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
;A5: ASM Source was:  ADDWFC AFSR0_H,F,ACCESS
	ADDWFC	FSR0H,F,ACCESS
	MOVFF	INDF0,SPITXDATA
	BANKSEL	0
	CALL	FASTHWSPITRANSFER
;wait 10 us
	MOVLW	53
	MOVWF	DELAYTEMP,ACCESS
DELAYUS7:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS7
;next
	BANKSEL	SSD1331BYTESTOSEND
	DECF	SSD1331BYTESTOSEND,W,BANKED
	MOVWF	SYSTEMP1,BANKED
	MOVFF	SSD1331BYTESTOSENDCOUNTER,SYSBYTETEMPA
	MOVFF	SYSTEMP1,SYSBYTETEMPB
	BANKSEL	0
	RCALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	SYSFORLOOP11
SYSFORLOOPEND11:
;set SSD1331_CS ON
	BSF	LATA,5,ACCESS
;exit sub
	RETURN
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (868)
SETBRIGHTNESS_SSD1331:
;dim_state = dim_state / 16
	MOVFF	DIM_STATE,SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPA,DIM_STATE
;SendCommand_SSD1331(SSD1331_MasterCurrent)
	MOVLW	135
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(dim_state)
	MOVFF	DIM_STATE,SSD1331SENDBYTE
	BRA	SENDCOMMAND_SSD1331

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (851)
SETCONTRAST_SSD1331:
;dim_state = dim_state / 16
	MOVFF	DIM_STATE,SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPA,DIM_STATE
;SendCommand_SSD1331(SSD1331_CONTRASTA)
	MOVLW	129
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(dim_state)
	MOVFF	DIM_STATE,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(SSD1331_CONTRASTB)
	MOVLW	130
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(dim_state)
	MOVFF	DIM_STATE,SSD1331SENDBYTE
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(SSD1331_CONTRASTC)
	MOVLW	131
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(dim_state)
	MOVFF	DIM_STATE,SSD1331SENDBYTE
	BRA	SENDCOMMAND_SSD1331

;********************************************************************************

;SOURCE: GLCD_SSD1331.H (880)
SETPOWERMODE_SSD1331:
;dim_state = dim_state / 16
	MOVFF	DIM_STATE,SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSDIVSUB
	MOVFF	SYSBYTETEMPA,DIM_STATE
;SendCommand_SSD1331(SSD1331_POWERMODE)
	MOVLW	176
	BANKSEL	SSD1331SENDBYTE
	MOVWF	SSD1331SENDBYTE,BANKED
	BANKSEL	0
	RCALL	SENDCOMMAND_SSD1331
;SendCommand_SSD1331(dim_state)
	MOVFF	DIM_STATE,SSD1331SENDBYTE
	BRA	SENDCOMMAND_SSD1331

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: HWSPI.H (378)
SPIMODE686:
;Supports K mode SPI using the specific SPI module
;Turn off SPI
;(Prevents any weird glitches during setup)
;SPI1CON0_EN = 0
;A8: ASM Source was:  BCF SPI1CON0,SPI1CON0_EN,BANKED
	BCF	SPI1CON0,7,BANKED
;Set clock pulse settings to middle
;SPI1CON1.SMP = 0
;A8: ASM Source was:  BCF SPI1CON1,SMP,BANKED
	BCF	SPI1CON1,7,BANKED
;Data write on rising (idle > active) clock (CPHA = 1)
;SPI1CON1.CKE = 0
;A8: ASM Source was:  BCF SPI1CON1,CKE,BANKED
	BCF	SPI1CON1,6,BANKED
;Clock idle low (CPOL = 0)
;SPI1CON1.CKP = 0
;A8: ASM Source was:  BCF SPI1CON1,CKP,BANKED
	BCF	SPI1CON1,5,BANKED
;If SPIClockMode.0 = Off Then
	BANKSEL	SPICLOCKMODE
	BTFSC	SPICLOCKMODE,0,BANKED
	BRA	ENDIF58
;SPI1CON1.CKE = 1
BANKSEL	SPI1CON1
;A8: ASM Source was:  BSF SPI1CON1,CKE,BANKED
	BSF	SPI1CON1,6,BANKED
;End If
ENDIF58:
;If SPIClockMode.1 = On Then
	BANKSEL	SPICLOCKMODE
	BTFSS	SPICLOCKMODE,1,BANKED
	BRA	ENDIF59
;SPI1CON1.CKP = 1
BANKSEL	SPI1CON1
;A8: ASM Source was:  BSF SPI1CON1,CKP,BANKED
	BSF	SPI1CON1,5,BANKED
;End If
ENDIF59:
;SPI1CON1 = 0x40
	MOVLW	64
BANKSEL	SPI1CON1
	MOVWF	SPI1CON1,BANKED
;Transfer
;SPI1CON2 = SPI1CON2 or 3
	MOVLW	3
	IORWF	SPI1CON2,F,BANKED
;Select mode and clock
;SPI1CLK = SSP1_FOSC
	CLRF	SPI1CLK,BANKED
;Select Case SPICurrentMode
;Case MasterFast or MasterUltraFast
SYSSELECT4CASE1:
	MOVFF	SPICURRENTMODE,SYSBYTETEMPA
	MOVLW	13
	MOVWF	SYSBYTETEMPB,ACCESS
	RCALL	SYSCOMPEQUAL
	MOVLW	14
	IORWF	SYSBYTETEMPX,W,ACCESS
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1,BANKED
	BTFSS	SYSTEMP1,0,BANKED
	BRA	SYSSELECT4CASE2
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT
;SPI1BAUD = SPIBAUDRATE_SCRIPT
	MOVLW	3
BANKSEL	SPI1BAUD
	MOVWF	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
;A8: ASM Source was:  BSF SPI1CON0,MST,BANKED
	BSF	SPI1CON0,1,BANKED
;Case Master
	BRA	SYSSELECTEND4
SYSSELECT4CASE2:
	MOVLW	12
	SUBWF	SPICURRENTMODE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE3
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTER
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTER
	MOVLW	9
BANKSEL	SPI1BAUD
	MOVWF	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
;A8: ASM Source was:  BSF SPI1CON0,MST,BANKED
	BSF	SPI1CON0,1,BANKED
;Case MasterSlow
	BRA	SYSSELECTEND4
SYSSELECT4CASE3:
	MOVLW	11
	SUBWF	SPICURRENTMODE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE4
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTERSLOW
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTERSLOW
	MOVLW	33
BANKSEL	SPI1BAUD
	MOVWF	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
;A8: ASM Source was:  BSF SPI1CON0,MST,BANKED
	BSF	SPI1CON0,1,BANKED
;Case Slave
	BRA	SYSSELECTEND4
SYSSELECT4CASE4:
	MOVF	SPICURRENTMODE,F,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT4CASE5
;SPI1CON0.MST = 0
BANKSEL	SPI1CON0
;A8: ASM Source was:  BCF SPI1CON0,MST,BANKED
	BCF	SPI1CON0,1,BANKED
;Case SlaveSS
	BRA	SYSSELECTEND4
SYSSELECT4CASE5:
	DECF	SPICURRENTMODE,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND4
;SPI1CON0.MST = 0
BANKSEL	SPI1CON0
;A8: ASM Source was:  BCF SPI1CON0,MST,BANKED
	BCF	SPI1CON0,1,BANKED
;End Select
SYSSELECTEND4:
;Enable SPI
;SPI1CON0.EN = 1
BANKSEL	SPI1CON0
;A8: ASM Source was:  BSF SPI1CON0,EN,BANKED
	BSF	SPI1CON0,7,BANKED
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
	BRA	ENDIF60
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
ENDIF60:
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
	BRA	ENDIF61
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
ENDIF61:
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
	BRA	ENDIF62
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
ENDIF62:
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
	BRA	ENDIF63
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
ENDIF63:
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
	BRA	ELSE55_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF56
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	RETURN
;End If
ENDIF56:
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
	BRA	ENDIF55
ELSE55_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	RETURN
;End If
;End If
ENDIF55:
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
	BRA	ENDIF48
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA,ACCESS
	CLRF	SYSWORDTEMPA_H,ACCESS
;exit sub
	RETURN
;end if
ENDIF48:
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
	BRA	ENDIF49
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W,ACCESS
	ADDWF	SYSDIVMULTX,F,ACCESS
	MOVF	SYSDIVMULTB_H,W,ACCESS
	ADDWFC	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF49:
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
	BRA	ENDIF53
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF53:
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
	BRA	ENDIF54
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
ENDIF54:
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
	BRA	ENDIF50
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF50:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF51
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF51:
;Call word divide routine
;SysDivSub16
	RCALL	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF52
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
ENDIF52:
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
	BRA	ENDIF45
	COMF	SYSINTEGERTEMPA,F,ACCESS
	COMF	SYSINTEGERTEMPA_H,F,ACCESS
	INCF	SYSINTEGERTEMPA,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF45:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7,ACCESS
	BRA	ENDIF46
	COMF	SYSINTEGERTEMPB,F,ACCESS
	COMF	SYSINTEGERTEMPB_H,F,ACCESS
	INCF	SYSINTEGERTEMPB,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF46:
;Call word multiply routine
;SysMultSub16
	RCALL	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	BTFSS	SYSSIGNBYTE,7,ACCESS
	BRA	ENDIF47
	COMF	SYSINTEGERTEMPX,F,ACCESS
	COMF	SYSINTEGERTEMPX_H,F,ACCESS
	INCF	SYSINTEGERTEMPX,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS,Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	INCF	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF47:
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
	DB	0

	ALIGN	2;X3

STRINGTABLE3:
	DB	12,74,97,110,117,97,114,121,32,50,48,50,49

	ALIGN	2;X3

STRINGTABLE4:
	DB	12,83,83,68,49,51,51,49,32,71,76,67,68

	ALIGN	2;X3

STRINGTABLE5:
	DB	10,98,121,32,65,110,111,98,105,117,109

	ALIGN	2;X3

STRINGTABLE6:
	DB	16,71,76,67,68,80,114,105,110,116,32,83,116,114,105,110,103

	ALIGN	2;X3

STRINGTABLE7:
	DB	15,83,83,68,49,51,51,49,32,76,105,98,114,97,114,121

	ALIGN	2;X3

STRINGTABLE8:
	DB	8,80,114,105,110,116,83,116,114

	ALIGN	2;X3

STRINGTABLE9:
	DB	1,64

	ALIGN	2;X3

STRINGTABLE10:
	DB	3,77,104,122

	ALIGN	2;X3

STRINGTABLE11:
	DB	7,68,114,97,119,83,116,114

	ALIGN	2;X3

STRINGTABLE12:
	DB	1,104

	ALIGN	2;X3

STRINGTABLE58:
	DB	1,32

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
	BANKSEL	SYSVALTEMP
	ANDWF	SYSVALTEMP,W,BANKED
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF37
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF37:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_2
	MOVWF	SYS_HEXPICAS_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP,BANKED
SYSFORLOOP12:
	INCF	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	RRCF	SYSVALTEMP,F,BANKED
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W,BANKED
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP12
SYSFORLOOPEND12:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W,BANKED
	MOVWF	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF39
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F,BANKED
ENDIF39:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W,BANKED
	BANKSEL	SYS_HEXPICAS_1
	MOVWF	SYS_HEXPICAS_1,BANKED
	BANKSEL	0
	RETURN

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
SYSDOLOOP_S5:
	MOVFF	LINEX1,SYSWORDTEMPA
	MOVFF	LINEX1_H,SYSWORDTEMPA_H
	MOVFF	LINEX2,SYSWORDTEMPB
	MOVFF	LINEX2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E5
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEX1_H,GLCDX_H
	MOVFF	LINEY1,GLCDY
	MOVFF	LINEY1_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
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
	BANKSEL	SYSTEMP3
	MOVWF	SYSTEMP3,BANKED
	MOVF	LINEDIFFX_X2_H,W,ACCESS
	SUBWFB	LINEDIFFY_X2_H,W,ACCESS
	MOVWF	SYSTEMP3_H,BANKED
	MOVF	SYSTEMP3,W,BANKED
	ADDWF	LINEERR,F,ACCESS
	MOVF	SYSTEMP3_H,W,BANKED
	ADDWFC	LINEERR_H,F,ACCESS
;LineY1 += LineStepY
	MOVF	LINESTEPY,W,ACCESS
	ADDWF	LINEY1,F,ACCESS
	MOVF	LINESTEPY_H,W,ACCESS
	ADDWFC	LINEY1_H,F,ACCESS
;end if
ENDIF43:
;loop
	BRA	SYSDOLOOP_S5
SYSDOLOOP_E5:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEX1_H,GLCDX_H
	MOVFF	LINEY1,GLCDY
	MOVFF	LINEY1_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
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
SYSDOLOOP_S6:
	MOVFF	LINEY1,SYSWORDTEMPA
	MOVFF	LINEY1_H,SYSWORDTEMPA_H
	MOVFF	LINEY2,SYSWORDTEMPB
	MOVFF	LINEY2_H,SYSWORDTEMPB_H
	BANKSEL	0
	RCALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F,ACCESS
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	SYSDOLOOP_E6
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEX1_H,GLCDX_H
	MOVFF	LINEY1,GLCDY
	MOVFF	LINEY1_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
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
	BANKSEL	SYSTEMP3
	MOVWF	SYSTEMP3,BANKED
	MOVF	LINEDIFFY_X2_H,W,ACCESS
	SUBWFB	LINEDIFFX_X2_H,W,ACCESS
	MOVWF	SYSTEMP3_H,BANKED
	MOVF	SYSTEMP3,W,BANKED
	ADDWF	LINEERR,F,ACCESS
	MOVF	SYSTEMP3_H,W,BANKED
	ADDWFC	LINEERR_H,F,ACCESS
;LineX1 += LineStepX
	MOVF	LINESTEPX,W,ACCESS
	ADDWF	LINEX1,F,ACCESS
	MOVF	LINESTEPX_H,W,ACCESS
	ADDWFC	LINEX1_H,F,ACCESS
;end if
ENDIF44:
;loop
	BRA	SYSDOLOOP_S6
SYSDOLOOP_E6:
;PSet (   LineX1,   LineY1, LineColour )
	MOVFF	LINEX1,GLCDX
	MOVFF	LINEX1_H,GLCDX_H
	MOVFF	LINEY1,GLCDY
	MOVFF	LINEY1_H,GLCDY_H
	MOVFF	LINECOLOUR,GLCDCOLOUR
	MOVFF	LINECOLOUR_H,GLCDCOLOUR_H
	CALL	PSET_SSD1331
;end if
ENDIF42:
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
