#!/bin/bash

echo "Stage 1 - convert pdf to jpg"
cd raw_data
for directoryName in */ ; do
        directoryName=${directoryName::-1}
        echo "Directory name is: $directoryName"
        mkdir -p ../processed/$directoryName
        cd $directoryName
        for pdfName in *.pdf; do
                echo "Pdf name is: $pdfName"
                subDirectoryName=$(sed s/\.pdf/""/g <<< $pdfName)
                mkdir -p ../../processed/$directoryName/$subDirectoryName
                pdfimages -j $pdfName ../../processed/$directoryName/$subDirectoryName/$pdfName
        done
        cd ..
done

echo "Stage 2 - clean images"
cd ../processed
for directoryName in */ ; do
        directoryName=${directoryName::-1}
        echo "Directory name is: $directoryName"
        mkdir -p ../processed2/$directoryName
        cd $directoryName
        for subDirectoryName in */ ; do
                subDirectoryName=${subDirectoryName::-1}
                echo "Subdirectory name is: $subDirectoryName"
                cd $subDirectoryName
                for jpgName in *.jpg; do
                        echo "Jpg name is: $jpgName"
                        pngName=$(echo $jpgName | sed 's/jpg/png/g')
                        mkdir -p ../../../processed2/$directoryName/$subDirectoryName
                        echo "png name is $pngName"
                        ../../../textcleaner -g -e normalize -f 30 -o 12 -s 2 $jpgName ../../../processed2/$directoryName/$subDirectoryName/$pngName
                done
                cd ..
        done
        cd ..
done

echo "Stage 3 - ocr on images"
cd ../processed2
for directoryName in */ ; do
        directoryName=${directoryName::-1}
        echo "Directory name is: $directoryName"
        mkdir -p ../final/$directoryName
        cd $directoryName
        for subDirectoryName in */ ; do
                subDirectoryName=${subDirectoryName::-1}
                echo "subDirectoryName name is: $subDirectoryName"
                cd $subDirectoryName
                for pngName in *.png; do
                        echo "Png name is $pngName"
                        ocrName=$(echo $pngName | sed 's/\.png//g')
                        mkdir -p ../../../final/$directoryName/$subDirectoryName
                        tesseract $pngName ../../../final/$directoryName/$subDirectoryName/$ocrName -l ron
                done
                cd ..
        done
        cd ..
done
