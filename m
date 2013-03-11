Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51053 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab3CKUMU (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 Mar 2013 16:12:20 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0844E20234
	for <backports@vger.kernel.org>; Mon, 11 Mar 2013 20:12:18 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 4FF21202BC
	for <backports@vger.kernel.org>; Mon, 11 Mar 2013 20:12:14 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130311201213.4361E11FA28@bugzilla.kernel.org>
Date: Mon, 11 Mar 2013 20:12:13 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #14 from mp-001@ponschab.de  2013-03-11 20:12:12 ---
Here dmesg:

### booting ...
[    6.666705] alx 0000:04:00.0: irq 47 for MSI/MSI-X
[    6.666711] alx 0000:04:00.0: irq 48 for MSI/MSI-X
[    6.666714] alx 0000:04:00.0: irq 49 for MSI/MSI-X
[    6.666717] alx 0000:04:00.0: irq 50 for MSI/MSI-X
[    6.666721] alx 0000:04:00.0: irq 51 for MSI/MSI-X
[    6.666724] alx 0000:04:00.0: irq 52 for MSI/MSI-X
[    6.666728] alx 0000:04:00.0: irq 53 for MSI/MSI-X
[    6.666732] alx 0000:04:00.0: irq 54 for MSI/MSI-X
[    6.666735] alx 0000:04:00.0: irq 55 for MSI/MSI-X
[    6.667708] alx 0000:04:00.0 p3p1: NIC Link Up: 1 Gbps Full
[    6.974830] Bridge firewalling registered
[    6.978233] RPC: Registered named UNIX socket transport module.
[    6.978236] RPC: Registered udp transport module.
[    6.978237] RPC: Registered tcp transport module.
[    6.978238] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    7.018578] device virbr0-nic entered promiscuous mode
[    7.130203] virbr0: topology change detected, propagating
[    7.130211] virbr0: port 1(virbr0-nic) entered forwarding state
[    7.130231] virbr0: port 1(virbr0-nic) entered forwarding state
[    7.151878] virbr0: port 1(virbr0-nic) entered disabled state
[    7.173009] systemd-readahead[411]: Failed to read event: Value too large
for defined data type
[    7.271444] Ebtables v2.0 registered
[    7.317803] cgroup: libvirtd (1340) created nested cgroup for controller
"memory" which has incomplete hierarchy support. Nested cgroups may change
behavior in the future.
[    7.317809] cgroup: "memory" requires setting use_hierarchy to 1 on the
root.
[    7.317897] cgroup: libvirtd (1340) created nested cgroup for controller
"devices" which has incomplete hierarchy support. Nested cgroups may change
behavior in the future.
[    7.317994] cgroup: libvirtd (1340) created nested cgroup for controller
"blkio" which has incomplete hierarchy support. Nested cgroups may change
behavior in the future.
[    8.762277] SELinux: initialized (dev mqueue, type mqueue), uses transition
SIDs
[    8.762338] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[    8.780100] SELinux: initialized (dev mqueue, type mqueue), uses transition
SIDs
[    8.780563] SELinux: initialized (dev proc, type proc), uses genfs_contexts
[   19.299383] fuse init (API version 7.20)
[   19.304469] SELinux: initialized (dev fuse, type fuse), uses genfs_contexts
[   19.329191] SELinux: initialized (dev fusectl, type fusectl), uses
genfs_contexts


##### Suspend/Resume


