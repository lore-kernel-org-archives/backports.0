Return-path: <backports-owner@vger.kernel.org>
Received: from fep27.mx.upcmail.net ([62.179.121.47]:52474 "EHLO
	fep27.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3DIOAJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Apr 2013 10:00:09 -0400
Received: from edge01.upcmail.net ([192.168.13.236])
          by viefep23-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20130409135826.CUGK17478.viefep23-int.chello.at@edge01.upcmail.net>
          for <backports@vger.kernel.org>; Tue, 9 Apr 2013 15:58:26 +0200
Message-ID: <1365508697.8720.11.camel@livecd.gentoo> (sfid-20130409_160018_285985_709149E7)
Subject: compat-drivers >=3.8 fails with inteldrmfb/i915
From: Stefan Kuhn <stefan.kuhn@hispeed.ch>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 09 Apr 2013 13:58:17 +0200
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello

compat-drivers works fine up to v3.7.9
Above that, it fails somewhere when loading the modules.
The result is a black screen right after booting.

I tested kernel versions 3.7.5 and 3.8.3 versus compat-drivers versions
3.7.9, 3.8.0 and 3.8.3 - so I'm rather positive the change happened
between compat-driver 3.7.9 and 3.8.0.

My suspicion is that it fails when moving from the "EFI VGA" to the
"inteldrmfb" driver.

Below is a sample of the dmesg log of kernel 3.7.5 vs. cp-drivers 3.8.0.
All other logs can be found at:
http://code.google.com/p/compat-drivers-i915-issue/
(I don't want to clog up everyones mail account)

I'm happy for any advice or hint and willing to provide any logs or run
tests, this has cost me days already!

Greetings
Stefan



Sample output of dmesg:

26.222313 checking generic (d0000000 300000) vs hw (d0000000 10000000)
26.222314 fb: conflicting fb hw usage inteldrmfb vs EFI VGA - removing
generic driver
26.222328 Console: switching to colour dummy device 80x25
26.222422 i915 0000:00:02.0: setting latency timer to 64
26.254305 mtrr: type mismatch for d0000000,10000000 old: write-back new:
write-combining
26.254307 drm? MTRR allocation failed. Graphics performance may suffer.
26.254419 i915 0000:00:02.0: irq 48 for MSI/MSI-X
26.254426 drm? Supports vblank timestamp caching Rev 1 (10.10.2010).
26.254427 drm? Driver supports precise vblank timestamp query.
26.254504 vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io
+mem,decodes=none:owns=io+mem
26.254505 vgaarb: transferring owner from PCI:0000:00:02.0 to
PCI:0000:01:00.0
26.316654 BUG: unable to handle kernel NULL pointer dereference at
(null)
26.316661 IP: [<ffffffffa006fc3f>] intel_enable_gtt+0xb/0x13f intel_gtt?
....
....
26.316796 Call Trace:
26.316813 [<ffffffffa082b4cd>] ? i915_gem_init_hw+0x29/0x13b i915?
26.316824 [<ffffffffa082b699>] ? i915_gem_init+0xba/0xf9 i915?
26.316836 [<ffffffffa081b4e4>] ? i915_driver_load+0xb1c/0xd23 i915?
26.316846 [<ffffffffa0e1ffdb>] ? drm_get_pci_dev+0x152/0x254 drm?
26.316851 [<ffffffff81396e5d>] ? pci_device_probe+0x63/0x9e
26.316856 [<ffffffff814254d9>] ? driver_probe_device+0xa1/0x1ac
26.316859 [<ffffffff81425633>] ? driver_attach+0x4f/0x6f
26.316862 [<ffffffff814255e4>] ? driver_probe_device+0x1ac/0x1ac
26.316865 [<ffffffff81423f18>] ? bus_for_each_dev+0x4a/0x75
26.316869 [<ffffffff81424cc9>] ? bus_add_driver+0xbc/0x207
26.316873 [<ffffffffa06e4000>] ? 0xffffffffa06e3fff
26.316876 [<ffffffff81425a47>] ? driver_register+0x85/0xfa
26.316879 [<ffffffffa06e4000>] ? 0xffffffffa06e3fff
26.316884 [<ffffffff81000226>] ? do_one_initcall+0x75/0x127
26.316888 [<ffffffff810c397b>] ? sys_init_module+0x7c/0x1bb
26.316893 [<ffffffff8167c996>] ? system_call_fastpath+0x1a/0x1f

