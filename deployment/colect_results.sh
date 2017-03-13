#!/bin/bash

echo "Colecting results"

mkdir -p final
for remoteHost in $@; do
	rsync -a --progress $remoteHost:~/viseem/final/ ./final/
done

echo "All results were colected"