These are the contents of the adaptation-droidian-fog-a11.zip file. So to be able to use it, it must be zipped and installed after installing droidian api30-arm64 which can be downloaded at :
https://github.com/droidian-images/droidian/releases

How do I get the boot.img for droidian in this repo?

First compile the fog kernel for droidian from the source:
https://github.com/SourceLab081/A14-fog
by using the kernel config vendor/miui11-halium_defconfig
After compiling, take the kernel Image.gz to be inserted into the boot.img from another device that is still close (spes). 
The next process uses the application to unpack and repack boot.img obtained from(you must compile the source first):

https://github.com/osm0sis/mkbootimg

This is how I unpack and repack the boot.img file:

./unpackbootimg

usage: unpackbootimg
	-i|--input <filename>
	[ -o|--output <directory> ]
	[ -p|--pagesize <size-in-hexadecimal> ]

mkdir spes

./unpackbootimg -i boot_spes.img -o spes

As a result,  we can see these files in spes folder:
boot_droidSpes.img-cmdline
boot_droidSpes.img-header_version
boot_droidSpes.img-kernel
boot_droidSpes.img-os_patch_level
boot_droidSpes.img-os_version
boot_droidSpes.img-ramdisk


 ./mkbootimg
 
error: no output filename specified
usage: mkbootimg
	[ --kernel <filename> ]
	[ --ramdisk <filename> | --vendor_ramdisk <filename> ]
	[ --second <filename> ]
	[ --dtb <filename> ]
	[ --recovery_dtbo <filename> | --recovery_acpio <filename> ]
	[ --dt <filename> ]
	[ --cmdline <command line> | --vendor_cmdline <command line> ]
	[ --base <address> ]
	[ --kernel_offset <base offset> ]
	[ --ramdisk_offset <base offset> ]
	[ --second_offset <base offset> ]
	[ --tags_offset <base offset> ]
	[ --dtb_offset <base offset> ]
	[ --os_version <A.B.C version> ]
	[ --os_patch_level <YYYY-MM-DD date> ]
	[ --board <board name> ]
	[ --pagesize <pagesize> ]
	[ --header_version <version number> ]
	[ --hashtype <sha1(default)|sha256> ]
	[ --id ]
	-o|--output <filename> | --vendor_boot <filename>

Details for the command line can be read in boot_droidSpes.img-cmdline and other files, but we have to change the kernel so that the mkbootimg command:

./mkbootimg --kernel Image.gz --ramdisk spes/boot_droidSpes.img-ramdisk --cmdline console=tty0 earlycon=msm_geni_serial,0x4a90000 androidboot.hardware=qcom androidboot.console=tty0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=2048 loop.max_part=7 buildvariant=user --pagesize 4096 --header_version 3 -o boot.img


I created a bash shell command with the contents as above but I changed boot.img to $1, the file name is nol.sh so to build boot.img we run the shell:
bash nol.sh boot.img

