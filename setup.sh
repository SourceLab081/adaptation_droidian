# Droidian Adaptation for the Xiaomi Redmi 10C  (fog)
# Flashing based on: https://github.com/droidian-releng/android-recovery-flashing-template

# Contains fixes for:
# 1. udev
# 2. scaling
# 3. fix audio, get from spes
# 4. boot


# https://droidian.org

OUTFD=/proc/self/fd/$1;
VENDOR_DEVICE_PROP=`grep ro.product.vendor.device /vendor/build.prop | cut -d "=" -f 2 | awk '{print tolower($0)}'`;

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

mkdir /r;

# mount droidian rootfs
mount /data/rootfs.img /r;

# Copy files
ui_print "Copying device adaptation files...";

cp data/70-*.rules /r/etc/udev/rules.d/;
rm /r/etc/udev/rules.d/70-.rules;
mkdir /r/etc/phosh;
cp data/phoc.ini /r/etc/phosh/;
cp -a data/usr /r/
rm /r/etc/pulse/default.pa
cp -a data/etc /r/
# umount rootfs
umount /r;

# flash boot.img
flash_image /dev/block/bootdevice/by-name/boot boot.img

exit 0;
