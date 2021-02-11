#!/bin/bash
# Extract XMIT files recusively one folder down
# License GPL2
# Soldier of FORTRAN

reset
echo "[+] Extracting XMIT files like a balla"
for xmitfile in $(find ./ -iname "*.xmi*"|sort -h); do
	output_folder=$(dirname "$xmitfile")
	echo "================= "$xmitfile" == $output_folder ========================="
	echo "python3 recv.py -j --jsonfile $output_folder --outputdir $output_folder  $xmitfile"
	python3 recv.py -mpH -j --jsonfile "$output_folder" --outputdir "$output_folder" "$xmitfile"
	for morexmits in $(find "$output_folder" -name "*.xmi"|sort -h); do
		output_folder_more=$(dirname "$morexmits")
		echo "================= $morexmits == $output_folder_more ========================="
		echo "python3 recv.py -j --jsonfile $output_folder_more --outputdir $output_folder_more $morexmits"
		python3 recv.py -mpH -j --jsonfile "$output_folder_more" --outputdir "$output_folder_more" "$morexmits"
	done
done
