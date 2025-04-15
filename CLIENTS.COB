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

       PROCEDURE                                              DIVISION.
           DISPLAY "Client Program".
           *> MOVE "Jonh Cornor" TO WRK-NAME.
           DISPLAY "Inform your name:".
           *> Just to simplify the tests
           *> ACCEPT WRK-NAME.
           MOVE "Jeff" TO WRK-NAME.
           MOVE WRK-INIT-BALANCE TO WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED
           DISPLAY "BALANCE IS " WRK-BALANCE-ED " FROM ACC. " WRK-NAME.
           DISPLAY "--------------------------------------------------".

      *    ---- Bank Statement
           DISPLAY "Bank statement cost is " WRK-BANK-STATEMENT-COST.
           SUBTRACT WRK-BANK-STATEMENT-COST FROM WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED
           DISPLAY "Your actual balance is " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Deposit
           DISPLAY "Please, inform total to add to your account:".
           ACCEPT WRK-DEPOSIT
           ADD WRK-DEPOSIT TO WRK-BALANCE.
           MOVE WRK-BALANCE TO WRK-BALANCE-ED
           DISPLAY "Now, your acc balance is: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Multiply by factor
           DISPLAY "Oh! You missied the bonus factor: " WRK-DT-FACTOR.
           MULTIPLY WRK-DEPOSIT BY WRK-DT-FACTOR GIVING WRK-DEPOSIT.
           MOVE WRK-DEPOSIT TO WRK-BALANCE-ED
           DISPLAY "Your deposit should: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Divided by factor
           DISPLAY "Just Kidding!! ".
           DIVIDE WRK-DEPOSIT BY WRK-DT-FACTOR GIVING WRK-DEPOSIT.
           MOVE WRK-DEPOSIT TO WRK-BALANCE-ED
           DISPLAY "Your REAL deposit is correct: " WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Better display
           MOVE WRK-BALANCE TO WRK-BALANCE-ED.
           DISPLAY "A better balance: R$" WRK-BALANCE-ED.
           DISPLAY "--------------------------------------------------".

      *    ---- Interest display
           DISPLAY "WRK-BALANCE --> " WRK-BALANCE
           COMPUTE WRK-RES-IN = WRK-BALANCE * (1 + WRK-INTEREST-RATE).
           DISPLAY "WRK-RES-IN --> " WRK-RES-IN
           MOVE WRK-RES-IN TO WRK-BALANCE-ED
           DISPLAY "Your balance w/ interrest will be " WRK-BALANCE-ED.

           STOP      RUN.
