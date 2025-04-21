       IDENTIFICATION                                          DIVISION.
      * Program to read client data, process and save it!
       PROGRAM-ID. CLIENTS.
       AUTHOR. Jefferson Campos.

       ENVIRONMENT                                             DIVISION.
       CONFIGURATION                                            SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA                                                    DIVISION.
       WORKING-STORAGE                                          SECTION.
       01 WRK-BALANCE-ED          PICTURE Z.ZZZ.ZZZ.ZZ9,99.
       01 WRK-NAME                PICTURE X(16)        VALUE SPACES.
       01 WRK-BALANCE             PICTURE S9(10)V9(02) COMP VALUE ZEROS.
       01 WRK-INIT-BALANCE        PICTURE S9(10)V9(02) VALUE 2000.
       01 WRK-BANK-STATEMENT-COST PICTURE S9(02)V9(02) VALUE 1.
       01 WRK-DEPOSIT             PICTURE S9(10)V9(02) VALUE ZEROS.
       01 WRK-DT-FACTOR           PICTURE S9(02)V9(02) VALUE 2.
       01 WRK-INTEREST-RATE       PICTURE S9(02)V9(02) VALUE 0,05.
       01 WRK-RES-IN              PICTURE S9(10)V9(02) COMP VALUE ZEROS.
       01 WRK-TH                  PICTURE S9(10)V9(02) VALUE 5000,00.
       01 WRK-TH-ED               PICTURE Z.ZZZ.ZZZ.ZZ9,99.
       01 WRK-ACC-TYPE            PICTURE 9.
       01 WRK-COUNTER             PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-INDIV       PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-BUSS        PICTURE 9(03) USAGE COMP VALUE ZEROES.
       01 WRK-COUNTER-OTHER       PICTURE 9(03) USAGE COMP VALUE ZEROES.

       PROCEDURE                                               DIVISION.
       0100-MAIN                                                SECTION.
           DISPLAY "Client Program".
           *> PERFORM 0200-INIT.
           *> PERFORM 0300-STATEMENT.
           *> PERFORM 0400-DEPOSIT.
           *> PERFORM 0500-OPER.
           *> PERFORM 0600-INTEREST.
           PERFORM 0700-DECISION.
           *> PERFORM 0801-PERF.
           *> PERFORM 0802-PERF-UTL UNTIL WRK-ACC-TYPE EQUAL 0.
           PERFORM 0802-PERF-UTL VARYING WRK-COUNTER FROM 0 BY 1
                                 UNTIL WRK-COUNTER EQUAL 3.
           PERFORM 9999-FINAL.
           STOP RUN.
       0100-END.                                                   EXIT.

       0200-INIT                                                SECTION.
           *> MOVE "Jonh Cornor" TO WRK-NAME.
           DISPLAY "Inform your name:".
           *> Just to simplify the tests
           *> ACCEPT WRK-NAME.
           MOVE "Jeff" TO WRK-NAME.
           MOVE WRK-INIT-BALANCE TO WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "BALANCE IS " WRK-BALANCE-ED " FROM ACC. " WRK-NAME.
           DISPLAY "--------------------------------------------------".
       0200-END.                                                   EXIT.

       0300-STATEMENT                                           SECTION.
      *    ---- Bank Statement
           DISPLAY "Bank statement cost is " WRK-BANK-STATEMENT-COST.
           SUBTRACT WRK-BANK-STATEMENT-COST FROM WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED
           DISPLAY "Your actual balance is " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".
       0300-END.                                                   EXIT.

       0400-DEPOSIT                                             SECTION.
      *    ---- Deposit
           DISPLAY "Please, inform total to add to your account:".
           ACCEPT WRK-DEPOSIT.
           ADD WRK-DEPOSIT TO WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "Now, your acc balance is: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".
       0400-END.                                                   EXIT.

       0500-OPER                                                SECTION.
      *    ---- Multiply by factor
           DISPLAY "Oh! You missied the bonus factor: " WRK-DT-FACTOR.
           MULTIPLY WRK-DEPOSIT BY WRK-DT-FACTOR GIVING WRK-DEPOSIT.
           MOVE WRK-DEPOSIT TO WRK-BALANCE-ED.
           DISPLAY "Your deposit should: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Divided by factor
           DISPLAY "Just Kidding!! ".
           DIVIDE WRK-DEPOSIT BY WRK-DT-FACTOR GIVING WRK-DEPOSIT.
           MOVE WRK-DEPOSIT TO WRK-BALANCE-ED.
           DISPLAY "Your REAL deposit is correct: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".
       0500-END.                                                   EXIT.

       0600-INTEREST                                            SECTION.
      *    ---- Better display
           MOVE WRK-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "A better balance: R$" WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Interest display
           DISPLAY "WRK-BALANCE --> " WRK-BALANCE.
           COMPUTE WRK-RES-IN = WRK-BALANCE * (1 + WRK-INTEREST-RATE).
           DISPLAY "WRK-RES-IN  --> " WRK-RES-IN.
           MOVE WRK-RES-IN TO WRK-BALANCE-ED.
           DISPLAY "Your balance w/ interrest will be " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".
       0600-END.                                                   EXIT.

       0700-DECISION                                            SECTION.
      *    ---- Decision structure
           ADD 1 TO WRK-COUNTER.
           DISPLAY "WHICH IS YOUR ACC TYPE?".
           DISPLAY "1 - INDIVIDUAL ACCOUNT".
           DISPLAY "2 - BUSINESS   ACCOUNT".
           ACCEPT WRK-ACC-TYPE.
           EVALUATE WRK-ACC-TYPE
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
           MOVE WRK-TH TO WRK-TH-ED.
           IF WRK-BALANCE GREATER OR EQUAL 5000
           AND (WRK-ACC-TYPE EQUAL 1 OR WRK-ACC-TYPE EQUAL 2) THEN
               MOVE WRK-BALANCE TO WRK-BALANCE-ED
               DISPLAY "Balance target is ABOVE thereshold " WRK-TH-ED
               DISPLAY "Actual balance: R$" WRK-BALANCE-ED
           ELSE
               MOVE WRK-BALANCE TO WRK-BALANCE-ED
               DISPLAY "Balance target is BELLOW thereshold " WRK-TH-ED
               DISPLAY "Actual balance: R$" WRK-BALANCE-ED
               DISPLAY "OR WRK-ACC-TYPE is invalid: " WRK-ACC-TYPE
           END-IF.
           DISPLAY "WRK-COUNTER 0700:       " WRK-COUNTER.
           DISPLAY "--------------------------------------------------".
       0700-END.                                                   EXIT.

       0801-PERF                                                SECTION.
           PERFORM 2 TIMES
               MOVE WRK-BALANCE TO WRK-BALANCE-ED
               DISPLAY "Add more to your balance is R$" WRK-BALANCE-ED
               ACCEPT WRK-DEPOSIT
               ADD WRK-DEPOSIT TO WRK-BALANCE
               MOVE WRK-BALANCE TO WRK-BALANCE-ED
               DISPLAY "NOW, Your balance is R$" WRK-BALANCE-ED
           END-PERFORM.
           DISPLAY "--------------------------------------------------".
       0801-END.                                                   EXIT.

       0802-PERF-UTL                                            SECTION.
           DISPLAY "Inform another account type, 0 to exit.".
           ACCEPT WRK-ACC-TYPE.
           EVALUATE WRK-ACC-TYPE
               WHEN 0
                   DISPLAY "You choosed TO END processing."
               WHEN 1
                   DISPLAY "You choosed INDIVIDUAL account type."
                   ADD 1 TO WRK-COUNTER-INDIV
               WHEN 2
                   DISPLAY "You choosed BUSINESS account type."
                   ADD 1 TO WRK-COUNTER-BUSS
               WHEN OTHER
                   DISPLAY "WRONG acc type - Use 1 or 2!! 0 exit."
                   ADD 1 TO WRK-COUNTER-OTHER
           END-EVALUATE.
           DISPLAY "WRK-COUNTER 0802:       " WRK-COUNTER.
           *> DISPLAY "--------------------------------------------------".
       0802-END.                                                   EXIT.

       9999-FINAL                                               SECTION.
           DISPLAY "--------------------------------------------------".
           DISPLAY "------------------- STATISTICS -------------------".
           DISPLAY "--------------------------------------------------".
           DISPLAY "WRK-COUNTER:       " WRK-COUNTER.
           DISPLAY "WRK-COUNTER-INDIV: " WRK-COUNTER-INDIV.
           DISPLAY "WRK-COUNTER-BUSS : " WRK-COUNTER-BUSS.
           DISPLAY "WRK-COUNTER-OTHER: " WRK-COUNTER-OTHER.
       9999-END.                                                   EXIT.
