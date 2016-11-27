# PiBarScan
Simple script to read &amp; process barcodes from a HID Bluetooth/USB scanner on a Raspberry Pi 

## Background
Most of the Raspberry Pi barcode scanner software I found on the web relied upon processing input from /dev/hidraw using snippets of C/C++ code.  After reasearching the input subsystem on Linux, and fiddling with the lsinput & input-events tools, I realized I could detect the presence of a barcode scanner, and read/process input from the device completely within shell.  The barcode.sh script is the result. 

## Usage
