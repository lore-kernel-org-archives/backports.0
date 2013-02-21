Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41305 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab3BUHss (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Feb 2013 02:48:48 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2606E20253
	for <backports@vger.kernel.org>; Thu, 21 Feb 2013 07:48:46 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 67AB12024D
	for <backports@vger.kernel.org>; Thu, 21 Feb 2013 07:48:41 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130221074840.5D02411FC73@bugzilla.kernel.org>
Date: Thu, 21 Feb 2013 07:48:40 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671


mp-001@ponschab.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mp-001@ponschab.de




--- Comment #10 from mp-001@ponschab.de  2013-02-21 07:48:40 ---
Im on fedora 18 running on asus n76vm. Since upgraded from fedora 17 alx will
crash when the interface comes up. When running the f17 kernel i've kept
(vmlinuz-3.6.11-1.fc17.x86_64), alx is quite usable.


wget
http://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/20/compat-drivers-2013-02-20-u.tar.bz2
tar -xf compat-drivers-2013-02-20-u.tar.bz2
cd compat-drivers-2013-02-20-u
./scripts/driver-select alx
sudo make install
sudo modprobe alx

===
Feb 21 08:16:46 N38 kernel: [36872.286081] Disabling lock debugging due to
kernel taint
Feb 21 08:16:46 N38 kernel: [36872.286499] Compat-drivers backport release:
compat-drivers-2013-02-20-u
Feb 21 08:16:46 N38 kernel: [36872.286500] Backport based on linux-next.git
next-20130220
Feb 21 08:16:46 N38 kernel: [36872.286501] compat.git: linux-next.git
Feb 21 08:16:46 N38 kernel: [36872.288050] Qualcomm Atheros(R) AR816x/AR817x
PCI-E Ethernet Network Driver
Feb 21 08:16:46 N38 kernel: [36872.290175] alx 0000:04:00.0:
alx(30:85:a9:01:9b:01): Qualcomm Atheros Ethernet Network Connection
Feb 21 08:16:46 N38 systemd-udevd[427]: specified group 'input' unknown
Feb 21 08:16:46 N38 NetworkManager[889]: <warn> failed to allocate link cache:
(-10) Operation not supported
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): carrier is OFF
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): new Ethernet device
(driver: 'alx' ifindex: 9)
Feb 21 08:16:46 N38 kernel: [36872.372088] IPv6: ADDRCONF(NETDEV_UP): p3p1:
link is not ready
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): exported as
/org/freedesktop/NetworkManager/Devices/1
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): device state change:
unmanaged -> unavailable (reason 'managed') [10 20 2]
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): bringing up device.
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): preparing device.
Feb 21 08:16:46 N38 NetworkManager[889]: <info> (p3p1): deactivating device
(reason 'managed') [2]
===

Since the driver does not detect a link, i restart NetworkManager:

service NetworkManager restart

Then it crashes:

