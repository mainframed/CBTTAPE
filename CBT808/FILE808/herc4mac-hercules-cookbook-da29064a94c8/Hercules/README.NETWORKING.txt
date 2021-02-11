
to use networking   install tuntap from
                    http://tuntaposx.sourceforge.net

and remember to...
                    cd /dev
                    sudo chmod 777 tun*
                    in this way no need for hercules to run as sudo
                    ( the current implementation fo apple is buggy,
                      I will let You know when the fix is complete )

to avoid the hassle the tuntap sources can be changed
to create the tun/tap devices with 666 permissions

my CTC definition

0E20.2  CTCI    -n /dev/tun0 -s 255.255.255.0 192.168.0.115 192.168.0.110

remember ( for external network connectivity to

sudo arp -s xxx.xxx.xxx.xxx zz:zz:zz:zz:zz:zz pub

where   xxx...  is the guest ip address
        xx...   is the mac address of the interface


tests run

ping the guest
ping the host
ping a different MAC
ping a guest on a different mac
ping a linux running on a different MAC under parallels

ftp get/put for all the above
both form the guest and a MAC

ftp get from cbttape.org

