#!/bin/bash

cd raw_data

echo "Copying raw data to remote machines."
i=0
for directoryName in */ ;do
        directoryName=$(echo $directoryName | sed 's/\///g')
        remoteHostNumber=$((i % $# + 1))
        remoteAddress=${!remoteHostNumber}
        ssh $remoteAddress "mkdir -p ~/viseem/raw_data"
        rsync -a --progress $directoryName $remoteAddress:~/viseem/raw_data/
        ((i++))
done

cd ..

echo "Copying ocr scripts."
for remoteAddresaa in $@; do
        rsync -a --progress process.sh textcleaner $remoteAddresaa:~/viseem/
done

echo "Running OCR on remote hosts"
for remoteAddresaa in $@; do
        ssh $remoteAddresaa "cd ~/viseem; nohup ./process.sh > process.log 2>&1 &"
done