Raspberry Pi Emulation Environment
----------------------------------

Raspberry Pi emulation environment for OS X.

Built with help from the following:
* https://github.com/psema4/pine/wiki/Installing-QEMU-on-OS-X
* http://xecdesign.com/qemu-emulating-raspberry-pi-the-easy-way/


Setup Instructions
-------------------

You will need a raspberry pi image. I've only tested this with Raspbian.
Download it from the pi (downloads)[http://www.raspberrypi.org/downloads/] page,
exctract the directory you've cloned this repo into, and edit `boot_vm.sh` to point
to your image.

When you're ready, first run `setup_qemu.sh`, then run `boot_vm.sh`. This should work,
but if it doesn't, use the sites referenced above to troubleshoot.