[   51.801000] PM: Syncing filesystems ... done.
[   51.802365] PM: Preparing system for mem sleep
[   51.919598] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   51.931307] Freezing remaining freezable tasks ... (elapsed 0.01 seconds)
done.
[   51.942323] PM: Entering mem sleep
[   51.942674] Suspending console(s) (use no_console_suspend to debug)
[   51.942920] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 1 ep 0 with no
TDs queued?
[   51.942954] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[   51.942958] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   51.943089] sd 0:0:0:0: [sda] Stopping disk
[   51.943800] sd 1:0:0:0: [sdb] Stopping disk
[   51.956198] nouveau  [     DRM] suspending fbcon...
[   51.956201] nouveau  [     DRM] suspending display...
[   51.956209] nouveau  [     DRM] unpinning framebuffer(s)...
[   51.956281] nouveau  [     DRM] evicting buffers...
[   51.963344] nouveau  [     DRM] suspending client object trees...
[   52.602795] ACPI: Cannot transition to non-D0 state from D3
[   54.281631] alx 0000:04:00.0 p3p1: wol: ctrl=3, speed=C
[   54.285938] alx 0000:04:00.0: System wakeup enabled by ACPI
[   54.297100] PM: suspend of devices complete after 2355.576 msecs
[   54.297221] PM: late suspend of devices complete after 0.119 msecs
[   54.308033] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI
[   54.318957] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI
[   54.340919] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI
[   54.351908] PM: noirq suspend of devices complete after 54.714 msecs
[   54.352556] ACPI: Preparing to enter system sleep state S3
[   54.434093] PM: Saving platform NVS memory
[   54.487218] Disabling non-boot CPUs ...
[   54.488995] smpboot: CPU 1 is now offline
[   54.489186] CPU 1 offline: Remove Rx thread
[   54.490536] smpboot: CPU 2 is now offline
[   54.490676] CPU 2 offline: Remove Rx thread
[   54.492095] smpboot: CPU 3 is now offline
[   54.492242] CPU 3 offline: Remove Rx thread
[   54.493810] smpboot: CPU 4 is now offline
[   54.494017] CPU 4 offline: Remove Rx thread
[   54.495326] smpboot: CPU 5 is now offline
[   54.495477] CPU 5 offline: Remove Rx thread
[   54.495788] Broke affinity for irq 42
[   54.496805] smpboot: CPU 6 is now offline
[   54.496971] CPU 6 offline: Remove Rx thread
[   54.497277] Broke affinity for irq 23
[   54.497279] Broke affinity for irq 41
[   54.498300] smpboot: CPU 7 is now offline
[   54.498534] CPU 7 offline: Remove Rx thread
[   54.498641] Extended CMOS year: 2000
[   54.499792] ACPI: Low-level resume complete
[   54.499834] PM: Restoring platform NVS memory
[   54.501452] Extended CMOS year: 2000
[   54.502155] microcode: CPU0 updated to revision 0x13, date = 2012-07-16
[   54.502187] Enabling non-boot CPUs ...
[   54.502256] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   54.516592] microcode: CPU1 updated to revision 0x13, date = 2012-07-16
[   54.516596] bnx2i: CPU 1 online: Create Rx thread
[   54.516638] CPU1 is up
[   54.516679] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   54.531035] microcode: CPU2 updated to revision 0x13, date = 2012-07-16
[   54.531039] bnx2i: CPU 2 online: Create Rx thread
[   54.531068] CPU2 is up
[   54.531109] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   54.545475] microcode: CPU3 updated to revision 0x13, date = 2012-07-16
[   54.545480] bnx2i: CPU 3 online: Create Rx thread
[   54.545508] CPU3 is up
[   54.545542] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   54.559845] microcode: CPU4 updated to revision 0x13, date = 2012-07-16
[   54.559849] bnx2i: CPU 4 online: Create Rx thread
[   54.559880] CPU4 is up
[   54.559914] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   54.574260] microcode: CPU5 updated to revision 0x13, date = 2012-07-16
[   54.574264] bnx2i: CPU 5 online: Create Rx thread
[   54.574289] CPU5 is up
[   54.574322] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   54.588624] microcode: CPU6 updated to revision 0x13, date = 2012-07-16
[   54.588633] bnx2i: CPU 6 online: Create Rx thread
[   54.588660] CPU6 is up
[   54.588688] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   54.602966] microcode: CPU7 updated to revision 0x13, date = 2012-07-16
[   54.602969] bnx2i: CPU 7 online: Create Rx thread
[   54.602995] CPU7 is up
[   54.613273] ACPI: Waking up from system sleep state S3
[   54.685567] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI
[   54.707544] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI
[   54.729531] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI
[   54.740565] nouveau 0000:01:00.0: power state changed by ACPI to D0
[   54.773587] PM: noirq resume of devices complete after 109.717 msecs
[   54.773683] PM: early resume of devices complete after 0.074 msecs
[   54.773712] i915 0000:00:02.0: setting latency timer to 64
[   54.773723] xhci_hcd 0000:00:14.0: setting latency timer to 64
[   54.773756] ehci-pci 0000:00:1a.0: setting latency timer to 64
[   54.773768] usb usb1: root hub lost power or was reset
[   54.773770] usb usb3: root hub lost power or was reset
[   54.773772] usb usb4: root hub lost power or was reset
[   54.773793] ahci 0000:00:1f.2: setting latency timer to 64
[   54.773794] nouveau  [     DRM] re-enabling device...
[   54.773811] mei 0000:00:16.0: irq 44 for MSI/MSI-X
[   54.773845] xhci_hcd 0000:00:14.0: Slot 1 endpoint 2 not removed from BW
list!
[   54.773851] nouveau  [     DRM] resuming client object trees...
[   54.773856] nouveau  [   VBIOS][0000:01:00.0] running init tables
[   54.773870] alx 0000:04:00.0: System wakeup disabled by ACPI
[   54.773891] snd_hda_intel 0000:00:1b.0: irq 42 for MSI/MSI-X
[   54.773931] ehci-pci 0000:00:1d.0: setting latency timer to 64
[   54.773991] usb usb2: root hub lost power or was reset
[   54.774078] xhci_hcd 0000:00:14.0: irq 46 for MSI/MSI-X
[   54.776668] mei 0000:00:16.0: unexpected reset: dev_state = RESETING
[   54.777665] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[   54.777876] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[   54.925686] nouveau  [     DRM] resuming display...
[   55.079363] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   55.080891] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   55.080903] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   55.081303] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   55.082027] ata2.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[   55.082111] ata2.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   55.082115] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   55.083149] ata2.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[   55.083154] ata3.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   55.083155] ata3.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   55.083231] ata2.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   55.083235] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   55.083509] ata3.00: configured for UDMA/100
[   55.083579] ata2.00: configured for UDMA/133
[   55.083738] sd 1:0:0:0: [sdb] Starting disk
[   55.228348] usb 3-3: reset low-speed USB device number 2 using xhci_hcd
[   55.242226] xhci_hcd 0000:00:14.0: xHCI xhci_drop_endpoint called with
disabled ep ffff88021ec41840
[   55.242232] usb 3-3: ep 0x81 - rounding interval to 64 microframes, ep desc
says 80 microframes
[   55.342262] usb 2-1: reset high-speed USB device number 2 using ehci-pci
[   55.558141] usb 1-1: reset high-speed USB device number 2 using ehci-pci
[   55.949055] usb 1-1.1: reset full-speed USB device number 3 using ehci-pci
[   56.027058] btusb 1-1.1:1.0: no reset_resume for driver btusb?
[   56.027061] btusb 1-1.1:1.1: no reset_resume for driver btusb?
[   56.097967] usb 1-1.3: reset high-speed USB device number 4 using ehci-pci
[   56.775847] [drm] Enabling RC6 states: RC6 on, RC6p on, RC6pp off
[   57.627026] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   57.633272] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[   57.633359] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   57.633363] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   57.645737] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK)
filtered out
[   57.645826] ata1.00: ACPI cmd ef/10:06:00:00:00:a0 (SET FEATURES) succeeded
[   57.645829] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered
out
[   57.651976] ata1.00: configured for UDMA/133
[   57.652361] sd 0:0:0:0: [sda] Starting disk
[   57.654026] Extended CMOS year: 2000
[   57.677143] PM: resume of devices complete after 2904.997 msecs
[   57.677639] PM: Finishing wakeup.
[   57.677640] Restarting tasks ... done.
[   57.690291] video LNXVIDEO:00: Restoring backlight state
[   57.690295] video LNXVIDEO:01: Restoring backlight state


