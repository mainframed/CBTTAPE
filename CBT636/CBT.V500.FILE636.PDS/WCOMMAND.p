/*BEGIN ==================== REXX ===================================*/
/*                                                                   */
/*      This REXX attempts to execute any command with any level of  */
/*   files.  It can also select certain files from the designated    */
/*   level with another string required to be a part of the file     */
/*   name.  The inputs are first, the level of the files to be       */
/*   operated on by the command.  The second argument is the command */
/*   with a single '*' in it which will be replaced with the         */
/*   designated file names.  The command entered should be enclosed  */
/*   in quotes, and either single or double quotes may be used       */
/*   depending on the users whim or the existing quotes within the   */
/*   command.  The third argument is the other string to be looked   */
/*   for in the file names for them to be used in the command.  If   */
/*   there is no selection desired among files within the level, an  */
/*   * may be used for this argument.  The final and optional        */
/*   argument may be EXEC in order to execute the commands.  If this */
/*   is not used, the commands will only be listed.  The program     */
/*   tries to avoid executing commands without the user taking due   */
/*   caution because it can create havoc with a system, so please be */
/*   careful trying to use it.                                       */
/*                                                                   */
/*      Below are sample command lines:                              */
/*   WCOMMAND IBMUSER "LISTC ENT(*) ALL" *                           */
/*   WCOMMAND IBMUSER "LISTC ENT(*) ALL" LIST                        */
/*   WCOMMAND IBMUSER "LISTC ENT(*) ALL" * EXEC                      */
/*   WCOMMAND IBMUSER "LISTC ENT(*) ALL" LIST EXEC                   */
/*   WCOMMAND SYSTEMS.DUMP 'DEL *' DMP00                             */
/*                                                                   */
/*END ====================== REXX ===================================*/

/* Get any possible argument                                         */
parse upper arg input

/* The command line must have something or else we lecture the guy   */
if length(input) = 0 then do

/* Search for start of comment                                       */
  do i = 1 to sourceline()
    if '/*BEGIN' = left(sourceline(i),7) then leave
    end

/* If we're at end of program, report and quit                       */
  if i > sourceline() then do
    say ' '
    say "There are no comments in this program, so they aren't printed."
    exit
    end

/* Else print them out while searching for end                       */
  do j = i + 1 to sourceline()
    if '/*END' = left(sourceline(j),5) then leave
    s = strip(sourceline(j),'l')
    l = pos('/*',s)
    if l > 0 then k = pos('*/',s)
    else do
      l = -1
      k = length(s) + 3
      end
    if k < 1 then k = length(s) + 3
    say substr(s,l+2,k-3)
    end
  exit
  end

/* Use the first argument eneterd as the input file level            */
parse var input lev input
lenlev = length(lev)

/* Second argument if present is the command to be executed else ask */
do while length(input) = 0
  say 'Enter the command to be executed'
  parse upper pull input
  end

/* Get whatever the user wants to be executed without blanks         */
input = strip(input,'B')

/* First check for quotes, either single or double                   */
if ( left(input,1) = '"' ) | ( left(input,1) = "'" ) then do

/* Then look for the closing auote                                   */
  quote = left(input,1)
  i = pos(quote,substr(input,2))
  if i = 0 then do
    say 'There was no trailing quote for the command, so quit now.'
    exit 4
    end
  com = substr(input,2,i-1)
  input = strip(substr(input,i+2),'B')
  end

/* If no quotes we must have an error so quit now ( can't have a * ) */
else do
  say 'The entered command must be enclosed in quotes to contain a *.'
  exit 4
  end

/* Now make the wildcard command by first finding the *              */
i = pos('*',com)
if i = 0 then do
  say 'The command is not recognized with a wildcard so this will end.'
  exit 4
  end

/* Set up the starting chars in the command ( before the * )         */
if i > 1 then first = substr(com,1,i-1)
else first = ''

/* Now the trailing chars in the command ( after the * )             */
if length(com) = i then last = ''
else last = substr(com,i+1)

/* Now show the command to be executed with the files found          */
say ' The command to be executed is:'
say first || '***' || last

/* Now ask for the auxiliary defining file name string               */
do while length(input) = 0
  say "Enter string of files to be operated upon '*' for none."
  parse upper pull input
  end

/* Get whatever the user wants to be used to pick out files or '*'   */
parse var input match input
if match = '*' then lmatch = 0
else lmatch = 1

/* Set up the default for the execution variable                     */
exec = 0

/* Now check for optional arguments and process them all             */
do while length(input) > 0
  parse var input opt input

/* Right now EXEC is the only one recognized so it is easy           */
  if opt = 'EXEC' then exec = 1

/* Say we  don't recognize the argument and leave                    */
  else do
    say 'Unrecognized optional argument.'
    exit 4
    end

  end

/* Report on the status of the execution of the command              */
if exec = 0 then say 'This will be a list only run.'
else do
  say 'This run is for real, break out if this is not desired.'
  say 'Please type enter if you are willing to suffer the consequences.'
  parse pull ans
  end

/* Set the outtrap capture and issue the LISTC to get file names     */
cmd = 'listc lev('lev')'
x = outtrap('line.','*')
cmd
x = outtrap('OFF')

/* If there were no files with the req'd name, we're done            */
if pos('NOT FOUND',line.1) > 0 then do
  say 'There was no return from the command:' cmd
  exit 4
  end

/* Let the user know how many lines were returned                    */
say 'There were' line.0 'lines returned from the command.'

/* Initialize command count                                          */
ocmd = 0

/* Now go ahead and process all the files listed                     */
do i = 1 to line.0

/* Make sure the vevel name is on this line                          */
  x = pos(lev,line.i)
  if x > 1 then do
    orig = substr(line.i,x)

/* If we are supposed to check for another match, do it else go on   */
    if ( lmatch = 0 ) | ( pos(match,orig) > 0 ) then do

/* Make the command and print it out in any case                     */
      cmd = first || "'"orig"'" || last
      say cmd
      ocmd = ocmd + 1

/* If we are supposed to execute the command do it now               */
      if exec > 0 then cmd
      end
    end
  end

/* Say how many commands were executed in all                        */
say ''
say 'There were' ocmd 'commands generated.'

