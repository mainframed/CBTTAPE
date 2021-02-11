#!/bin/bash
# Attempts to generate CBTTAPE folder readme.md for github
# License GPL2
# Soldier of FORTRAN
reset
for i in $(find -mindepth 2 -type d|sort); do
    echo "[+] In $i"
    if ls "$i" |grep -q '@FILE.*'; then
            cbt_file=$(ls "$i" |grep '@FILE.*')
            root_dir=$(echo $i|awk -F/ '{print "./"$2"/"}')
            #touch $root_dir/readme.md
            echo '```' > $root_dir/readme.md
            for f in $cbt_file; do
                echo "[+] Copying $f to $root_dir/readme.md"
                cat "$i/$f" >> $root_dir/readme.md
                echo ""  >> $root_dir/readme.md
            done
            echo '```' >> $root_dir/readme.md
    fi

    if ls "$i" |grep -q '\$.*README.*'; then
        readme=$(ls "$i" |grep '\$.*README.*')
    elif ls "$i" |grep -q '\$.*READ.*'; then
        read=$(ls "$i" |grep '\$.*READ.*')
    elif ls "$i"|grep -q '\$.*DOC.*' ; then
        doc=$(ls "$i"|grep '\$.*DOC.*')
    elif ls "$i" |grep -q '@FILE.*'; then
        cbt_file2=$(ls "$i" |grep '@FILE.*')
    fi

    files="$readme $read $doc $cbt_file2"
    if [ ${#files} -ge 4 ]; then
        echo '' > $i/"readme.md"
        for f in $files; do
            echo "[+] Copying $f to $i/readme.md"
            echo "## $f" >> $i/"readme.md"
            echo '```' >> $i/"readme.md"
            cat "$i/$f" >> $i/"readme.md"
            echo '```' >> $i/"readme.md"
            echo >> $i/"readme.md"
        done
    fi
    files=''
    readme=''
    read=''
    doc=''
    cbt_file2=''
done