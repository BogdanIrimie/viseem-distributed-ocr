# viseem_distributed_ocr
Distribute OCR work on several machines.

# Dependencies
on worker nodes: poppler-utils, tesseract-ocr, bc, imagemagick;
```bash
sudo apt-get --yes --force-yes install poppler-utils; sudo apt-get --yes --force-yes install tesseract-ocr; sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/ron.traineddata -O /usr/share/tesseract-ocr/tessdata/ron.traineddata; sudo apt-get --yes --force-yes install bc; sudo apt-get --yes --force-yes install imagemagick
```


# Usage 
Assuming the master has acces to the worker nodes through ssh using ssh-keys, one might use `./deploy.sh user1@ip1 user2@ip2 user3@ip3` where `user1@ip1` represent the connecton detail to worker1.
