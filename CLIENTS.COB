       IDENTIFICATION                                          DIVISION.
      * Program to read client data, process and save it!
       PROGRAM-ID. CLIENTS.
       AUTHOR. Jefferson Campos.

       ENVIRONMENT                                             DIVISION.
       CONFIGURATION                                            SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT                                             SECTION.
       FILE-CONTROL.
           SELECT IFILCLI ASSIGN TO "./ifilcli.txt"
               FILE STATUS IS FS-IFILCLI.

       DATA                                                    DIVISION.
       FILE                                                     SECTION.
       FD IFILCLI
           RECORDING MODE IS F.
       01 REGISTER.
         05 REG-AGENCY            PICTURE X(04).
         05 REG-ACCOUNT           PICTURE X(08).
         05 REG-NAME              PICTURE X(32).
         05 REG-MANAGER           PICTURE X(04).
         05 REG-ACC-TYPE          PICTURE 9(02).
         05 REG-BALANCE           PICTURE 9(16)V99.
      * 68 POSITIONS AS IS IN 4 + 8 + 32 + 4 +2 + (16 + 2)
      *  AGENCY   ACCOUNT  NAME       MANAGER  ACCOUNT-TYPE BALANCE
      *  2344     45645    JONAS      003      1            15000

       WORKING-STORAGE                                          SECTION.
       01 FS-IFILCLI              PICTURE 9(02).

       01 WRK-BANK-STATEMENT-COST PICTURE S9(02)V9(02) VALUE 01,00.
       01 WRK-INIT-BALANCE        PICTURE S9(10)V9(02) VALUE 2413,78.
       01 WRK-BALANCE-ED          PICTURE Z.ZZZ.ZZZ.ZZ9,99.

       01 WRK-COUNTER             PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-INDIV       PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-BUSS        PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-OTHER       PICTURE 9(03) USAGE COMP VALUE ZEROES.

       PROCEDURE                                               DIVISION.
       0100-MAIN                                                SECTION.
           DISPLAY "Client Program".
           PERFORM 0200-INIT.
           PERFORM 0300-PROCESSING UNTIL FS-IFILCLI EQUAL 10.
           PERFORM 9999-FINAL.
           STOP RUN.
       0100-END.                                                   EXIT.

       0200-INIT                                                SECTION.
           ADD 1 TO WRK-COUNTER.
           PERFORM 0203-INIT-FILE-POPULATE.
           DISPLAY "..................................................".
       0200-END.                                                   EXIT.

       0201-INIT-HARDCODED-POPULATE                             SECTION.
           MOVE 1567 TO REG-ACCOUNT.
           MOVE 10756985 TO REG-ACCOUNT.
           MOVE "Jonh Cornor" TO REG-NAME.
           MOVE 6752 TO REG-MANAGER.
           MOVE 1 TO REG-ACC-TYPE.
           MOVE WRK-INIT-BALANCE TO REG-BALANCE.
       0201-END.                                                   EXIT.

       0202-INIT-ASKIING-POPULATE                               SECTION.
           DISPLAY "Inform your AGENCY:".
           ACCEPT REG-AGENCY.
           DISPLAY "Inform your ACCOUNT:".
           ACCEPT REG-ACCOUNT.
           DISPLAY "Inform your NAME:".
           ACCEPT REG-NAME.
           DISPLAY "Inform your MANAGER:".
           ACCEPT REG-MANAGER.
           DISPLAY "Inform your ACC-TYPE:".
           ACCEPT REG-ACC-TYPE.
           DISPLAY "Inform your BALANCE:".
           ACCEPT REG-BALANCE.
       0202-END.                                                   EXIT.

       0203-INIT-FILE-POPULATE                                  SECTION.
           OPEN INPUT IFILCLI.
           IF FS-IFILCLI NOT EQUAL ZEROS
               DISPLAY "FILE WAS NOT OPENED!!"
               GOBACK
           END-IF.

           PERFORM 0210-READ.
       0203-END.                                                   EXIT.

       0210-READ                                                SECTION.
           READ IFILCLI.
       0210-END.                                                   EXIT.

       0300-PROCESSING                                          SECTION.
      *    ---- Print balance and pay the fee
           MOVE REG-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "You have in your account R$ " WRK-BALANCE-ED.
           SUBTRACT WRK-BANK-STATEMENT-COST FROM REG-BALANCE.
           MOVE REG-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "After fee R$ " WRK-BALANCE-ED.

           PERFORM 0700-DECISION.

           *> DISPLAY REGISTER.
           PERFORM 0210-READ.

           DISPLAY "==================================================".
       0300-END.                                                   EXIT.

       0700-DECISION                                            SECTION.
      *    ---- Decision structure
           EVALUATE REG-ACC-TYPE
               WHEN 1
                   DISPLAY "You choosed INDIVIDUAL account type."
                   ADD 1 TO WRK-COUNTER-INDIV
               WHEN 2
                   DISPLAY "You choosed BUSINESS account type."
                   ADD 1 TO WRK-COUNTER-BUSS
               WHEN OTHER
                   DISPLAY "You choosed WRONG acc type - Use 1 or 2!!"
                   ADD 1 TO WRK-COUNTER-OTHER
           END-EVALUATE
           DISPLAY "--------------------------------------------------".
       0700-END.                                                   EXIT.

       9999-FINAL                                               SECTION.
           CLOSE IFILCLI.
           DISPLAY "--------------------------------------------------".
           DISPLAY "------------------- STATISTICS -------------------".
           DISPLAY "--------------------------------------------------".
           DISPLAY "WRK-COUNTER:       " WRK-COUNTER.
           DISPLAY "WRK-COUNTER-INDIV: " WRK-COUNTER-INDIV.
           DISPLAY "WRK-COUNTER-BUSS : " WRK-COUNTER-BUSS.
           DISPLAY "WRK-COUNTER-OTHER: " WRK-COUNTER-OTHER.
       9999-END.                                                   EXIT.
