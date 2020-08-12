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

# OpenCore kext directory
KEXTSDIR=$OCVERSION/EFI/OC/Kexts

# OpenCore kext directory
ACPISDIR=$OCVERSION/EFI/OC/ACPI

print_info "OpenCore version: $OCVERSION"
print_info "Drivers directory: $DRIVERSDIR"
print_info "Tools directory: $TOOLSDIR"
print_info "Kext directory: $KEXTSDIR"
print_info "ACPI directory: $ACPISDIR"
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

print_info "Removing all unnecessary tools...(keeping OpenShell.efi)..."

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
rm -v $TOOLSDIR/CleanNvram.efi

print_info "Removing all unnecessary tools...DONE."
echo


#
# Adding firmware drivers as per https://dortania.github.io/OpenCore-Install-Guide/ktext.html#firmware-drivers
#

print_info "Adding firmware driver 'HfsPlus.efi' (Needed for seeing HFS volumes)..."
HFSPLUS_DEST=$DRIVERSDIR/HfsPlus.efi
[[ ! -f $HFSPLUS_DEST ]] && curl -L https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/HfsPlus.efi -o $DRIVERSDIR/HfsPlus.efi
echo


#
# Adding needed kexts as per https://dortania.github.io/OpenCore-Install-Guide/ktext.html#kexts
# 

print_info "Adding kext 'VirtualSMC' (Emulates the SMC chip found on real macs, without this macOS will not boot)..."
VIRTUALSMC_SRC=../kexts/virtualsmc-*/Kexts/VirtualSMC.kext
VIRTUALSMC_DEST=$KEXTSDIR/VirtualSMC.kext
[[ ! -d $VIRTUALSMC_DEST ]] && cp -R $VIRTUALSMC_SRC $KEXTSDIR/

print_info "Adding VirtualSMC plugin 'SMCProcessor.kext' (Used for monitoring CPU temperature)..."
SMCPROCESSOR_SRC=../kexts/virtualsmc-*/Kexts/SMCProcessor.kext
SMCPROCESSOR_DEST=$KEXTSDIR/SMCProcessor.kext
[[ ! -d $SMCPROCESSOR_DEST ]] && cp -R $SMCPROCESSOR_SRC $KEXTSDIR/

print_info "Adding VirtualSMC plugin 'SMCSuperIO.kext' (Used for monitoring fan speed)..."
SMCSUPERIO_SRC=../kexts/virtualsmc-*/Kexts/SMCSuperIO.kext
SMCSUPERIO_DEST=$KEXTSDIR/SMCSuperIO.kext
[[ ! -d $SMCSUPERIO_DEST ]] && cp -R $SMCSUPERIO_SRC $KEXTSDIR/
echo

print_info "Adding kext 'Lilu' (A kext to patch many processes, required for AppleALC, WhateverGreen, VirtualSMC and many other kexts.)..."
LILU_SRC=../kexts/lilu-*/Lilu.kext
LILU_DEST=$KEXTSDIR/Lilu.kext
[[ ! -d $LILU_DEST ]] && cp -R $LILU_SRC $KEXTSDIR/
echo

print_info "Adding kext 'WhateverGreen' (Used for graphics patching DRM, boardID, framebuffer fixes, etc, all GPUs benefit from this kext.)..."
WHATEVERGREEN_SRC=../kexts/whatevergreen-*/WhateverGreen.kext
WHATEVERGREEN_DEST=$KEXTSDIR/WhateverGreen.kext
[[ ! -d $WHATEVERGREEN_DEST ]] && cp -R $WHATEVERGREEN_SRC $KEXTSDIR/
echo

print_info "Adding kexts 'FACEPCIID*' (Needed for Ethernet: Intel I225-V 2.5 Gb)..."
FACEPCIID_SRC=../kexts/fakepciid_intel_i225-v/FakePCIID.kext
FACEPCIID_DEST=$KEXTSDIR/FakePCIID.kext
FACEPCIID_I225_SRC=../kexts/fakepciid_intel_i225-v/FakePCIID_Intel_I225-V.kext
FACEPCIID_I225_DEST=$KEXTSDIR/FakePCIID_Intel_I225-V.kext
[[ ! -d $FACEPCIID_DEST ]] && cp -R $FACEPCIID_SRC $KEXTSDIR/
[[ ! -d $FACEPCIID_I225_DEST ]] && cp -R $FACEPCIID_I225_SRC $KEXTSDIR/
echo


#
# SSDTs as per https://dortania.github.io/Getting-Started-With-ACPI/ssdt-platform.html#desktop
#

print_info "Adding SSDTs (.aml files) to ACPI dir..."
SSDT_SRC=0.5.9/ACPI
cp -v $SSDT_SRC/*.aml $ACPISDIR/
echo


#
# config.plist
# 
print_info "Copying Sample.plist to EFI/OC directory..."
cp -v releases/OpenCore-$OCVERSION/Docs/Sample.plist $OCVERSION/EFI/OC/config.plist

