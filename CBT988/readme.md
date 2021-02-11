```
//***FILE 988 is from Shmuel (Seymour) Metz and contains his        *   FILE 988
//*           OS/360 Storage ZAP program called MZAP.               *   FILE 988
//*           I realize that not too many people run OS/360         *   FILE 988
//*           or SVS nowadays, although some people do run          *   FILE 988
//*           a OS/360 Turnkey system under Hercules.               *   FILE 988
//*                                                                 *   FILE 988
//*       "MOREZAP (MZAP) is a replacement for COREZAP0 that can    *   FILE 988
//*       locate csects by name in the jobpack, linkpack and        *   FILE 988
//*       nucleus. It can be assembled for OS/360 or for OS/VS2     *   FILE 988
//*       R1 (SVS); it may require changes for OS/VS1. It can       *   FILE 988
//*       locate various system control blocks and can display      *   FILE 988
//*       storage either as raw hex+EBCDIC or with opcode           *   FILE 988
//*       deciphering for, e.g., S/360, S/370 and compatibility     *   FILE 988
//*       features.  There is a COPY file that must be tailored     *   FILE 988
//*       prior to assembly.  MZAP process all VER statements       *   FILE 988
//*       prior to any ZAP statements, relying on SSM for           *   FILE 988
//*       serialization.                                            *   FILE 988
//*                                                                 *   FILE 988
//*       MZAP can also follow pointer chains.                      *   FILE 988
//*                                                                 *   FILE 988
//*       The code would need significant changes to support MVS;   *   FILE 988
//*       feel free to contact Shmuel (Seymour J.) Metz             *   FILE 988
//*       <smetz3@gmu.edu> if you wish guidance."                   *   FILE 988
//*                                                                 *   FILE 988
//*       Member MZAPMVS supplies some notes from Shmuel Metz       *   FILE 988
//*       advising some of the things needed to adapt the code      *   FILE 988
//*       either to MVS 3.8 or to z/OS.                             *   FILE 988
//*                                                                 *   FILE 988
//*       The material is being placed here in the hope that:       *   FILE 988
//*                                                                 *   FILE 988
//*       1.  A few of the OS/360 buffs might find it useful.       *   FILE 988
//*                                                                 *   FILE 988
//*       2.  Someone might modernize it, perhaps to the MVS 3.8    *   FILE 988
//*           level, or even to z/OS.  See member $$NOTE01.         *   FILE 988
//*                                                                 *   FILE 988
//*       email:  Shmuel (Seymour J.) Metz<smetz3@gmu.edu>          *   FILE 988
//*                                                                 *   FILE 988
//*       web  :  http://mason.gmu.edu/~smetz3                      *   FILE 988
//*                                                                 *   FILE 988

```
