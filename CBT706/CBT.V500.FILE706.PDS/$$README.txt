To install on OS/390 or z/OS:
   Edit and submit JCL in $01INST
   If successful, a file called sample.svg will be generated.
   You can either publish it using your mainframe web server or
   download it to your PC (in binary mode - it is already ASCII)
   and open it with Internet Explorer. Make sure you have installed
   the Adobe SVG Viewer plug-in for Internet Explorer first.

To transform XML to SVG on OS/390 or z/OS:
   Edit and submit JCL in $02TOSVG

To transform SVG to PNG, or JPEG, or TIFF on z/OS (ONLY):
   Edit and submit JCL in $03TOPNG
                       or $04TOJPG
                       or $05TOTIF

To install on a PC (and view the documentation and tutorial):
   (only tested on Windows, but should be ok on Linux)
1. Download ZIPDOCS (in binary mode) as file706.zip
2. Unzip file706.zip (retaining the directory structure)
3. Open the index.html file in Internet Explorer to view the
   documentation and tutorial
4. Use the linechart.xsl stylesheet in the src directory
   as per instructions in the html documentation
