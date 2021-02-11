```
//***FILE 865 is a FREE zip/unzip program for MVS from Jason Winter *   FILE 865
//*           who used his JCC C-language compiler to port it to    *   FILE 865
//*           the MVS platform.  The zip program is called MINIZIP  *   FILE 865
//*           and the unzip program is called MINIUNZ.              *   FILE 865
//*                                                                 *   FILE 865
//*           MINIZIP and MINIUNZ (unzip) were incorporated into    *   FILE 865
//*           Greg Price's load module library (CBT File 135) for   *   FILE 865
//*           the use of unzipping sequential zip files which were  *   FILE 865
//*           to be browsed with the REVIEW program.                *   FILE 865
//*                                                                 *   FILE 865
//*           I have tried to package MINIZIP and MINIUNZ here,     *   FILE 865
//*           to be used independently for zipping and unzipping    *   FILE 865
//*           files under MVS.  They do have some limitations.      *   FILE 865
//*           See the supplied sample JCL in this file.             *   FILE 865
//*                                                                 *   FILE 865
//*           For now, it appears that the usefulness of these      *   FILE 865
//*           programs is for a shop that needs to handle zipped    *   FILE 865
//*           files on an MVS (z/OS) system and can't afford, or    *   FILE 865
//*           doesn't want to have to "trial" one of the expensive  *   FILE 865
//*           zipping/unzipping programs that are sold for MVS.     *   FILE 865
//*                                                                 *   FILE 865
//*           In our limited tests, it appears that MINIUNZ can     *   FILE 865
//*           unzip files that were zipped using other packages,    *   FILE 865
//*           correctly.  You will have to discover this for        *   FILE 865
//*           yourself.  Please report any discoveries back to      *   FILE 865
//*           us, so that we can improve the usefulness of this     *   FILE 865
//*           product for MVS (z/OS) shops.                         *   FILE 865
//*                                                                 *   FILE 865
//*           Belinda Tinsley has tested MINIZIP and MINIUNZ, and   *   FILE 865
//*           has developed JCL to make them work in batch jobs     *   FILE 865
//*           under z/OS.  See members $$NOTE0x.  JCL was tested    *   FILE 865
//*           by S.Golob.  See members ZIPxx and UNZxx.             *   FILE 865
//*                                                                 *   FILE 865
//*           email:  sbgolob@cbttape.org    or                     *   FILE 865
//*                   sbgolob@attglobal.net                         *   FILE 865
//*                                                                 *   FILE 865
//*           email:  belinda.tinsley@tnb.com                       *   FILE 865
//*                                                                 *   FILE 865
//*           email:  jasonwinter@hotmail.com                       *   FILE 865
//*                                                                 *   FILE 865

```