===
...
Feb 21 08:18:12 N38 kernel: [36957.690744] ------------[ cut here ]------------
Feb 21 08:18:12 N38 kernel: [36957.690761] WARNING: at
net/sched/sch_generic.c:255 dev_watchdog+0x238/0x250()
Feb 21 08:18:12 N38 kernel: [36957.690764] Hardware name: N76VM
Feb 21 08:18:12 N38 kernel: [36957.690767] NETDEV WATCHDOG: p3p1 (alx):
transmit queue 3 timed out
Feb 21 08:18:12 N38 kernel: [36957.690769] Modules linked in: alx(OF)
compat(OF) usb_storage dm_crypt tcp_lp fuse ebtable_nat ebtables ipt_MASQUERADE
iptable_nat nf_nat_ipv4 nf_nat xt_CHECKSUM iptable_mangle bridge stp llc lockd
sunrpc rfcomm bnep be2iscsi iscsi_boot_sysfs bnx2i cnic uio cxgb4i cxgb4 cxgb3i
cxgb3 mdio libcxgbi ib_iser rdma_cm ip6t_REJECT ib_addr nf_conntrack_ipv4
nf_conntrack_ipv6 iw_cm nf_defrag_ipv4 nf_defrag_ipv6 ib_cm ib_sa ib_mad
xt_conntrack nf_conntrack ib_core iscsi_tcp ip6table_filter libiscsi_tcp
libiscsi ip6_tables scsi_transport_iscsi binfmt_misc snd_hda_codec_realtek arc4
snd_hda_intel snd_hda_codec iTCO_wdt asus_nb_wmi asus_wmi iTCO_vendor_support
snd_hwdep sparse_keymap uvcvideo snd_seq videobuf2_vmalloc snd_seq_device
iwldvm videobuf2_memops videobuf2_core snd_pcm videodev vhost_net btusb
mac80211 media tun bluetooth macvtap macvlan coretemp kvm_intel kvm iwlwifi
snd_page_alloc uinput cfg80211 snd_timer snd lpc_ich joydev rfkill soundcore
mei microcode i2c_i801 serio_raw mfd_core nouveau crc32c_intel i915
i2c_algo_bit ttm drm_kms_helper ghash_clmulni_intel drm mxm_wmi i2c_core wmi
video
Feb 21 08:18:12 N38 kernel: [36957.690878] Pid: 0, comm: swapper/0 Tainted: GF 
        O 3.7.8-202.fc18.x86_64 #1
