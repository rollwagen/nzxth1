#!/bin/bash

print_info () {
	echo "$(tput bold)$1$(tput sgr 0)"
}

# OpenCore version
OCVERSION=0.6.0

# OpenCore drivers directory
DRIVERSDIR=$OCVERSION/EFI/OC/Drivers

# OpenCore drivers directory
TOOLSDIR=$OCVERSION/EFI/OC/Tools

print_info "OpenCore version: $OCVERSION"
print_info "Drivers directory: $DRIVERSDIR"
print_info "Tools directory: $TOOLSDIR"
echo

#
# 'Remove from drivers' as per https://dortania.github.io/OpenCore-Install-Guide/installer-guide/opencore-efi.html
#

print_info "Removing all unnecessary drivers..."

# Unrelated to Audio support in macOS
rm -v $DRIVERSDIR/AudioDxe.efi

# Used for taking screenshots in UEFI, not needed by us
rm -v $DRIVERSDIR/CrScreenshotDxe.efi

# Used for OpenCore picker on legacy systems running DuetPkg, not recommended and even harm -vful on Ivy Bridge and newer
rm -v $DRIVERSDIR/OpenUsbKbDxe.efi

# similar idea to OpenUsbKbDxe, should only be needed on legacy systems using DuetPkg
rm -v $DRIVERSDIR/UsbMouseDxe.efi

# Used for Haswell and older when no NVMe driver is built into the firm -vware
rm -v $DRIVERSDIR/NvmExpressDxe.efi

# Used for Sandy Bridge and older when no XHCI driver is built into the firm -vware
rm -v $DRIVERSDIR/XhciDxe.efi

# Used for fixing GUI support like OpenShell.efi on Sandy Bridge and older
rm -v $DRIVERSDIR/HiiDatabase.efi

# This is OpenCore's optional GUI, we'll be going over how to set this up in Post Install so remove this for now
rm -v $DRIVERSDIR/OpenCanopy.efi

# Pretty obvious when you need this, USB keyboard and mouse users don't need it
rm -v $DRIVERSDIR/Ps2KeyboardDxe.efi
rm -v $DRIVERSDIR/Ps2MouseDxe.efi

print_info "Removing all unnecessary drivers...DONE."
echo

#
# 'Remove from drivers' as per https://dortania.github.io/OpenCore-Install-Guide/installer-guide/opencore-efi.html
#

print_info "Removing all unnecessary tools...(keeping OpenShell.efi and CleanNvram.efi)..."

rm -v $TOOLSDIR/BootKicker.efi
rm -v $TOOLSDIR/ChipTune.efi
rm -v $TOOLSDIR/GopStop.efi
rm -v $TOOLSDIR/HdaCodecDump.efi
rm -v $TOOLSDIR/KeyTester.efi
rm -v $TOOLSDIR/MmapDump.efi
rm -v $TOOLSDIR/OpenControl.efi
rm -v $TOOLSDIR/ResetSystem.efi
rm -v $TOOLSDIR/RtcRw.efi
rm -v $TOOLSDIR/VerifyMsrE2.efi

print_info "Removing all unnecessary tools...DONE."
echo


#
# Adding firmware drivers as per https://dortania.github.io/OpenCore-Install-Guide/ktext.html#firmware-drivers
#

print_info "Adding 'HfsPlus.efi' (Needed for seeing HFS volumes)..."
curl -s -L https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/HfsPlus.efi -o $DRIVERSDIR/HfsPlus.efi




