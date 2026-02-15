# Keycap-desktop

## Installing
Run :
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest 'https://github.com/keycapeditor/Keycap-desktop/releases/download/Keycap/Installer.ps1' -OutFile install.ps1; .\install.ps1"
```
the script will guide you further.

## Building

Download this repo and open a terminal and run :
```bash
pip install pywebview pyinstaller
```
then run the **build.bat** executable.

The exe will be in the **dist** folder.

## Usage
You can run :
```
Keycap_desktop /..
```
and it will open that folder in the Keycap desktop editor
