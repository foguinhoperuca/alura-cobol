       01 REGISTER.
         05 REG-AGENCY            PICTURE X(04).
         05 REG-ACCOUNT           PICTURE X(08).
         05 REG-NAME              PICTURE X(32).
         05 REG-MANAGER           PICTURE X(04).
         05 REG-ACC-TYPE          PICTURE 9(02).
         05 REG-BALANCE           PICTURE 9(16)V99.
      * 68 POSITIONS AS IS IN 4 + 8 + 32 + 4 + 2 + (16 + 2)
      *  AGENCY   ACCOUNT  NAME                             MANAGER  ACCOUNT-TYPE BALANCE
      *  2344     00045645 JONAS                            0003     01           000000000000015000