# PiBarScan
Simple script to read &amp; process barcodes from a HID Bluetooth/USB scanner on a Raspberry Pi 

## Background
I wanted to connect a barcode scanner to my Raspberry Pi not only to scan product inventory, but also to launch commands on the Pi using specially crafted barcodes.  A search of barcode software on the web yielded two types of utilities:
* those that read barcodes from stdin
* those that read barcodes from /dev/hidraw

Unfortunately, the stdin-based tools require the HID focus to be set on the window from which they're executed, so they can't be run as background daemons.  And while the tools that read from /dev/hidraw get around this limitation, those tools typically rely on some snippet of C/C++ code to translate the raw keyboard input.  

## Usage