Feb 21 08:18:12 N38 kernel: [36957.690880] Call Trace:
Feb 21 08:18:12 N38 kernel: [36957.690883]  <IRQ>  [<ffffffff8105e6df>]
warn_slowpath_common+0x7f/0xc0
Feb 21 08:18:12 N38 kernel: [36957.690897]  [<ffffffff8105e7d6>]
warn_slowpath_fmt+0x46/0x50
Feb 21 08:18:12 N38 kernel: [36957.690904]  [<ffffffff81096365>] ?
sched_clock_cpu+0xc5/0x120
Feb 21 08:18:12 N38 kernel: [36957.690910]  [<ffffffff815456c8>]
dev_watchdog+0x238/0x250
Feb 21 08:18:12 N38 kernel: [36957.690914]  [<ffffffff81545490>] ?
dev_deactivate_queue.constprop.30+0x80/0x80
Feb 21 08:18:12 N38 kernel: [36957.690921]  [<ffffffff8106d3ea>]
call_timer_fn+0x3a/0x120
Feb 21 08:18:12 N38 kernel: [36957.690926]  [<ffffffff81092ac9>] ?
scheduler_tick+0x109/0x140
Feb 21 08:18:12 N38 kernel: [36957.690930]  [<ffffffff81545490>] ?
dev_deactivate_queue.constprop.30+0x80/0x80
Feb 21 08:18:12 N38 kernel: [36957.690937]  [<ffffffff8106f17e>]
run_timer_softirq+0x1fe/0x2b0
Feb 21 08:18:12 N38 kernel: [36957.690942]  [<ffffffff81067060>]
__do_softirq+0xd0/0x210
Feb 21 08:18:12 N38 kernel: [36957.690948]  [<ffffffff8101b903>] ?
native_sched_clock+0x13/0x80
Feb 21 08:18:12 N38 kernel: [36957.690954]  [<ffffffff81640b9c>]
call_softirq+0x1c/0x30
Feb 21 08:18:12 N38 kernel: [36957.690961]  [<ffffffff81016315>]
do_softirq+0x75/0xb0
Feb 21 08:18:12 N38 kernel: [36957.690965]  [<ffffffff81067335>]
irq_exit+0xb5/0xc0
Feb 21 08:18:12 N38 kernel: [36957.690969]  [<ffffffff8164152e>]
smp_apic_timer_interrupt+0x6e/0x99
Feb 21 08:18:12 N38 kernel: [36957.690976]  [<ffffffff8164045d>]
apic_timer_interrupt+0x6d/0x80
Feb 21 08:18:12 N38 kernel: [36957.690978]  <EOI>  [<ffffffff81346c50>] ?
intel_idle+0xf0/0x150
Feb 21 08:18:12 N38 kernel: [36957.690988]  [<ffffffff81346c2e>] ?
intel_idle+0xce/0x150
Feb 21 08:18:12 N38 kernel: [36957.690996]  [<ffffffff814df899>]
cpuidle_enter+0x19/0x20
Feb 21 08:18:12 N38 kernel: [36957.691001]  [<ffffffff814dff29>]
cpuidle_idle_call+0xa9/0x260
Feb 21 08:18:12 N38 kernel: [36957.691006]  [<ffffffff8101d4af>]
cpu_idle+0xaf/0x120
Feb 21 08:18:12 N38 kernel: [36957.691013]  [<ffffffff816139c2>]
rest_init+0x72/0x80
Feb 21 08:18:12 N38 kernel: [36957.691021]  [<ffffffff81cfbc44>]
start_kernel+0x3d1/0x3de
Feb 21 08:18:12 N38 kernel: [36957.691026]  [<ffffffff81cfb672>] ?
repair_env_string+0x5e/0x5e
Feb 21 08:18:12 N38 kernel: [36957.691032]  [<ffffffff81cfb356>]
x86_64_start_reservations+0x131/0x135
Feb 21 08:18:12 N38 kernel: [36957.691037]  [<ffffffff81cfb45a>]
x86_64_start_kernel+0x100/0x10f
Feb 21 08:18:12 N38 kernel: [36957.691040] ---[ end trace aea5f9c812fd911f ]---
Feb 21 08:18:12 N38 kernel: [36957.691046] alx 0000:04:00.0 p3p1:
-----------------TPD-ring(0)------------------
Feb 21 08:18:12 N38 kernel: [36957.691052] alx 0000:04:00.0 p3p1: F8:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691056] alx 0000:04:00.0 p3p1: F9:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691059] alx 0000:04:00.0 p3p1: FA:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691062] alx 0000:04:00.0 p3p1: FB:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691065] alx 0000:04:00.0 p3p1: FC:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691069] alx 0000:04:00.0 p3p1: FD:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691072] alx 0000:04:00.0 p3p1: FE:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691075] alx 0000:04:00.0 p3p1: FF:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691078] alx 0000:04:00.0 p3p1: 0:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691081] alx 0000:04:00.0 p3p1: 1:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691084] alx 0000:04:00.0 p3p1: 2:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691088] alx 0000:04:00.0 p3p1: 3:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691091] alx 0000:04:00.0 p3p1:
-----------------TPD-ring(1)------------------
Feb 21 08:18:12 N38 kernel: [36957.691094] alx 0000:04:00.0 p3p1: F8:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691097] alx 0000:04:00.0 p3p1: F9:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691100] alx 0000:04:00.0 p3p1: FA:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691103] alx 0000:04:00.0 p3p1: FB:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691106] alx 0000:04:00.0 p3p1: FC:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691110] alx 0000:04:00.0 p3p1: FD:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691113] alx 0000:04:00.0 p3p1: FE:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691116] alx 0000:04:00.0 p3p1: FF:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691119] alx 0000:04:00.0 p3p1: 0:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691122] alx 0000:04:00.0 p3p1: 1:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691125] alx 0000:04:00.0 p3p1: 2:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691129] alx 0000:04:00.0 p3p1: 3:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691132] alx 0000:04:00.0 p3p1:
-----------------TPD-ring(2)------------------
Feb 21 08:18:12 N38 kernel: [36957.691135] alx 0000:04:00.0 p3p1: F8:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691138] alx 0000:04:00.0 p3p1: F9:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691141] alx 0000:04:00.0 p3p1: FA:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691144] alx 0000:04:00.0 p3p1: FB:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691147] alx 0000:04:00.0 p3p1: FC:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691150] alx 0000:04:00.0 p3p1: FD:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691154] alx 0000:04:00.0 p3p1: FE:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691157] alx 0000:04:00.0 p3p1: FF:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691161] alx 0000:04:00.0 p3p1: 0:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691164] alx 0000:04:00.0 p3p1: 1:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691168] alx 0000:04:00.0 p3p1: 2:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691171] alx 0000:04:00.0 p3p1: 3:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691174] alx 0000:04:00.0 p3p1:
-----------------TPD-ring(3)------------------
Feb 21 08:18:12 N38 kernel: [36957.691177] alx 0000:04:00.0 p3p1: F9:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691181] alx 0000:04:00.0 p3p1: FA:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691184] alx 0000:04:00.0 p3p1: FB:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691187] alx 0000:04:00.0 p3p1: FC:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691190] alx 0000:04:00.0 p3p1: FD:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691193] alx 0000:04:00.0 p3p1: FE:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691196] alx 0000:04:00.0 p3p1: FF:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691200] alx 0000:04:00.0 p3p1: 0:
W0=0000005A, W1=80000000, W2=35EFF002
Feb 21 08:18:12 N38 kernel: [36957.691203] alx 0000:04:00.0 p3p1: 1:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691206] alx 0000:04:00.0 p3p1: 2:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691209] alx 0000:04:00.0 p3p1: 3:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691212] alx 0000:04:00.0 p3p1: 4:
W0=00000000, W1=00000000, W2=0
Feb 21 08:18:12 N38 kernel: [36957.691215] alx 0000:04:00.0 p3p1:
---------------dump registers-----------------
Feb 21 08:18:12 N38 kernel: [36957.691227] alx 0000:04:00.0 p3p1: 1400:
C0020CE0,00000000,00000064,00001C01
Feb 21 08:18:12 N38 kernel: [36957.691237] alx 0000:04:00.0 p3p1: 1410:
00002214,474019AA,03FE003E,00000000
Feb 21 08:18:12 N38 kernel: [36957.691248] alx 0000:04:00.0 p3p1: 1420:
00000000,E03EBB60,00000240,CF01C831
Feb 21 08:18:12 N38 kernel: [36957.691258] alx 0000:04:00.0 p3p1: 1430:
0000CC01,00000000,00000000,00000010
Feb 21 08:18:12 N38 kernel: [36957.691269] alx 0000:04:00.0 p3p1: 1440:
8010020C,00000020,0007801A,00000180
Feb 21 08:18:12 N38 kernel: [36957.691279] alx 0000:04:00.0 p3p1: 1450:
00000000,14700040,00000040,00000000
Feb 21 08:18:12 N38 kernel: [36957.691290] alx 0000:04:00.0 p3p1: 1460:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691300] alx 0000:04:00.0 p3p1: 1470:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691310] alx 0000:04:00.0 p3p1: 1480:
64205CEF,60405060,A9019B01,00003085
Feb 21 08:18:12 N38 kernel: [36957.691321] alx 0000:04:00.0 p3p1: 1490:
80000010,40000000,07A1F037,000005F2
Feb 21 08:18:12 N38 kernel: [36957.691331] alx 0000:04:00.0 p3p1: 14A0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691342] alx 0000:04:00.0 p3p1: 14B0:
3BED200D,14364D17,6A3E67EA,B855AABE
Feb 21 08:18:12 N38 kernel: [36957.691352] alx 0000:04:00.0 p3p1: 14C0:
E214AD3D,EA49AF7C,A54F2BEC,2A94B30D
Feb 21 08:18:12 N38 kernel: [36957.691362] alx 0000:04:00.0 p3p1: 14D0:
1805EC6C,E291D73D,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691373] alx 0000:04:00.0 p3p1: 14E0:
1CBEB000,1CBEA000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691383] alx 0000:04:00.0 p3p1: 14F0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691393] alx 0000:04:00.0 p3p1: 1500:
05FF05E0,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691403] alx 0000:04:00.0 p3p1: 1510:
00000020,00000000,0BDF0BC0,00000020
Feb 21 08:18:12 N38 kernel: [36957.691414] alx 0000:04:00.0 p3p1: 1520:
05DF0000,000005E0,0BBF0600,000005C0
Feb 21 08:18:12 N38 kernel: [36957.691424] alx 0000:04:00.0 p3p1: 1530:
06000BE0,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691434] alx 0000:04:00.0 p3p1: 1540:
00000001,00000001,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691446] alx 0000:04:00.0 p3p1: 1550:
1CBEE000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691456] alx 0000:04:00.0 p3p1: 1560:
00000200,000005F8,1CBEC000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691466] alx 0000:04:00.0 p3p1: 1570:
00000000,00000000,00000200,1CBE9000
Feb 21 08:18:12 N38 kernel: [36957.691477] alx 0000:04:00.0 p3p1: 1580:
1CBE8000,00000100,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691487] alx 0000:04:00.0 p3p1: 1590:
020000F5,000008BF,01800080,00000000
Feb 21 08:18:12 N38 kernel: [36957.691498] alx 0000:04:00.0 p3p1: 15A0:
AC8080BF,00001210,00C0044E,00000100
Feb 21 08:18:12 N38 kernel: [36957.691508] alx 0000:04:00.0 p3p1: 15B0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691519] alx 0000:04:00.0 p3p1: 15C0:
04047C24,00030D40,00000055,000000C8
Feb 21 08:18:12 N38 kernel: [36957.691529] alx 0000:04:00.0 p3p1: 15D0:
00214321,00000000,00438765,00000000
Feb 21 08:18:12 N38 kernel: [36957.691539] alx 0000:04:00.0 p3p1: 15E0:
000001FF,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691550] alx 0000:04:00.0 p3p1: 15F0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691560] alx 0000:04:00.0 p3p1: 1600:
00201081,7C0F96E7,00004E20,00000000
Feb 21 08:18:12 N38 kernel: [36957.691572] alx 0000:04:00.0 p3p1: 1610:
FFFFFFFB,00000000,00000001,00000001
Feb 21 08:18:12 N38 kernel: [36957.691582] alx 0000:04:00.0 p3p1: 1620:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691592] alx 0000:04:00.0 p3p1: 1630:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691602] alx 0000:04:00.0 p3p1: 1640:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691612] alx 0000:04:00.0 p3p1: 1650:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691622] alx 0000:04:00.0 p3p1: 1660:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691633] alx 0000:04:00.0 p3p1: 1670:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691644] alx 0000:04:00.0 p3p1: 1680:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691654] alx 0000:04:00.0 p3p1: 1690:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691664] alx 0000:04:00.0 p3p1: 16A0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691674] alx 0000:04:00.0 p3p1: 16B0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691685] alx 0000:04:00.0 p3p1: 16C0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691695] alx 0000:04:00.0 p3p1: 16D0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691706] alx 0000:04:00.0 p3p1: 16E0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691716] alx 0000:04:00.0 p3p1: 16F0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691746] alx 0000:04:00.0 p3p1: 1700:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691756] alx 0000:04:00.0 p3p1: 1710:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691767] alx 0000:04:00.0 p3p1: 1720:
00000000,00000000,00000001,00000000
Feb 21 08:18:12 N38 kernel: [36957.691778] alx 0000:04:00.0 p3p1: 1730:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691790] alx 0000:04:00.0 p3p1: 1740:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691807] alx 0000:04:00.0 p3p1: 1750:
00000000,00000000,00000000,00000001
Feb 21 08:18:12 N38 kernel: [36957.691819] alx 0000:04:00.0 p3p1: 1760:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691830] alx 0000:04:00.0 p3p1: 1770:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691841] alx 0000:04:00.0 p3p1: 1780:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691852] alx 0000:04:00.0 p3p1: 1790:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691863] alx 0000:04:00.0 p3p1: 17A0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691875] alx 0000:04:00.0 p3p1: 17B0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691887] alx 0000:04:00.0 p3p1: 17C0:
00000000,00000000,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691898] alx 0000:04:00.0 p3p1: 17D0:
00000000,00000001,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691909] alx 0000:04:00.0 p3p1: 17E0:
00000000,0000005A,00000000,00000000
Feb 21 08:18:12 N38 kernel: [36957.691920] alx 0000:04:00.0 p3p1: 17F0:
00000000,00000000,00000000,00000000
===

Have to hard reset the box, can't unload the module.

There are people having related problems: 
https://aur.archlinux.org/packages/dkms-alx/

Any info i can provide?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
