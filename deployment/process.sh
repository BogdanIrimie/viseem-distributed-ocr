#!/bin/bash

echo "Stage 1 - convert pdf to jpg"
cd raw_data
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
	mkdir -p ../processed/$directoryName
	for pdfName in $directoryName*.pdf; do
		# echo "Pdf name is: $pdfName"
		pdfimages -j $pdfName ../processed/$pdfName
	done
done

echo "Stage 2 - clean images"
cd ../processed
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
	mkdir -p ../processed2/$directoryName
	for jpgName in $directoryName*.jpg; do
		# echo "Jpg name is: $jpgName"
		pngName=$(echo $jpgName | sed 's/jpg/png/g')
		# echo "png name is $pngName"
		../textcleaner -g -e normalize -f 30 -o 12 -s 2 $jpgName ../processed2/$pngName
	done
done

echo "Stage 3 - ocr on images"
cd ../processed2
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
	mkdir -p ../final/$directoryName
	for pngName in $directoryName*.png; do
		echo "Png name is $pngName"
		ocrName=$(echo $pngName | sed 's/png/txt/g')
		tesseract $pngName ../final/$ocrName -l ron
	done
done
