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
           SELECT OFILCLI ASSIGN TO "./ofilcli.txt"
               FILE STATUS IS FS-OFILCLI.

       DATA                                                    DIVISION.
       FILE                                                     SECTION.
       FD IFILCLI
           RECORDING MODE IS F.
      * Input layout of file
       COPY "BOOKCLI".

       FD OFILCLI
           RECORDING MODE IS F.
       01 REG-OFILCLI             PICTURE X(36).
      * 32 POSITIONS AS IS IN 4 + 8 + 2 + (16 + 2)
      *  AGENCY   ACCOUNT  ACCOUNT-TYPE BALANCE
      *  2344     00045645 01           000000000000015000

       WORKING-STORAGE                                          SECTION.
       01 FS-IFILCLI              PICTURE 9(02).
       01 FS-OFILCLI              PICTURE 9(02).

       01 WRK-BANK-STATEMENT-COST PICTURE S9(02)V9(02) VALUE 01,00.
       01 WRK-INIT-BALANCE        PICTURE S9(10)V9(02) VALUE 2413,78.
       01 WRK-BALANCE-ED          PICTURE Z.ZZZ.ZZZ.ZZ9,99.

       01 WRK-COUNTER             PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-INDIV       PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-BUSS        PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-OTHER       PICTURE 9(03) USAGE COMP VALUE ZEROES.

       PROCEDURE                                               DIVISION.
       0100-MAIN                                                SECTION.
           DISPLAY "== Client Program ==".
           PERFORM 0200-INIT.
           *> PERFORM 0300-PROCESSING UNTIL FS-IFILCLI EQUAL 10. 10 is after status 04. 04 repeat the last register. Until 04, all status in each read is 00.
           PERFORM 0300-PROCESSING UNTIL FS-IFILCLI EQUAL 04.
           PERFORM 9999-FINAL.
           STOP RUN.
       0100-END.                                                   EXIT.

       0200-INIT                                                SECTION.
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
           OPEN INPUT  IFILCLI.
           OPEN OUTPUT OFILCLI.

           DISPLAY "FS-OFILCLI value is " FS-OFILCLI
           DISPLAY "FS-IFILCLI value is " FS-IFILCLI
           IF FS-IFILCLI NOT EQUAL ZEROS OR FS-OFILCLI NOT EQUAL ZEROS
               DISPLAY "FILE WAS NOT OPENED!!"
               GOBACK
           ELSE
               DISPLAY "== Opened file!!! =="
           END-IF.

           PERFORM 0210-READ.
       0203-END.                                                   EXIT.

       0210-READ                                                SECTION.
           READ IFILCLI.
       0210-END.                                                   EXIT.

       0211-DISPLAY-REG                                         SECTION.
           *> DISPLAY REGISTER.
          DISPLAY "FS-IFILCLI value is " FS-IFILCLI
           DISPLAY "AGENCY....: " REG-AGENCY.
           DISPLAY "ACCOUNT...: " REG-ACCOUNT.
           DISPLAY "NAME......: " REG-NAME.
           DISPLAY "MANAGER...: " REG-MANAGER.
           DISPLAY "ACC-TYPE..: " REG-ACC-TYPE.
           DISPLAY "BALANCE...: " REG-BALANCE.
           DISPLAY "--------------------------------------------------".
       0211-END.                                                   EXIT.

       0300-PROCESSING                                          SECTION.
           PERFORM 0211-DISPLAY-REG.

           ADD 1 TO WRK-COUNTER.
      *    ---- Print balance and pay the fee
           MOVE REG-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "You have in your account R$ " WRK-BALANCE-ED.
           SUBTRACT WRK-BANK-STATEMENT-COST FROM REG-BALANCE.
           MOVE REG-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "After fee R$ " WRK-BALANCE-ED.

           PERFORM 0700-DECISION.

           IF REG-BALANCE GREATER THAN OR EQUAL 5000 AND
              (REG-ACC-TYPE EQUAL 1 OR REG-ACC-TYPE EQUAL 2)
               DISPLAY "*** greater ***"
               STRING REG-AGENCY     DELIMITED BY SIZE
                      REG-ACCOUNT    DELIMITED BY SIZE
                      REG-ACC-TYPE   DELIMITED BY SIZE
                      REG-BALANCE    DELIMITED BY SIZE
               INTO REG-OFILCLI
               WRITE REG-OFILCLI
               IF FS-OFILCLI NOT EQUAL ZEROS
                   DISPLAY "FAILED TO WRITE DATA TO FILE " REG-AGENCY
                   REG-ACCOUNT
               END-IF
           END-IF.

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
           END-EVALUATE.
       0700-END.                                                   EXIT.

       9999-FINAL                                               SECTION.
           CLOSE IFILCLI.
           CLOSE OFILCLI.
           DISPLAY "--------------------------------------------------".
           DISPLAY "------------------- STATISTICS -------------------".
           DISPLAY "--------------------------------------------------".
           DISPLAY "WRK-COUNTER:       " WRK-COUNTER.
           DISPLAY "WRK-COUNTER-INDIV: " WRK-COUNTER-INDIV.
           DISPLAY "WRK-COUNTER-BUSS : " WRK-COUNTER-BUSS.
           DISPLAY "WRK-COUNTER-OTHER: " WRK-COUNTER-OTHER.
       9999-END.                                                   EXIT.
