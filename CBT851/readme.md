```
//***FILE 851 is from Fred Schmidt and contains his tool to create  *   FILE 851
//*           tape copying JCL that copies one tape to another.     *   FILE 851
//*           His package is called RMMCOPY.                        *   FILE 851
//*                                                                 *   FILE 851
//*       email:  Fred.Schmidt@nt.gov.au                            *   FILE 851
//*                                                                 *   FILE 851
//*             Notes for running the RMMCOPY tool                  *   FILE 851
//*                                                                 *   FILE 851
//*     Introduction.                                               *   FILE 851
//*                                                                 *   FILE 851
//*     The RMMCOPY tool was written to copy all files from one     *   FILE 851
//*     tape to another, for tapes managed by RMM.  Whilst this     *   FILE 851
//*     is a simple process to do manually via a batch job, with    *   FILE 851
//*     modern tapes able to contain many thousands of files, a     *   FILE 851
//*     manual approach soon becomes very cumbersome.  There are    *   FILE 851
//*     commercial products available to copy tapes, however,       *   FILE 851
//*     that costs money. This tool was written to perform such     *   FILE 851
//*     a copy without having to purchase a package. The tool       *   FILE 851
//*     should copy tapes with all valid block sizes at the time    *   FILE 851
//*     of writing, including up to 256K.                           *   FILE 851
//*                                                                 *   FILE 851
//*     The tool copies all DCB attributes and the expiry date      *   FILE 851
//*     from the source tape's datasets. You can override the       *   FILE 851
//*     expiry date to a single fixed value, for all datasets,      *   FILE 851
//*     by modifying the settings in the RMMEXEC (see below for     *   FILE 851
//*     details).                                                   *   FILE 851
//*                                                                 *   FILE 851
//*     One restriction that the tool has, is that where there      *   FILE 851
//*     are more than 255 files on the tape to be copied, the       *   FILE 851
//*     output tape must first have a dummy file written to it,     *   FILE 851
//*     so that its VOLSER is known. This is required because a     *   FILE 851
//*     maximum of 255 steps are permitted in a job. Since there    *   FILE 851
//*     is no DD referback mechanism available between jobs, the    *   FILE 851
//*     VOLSER of the output tape must be known in advance and      *   FILE 851
//*     available to the subsequent jobs. The result of this        *   FILE 851
//*     approach is that all files on such an output tape appear    *   FILE 851
//*     one file sequence number later than they do on the input    *   FILE 851
//*     tape.                                                       *   FILE 851
//*                                                                 *   FILE 851

```
