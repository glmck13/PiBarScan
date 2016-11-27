# PiBarScan
Simple script to read &amp; process barcodes from a HID Bluetooth/USB scanner on a Raspberry Pi 

## Background
I wanted to connect a barcode scanner to my Raspberry Pi not only to scan product inventory, but also to launch commands on the Pi using specially crafted barcodes.  A search of barcode software on the web yielded two types of utilities:
* those that read barcodes from stdin
* those that read barcodes from /dev/hidraw

Unfortunately, the stdin-based tools require the HID focus to be set on the window from which they're executed, so they can't be run as background daemons.  And while the tools that read from /dev/hidraw get around this limitation, those tools typically rely on some snippet of C/C++ code to translate the raw keyboard input.  

After reasearching the input subsystem on Linux, and fiddling with lsinput, udevadm, and input-events, I realized I could implement a very simple utility completely within shell for reading & processing barcodes.  Moreover, the tool could automatically detect whenever the barcode scanner connected (in the base of Bluetooth devices).

## Usage
You may need to "apt-get install xinput" if it's not already installed on your Pi.  Ditto for "ksh".  Otherwise, everything else needed by the barcode.sh script should already be loaded on your Pi.  

Before running the tool, you'll first have to edit barcode.cfg to specify the commands for handling the incoming barcodes.  Each line of the tool is pipe-delimited.  The first field is a ksh-regex pattern for a class of barcodes, while the second field is the command to run when that barcode class is detected.
