# PiBarScan
Simple shell script to read &amp; process barcodes from a HID Bluetooth/USB scanner on a Raspberry Pi.  

## Update, Remote Execution: Dec 2, 2016
I realized the tool would be much more powerful if barcodes could be read on one host but executed on another.  So I split the barcode.sh script into two: readcode.sh and execcode.sh.  In a single host environment, simply leave the REMOTE variable in the barcode.sh script commented out.  In a multi-host environment, install readcode.sh on the system that connects to the Bluetooth scanner (the "REMOTE" host), while depositing execcode.sh & barcode.cfg on your other machine (the "LOCAL" host).  Then edit the fields within the REMOTE variable in barcode.sh to populate a host name/address, user, password, and path.  

## Background
I wanted to connect a barcode scanner to my Raspberry Pi not only to scan product inventory, but also to launch commands on the Pi using specially crafted barcodes.  A search of barcode software on the web yielded two types of utilities:
* those that read barcodes from stdin
* those that read barcodes from /dev/hidraw

Unfortunately, the stdin-based tools require the HID focus to be set on the window from which they're executed, so they can't be run as background daemons.  And while the tools that read from /dev/hidraw get around this limitation, those tools typically rely on some snippet of C/C++ code to translate the raw keyboard input.  

After reasearching the input subsystem on Linux, and fiddling with lsinput, udevadm, and input-events, I realized I could implement a very simple utility completely within shell for reading & processing barcodes.  Moreover, the tool can automatically detect whenever the barcode scanner connects (in the case of Bluetooth devices), and can be executed as a background process.

## Usage
You may need to "apt-get install xinput" if it's not already installed on your Pi.  Ditto for "ksh".  Otherwise, everything else needed by the barcode.sh script should already be loaded on your Pi.  

Before running the tool, you'll first have to edit barcode.cfg to specify the commands for handling incoming barcodes.  Each line of the config file is pipe-delimited.  The first field is a glob pattern for a class of barcodes, while the second field is the command to run when that barcode class is detected.  The $BARCODE variable can be passed via the command line, or can be accessed in the environment.  

If your scanner uses Bluetooth, follow the manufacturer's instructions for pairing it with the Pi.  You'll only need to do this once.

You can launch the barcode.sh script from a term window - either in the foreground or background (nohup) - or launch it on system startup from /etc/rc.local.  

The current implementation admittedly takes some shortcuts, since it doesn't attempt to process SHIFT or other special keystrokes.  In practice, this doesn't pose much of a problem since the common barcode specs (UPC, EAN, etc.) primarily use basic alphanumerics.  

Let me know if you encounter problems, or have any other feedback.
