# NDI-Auto-Player-ISO
This is a bootable ISO which can turn any suitably modern computer into an NDI codec. The ISO automatically launches an NDI player, which can be configured to display on a specific screen, and listen for a specific NDI source. This project is based on the archISO build script, which creates a compact and read-only linux environment for the player to run in. The read only nature of the design makes the filesystem indestructable, even if the computer is hard powered off. This allows the player to be turned on and off simply by supplying or shutting off power to the computer. 
## Requirements for running NDI Auto Player:
- An x86-64 computer
- UEFI boot support (may be dropped later)
- Very basic vulkan support (ivybridge intel HD 4000 minumum)
- around 1.5GB of storage to flash the ISO onto (may be shrunk later), be it USB flash drive, HDD, or SSD.
- Optional: A bios option for "restore on AC power loss", or "power on AC attach". This would allow you to simply supply or remove power to the machine to turn on or off the player, as if it were an appliance.
- Optional: To make sure the bios doesn't reset when power is cut, a working cmos battery.

## Configuring
After you flashed the image onto a USB stick, mount the partition labled `config`. There, edit the file called `config` and set the xorg display output, and the NDI stream name. You can also supply a custom xorg conf file, which will be copied to `/etc/X11/xorg.conf.d/`. You can use this to disable tearing in the Intel driver for example.

## Building
### Dependincies
- Am up to date Archlinux system
- git, for cloning this repo
- mkarchiso, for building the ISO itself
- multipath-tools, for building the combined iso + config image
### Building the image
Clone the repository\
`git clone https://github.com/MaksymUserAgent/NDI-Auto-Player-ISO.git`\
Enter the directory\
`cd NDI-Auto-Player-ISO`\
Build the image\
`sudo ./build`\
Now, in the directory there should be `NDIplayer.img` and `NDIplayer.iso`, if not, then something broke. `NDIplayer.img` is a combined ISO and config partition image, while `NDIplayer.iso` lacks the config partition.
