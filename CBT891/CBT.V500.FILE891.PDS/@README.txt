1.1 Introduction
    ------------
    MINE is a powerful Rexx utility developed to build a structure
    chart of a COBOL source. Just press <PF1> under any paragraph.
    A visual diagram that shows all the calling paragraphs and
    called paragraphs is displayed on the screen.

    Pressing <PF2> on any PERFORM <para> statement, allows you to
    jump directly to the called paragraph. Press <PF4> within the
    called paragraph, takes you back to the last PERFORM statement.
    You can traverse upto any number of levels.

1.2 How to use
    ----------
    You may invoked MINE on the ISPF Editor.

    Syntax
    ======
    MINE {parameter}

    The parameter passed to the MINE EXEC determines the function
    to be performed. The parameter could be one of these values
    IN, OUT or GRAPH.

1.3 Installation
    ------------
    Copy the MINE EXEC in this PDS to any library under your
    //SYSPROC or //SYSEXEC concatenations. It is recommended to change
    your ISPF Editor Keylist settings as follows; assign the command
    MINE IN to <PF2>, MINE OUT to <PF4> and MINE GRAPH <PF1>.

1.4 Author
    ------
    MINE is written entirely in REXX by Quasar Chunawala.
    He can be reached at quasar.chunawalla@gmail.com.

    Thank you for trying MINE!
    - Quasar Chunawala,
      Pune, Maharashtra, India
      quasar.chunawalla@gmail.com
