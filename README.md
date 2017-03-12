# viseem_distributed_ocr
Distribute OCR work on several machines.

#Dependencies
packages: poppler-utils, tesseract-ocr, bc, imagemagick;
```bash
sudo apt-get install poppler-utils; sudo apt-get install tesseract-ocr; cd /usr/share/tesseract-ocr/tessdata; sudo wget https://github.com/tesseract-ocr/tessdata/raw/master/ron.traineddata; sudo apt-get install bc; sudo apt-get install imagemagick
```


#Usage 
assuming the master has acces to the worker nodes through ssh using ssh-keys, one might use `./deploy.sh user1@ip1 user2@ip2 user3@ip3` where `user1@ip1` represent the connecton detail to worker1.
