#!/bin/bash
mkdir results


base_file=$1

echo -e "Your file you are using is $base_file"


file_ext=$(sed -e 's/.*\.//' <<< "$base_file")

echo "file extension is $file_ext"


if [ ! -z "$base_file" ]; then
	strings $base_file > results/strings.txt
	binwalk $base_file > results/binwalk.txt
       	cd results
	binwalk -e $base_file
	cd ..

	


else
	echo "Sorry your file is empty. Please use a valid file"
fi

if [ "$file_ext" == "txt" ]
then
	echo "this is a txt file"
	stegsnow -C $base_file > results/stegsnow.txt
fi


if [ "$file_ext" == "jpg" ] || [ "$file_ext" == "jpg" ]; then
	echo "this is a jpeg file"
	exiftool $base_file > results/exiftool.txt
	steghide extract -sf $base_file > results/steghide.txt
fi

if [ "$file_ext" == "png" ]; then
	exiftool $base_file > results/exiftool.txt
	zsteg $base_file > results/zsteg.txt

fi

if [ "$file_ext" == "wav" ]; then
	steghide extract -sf $base_file
fi

