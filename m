Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47766 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab3BEObR (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 5 Feb 2013 09:31:17 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 827AB203A8
	for <backports@vger.kernel.org>; Tue,  5 Feb 2013 14:31:15 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id B0B2D203A5
	for <backports@vger.kernel.org>; Tue,  5 Feb 2013 14:31:13 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 53421] New: eeprom init error of AR9582
Message-ID: <bug-53421-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Tue,  5 Feb 2013 14:31:13 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=53421

               URL: https://dev.openwrt.org/ticket/12920#comment:7
           Summary: eeprom init error of AR9582
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.7.4
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Compat
        AssignedTo: backports@vger.kernel.org
        ReportedBy: banglang.huang@gmail.cOM
        Regression: No


below is the kernel log.
My testbed is DB120 reference borad, of cause it is dual-band.But there is only
One works.
AR9344+AR8035PHY+AR9580...
## Booting image at 81000000 ...
Image Name: MIPS OpenWrt Linux-3.3.8
Created: 2013-01-15 6:40:58 UTC
Image Type: MIPS Linux Kernel Image (lzma compressed)
Data Size: 3237612 Bytes = 3.1 MB
Load Address: 80060000
Entry Point: 80060000
Verifying Checksum at 0x81000040 ...OK
Uncompressing Kernel Image ... OK
No initrd
## Transferring control to Linux (at address 80060000) ...
## Giving linux memsize in bytes, 134217728
Starting kernel ...
[ 0.000000] Linux version 3.3.8 (banglang@banglang) (gcc version 4.6.4 20121001
(prerelease) (Linaro GCC 4.6-2012.10) ) #74 Tue Jan 15 14:40:43 HKT 2013
[ 0.000000] bootconsole [early0] enabled
[ 0.000000] CPU revision is: 0001974c (MIPS 74Kc)
[ 0.000000] SoC: Atheros AR9344 rev 2
[ 0.000000] Clocks: CPU:532.500MHz, DDR:400.000MHz, AHB:200.000MHz,
Ref:40.000MHz
[ 0.000000] Determined physical RAM map:
[ 0.000000] memory: 08000000 @ 00000000 (usable)
[ 0.000000] Initrd not found or empty - disabling initrd
[ 0.000000] Zone PFN ranges:
[ 0.000000] Normal 0x00000000 -> 0x00008000
[ 0.000000] Movable zone start PFN for each node
[ 0.000000] Early memory PFN ranges
[ 0.000000] 0: 0x00000000 -> 0x00008000
[ 0.000000] Built 1 zonelists in Zone order, mobility grouping on. Total pages:
32512
[ 0.000000] Kernel command line: board=DB120 console=ttyS0,115200
mtdparts=spi0.0:256k(u-boot)ro,64k(u-boot-env)ro,6336k(rootfs),1408k(kernel),64k(nvram),64k(art)ro,7744k@0x50000(firmware)
rootfstype=squashfs,jffs2 noinitrd
[ 0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[ 0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[ 0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[ 0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
[ 0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32
bytes
[ 0.000000] Writing ErrCtl register=00000000
[ 0.000000] Readback ErrCtl register=00000000
[ 0.000000] Memory: 124372k/131072k available (2089k kernel code, 6700k
reserved, 400k data, 2448k init, 0k highmem)
[ 0.000000] SLUB: Genslabs=9, HWalign=32, Order=0-3, MinObjects=0, CPUs=1,
Nodes=1
[ 0.000000] NR_IRQS:51
[ 0.000000] Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
[ 0.080000] pid_max: default: 32768 minimum: 301
[ 0.080000] Mount-cache hash table entries: 512
[ 0.090000] NET: Registered protocol family 16
[ 0.090000] gpiochip_add: registered GPIOs 0 to 22 on device: ath79
[ 0.100000] MIPS: machine is Atheros DB120 reference board
[ 0.110000] registering PCI controller with io_map_base unset
[ 0.520000] bio: create slab <bio-0> at 0
[ 0.530000] PCI host bridge to bus 0000:00
[ 0.530000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13ffffff]
[ 0.540000] pci_bus 0000:00: root bus resource [io 0x0000]
[ 0.540000] pci 0000:00:00.0: invalid calibration data
[ 0.550000] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1001ffff 64bit]
[ 0.550000] pci 0000:00:00.0: BAR 6: assigned [mem 0x10020000-0x1002ffff pref]
[ 0.560000] pci 0000:00:00.0: using irq 40 for pin 1
[ 0.560000] Switching to clocksource MIPS
[ 0.570000] NET: Registered protocol family 2
[ 0.570000] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[ 0.570000] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[ 0.580000] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[ 0.580000] TCP: Hash tables configured (established 4096 bind 4096)
[ 0.590000] TCP reno registered
[ 0.590000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[ 0.600000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[ 0.600000] NET: Registered protocol family 1
[ 3.770000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[ 3.780000] JFFS2 version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY)
(c) 2001-2006 Red Hat, Inc.
[ 3.790000] msgmni has been set to 242
[ 3.790000] io scheduler noop registered
[ 3.800000] io scheduler deadline registered (default)
[ 3.800000] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[ 3.830000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq = 11) is a 16550A
[ 3.840000] console [ttyS0] enabled, bootconsole disabled
[ 3.840000] console [ttyS0] enabled, bootconsole disabled
[ 3.850000] m25p80 spi0.0: found mx25l12805d, expected m25p80
[ 3.860000] m25p80 spi0.0: mx25l12805d (16384 Kbytes)
[ 3.860000] 7 cmdlinepart partitions found on MTD device spi0.0
[ 3.870000] Creating 7 MTD partitions on "spi0.0":
[ 3.870000] 0x000000000000-0x000000040000 : "u-boot"
[ 3.880000] 0x000000040000-0x000000050000 : "u-boot-env"
[ 3.890000] 0x000000050000-0x000000680000 : "rootfs"
[ 3.890000] mtd: partition "rootfs" set to be root filesystem
[ 3.900000] split_squashfs: no squashfs found in "spi0.0"
[ 3.900000] 0x000000680000-0x0000007e0000 : "kernel"
[ 3.910000] 0x0000007e0000-0x0000007f0000 : "nvram"
[ 3.920000] 0x0000007f0000-0x000000800000 : "art"
[ 3.920000] 0x000000050000-0x0000007e0000 : "firmware"
[ 3.950000] ag71xx_mdio: probed
[ 3.960000] ag71xx_mdio: probed
[ 3.960000] eth0: Atheros AG71xx at 0xb9000000, irq 4
[ 4.520000] ag71xx ag71xx.0: eth0: no PHY found with phy_mask=00000001
[ 4.530000] eth0: Atheros AG71xx at 0xba000000, irq 5
[ 5.080000] eth0: Found an AR934X built-in switch
[ 6.120000] TCP cubic registered
[ 6.120000] NET: Registered protocol family 17
[ 6.120000] 8021q: 802.1Q VLAN Support v1.8
[ 6.140000] Freeing unused kernel memory: 2448k freed
preinit -
Press the [f] key and hit [enter] to enter failsafe mode
regular preinit -
init -
[ 11.260000] Compat-drivers backport release:
compat-drivers-2012-09-04-2-gddac993
[ 11.270000] Backport based on wireless-testing.git master-2012-09-07
[ 11.280000] compat.git: wireless-testing.git
[ 11.300000] cfg80211: Calling CRDA to update world regulatory domain
[ 11.310000] cfg80211: World regulatory domain updated:
[ 11.310000] cfg80211: (start_freq - end_freq @ bandwidth), (max_antenna_gain,
max_eirp)
[ 11.320000] cfg80211: (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.330000] cfg80211: (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000
mBm)
[ 11.330000] cfg80211: (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000
mBm)
[ 11.340000] cfg80211: (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.350000] cfg80211: (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.390000] NET: Registered protocol family 10
[ 11.460000] usbcore: registered new interface driver usbfs
[ 11.470000] usbcore: registered new interface driver hub
[ 11.470000] usbcore: registered new device driver usb
[ 11.570000] ieee80211 phy0: Atheros AR9340 Rev:0 mem=0xb8100000, irq=47
[ 11.580000] PCI: Enabling device 0000:00:00.0 (0000 -> 0002)
[ 11.590000] ath: phy1: Unable to initialize hardware; initialization status:
-5
[ 11.600000] ath9k 0000:00:00.0: Failed to initialize device
[ 11.600000] ath9k: probe of 0000:00:00.0 failed with error -5

[ 11.610000] cfg80211: Calling CRDA for country: US
[ 11.620000] cfg80211: Regulatory domain changed to country: US
[ 11.620000] cfg80211: (start_freq - end_freq @ bandwidth), (max_antenna_gain,
max_eirp)
[ 11.630000] cfg80211: (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2700
mBm)
[ 11.640000] cfg80211: (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 1700
mBm)
[ 11.650000] cfg80211: (5250000 KHz - 5330000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.650000] cfg80211: (5490000 KHz - 5600000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.660000] cfg80211: (5650000 KHz - 5710000 KHz @ 40000 KHz), (300 mBi, 2000
mBm)
[ 11.670000] cfg80211: (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 3000
mBm)
[ 11.700000] PPP generic driver version 2.4.2
[ 11.740000] IPv6 over IPv4 tunneling driver
[ 11.790000] ip_tables: (C) 2000-2006 Netfilter Core Team
[ 11.870000] NET: Registered protocol family 24
[ 11.890000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[ 11.900000] ehci-platform ehci-platform: Generic Platform EHCI Controller
[ 11.900000] ehci-platform ehci-platform: new USB bus registered, assigned bus
number 1
[ 11.940000] ehci-platform ehci-platform: irq 3, io mem 0x1b000000
[ 11.960000] ehci-platform ehci-platform: USB 2.0 started, EHCI 1.00
[ 11.960000] hub 1-0:1.0: USB hub found
[ 11.970000] hub 1-0:1.0: 1 port detected
[ 11.980000] nf_conntrack version 0.5.0 (1981 buckets, 7924 max)
[ 12.160000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Please press Enter to activate this console.



I found the issue is here, but I don't know how to fix it.
@compat-wireless/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c 
/*
Read the configuration data from the eeprom.
The data can be put in any specified memory buffer.
*
Returns -1 on error.
Returns address of next memory location on success.
*/
static int ar9300_eeprom_restore_internal(struct ath_hw *ah,
u8 *mptr, int mdata_size)
{
#define MDEFAULT 15
#define MSTATE 100
int cptr;
u8 *word;
int code;
int reference, length, major, minor;
int osize;
int it;
u16 checksum, mchecksum;
struct ath_common *common = ath9k_hw_common(ah);
struct ar9300_eeprom *eep;
eeprom_read_op read;
if (ath9k_hw_use_flash(ah)) {
u8 txrx;
ar9300_eeprom_restore_flash(ah, mptr, mdata_size);
/* check if eeprom contains valid data */
eep = (struct ar9300_eeprom *) mptr;

why my txrx == 0xff ????

txrx = eep->baseEepHeader.txrxMask;
if (txrx != 0 && txrx != 0xff)

return 0;

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
