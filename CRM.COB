       IDENTIFICATION                                          DIVISION.
      * Program to read client data, process and save it!
       PROGRAM-ID. CLIENTS.
       AUTHOR. Jefferson Campos.

       ENVIRONMENT                                             DIVISION.

       DATA                                                    DIVISION.
       WORKING-STORAGE                                          SECTION.
       01 BRAILLE                                         PICTURE X(64).
       01 LINE01                                          PICTURE X(64).
       01 LINE02                                          PICTURE X(64).
       01 LINE03                                          PICTURE X(64).
       01 LINE04                                          PICTURE X(64).
       01 LINE05                                          PICTURE X(64).
       01 LINE06                                          PICTURE X(64).
       01 SEP                                             PICTURE X(64).
       01 WRK-OPTION                                      PICTURE 9(01).
       SCREEN                                                   SECTION.
       01 DISP-SCREEN.
           05 BLANK SCREEN.
      *    Input layout of file

       PROCEDURE                                               DIVISION.
       0100-MAIN                                                SECTION.
           MOVE "   ( .     (  .             (  (   (   (   " TO LINE01.
           MOVE "  ())  (  (_)   ( (        ()) )\  )\: )\  " TO LINE02.
           MOVE " ((_)) )\(_))   )\)\      ((_))(_)((_)((_) " TO LINE03.
           MOVE "(/ __|((_) |() ((_) |    (/ __| _ \  \/  | " TO LINE04.
           MOVE "| (__/ _ \  _ \ _ \ |    | (__|   / |\/| | " TO LINE05.
           MOVE " \___|___/____/___/_|     \___|_|_\_|  |_| " TO LINE06.
           MOVE "-.-. --- -... --- .-.. / -.-. .-. --"       TO BRAILLE.
           DISPLAY DISP-SCREEN.
           DISPLAY LINE01                             LINE 01 COLUMN 01.
           DISPLAY LINE02                             LINE 02 COLUMN 01.
           DISPLAY LINE03                             LINE 03 COLUMN 01.
           DISPLAY LINE04                             LINE 04 COLUMN 01.
           DISPLAY LINE05                             LINE 05 COLUMN 01.
           DISPLAY LINE06                             LINE 06 COLUMN 01.

           DISPLAY BRAILLE                            LINE 07 COLUMN 01.

           DISPLAY "====== Cobol CRM ====== "         LINE 08 COLUMN 01.
           DISPLAY "1 - CREATE              "         LINE 09 COLUMN 01.
           DISPLAY "2 - READ                "         LINE 10 COLUMN 01.
           DISPLAY "3 - UPDATE              "         LINE 11 COLUMN 01.
           DISPLAY "4 - DELETE              "         LINE 12 COLUMN 01.
           DISPLAY "5 - INACTIVATE/ACTIVATE "         LINE 13 COLUMN 01.
           DISPLAY "6 - ACTIVE REPORT       "         LINE 14 COLUMN 01.
           DISPLAY "7 - INACTIVE REPORT     "         LINE 15 COLUMN 01.
           DISPLAY "8 - SYSTEM SETUP        "         LINE 16 COLUMN 01.
           DISPLAY "9 - FINISH              "         LINE 17 COLUMN 01.
           DISPLAY "CHOOSE Your Destiny     "         LINE 20 COLUMN 01.
               ACCEPT WRK-OPTION                      LINE 20 COLUMN 21.
           PERFORM 0101-EVAL-OPT.
           STOP RUN.
       0100-END.                                                   EXIT.

       0101-EVAL-OPT                                            SECTION.
           MOVE ".............................................." TO SEP.
           DISPLAY DISP-SCREEN.
           DISPLAY SEP                                LINE 01 COLUMN 01.
           DISPLAY "   "                              LINE 02 COLUMN 01.
           EVALUATE WRK-OPTION
               WHEN 1
                   CALL "CREATE"
               WHEN 2
                   CALL "READ"
               WHEN 3
                   CALL "UPDATE"
               WHEN 4
                   CALL "DELETE"
               WHEN 5
                   CALL "TOGGLE INACTIVATE / ACTIVATE"
               WHEN 6
                   CALL "ACTIVE REPORT"
               WHEN 7
                   CALL "INACTIVE REPORT"
               WHEN 8
                   CALL "SYSTEM SETUP"
               WHEN 9
                   DISPLAY "EXITING crm PROGRAM" LINE 03 COLUMN 01
           END-EVALUATE.
           DISPLAY "YOU CHOOSED OPTION: "             LINE 04 COLUMN 01.
           DISPLAY WRK-OPTION                         LINE 05 COLUMN 01.

       0101-END.                                                   EXIT.