###### sudo rmmod alx; sudo modprobe alx


[  102.414400] Qualcomm Atheros(R) AR816x/AR817x PCI-E Ethernet Network Driver
[  102.432649] alx 0000:04:00.0: alx(30:85:a9:01:9b:01): Qualcomm Atheros
Ethernet Network Connection
[  102.451912] systemd-udevd[2839]: renamed network interface eth0 to p3p1
[  102.460935] alx 0000:04:00.0: irq 47 for MSI/MSI-X
[  102.460958] alx 0000:04:00.0: irq 48 for MSI/MSI-X
[  102.460974] alx 0000:04:00.0: irq 49 for MSI/MSI-X
[  102.460991] alx 0000:04:00.0: irq 50 for MSI/MSI-X
[  102.461007] alx 0000:04:00.0: irq 51 for MSI/MSI-X
[  102.461025] alx 0000:04:00.0: irq 52 for MSI/MSI-X
[  102.461042] alx 0000:04:00.0: irq 53 for MSI/MSI-X
[  102.461059] alx 0000:04:00.0: irq 54 for MSI/MSI-X
[  102.461077] alx 0000:04:00.0: irq 55 for MSI/MSI-X
[  102.462652] IPv6: ADDRCONF(NETDEV_UP): p3p1: link is not ready
[  104.329822] alx 0000:04:00.0 p3p1: NIC Link Up: 1 Gbps Full
[  104.330071] IPv6: ADDRCONF(NETDEV_CHANGE): p3p1: link becomes ready

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
