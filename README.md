# Keiser.M3i.BLE-HCI-Simulator
⛔️ [DEPRECATED] This repository is no longer maintained.
**Simulates an M3i for development and testing purposes.**

Simulator uses a Linux Bash script which requires an HCI BLE device to operate.

If no HCI BLE device is available, we recommend connecting a USB adapter with Linux compatibility.

Recommended USB Adapter: [Plugable USB Adapter on Amazon US](http://www.amazon.com/gp/product/B009ZIILLI)

*This script is very basic, and designed to be a building block for testing and development.  If you develop a more advanced script and would like to share it with other developers, please send a pull request and we will be happy to bring it into the repository*

## Use
Ensure that `BlueZ` library is installed. 

`sudo apt-get install bluez`

Run script with root permissions. (*hciconfig requires root permission on most distros*)

`sudo ./M3i_Sim.sh`

## Copyright and License
Copyright 2015 [Keiser Corporation](http://keiser.com/).

Licensed under the [MIT license](LICENSE.md).
