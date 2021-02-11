1. The SSLHAND program in JSSLHAND initiates Secure Socket Layer (SSL)
   session with the partner SSL server provided in the parameter by
   sending SSL client hello message.  The server will respond with
   SSL server hello message containing server certificate and
   optionally with Certificate request.  Following flow diagram is
   extracted from
   http://www.ietf.org/rfc/rfc2246.txt.

   -------------------------------------------------------------------
      Client                                       Server

      ClientHello                  -------->
                                                      ServerHello
                                                     Certificate*
                                               ServerKeyExchange*
                                              CertificateRequest*
                                   <--------      ServerHelloDone
      ::::::::::
   ------------------------------------------------------------------

   The SSLHAND program then formats the content supplied in Certificate
   and CertificateRequest and prints the output to SYSPRINT DD.  The
   public certificates found in the Certificate command will print
   to the SYSPRINT DD in Base64-encoded format for easy transportation.
   Finally, the SSLHAND program returns and let the TCPIP stack in z/OS
   to close the TCP/IP socket.

2. Program SSLHAND is developed and verified in z/OS v1.6 environment.
   Standard z/OS TCPIP API socket call, DFHSMS macros (OPEN, CLOSE,
   XLATE) are used.  Although the program uses AMODE 24 and RMODE 24,
   ESA/390 machine instructions are used.  This program does not
   require any external SSL library e.g. IBM z/OS System SSL (GSKSSL).
   Only IPv4 is supported.

3. To execute the SSLHAND program, you can refer to the JSSLHAND member,
   amend the JOB and SYSTCPD DD card to suit your executing environment.
   For SYSTCPD setting, you can refer to section 'Selecting a Stack When
   Running Multiple Instances of TCP/IP' in z/OS IBM Communications
   Server: IP Configuration Guide.  The SSL server IP address and TCP
   port number are supplied as parameter to SSLHAND program in EXEC
   DD card in the following format:
                    PARM='IPv4addr(port_num)'
      For example,  PARM='123.45.67.89(1414)'

4. This program is free to use via JSSLHAND member.  Feel free to send
   email message to sslhand@gmail.com for any comments.

5. Sample output SYSPRINT DD is attached.

SSLHAND V0.1: 64.233.189.83(443)
Server Hello received
 Version: 3
 Serial Number:
          1F19F6DE35DD63A142918AD52CC0AB12
 Signature Algorithm: sha1RSA
 Issuer:
          C=ZA
          O=Thawte Consulting (Pty) Ltd.
          CN=Thawte SGC CA
 Validity:
          NOT BEFORE=091218000000Z
           NOT AFTER=111218235959Z
 Subject:
          C=US
          ST=California
          L=Mountain View
          O=Google Inc
          CN=mail.google.com
 Subject Public Key Algorithm: RSA
 Subject Public Key:
          0030818902818100D927C811F27BE445C946B6637583B1777E174189
          8038F14527A03CD9E8A8004BD907D0BADEEDF42CA6ACDC2713EC0CC1
          A6991742E68D27D28114B04B82FAB2C5D0BB20596228A396B561F676
          C16D46D2FDBAC60F3DD1C9779A5833F6067632AD515F295F6EF8128B
          ADE6C50839B34343A95B911DD7E3CF51DF75598E8D80AB5302030100
          01
 Signature Algorithm: sha1RSA
 Signature:
          0089C8EEEDF7B1CBEC913F676BC79ED372AA3E044951D42887359D67
          84F992F504996AE74303C8F2DB920F556BE31206AAD771EBA341E0DF
          664D54AE77A9C5F08D6B6708045EA23BCDC23EBFC750A2AB907A0FB1
          3A7A260349F5C9F3F6B6BD1E486E063CF67ABEC2E1DA03ABECA47EAF
          351F38F313B7CF53D0EC1AC88E7610D40D
