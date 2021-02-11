        /* --------------------  rexx procedure  -------------------- *
         * Name:      txt2rtf                                         */
         ver = "1.13"
        /*                                                            *
         * Function:  Convert a mainframe sequential file to an       *
         *            RTF (rich text format) file that can then be    *
         *            transferred to a workstation and opened in      *
         *            any office word processing application.         *
         *                                                            *
         * Syntax:    %txt2rtf input output options                   *
         *                                                            *
         *             Where:                                         *
         *                                                            *
         *             input is the input data set name               *
         *                   or dd:ddname                             *
         *             output is the output data set name             *
         *                    or dd:ddname                            *
         *                                                            *
         *             optional options                               *
         *             CC                                             *
         *                   this is a switch and if coded will cause *
         *                   carriage control to be detected in this  *
         *                   input file regardless of the DCB         *
         *             NOCC                                           *
         *                   this is a switch and if coded will cause *
         *                   carriage control to NOT be detected.     *
         *             NOCONFIRM                                      *
         *                   this is a switch and if coded will cause *
         *                   all confirmation message to be suppressed*
         *             CONFIG dataset or DD:ddname                    *
         *                  references a configuration file with      *
         *                  txt2rtf keywords and parameters           *
         *                                                            *
         *                  syntax:                                   *
         *                  one or more keywords with parameters on   *
         *                  each line with no continuation supported  *
         *                                                            *
         *                  e.g.                                      *
         *                  CC                                        *
         *                  FONT 9                                    *
         *                  MARGINS .8/.8.5.5                         *
         *                                                            *
         *                  Note: You can over-ride any value in the  *
         *                        CONFIG using a keyword on the cmd.  *
         *                                                            *
         *             FONT size                                      *
         *                  from 1 to nn where 72 is 1 inch           *
         *             MARGINS left/right/top/bottom                  *
         *             METRIC                                         *
         *                   this is a switch and if coded will cause *
         *                   measurements to be in centimeters        *
         *             ORIENTATION Portrait or Landscape              *
         *             PAPER size                                     *
         *                   size is LETTER for 8.5 x 11              *
         *                           LEGAL  for 11 x 14               *
         *                           A4     for 8.27 x 11.7           *
         *                           widthXheight (e.g. 4x6)          *
         *             READONLY                                       *
         *                   this is a switch and if coded will set   *
         *                   the read-only flag in the rtf file       *
         *             NORTFXLATE                                     *
         *                   this is a switch and if coded prevent    *
         *                   RTF Translation on for special characters*
         *                   to that they will print in some charsets *
         *                      backslash                             *
         *                      curly bracket left                    *
         *                      curly bracket right                   *
         *                                                            *
         * Customization:  Find *custom* for local customizations     *
         *                                                            *
         * Note: Carriage control processing is based on the CC or    *
         *       NOCC keywords or based on the DCB of the input file. *
         *                                                            *
         * Author:    Lionel B. Dyck                                  *
         *            Internet: Internet: lbdyck@gmail.com            *
         *                                                            *
         * History:                                                   *
         *          2016-06-02 - Version 1.16                         *
         *                     - Update from Larry Slaten for basl    *
         *          2009-12-03 - Version 1.12                         *
         *                     - Update from Mario Robitaille         *
         *                       to report on non-zero returns        *
         *          2008-12-01 - Version 1.11                         *
         *                     - use quotes for x2c strings           *
         *          2008-09-01 - 1.10 remove never executed "exit"s   *
         *          2008-08-28 - 1.09 msgid correction                *  /*wls*/
         *                     - compiled exec - fix msgid problem    *
         *                     - uniform msgid                        *
         *          2008-06-27 - 1.08 add options support ver         *  /*wls*/
         *          2007-11-13 - 1.07 NLS support (see also XMITIPCU) *  /*wls*/
         *                       use variables instead of special     *
         *                       characters                           *
         *                     - use hardcoded default values or      *
         *                       use default values from xmitipcu     *
         *                       (depending on the existence of the   *
         *                       routine xmitipcu)                    *
         *                     - support explicit execute of TXT2RTF  *
         *                       by checking source and use of altlib *
         *          2007-01-22 - 1.06 Correction for merge lines      *  /*wls*/
         *          2006-03-09 - 1.05 from Billy Smith                *  /*wls*/
         *                       allow CONFIG options to be overridden*  /*wls*/
         *                       by command keyword usage             *
         *          2006-02-24 - 1.04 from Billy Smith                *  /*wls*/
         *                       added option to set line spacing     *  /*wls*/
         *          2006-01-26 - 1.03                                 *
         *                     - Correction for mach cc x'09'         *
         *                       thx to Robert Charlesworth           *
         *          2006-01-19 - 1.02                                 *
         *                     - Correct + CC if overlay is shorter   *
         *                       than the primary record              *
         *          2004-02-05 - 1.01                                 *
         *                     - Add font name local customization    *
         *          2004-02-05 - 1.00                                 *
         *                     - Change to version 1.00               *
         *                     - Correct font name (thx to wordpad)   *
         *          2004-01-24 - 0.16                                 *
         *                     - Correct overlay processing (+) if    *
         *                       line 2 is longer than line 1         *
         *          2004-01-23 - 0.15                                 *
         *                     - Correct processing for overlay +     *
         *          2004-01-12 - 0.14                                 *
         *                     - Correct NOXLATE to NORTFXLATE        *
         *          2003-12-30 - 0.13                                 *
         *                     - Correct test for readonly (rop) var  *
         *          2003-10-09 - 0.12                                 *
         *                     - Correct bug if margins but no left   *
         *                       margin coded                         *
         *          2003-09-30 - 0.11                                 *
         *                     - Correct bug if 1st line is just 1    *
         *                     - Detect recursive configs             *
         *          2003-09-23 - 0.10                                 *
         *                     - Add msgid to messages                *
         *          2003-09-17 - 0.09                                 *
         *                     - Add improved messages                *
         *          2003-09-16 - 0.08                                 *
         *                     - Add ISPF Panel                       *
         *          2003-09-13 - 0.07                                 *
         *                     - fix DD: for input and output         *
         *          2003-09-11 - 0.06                                 *
         *                     - fix DCB detection routine            *
         *                     - if first line is a + (no space) then *
         *                       ignore it                            *
         *          2003-09-11 - 0.05                                 *
         *                     - add NOCONFIRM option                 *
         *                     - Get CC option from DCB and override  *
         *                       with CC/NOCC                         *
         *          2003-09-11 - 0.04                                 *
         *                     - Overwrite output file if it exists   *
         *          2003-09-11 - 0.03                                 *
         *                     - Correct parameter parsing            *
         *          2003-09-11 - 0.02                                 *
         *                     - Correct output space alloc and       *
         *                       support output pds member            *
         *                     - Improve reporting                    *
         *                     - Correct carriage control processing  *
         *                     - Allow ORIENT as an abbreviation of   *
         *                       ORIENTATION                          *
         *          2003-09-09 - 0.01                                 *
         *                     - Cleanup (add CONFIG)                 *
         *          2003-09-08 - Creation                             *
         *                                                            *
         * ---------------------------------------------------------- */
         _x_ = sub_init() ;
         parse arg options

         if abbrev(options,"VER") = 1,
         then do ;
                    /* ----------------------------- *
                     * Get Current Version           *
                     * ----------------------------- */
                     return ver
              end;

        /* -------------------------------------------------------- *
         * Local Customization *custom*                             *
         *  Change FONTNAME from Courier New to Courier if you like *
         * -------------------------------------------------------- */
         fontname = "Courier New"

         if length(options) > 0 then
            parse arg input output options
         else do
              if sysvar('sysispf') = "ACTIVE" ,
                 then do
                        if rexxdsn /= "?" ,
                        then "altlib   act appl(exec) da('"rexxdsn"')"
                        call do_ispf
                        if rexxdsn /= "?" ,
                        then "altlib deact appl(exec)"
                        exit 0
                      end
                 else signal do_syntax
              end

         Start:
         if length(input) = 0 then do
            say msgid "Error: No input file specified."
            say msgid " try again...."
            signal do_syntax
            end

         if length(output) = 0 then do
            say msgid "Error: No output file specified."
            say msgid " try again...."
            signal do_syntax
            end

         input  = translate(input)
         output = translate(output)

         options = strip(options)
         save_options = options

        call set_defaults

        /* ---------------------------- *
         * Find DCB of the Input for CC *
         * ---------------------------- */
         if left(input,3) = "DD:" then do
            parse value input with "DD:"indd
            call listdsi indd "FILE"
            end
            else
            call listdsi input
         if right(sysrecfm,1) = "A" then do_cc = 1
         if right(sysrecfm,1) = "M" then do_cc = 1

        /* ----------------------------- *
         * Now process the other options *
         * ----------------------------- */
         do while length(options) > 0
            uoptions = translate(options)
            Select
              When word(uoptions,1) = "CONFIG" then do
                   config  = word(uoptions,2)
                   if wordpos(config,configs) = 0  then
                      configs = configs config
                   else do
                      say msgid "Error: Recursive CONFIG files"
                      say msgid "       Config" config "already specified."
                      say msgid "Exiting...."
                      exit 8
                      end
                   call add_log "CONFIG" config
                   options = delword(options,1,2)
                   drop cfg.
                   if left(config,3) = "DD:" then do
                      parse value config with "DD:"cdd
                      "Execio * diskr" cdd "(finis stem cfg."
                      end
                   else do
                        "Alloc f("rtfdd") shr reuse ds("config")"
                        "Execio * diskr" rtfdd "(finis stem cfg."
                        "Free  f("rtfdd")"
                        end
                   do ic = 1 to cfg.0
                   /* reverse concatenation of options to allow
                      individual parameters to follow and override
                      DD:CONFIG parms
                      options = strip(options cfg.ic) wlsb */
                      options = strip(cfg.ic)" "options
                      end
                   uoptions = translate(options)
                   end
              When word(uoptions,1) = "CC" then do
                   do_cc   = 1
                   call add_log "CC"
                   options = delword(options,1,1)
                   end
              When word(uoptions,1) = "NOCC" then do
                   do_cc   = null
                   call add_log "NOCC"
                   options = delword(options,1,1)
                   end
              When word(uoptions,1) = "FONT" then do
                   font = word(uoptions,2)
                   call add_log "FONT" font
                   options = delword(options,1,2)
                   end
              When word(uoptions,1) = "MARGINS" then do
                   margins = word(uoptions,2)
                   call add_log "MARGINS" margins
                   options = delword(options,1,2)
                   parse value margins with wleft"/"wright"/"wtop"/"wbottom
                   if wleft   <> null then left   = wleft
                   if wright  <> null then right  = wright
                   if wtop    <> null then top    = wtop
                   if wbottom <> null then bottom = wbottom
                   end
              When abbrev("ORIENTATION",word(uoptions,1),6) = 1 then do
                   orient  = word(uoptions,2)
                   call add_log "ORIENTATION" orient
                   options = delword(options,1,2)
                   end
              When word(uoptions,1) = "PAPER" then do
                   paper   = word(uoptions,2)
                   call add_log "PAPER" paper
                   options = delword(options,1,2)
                   end
              When word(uoptions,1) = "METRIC" then do
                   metric = "C"
                   call add_log "METRIC"
                   options = delword(options,1,1)
                   end
              When word(uoptions,1) = "READONLY" then do
                   readonly = "YES"
                   call add_log "READONLY"
                   options = delword(options,1,1)
                   end
              When abbrev("NORTFXLATE",word(uoptions,1),6) = 1 then do
                   xlate = "OFF"
                   call add_log "NORTFXLATE"
                   options = delword(options,1,1)
                   end
              When abbrev("NOCONFIRM",word(uoptions,1),3) = 1 then do
                   confirm = "OFF"
                   call add_log "NOCONFIRM"
                   options = delword(options,1,1)
                   end
              When word(uoptions,1) = "LINESPACE" then do                /*wls*/
                   linespace  = word(uoptions,2)                         /*wls*/
                   call add_log "LINESPACE" linespace                    /*wls*/
                   options = delword(options,1,2)                        /*wls*/
                   end                                                   /*wls*/
              Otherwise do
                        say msgid "Error: Invalid option found" ,
                             word(options,1)
                        say msgid "Exiting....."
                        exit 8
                        end
              end
            end

        /* -------------------------- *
         * Now read in the input data *
         * -------------------------- */
         if left(input,3) = "DD:" then do
            parse value input with "DD:"inddn
            "Execio * diskr" inddn "(Finis stem in."
            end
         else do
              "Alloc f("rtfdd") ds("input") shr reuse"
              "Execio * diskr" rtfdd "(Finis stem in."
              "Free  f("rtfdd")"
              end
         input_count = in.0

        /* ------------------------ *
         * Write out the RTF Header *
         * ------------------------ */
           call do_rtf_head
           n = out.0

        /* ----------------------------- *
         * Now process each input record *
         * ----------------------------- */
           do i = 1 to in.0
              in.i = strip(in.i,'t')
              call do_rtf
              end
           n = out.0
           do i = 1 to in.0
              if left(in.i,2) = x2c("FF FF") then iterate
              n = n + 1
              out.n = in.i
              if max < length(in.i) then
                 max = length(in.i)
              end
           out.0 = n

        /* ------------------------- *
         * Write out the RTF Trailer *
         * ------------------------- */
           call do_rtf_end
           output_count = out.0

        /* -------------------------------- *
         * Report on our processing options *
         * -------------------------------- */
         if confirm = null then do
            call add_msg "Starting TXT2RTF version" ver "processing."
            call add_msg " "
            call add_msg "User specified options:"
            do lc = 1 to opt.0
               call add_msg opt.lc
               end
            call add_msg " "
            call add_msg "Processing report:"
            call add_msg "Input:   " input
            call add_msg " records:" input_count
            call add_msg "Output:  " output
            call add_msg " records:" output_count
            if cc_type <> null then
               call add_msg "Carriage:" cc_type
            call add_msg "Font:    " font/2
            call add_msg "Margins: " margins_report
            if left(orient,1) = "L" then
               call add_msg "Orient:   Landscape"
            else
                call add_msg "Orient:   Portrait"
            call add_msg "Paper:   " paper pmeasure
            call add_msg "Linespace:   " linespace                       /*wls*/
            if readonly = "YES" then
               call add_msg "ReadOnly: Yes"
            if xlate = null then
               call add_msg "XLATE:    Yes"
            else
               call add_msg "XLATE:    No"
            call add_msg " "
            end

        /* ----------------------------- *
         * Now write out the output file *
         * ----------------------------- */
          if left(output,3) = "DD:" then do
             parse value output with "DD:"ddn
             "Execio * diskw" ddn "(Finis stem out."
             if rc > 0 then do
                if rc = 20 then do
                   say msgid " "
                   say msgid "severe error returned by EXECIO"
                   say msgid "Exiting...."
                   exit 8
                   end
                else call add_msg "Output data has been written" ,
                                  "but some data truncation has" ,
                                  "occurred due to a too small" ,
                                  "lrecl."
                end
             end
         else do
         if pos("(",output) > 0 then do
                                     dir = "dir(15)"
                                     if max < 256 then max = 256
                                     end
                                else dir = null
         if dir = null then disp = "new"
         if sysdsn(output) = "DATASET NOT FOUND"
             then disp = "new"
             else disp = "shr"
              "Alloc f("rtfdd") ds("output") reuse",
                    "spa(90,90) tr recfm(v b) lrec("max+8")" ,
                    "blksize(23998)" dir disp
              "Execio * diskw" rtfdd "(Finis stem out."
              "Free  f("rtfdd")"
          end

          if ispf = 1 then do
             call add_msg " "
             call add_msg "Completed processing" input "to" output
             "Alloc f("rtfdd") new spa(1,1) tr recfm(v b) lrecl(80)" ,
                    "ds("rtfdd")"
             "Execio * diskw" rtfdd "(finis stem log."
             Address ISPExec "Browse Dataset("rtfdd")"
             call msg 'off'
             "Del" rtfdd
             call msg 'on'
             return
             end
          else do
               do i = 1 to log.0
                  say msgid log.i
                  end
               end
          exit 0

        /* ----------------------------------------------------- *
         * Do_RTF_Head Routine.                                  *
         * put out rtf headers                                   *
         * -------------------------                             *
         * The paperw/etc numbers are in twips. 1440 per inch.   *
         * ----------------------------------------------------- */
         Do_RTF_Head:

        /* --------------------------------------------------------- *
         * Convert centimeters to inches if needed                   *
         * --------------------------------------------------------- */
         if metric = "C" then do
            top    = top * 0.3937
            bottom = bottom * 0.3937
            left   = left * 0.3937
            right  = right * 0.3937
            marg   = "Centimeters"
            end
         else marg = "Inches"

         margins_report = "Left:" left "Right:" right ,
                          "Top:" top "Bottom:" bottom ,
                          "in" marg
         left   = trunc(left   * 1440)
         right  = trunc(right  * 1440)
         top    = trunc(top    * 1440)
         bottom = trunc(bottom * 1440)
         orient = strip(translate(orient))

        /* ----------------------------------------------------- *
         * setup the paper size values (width/height)            *
         * ----------------------------------------------------- */
         paper = strip(translate(paper))
         if length(paper) = 0 then paper = translate(paper_size)
         width    = 12240
         pmeasure = " "
         Select
            when pos("X",paper) > 0 then do
                 parse value paper with w "X" h
                 paper = "Width" w "by Height" h
                 if metric = "C" then do
                    h = h * 0.3937
                    w = w * 0.3937
                    pmeasure = "in Centimeters"
                    end
                 height = h * 1440
                 width  = w * 1440
                 if pos('.',height)> 0 then
                    parse value height with height '.' .
                 if pos('.',width) > 0 then
                    parse value width with width '.' .
                 end
            when abbrev("LETTER",paper,3) = 1 then height = 15840
            when abbrev("LEGAL",paper,3) = 1 then height = 20160
            When paper = "LTR" then height = 15840
            When paper = "LGL" then height = 20160
            When paper = "A4"  then do
                 width  = 11908
                 height = 16833
                 end
            otherwise do
                      if strip(paper) <> null then
                      call add_msg "Invalid paper size:" paper ,
                                "default Letter used."
                      height = 15840
                      end
            end

         n = out.0 + 1
         _out_ = ""brcl
         _out_ = _out_""basl"rtf1"basl"ansi"basl"ansicpg1252"
         _out_ = _out_""basl"deff0"basl"deflang1033"basl"deftab720"
         out.n = _out_ ; _out_ = ""
         n     = n + 1
         _out_ = ""brcl
         _out_ = _out_""basl"fonttbl"basl"f0"basl"fmodern"
         _out_ = _out_""basl"fprq1"basl"fcharset0" fontname";"brcr
         out.n = _out_ ; _out_ = ""
         if left(orient,1) = "L" then do
             n      = n + 1
             out.n  = ""basl"landscape"
             h      = width
             width  = height
             height = h
             end
         n     = n + 1
         out.n = basl"paperw"width""basl"paperh"height""basl"horzdoc"
         n     = n + 1
         _out_ = basl"margl"left""basl"margr"right
         _out_ = _out_""basl"margt"top""basl"margb"bottom
         out.n = _out_ ; _out_ = ""
         n     = n + 1
         /* font is in 1/2 points thus 18 = 9 points */
         font = font*2
         out.n = ""basl"pard"basl"plain"basl"f0"basl"fs"trunc(font)
         Select                                                          /*wls*/
            when linespace = 1 then nop                                  /*wls*/
            when linespace = 0 then do                                   /*wls*/
                    out.n = out.n""basl"sl"                              /*wls*/
                    out.n = out.n"-"trunc(font)*10                       /*wls*/
                    out.n = out.n""basl"slmult0"                         /*wls*/
                 end                                                     /*wls*/
            otherwise do                                                 /*wls*/
                    out.n = out.n""basl"sl"                              /*wls*/
                    out.n = out.n""trunc(linespace*240)                  /*wls*/
                    out.n = out.n""basl"slmult1"                         /*wls*/
            end                                                          /*wls*/
         end                                                             /*wls*/
         if readonly = "YES" then do
            n     = n + 1
            out.n = ""basl"annotprot"
            end
         out.0 = n
         return

        /* ----------------------------------------------------- *
         * Do_RTF Routine                                        *
         * setup rtf record                                      *
         *                                                       *
         * If Do_CC  = 1 then:                                   *
         *  1 in column 1 gets page eject                        *
         *    except for the first record in the file            *
         *  0 in column 1 gets space 1 line                      *
         *  - in column 1 gets space 2 lines                     *
         *  + in column 1 gets data merged into previous line    *
         *  other in col 1 treated as a 0                        *
         * ----------------------------------------------------- */
         Do_RTF:
         /* ----------------------------------------------------- *
          * convert                                               *
          *   backslash  curly-bracket-left  curly-bracket-right  *
          *     so they will print                                *
          * ----------------------------------------------------- */
         if xlate = null then do
            Call RTFXlate in.i
            in.i = strout
            end

         /* - insert the RTF control */
         if do_cc = 1 then do
         if cc_type = null then do
            if pos(left(in.i,1),"01-+ ") > 0 then
               cc_type = "ASA"
            if pos(left(in.i,1),x2c("89 8B 11 13 19 1B")) > 0 then
               cc_type = "Machine"
            end
         Select
            when left(in.i,1) = "1" then do
                 if i > 1 then
                    in.i = ""basl"page" substr(in.i,2)
                 else
                    in.i = substr(in.i,2)
                 if length(in.i) = 0 then in.i = " "
                 end
            when left(in.i,1) = "0" then
                 in.i = ""basl"line"basl"par" substr(in.i,2)
            when left(in.i,1) = "-" then
                 in.i = ""basl"line"basl"line"basl"par" substr(in.i,2)
            when left(in.i,1) = "+" then do
                 ip = i - 1
                 if ip > 0 then do
                    parse value in.ip with rtftag i1
                    l1 = length(i1)
                    i2 = substr(in.i,2)
                    l1 = max(l1,length(i2))
                    if i1 <> i2 then
                       i1 = left(i1,l1,' ')
                       do c = 1 to l1
                          c1 =  substr(i2,c,1)
                          if substr(i1,c,1) = " " then
                             i1 = overlay(c1,i1,c)
                          end
                    in.ip = rtftag i1
                    end
                 in.i = x2c("FF FF")
                 end
            when left(in.i,1) = " " then
                 in.i = ""basl"par" substr(in.i,2)
        /* --------------------------------------------------------- *
         * Process Machine Carriage Control - revised & corrected    *
         * --------------------------------------------------------- */
            when left(in.i,1) = '89'x then do
                 if i > 1 then
                    in.i = substr(in.i,2) ""basl"page"
                 else
                    in.i = substr(in.i,2)""basl"line"
                 end
            when left(in.i,1) = '8B'x then
                 if i > 1 then
                    in.i = ""basl"page" substr(in.i,2)
                 else
                    in.i = substr(in.i,2)""basl"line"
            when left(in.i,1) = '09'x then
                 in.i = substr(in.i,2) ""basl"par"
            when left(in.i,1) = '11'x then
                 in.i = substr(in.i,2) ""basl"line"basl"par"
            when left(in.i,1) = '13'x then
                 in.i = ""basl"line"basl"par" substr(in.i,2)
            when left(in.i,1) = '19'x then
                 in.i = substr(in.i,2) ""basl"line"basl"line"basl"par"
            when left(in.i,1) = '1B'x then
                 in.i = ""basl"line"basl"line"basl"par" substr(in.i,2)
            otherwise in.i = ""basl"par" substr(in.i,2)
            end
         end
         else in.i = ""basl"par" in.i
         return

        /* ----------------------------------------------------- *
         * Do_RTF_End Routine                                    *
         * put out rtf trailer                                   *
         * ----------------------------------------------------- */
         Do_RTF_End:
         n = out.0 + 1
         out.n = ""basl"par "brcr""brcr""
         out.0 = n
         return

         /*
          * =========================================================
          * Routine:       RTFXlate    : Escapes characters within
          *                            : text
          * Arguments:     strData     : Data to scan
          * Return:        strData     : Updated data
          * Exposed vars:  (all)       : All
          * ========================================================
         */
         RTFXlate:
         PARSE ARG strData

           /* ======================================================
            * The characters we need to escape
           */
           strFrom = ""brcl""brcr""basl""

           /* ======================================================
            * Loop, prefixing all above characters with a
            * a backslash
           */
           strOut = ""
           DO UNTIL numPos = 0
             numPos =  Verify( strData, strFrom, "Match" )
             IF numPos <> 0 THEN DO
               strChar = Substr( strData, numPos, 1 )
               PARSE VAR strData strLeft (strChar) strData
               strOut = strOut""strLeft""basl""strChar
              END
            END
            strOut = strOut""strData

            /* =====================================================
             * Return escaped data
            */
          RETURN strOut

        /* ----------------------- *
         * Do the ISPF Dialog here *
         * ----------------------- */
         Do_ISPF:
         Address ISPExec
         "Vget (zapplid)"
         if zapplid <> "T2R" then do
            "Select CMD("myname" "options ") Newappl(T2R)" ,
                "passlib scrname(TXT2RTF)"
            return 0
            end
         call set_defaults
         ispf = 1
         "Vget (pinput poutput pcc pfont pleft pright ptop pbottom " ,
              "ppaper rop porient plinespc) profile"
         if pfont   = null then pfont = font
         if pleft   = null then pleft = left
         if pright  = null then pright = right
         if ptop    = null then ptop   = top
         if pbottom = null then pbottom = bottom
         if ppaper  = null then ppaper  = paper
         if porient = null then porient = orient
         if plinespc = null then plinespc = linespace                    /*wls*/
         do forever
            "Display Panel(txt2rtf)"
            if rc > 0 then do
               zedsmsg = "Complete"
               zedlmsg = "TXT2RTF dialog processing completed."
               "Setmsg msg(isrz001)"
               return 0
               end
            "Vput (pinput poutput pcc pfont pleft pright ptop pbottom " ,
                  "ppaper rop porient) profile"
            input  = pinput
            output = poutput
            options = "Font" pfont
            if translate(pcc) = "YES" then
               options = options "CC"
            if translate(pcc) = "NO" then
               options = options "NOCC"
            if pleft <> null then
               options = options "MARGINS" pleft"/"pright"/"ptop"/"pbottom
            if porient <> null then
               options = options "ORIENT" porient
            if ppaper <> null then
               options = options "PAPER" ppaper
            if plinespc <> null then                                     /*wls*/
               options = options "LINESPACE" plinespc                    /*wls*/
            if translate(rop) = "YES" then
               options = options "READONLY"
            Address TSO
            call start
            Address ISPEXEC
            end

        /* ----------------------- *
         * Display Syntax and Exit *
         * ----------------------- */
         Do_Syntax:
         say msgid " "
         say msgid left("*",50,"*")
         say msgid "Syntax error in TXT2RTF"
         say msgid " "
         say msgid "The correct syntax is:"
         say msgid " "
         say msgid "%txt2rtf input_dsn output_dsn options:"
         say msgid " "
         say msgid "Valid options are:"
         say msgid " CC or NOCC"
         say msgid " NOCONFIRM"
         say msgid " CONFIG dataset"
         say msgid " or "
         say msgid " CONFIG DD:ddname"
         say msgid " FONT nn"
         say msgid " MARGINS left/right/top/bottom"
         say msgid " ORIENTATION PORTRAIT or LANDSCAPE"
         say msgid " METRIC "
         say msgid " PAPER LETTER or LEGAL or A4 or widthXheight"
         say msgid " LINESPACE (0 thru 3 in 0.5 increments"              /*wls*/
         say msgid " READONLY"
         say msgid " NORTFXLATE"
         exit 8

        /* ------------------- *
         * Define our defaults *
         * ------------------- */
         Set_Defaults:
         parse value "" with null readonly xlate out. ,
                        paper_size font_size metric def_orient ,
                        mtop mbottom mleft mright ,
                        cc_type confirm do_cc log. opt. configs

         _x_ = sub_codepage_set()
         codepage = codepage_num

         out.0  = 0
         log.0  = 0
         opt.0  = 0

         if   mleft   = "" ,
         then  left   = .5
         else  left   = mleft
         if   mright  = "" ,
         then  right  = .5
         else  right  = mright
         if   mtop    = "" ,
         then  top    = .5
         else  top    = mtop
         if   mbottom = "" ,
         then  bottom = .5
         else  bottom = mbottom
         if font_size = "" ,
         then font = 9          /* font size */
         else font = font_size  /* font size */
         if def_orient = "" ,
         then orient = "P"
         else orient = def_orient
         linespace = "1"                                                 /*wls*/
         if paper_size = "" ,
         then paper  = "LETTER"
         else paper  = ""paper_size

         rtfdd  = "RTF"random(9999)
         max    = 80

         return

        /* -------------------------- *
         * Add Options to Options Log *
         * -------------------------- */
         Add_Log: procedure expose opt. ispf
         parse arg msg
         c = opt.0 + 1
         opt.c = ">" msg
         opt.0 = c
         return

        /* -------------------------- *
         * Add Message to Message Log *
         * -------------------------- */
         Add_Msg: procedure expose log. ispf
         parse arg msg
         c = log.0 + 1
         log.c = msg
         log.0 = c
         return

