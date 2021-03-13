## NZXT H1

![About this mac](/doc/macos_about.png)

OpenCore build for NZXT H1.

**Current OpenCore Bootloader Version: 0.6.0**

## Hardware
- Case: NZXT H1 (black)
- CPU: Intel i9-10900T (LGA 1200)
- Motherboard: Gigabyte Z490I AORUS Ultra, mATX
	- WIFI: Intel AX201 Wi-Fi 6 
	- Ethernet: Intel I225-V 2.5 GbE
- RAM: 64GB Corsair Vengeance LPX Black (2x, 32GB, DDR4-3200, DIMM 288) 
- GPU: Sapphire Radeon RX 570 (8GB) 
- SSD: WD Black SN750 NAND, 500GB, M.2 2280
- SSD (back of motherboard): Samsung 970 EVO Plus, 1TB, M.2 2280
- Bluetooth: TP-Link Bluetooth 4.0 Nano-USB-Adapter 

## Benchmarks
### Geekbench 5
* Single-Core Score: 1274
* Multi-Core Score: 9096
* OpenCL Score: 40350
* Metal Score: 45367

## Working

## General / hardware
- [x] **macOS Catalina 10.5.6** (Software Update from 10.5.5 worked without issues)
- [x] **Bluetooth** (via USB adapter, see 'Hardware' above)
- [ ] **Wireless** (disabled, see USB Mapping info below)
- [x] **Audio** (not kext or any specic conifg needed; worked out of the box)
- [x] **USB** (see USB Mapping info below)
- [x] **2.5Gbit Ethernet (Intel I225-V)**
- [x] **Sleep/Wake** (worked out of the box)

## Software
- [x] **VMWare Fusion** (including vagrant w/ VMWare Fusion)

## Issues / Notes
Although Bluetooth is working in general (e.g. for audio), slight lag+latency issues with Apple Magic Keyboard/Trackpad; hence, still running keyboard + trackpad via cable.

## Details

### OpenCore config
* [`config.plist`](opencore/0.6.0/config.plist)
* current kexts used: see `config.plist`, for info on specific kext versions used, see file [`kext_versions.txt`](opencore/0.6.0/kext_versions.txt) in `opencore/<version>/`.

### USB Mapping 
* see details `README.md` in `opencore/<version>/usbmap` folder [link to current](opencore/0.6.0/usbmap/)

### CPUFriend config
* see `README.md` in `opencore/<version>/cpufriendfriend` folder [link to current](opencore/0.6.0/cpufriendfriend/)


# Credits / Links
- [SchmockLord's build](https://github.com/SchmockLord/Hackintosh-Intel-i9-10900k-Gigabyte-Z490-Vision-D)
- [Dortania](https://github.com/dortania) _the_ OpenCore Desktop Guide
- [OpenCore project](https://github.com/OpenCorePkg) 
- [Open Canopy OS Icons](https://github.com/blackosx/OpenCanopyIcons)

