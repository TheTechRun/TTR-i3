#!/usr/bin/env bash
#Easy method to DOWNLOAD this: see README.md
cd ~
git clone https://github.com/TheTechRun/TTR-i3
cd TTR-i3
mv .config .scripts .fonts .icons Pictures .themes ~/
chmod -R +x ~/.config/i3
chmod -R +x ~/.config/polybar
chmod -R +x ~/.scripts/TTR
exit