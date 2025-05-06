# NDI-Auto-Player-ISO
This is a bootable ISO which can turn any suitably modern computer into an NDI player. The ISO automatically launches the [NSM](https://github.com/keijiro/Nsm) player, which can be configured to display on a specific screen, and listen for a specific NDI source. This project is based on the archISO build script, which creates a compact and read-only linux environment for the player to run in. The read only nature of the design makes the filesystem indestructable, even if the computer is hard powered off. This allows the player to be turned on and off simply by supplying or shutting off power to the computer.

## Requirements for running NDI Auto Player:
- An x86-64 computer
- UEFI boot support (may be dropped later)
- Very basic vulkan support (ivybridge intel HD 4000 minumum)
- 1GB of storage to flash the ISO onto (may be shrunk later), be it USB flash drive, HDD, or SSD.
- Gigabit Ethernet port, A 1080p NDI stream uses more bandwidth than a 100mbit nic can handle.
- Optional: A bios option for "restore on AC power loss", or "power on AC attach". This would allow you to simply supply or remove power to the machine to turn on or off the player, as if it were an appliance.
- Optional: To make sure the bios doesn't reset when power is cut, a working cmos battery.

## Using
Go to the [reelases](https://github.com/MaksymUserAgent/NDI-auto-player-ISO/releases), and download the latest `NDIplayer.img` file, don't use `NDIplayer.iso` as it omits the config partition. Then, use a program like [rufus](https://rufus.ie/en/) (in dd mode), or dd on linux to flash the image onto a USB drive, or any other storage medium that your target machine can boot from. 

## Configuring
After you flashed the image onto a USB stick, mount the partition labled `config`. There, edit the file called `config`, and set the screen and the NDI stream name. To find out the screen name, you will have to boot into the player on the target machine with only your desired screen connected, switch to tty3 (Ctrl+Alt+f3), type "root" and enter to log in. Then follow the on screen instructions. When you see the xrandr output, the display name followed by "connected" is your monitor name to use in the config file. When entering an NDI source name that has a space, do not use quotes, and make sure there are no spaces preceeding and following the NDI source name.

You can also supply a custom xorg conf file by editing the `xorg-custom.conf` file in the config partition, which will be copied to `/etc/X11/xorg.conf.d/`. You can use this to disable tearing in the Intel driver for example.

## Booting
To boot the player, plug in the flashed storage medium into the target machine, and set it to highest priority in the bios, while also enabling UEFI boot. Make sure an ethernet cable and the display you configured are connected. The ISO will boot, get an IP address via DHCP, start the xorg display server, and wait for the configured monitor to be detected. After it is, then the NDI player is launched in fullscreen, and listens for the configured NDI source.

Because the filesystem is read-only, you do not have to worry about safely shutting down the machine, and can simply remove power as if it were a wifi router. 

## Limitations
- No sound support
- cannot work over wifi
- crude config system
- no error checking for config or build mistakes

I plan to fix all of these in the future. This is my first time making an embedded system like this, so cut me some slack.

## Building
### Dependincies
- An up to date Archlinux system
- `git`, for cloning this repo
- `mkarchiso`, for building the ISO itself
- `multipath-tools`, for kpartx, used for building the combined iso + config image
### Building the image
Clone the repository\
`git clone https://github.com/MaksymUserAgent/NDI-auto-player-ISO.git`\
Enter the directory\
`cd NDI-Auto-Player-ISO`\
Build the image\
`sudo ./build`\
Now, in the base directory there should be `NDIplayer.img` and `NDIplayer.iso`, if not, then something broke. `NDIplayer.img` is a combined ISO and config partition image, while `NDIplayer.iso` lacks the config partition.
