        /* --------------------  rexx procedure  -------------------- */
        ver = "0.6"
        /* Name:      txt2csv                                         *
         *                                                            *
         * Function:  program to convert a text file to csv format    *
         *                                                            *
         * Syntax:    %txt2csv input_dsn output_dsn c1 c2 ... / opt's *
         *            or                                              *
         *            txt2csv inputfile outputfile c1 c1 ... / opt's  *
         *                                                            *
         *            if z/OS:                                        *
         *            input_dsn   sequential or pds member            *
         *            output_dsn  sequential file to be created       *
         *                                                            *
         *            both accept DD:ddname to use a DD for input     *
         *            or output                                       *
         *                                                            *
         *            if z/VM                                         *
         *            inputfile   fn ft fm of input                   *
         *            outputfile  fn ft fm of output                  *
         *                        and '=' may be used for each fileid *
         *                            except for the fn               *
         *                                                            *
         *            c1 etc      column start position               *
         *                        (if preceeded by - then the column  *
         *                         is eliminated in the output)       *
         *            *           compacts blanks and convert them to *
         *                        the csv delimiter                   *
         *            /           a delimeter for following options   *
         *            debug       optional - also abbreviated         *
         *            csv csvchar desired csv separator 'csvchar'     *
         *                        instead of defaulted comma, it must *
         *                        be quoted when special character    *
         *                                                            *
         * Author:    Lionel B. Dyck                                  *
         *            E-Mail: lbdyck@gmail.com                        *
         *                                                            *
         * History:                                                   *
         *            05/31/16 - v0.6 minor bug fix                   *
         *                       thanks to Larry Slaten               *
         *            08/25/10 - v0.5 minor bug fix                   *
         *            08/23/10 - v0.4 add support for z/VM usage      *
         *                     - remove extraneous trailing comma's   *
         *                     - csv default character ',' now can be *
         *                       overriden by a parm / csv ';'        *
         *                       (update from Orazio Scaggion)        *
         *                     - '*' instead of column start positions*
         *                       causes compaction and replacing of   *
         *                       blanks with csv character.           *
         *                       (update from Orazio Scaggion)        *
         *            02/03/09 - v0.3 remove leading blank            *
         *                     - add version to report                *
         *            01/15/08 - v0.2 (update from David Clark)       *
         *                     - add code so that a colm prefixed by  *
         *                       a - will be skipped ex 2 8 -15 30    *
         *                       this would bypass data in 15-29     *
         *            01/08/08 - v0.1 converted from csvedit rexx code*
         *                                                            *
         * ---------------------------------------------------------- */

         parse source with a b c d e os
         if os /= 'CMS' then os = ''

        /* -------------------- *
         * Setup Default Values *
         * -------------------- */
         parse value "" with null inputdd outputdd out. csv  ,
                             ifn ift ifm ofn oft ofm
         outc  = 0
         wrkdd = "CSV"random(99)random(99)
         sep_default = ","

        /* -------------------------- *
         * Parse Execution Parameters *
         * -------------------------- */
         if os = '' then
         arg input output columns "/"debug
         else do
              arg ifn ift ifm ofn oft ofm columns "/"debug
              if oft = "=" then oft = ift
              if ofm = "=" then ofm = ifm
              end

        /* -------------------------- *
         * Check for input parameters *
         * -------------------------- */
         if os = ''
            then if length(input) = 0 then do
                say 'Invalid syntax - correct syntax is:'
                say ' '
                say '%txt2csv input_dsn output_dsn col1 col2 col3 ...'
                exit 8
                end
         if os /= ''
            then if length(ifn) = 0 then do
                say 'Invalid syntax - correct syntax is:'
                say ' '
                say 'txt2csv infn inft infm outfn outft outfm col1 col2 ...'
                exit 8
                end

        /* -------------------- *
         * Keep the user posted *
         * -------------------- */
         Say "TXT2CSV Processing has started. Version"  ver ,
             date() time()

        /* ------------------- *
         * Validate Parameters *
         * ------------------- */
         pos_debug = 0
         do i = 1 to words(debug)
            if abbrev('DEBUG',word(debug,i),1)
            then do
                 trace "?i"
                 pos_debug = i
                 leave
                 end
         end
         if pos_debug <> 0
         then csv = strip(delword(debug,pos_debug,1))
         else csv = strip(debug)

         pos_csv = wordpos('CSV',csv)
         if pos_csv <> 0
         then do
              csv = strip(delword(csv,pos_csv,1))
              qt = left(csv,1)
        /* check if csv is quoted by open and close parentheses or by
                                  single or double quotation marks   */
              if pos(qt,x2c('4d7d7f')) <> 0
              then csv = substr(csv,2,1) /* pair of quotes assumed */
              else csv = left(csv,1)     /* else it is not quoted  */
              end
         else csv = sep_default
         sep = csv

         if pos('*',columns) <> 0
         then ignore_columns = "and column values being ignored"
         else ignore_columns = null
         Say "CSV character:" sep
         Say "  " ignore_columns

         if os = '' then
         if input <> null then do
            if left(input,3) = "DD:"
               then do
                    parse value input with "DD:"inputdd
                    input = null
                    Say "Using Input DD:" inputdd
                    end
               else if sysdsn(input) <> "OK" then do
                    say "Error: Input DSN" sysdsn(input)
                    exit 16
                    end
                    else Say "Using Input DSN:" input
            end

         if os = '' then do
         if output <> null then do
            if left(output,3) = "DD:" then do
               parse value output with "DD:"outputdd
               output = null
               end
            if output = null
               then Say "Using Output DD: " outputdd
               else Say "Using Output DSN:" output
            end
         if outputdd = null
            then if sysdsn(output) = "OK"
            then do
                 Say "The output file" output
                 Say "currently exists - please rerun with a new" ,
                     "output data set name"
                 exit 16
                 end
                 end

        /* ---------------------- *
         * Read in the Input File *
         * ---------------------- */
         if os = '' then do
         if inputdd = null
            then do
                 "Alloc f("wrkdd") shr reuse ds("input")"
                 "Execio * diskr" wrkdd "(finis stem in."
                 "Free  f("wrkdd")"
                 end
            else "Execio * diskr" inputdd "(finis stem in."
            end
            else 'pipe <' ifn ift ifm '| stem in.'

         Say in.0 "Input records read in for processing"

        /* --------------------------------------------------------- *
         * Validate the provided input                               *
         * - test to ensure columns are sequential in order           *
         * --------------------------------------------------------- */
         if ignore_columns = null then,
         do col = words(columns) to 1 by -1
            ce  = abs(word(columns,col))       /* dgc */
            cm  = col - 1
            if cm < 1 then cm = col
            cp  = word(columns,cm)
            if cp > ce then do
               msg = "Column" col "value is not greater than the" ,
                      "column" col-1 "value."
               call do_msg
               end
            end

        /* --------------------------------------------------------- *
         * Now begin CSV conversion                                  *
         * --------------------------------------------------------- */
         line = 0
         do forever
            line = line + 1
            if line > in.0 then leave
            data = in.line
            record = null
            if ignore_columns = null then,
            do col = 1 to words(columns)
               if word(columns,col) < 0 then iterate       /* dgc */
               if abs(word(columns,col)) <> null then      /* dgc */
                  call do_csv word(columns,col) word(columns,col+1)
               end
            else /* ignore_columns <> null */ ,
               record = translate(space(data,1),sep," ")
            if left(record,1) = sep then
               record = substr(record,2)
            record   = strip(record,'t')
            outc     = outc + 1
            if right(record,1) = sep then
               record = left(record,length(record)-1)
            if right(record,1) = sep then
               record = left(record,length(record)-1)
            out.outc = record
            end

        /* ----------------------- *
         * Process the output file *
         * ----------------------- */
         out.0 = outc
         Say out.0 "Output records processed"

         if os = '' then do
         if outputdd = null then do
            lrecl = 80
            do i = 1 to out.0
               lrecl = max(lrecl,length(out.i))
               end
            Say "Creating Output file:" output
            "Alloc f("wrkdd") new ds("output")" ,
               "Recfm(v b) Lrecl("lrecl+4") Blksize(0)"
            "Execio * diskw "wrkdd" (finis stem out."
            "Free  f("wrkdd")"
            end
         else "Execio * diskw "outputdd" (finis stem out."
            end
         if os = 'CMS' then do
              'pipe  stem out. | >' ofn oft ofm
              end

        /* --------------------------------------------------------- *
         * Processing completed - inform the user.                   *
         * --------------------------------------------------------- */
         Say  "CSV Conversion completed."
         Say  "The file is now ready for download or"
         Say  "e-mail for import into Excel or other tool."
        Exit 0

        /* --------------------------------------------------------- *
         * Extract CSV Column Data                                   *
         * Then test it:                                             *
         *   - begins with a zero       = set to ="xxx"              *
         *   - contains a comma         = enclose in double quotes   *
         *   - contains a blank         = enclose in double quotes   *
         *   - contains the sep char    = enclose in double quotes   *
         *   - insert comma between values                           *
         * --------------------------------------------------------- */
         Do_CSV:
           arg start next
           start = abs(start)                   /* dgc */
           if next = null then
              work = strip(substr(data,start))
           else do
                next = abs(next)                /* dgc */
                work = strip(substr(data,start,next-start))
                end
           if length(work) = 0 then work = " "

           Select
             When pos(",",work) > 0 then work = '"'work'"'
             When pos(" ",work) > 0 then work = '"'work'"'
             When pos(sep,work) > 0 then work = '"'work'"'
             When left(work,1) = "0" then do
                  if lz = "YES" then
                     work = '="'work'"'
                  end
             otherwise nop
             end

           work = work""sep
           record = record""work
           return

        /* --------------------------------------------------------- *
         * Issue message and redisplay prompt                        *
         * --------------------------------------------------------- */
         do_msg:
            Say msg
            exit 16