sub_init:
  /* to get the correct name for MSGID don't use other cmds before */
  parse source ,
    rexxenv rexxinv rexxname rexxdd rexxdsn . rexxtype addrspc .

  myname = rexxname
  if myname = "?" ,
  then do ;
           myname = sysvar("sysicmd")
           if length(myname) = 0 ,
           then  myname = sysvar("syspcmd")
       end;
  msgid = left(myname": ",9)

 return 0

 /* -------------------------------------------------------------- *
  * set the codepage                                               *
  * -------------------------------------------------------------- */

 sub_codepage_set: procedure expose ,
   codepage_num codepage_chars ,
         paper_size font_size metric def_orient ,
         mtop mbottom mleft mright ,
   excl basl diar brsl brsr brcl brcr hash

   cc_excl          = x2c("5A")
   cc_brcl          = x2c("C0")
   cc_brcr          = x2c("D0")
      excl          = x2c("5A")
      basl          = x2c("E0")  /* Larry Slaten */
      brcl          = x2c("C0")
      brcr          = x2c("D0")
   SpecialChars     = x2c("5A E0 72 AD BD C0 D0 7B")
   codepage_num     = "00037"
   codepage_chars   = ""SpecialChars
   codepage_default = ""codepage_num" "codepage_chars
   codepage_default = ""
   encoding_default = "WINDOWS-1252"
        sep_default = ","
 /* return 0 */ /* remove the comment to deactivate xmitipcu */

 /* check xmitipcu existence and get data                */
 /*   use a sub routine to continue processing if error  */
 cu = sub_check_xmitipcu() ;

 if datatype(cu) = "NUM" ,
 then do ;
           nop ;
      end;
 else do ;
        /* ----------------------------------------------------- *
         * Invoke XMITIPCU for local customization values        *
         * ----------------------------------------------------- */
        cu = xmitipcu()
        if datatype(cu) = "NUM" then exit cu

        /* ----------------------------------------------------- *
         * parse the customization defaults to use them here     *
         * ----------------------------------------------------- *
         * parse the string depending on the used separator      *
         * ----------------------------------------------------- */
        if left(cu,4) = "SEP=" ,
        then do ;
                 parse var cu "SEP=" _s_ cu
                 _s_val_d_ = c2d(_s_)
                 _s_val_x_ = c2x(_s_)
             end;
        else     _s_ = left(strip(cu),1)

        parse value cu with ,
             (_s_) _center_ (_s_) zone (_s_) smtp ,
             (_s_) vio (_s_) smtp_secure (_s_) smtp_address ,
             (_s_) smtp_domain (_s_) text_enter ,
             (_s_) sysout_class (_s_) from_center (_s_) writer ,
             (_s_) mtop (_s_) mbottom (_s_) mleft (_s_) mright ,
             (_s_) tcp_hostid (_s_) tcp_name (_s_) tcp_domain ,
             (_s_) tcp_stack  ,
             (_s_) from_default ,
             (_s_) append_domain (_s_) zip_type (_s_) zip_load ,
             (_s_) zip_hlq (_s_) zip_unit ,
             (_s_) interlink (_s_) size_limit ,
             (_s_) batch_idval (_s_) create_dsn_lrecl ,
             (_s_) receipt_type (_s_) paper_size ,
             (_s_) file_suf (_s_) force_suf ,
             (_s_) mail_relay (_s_) AtSign ,
             (_s_) ispffrom (_s_) fromreq ,
             (_s_) char (_s_) charuse (_s_) disclaim (_s_) empty_opt ,
             (_s_) font_size (_s_) def_orient ,
             (_s_) conf_msg (_s_) metric ,
             (_s_) descopt (_s_) smtp_method (_s_) smtp_loadlib ,
             (_s_) smtp_server (_s_) deflpi (_s_) nullsysout ,
             (_s_) default_hlq (_s_) msg_summary (_s_) site_disclaim ,
             (_s_) zipcont (_s_) feedback_addr (_s_) rfc_maxreclen ,
             (_s_) restrict_domain (_s_) log ,
             (_s_) faxcheck (_s_) tpageend (_s_) tpagelen,
             (_s_) from2rep (_s_) dateformat (_s_) validfrom ,
             (_s_) systcpd (_s_) restrict_hlq (_s_) default_lang ,
             (_s_) disable_antispoof (_s_) special_chars ,
             (_s_) send_from (_s_) Mime8bit ,
             (_s_) jobid (_s_) jobidl (_s_) custsym ,
             (_s_) codepage_default ,
             (_s_) encoding_default (_s_) encoding_check ,
             (_s_) check_send_from ,
             (_s_) check_send_to ,
             (_s_) smtp_array ,
             (_s_) txt2pdf_parms ,
             (_s_) xmitsock_parms ,
             (_s_) xmitipcu_infos ,
             (_s_) antispoof (_s_)(_s_) cu_add
                   /*   antispoof is always last         */
                   /*   finish CU with double separator  */
                   /*   cu_add for specials ...          */

        /* ------------------------------------------------------ *
         * Now remove any leading/trailing blanks from the values *
         * ------------------------------------------------------ */
         special_chars = special_chars
         codepage_num  = strip(word(special_chars,1))
         sp_chars      = strip(word(special_chars,2))
         excl          = substr(sp_chars,1,1)
         basl          = substr(sp_chars,2,1)
         diar          = substr(sp_chars,3,1)
         brsl          = substr(sp_chars,4,1)
         brsr          = substr(sp_chars,5,1)
         brcl          = substr(sp_chars,6,1)
         brcr          = substr(sp_chars,7,1)
         hash          = substr(sp_chars,8,1)
         paper_size    = strip(paper_size)
         font_size     = strip(font_size)
         metric        = strip(metric)
         def_orient    = strip(def_orient)
         mtop          = strip(mtop)
         mbottom       = strip(mbottom)
         mleft         = strip(mleft)
         mright        = strip(mright)
      end;
   return 0

 sub_check_xmitipcu:
   signal on  syntax name sub_check
   cu = xmitipcu() ;
   signal off syntax
   return cu

 sub_check:

  signal off novalue        /* Ignore no-value variables within trap */
  trap_errortext = 'Not Present'/* Error text available only with RC */
  trap_condition = Condition('C')              /* Which trap sprung? */
  trap_description = Condition('D')               /* What caused it? */
  trap_rc = rc                          /* What was the return code? */
  if datatype(trap_rc) = 'NUM' then     /* Did we get a return code? */
     trap_errortext = Errortext(trap_rc)    /* What was the message? */
  trap_linenumber = sigl                     /* Where did it happen? */
  trap_line = sourceline(trap_linenumber)  /* What is the code line? */
  trap_line = strip(space(trap_line,1," "))

  _code_ = 999
  rcode = sub_specials(_code_)
  if rcode < _code_ ,
  then do ;
           return rcode
       end;

  if value(contact) = "CONTACT" ,
  then contact = "your contact"
  ER. = ''                           /* Initialize error output stem */
  ER.1 = ' '
  ER.2 = 'An error has occurred in Rexx module:' myname
  ER.3 = '   Error Type        :' trap_condition
  ER.4 = '   Error Line Number :' trap_linenumber
  ER.5 = '   Instruction       :' trap_line
  ER.6 = '   Return Code       :' trap_rc
  ER.7 = '   Error Message text:' trap_errortext
  ER.8 = '   Error Description :' trap_description
  ER.9 = ' '
  ER.10= 'Please look for corresponding messages '
  ER.11= '  and report the problem to 'contact'.'
  ER.12= ' '
  ER.0 = 12

  do i = 1 to ER.0                   /* Print error report to screen */
     say ER.i
  end /*do i = 1 to ER.0*/

  Exit 8

  /* ------------------------------------------------------------ *
   * special checks:                                              *
   *    get the failing command                                   *
   *    check whether processing can / should continue ...        *
   * here: check existence of xmitipcu                            *
   *       continue processing without messages                   *
   *       use hardcoded values or xmitipcu values                *
   * ------------------------------------------------------------ */
 sub_specials:
  parse arg ret_str
  _cmd_ = trap_line
  parse var _cmd_ 1 . "=" _cmd_ "/*" .
  parse var _cmd_ 1       _cmd_ ";"  .
  _cmd_ = space(translate(_cmd_,"",'"'),0)
  _cmd_upper_ = translate(_cmd_)
  txt.0 = 0
  select
    when ( _cmd_upper_ = translate("XMITIPCU()") ) ,
      then do ;
               ret_str = 4
               txt.1 = " "
               txt.2 = ""msgid"... "_cmd_
               txt.3 = ""msgid"... "trap_rc" - "trap_errortext
               txt.4 = ""msgid"... processing continues ..."
               txt.5 = " "
               txt.0 = 5
               txt.0 = 0  /* deactivate msg lines */
           end;
    when ( _cmd_upper_ = translate("SOCKET('terminate')") ) ,
      then do ;
               ret_str = 4
               txt.1 = " "
               txt.2 = ""msgid"... "_cmd_
               txt.3 = ""msgid"... "trap_rc" - "trap_errortext
               txt.4 = ""msgid"... processing continues ..."
               txt.5 = " "
               txt.0 = 5
           end;
    otherwise nop ;
  end;
           do i = 1 to txt.0
              say txt.i
           end
  return ret_str

