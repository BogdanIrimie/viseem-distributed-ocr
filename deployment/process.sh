#!/bin/bash

echo "Stage 1 - convert pdf to jpg"
cd raw_data
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
        mkdir -p ../processed/$directoryName
        cd $directoryName
        for pdfName in *.pdf; do
                echo "Pdf name is: $pdfName"
                subDirectory=$(sed s/\.pdf/""/g <<< $pdfName)
                mkdir -p ../../processed/$directoryName/$subDirectory
                pdfimages -j $pdfName ../../processed/$directoryName/$subDirectory/$pdfName
        done
        cd ..
done

echo "Stage 2 - clean images"
cd ../processed
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
        mkdir -p ../processed2/$directoryName
        cd $directoryName
        for subDirectory in */ ; do
                echo "Subdirectory name is: $subDirectory"
                cd $subDirectory
                for jpgName in *.jpg; do
                        echo "Jpg name is: $jpgName"
                        pngName=$(echo $jpgName | sed 's/jpg/png/g')
                        mkdir -p ../../../processed2/$directoryName/$subDirectory
                        echo "png name is $pngName"
                        ../../../textcleaner -g -e normalize -f 30 -o 12 -s 2 $jpgName ../../../processed2/$directoryName/$subDirectory/$pngName
                done
                cd ..
        done
        cd ..
done

echo "Stage 3 - ocr on images"
cd ../processed2
for directoryName in */ ; do
        echo "Directory name is: $directoryName"
        mkdir -p ../final/$directoryName
        cd $directoryName
        for subDirectory in */ ; do
                echo "Subdirectory name os: $subDirectory"
                cd $subDirectory
                for pngName in *.png; do
                        echo "Png name is $pngName"
                        ocrName=$(echo $pngName | sed 's/\.png//g')
                        mkdir -p ../../../final/$directoryName/$subdirectory
                        tesseract $pngName ../../../final/$directoryName/$subDirectory/$ocrName -l ron
                done
                cd ..
        done
        cd ..
done