-----BEGIN CERTIFICATE-----
MIIDIjCCAougAwIBAgIQHxn23jXdY6FCkYrVLMCrEjANBgkqhkiG9w0BAQUFADBM
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEWMBQGA1UEAxMNVGhhd3RlIFNHQyBDQTAeFw0wOTEyMTgwMDAwMDBaFw0x
MTEyMTgyMzU5NTlaMGkxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlh
MRYwFAYDVQQHFA1Nb3VudGFpbiBWaWV3MRMwEQYDVQQKFApHb29nbGUgSW5jMRgw
FgYDVQQDFA9tYWlsLmdvb2dsZS5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBANknyBHye+RFyUa2Y3WDsXd+F0GJgDjxRSegPNnoqABL2QfQut7t9CymrNwn
E+wMwaaZF0LmjSfSgRSwS4L6ssXQuyBZYiijlrVh9nbBbUbS/brGDz3RyXeaWDP2
BnYyrVFfKV9u+BKLrebFCDmzQ0OpW5Ed1+PPUd91WY6NgKtTAgMBAAGjgecwgeQw
DAYDVR0TAQH/BAIwADA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnRoYXd0
ZS5jb20vVGhhd3RlU0dDQ0EuY3JsMCgGA1UdJQQhMB8GCCsGAQUFBwMBBggrBgEF
BQcDAgYJYIZIAYb4QgQBMHIGCCsGAQUFBwEBBGYwZDAiBggrBgEFBQcwAYYWaHR0
cDovL29jc3AudGhhd3RlLmNvbTA+BggrBgEFBQcwAoYyaHR0cDovL3d3dy50aGF3
dGUuY29tL3JlcG9zaXRvcnkvVGhhd3RlX1NHQ19DQS5jcnQwDQYJKoZIhvcNAQEF
BQADgYEAicju7fexy+yRP2drx57Tcqo+BElR1CiHNZ1nhPmS9QSZaudDA8jy25IP
VWvjEgaq13Hro0Hg32ZNVK53qcXwjWtnCAReojvNwj6/x1Ciq5B6D7E6eiYDSfXJ
8/a2vR5IbgY89nq+wuHaA6vspH6vNR848xO3z1PQ7BrIjnYQ1A0=
-----END CERTIFICATE-----
 Version: 3
 Serial Number:
          30000002
 Signature Algorithm: sha1RSA
 Issuer:
          C=US
          O=VeriSign, Inc.
          OU=Class 3 Public Primary Certification Authority
 Validity:
          NOT BEFORE=040513000000Z
           NOT AFTER=140512235959Z
 Subject:
          C=ZA
          O=Thawte Consulting (Pty) Ltd.
          CN=Thawte SGC CA
 Subject Public Key Algorithm: RSA
 Subject Public Key:
          0030818902818100D4D367D08D157FAECD31FE7D1D91A13F0B713CAC
          CCC864FB63FC324B0794BD6F80BA2FE10493C033FC093323E90B742B
          71C403C6D2CDE22FF50963CDFF48A500BFE0E7F388B72D32DE9836E6
          0AAD007BC4644A3B847503F270927D0E62F521AB693684317590F8BF
          C76C881B06957CC9E5A8DE75A12C7A68DFD5CA1C8758601902030100
          01
 Signature Algorithm: sha1RSA
 Signature:
          0055AC63EADEA1DDD2905F9F0BCE76BE13518F93D9052BC81B774BAD
          6950A1EEDEDCFDDB07E9E83994DCAB72792F06BFAB8170C4A8EDEA53
          34EDEF1E53D906C7562BD15CF4D18A8EB42BB1379048084225C53E8A
          CB7FEB6F04D16DC574A2F7A27C7B603C77CD0ECE48027F012FB69B37
          E02A2A36DCD585D6ACE53F546F961E05AF
-----BEGIN CERTIFICATE-----
MIIDIzCCAoygAwIBAgIEMAAAAjANBgkqhkiG9w0BAQUFADBfMQswCQYDVQQGEwJV
UzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xNzA1BgNVBAsTLkNsYXNzIDMgUHVi
bGljIFByaW1hcnkgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMDQwNTEzMDAw
MDAwWhcNMTQwNTEyMjM1OTU5WjBMMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEWMBQGA1UEAxMNVGhhd3RlIFNHQyBD
QTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA1NNn0I0Vf67NMf59HZGhPwtx
PKzMyGT7Y/wySweUvW+Aui/hBJPAM/wJMyPpC3QrccQDxtLN4i/1CWPN/0ilAL/g
5/OIty0y3pg25gqtAHvEZEo7hHUD8nCSfQ5i9SGraTaEMXWQ+L/HbIgbBpV8yeWo
3nWhLHpo39XKHIdYYBkCAwEAAaOB/jCB+zASBgNVHRMBAf8ECDAGAQH/AgEAMAsG
A1UdDwQEAwIBBjARBglghkgBhvhCAQEEBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAX
BgNVBAMTEFByaXZhdGVMYWJlbDMtMTUwMQYDVR0fBCowKDAmoCSgIoYgaHR0cDov
L2NybC52ZXJpc2lnbi5jb20vcGNhMy5jcmwwMgYIKwYBBQUHAQEEJjAkMCIGCCsG
AQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMDQGA1UdJQQtMCsGCCsGAQUF
BwMBBggrBgEFBQcDAgYJYIZIAYb4QgQBBgpghkgBhvhFAQgBMA0GCSqGSIb3DQEB
BQUAA4GBAFWsY+reod3SkF+fC852vhNRj5PZBSvIG3dLrWlQoe7e3P3bB+noOZTc
q3J5Lwa/q4FwxKjt6lM07e8eU9kGx1Yr0Vz00YqOtCuxN5BICEIlxT6Ky3/rbwTR
bcV0oveifHtgPHfNDs5IAn8BL7abN+AqKjbc1YXWrOU/VG+WHgWv
-----END CERTIFICATE-----
Server hello done received
