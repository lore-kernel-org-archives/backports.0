Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46004 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab2K2TEh (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 29 Nov 2012 14:04:37 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 663FA2048E
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 19:04:36 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 9ECBF20487
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 19:04:34 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51061] brcmsmac crashes and disconnects
In-Reply-To: <bug-51061-58281@https.bugzilla.kernel.org/>
References: <bug-51061-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121129190433.954DB11FA54@bugzilla.kernel.org>
Date: Thu, 29 Nov 2012 19:04:33 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51061





--- Comment #1 from Luis R. Rodriguez <mcgrof@gmail.com>  2012-11-29 19:04:33 ---
Thanks for the great report, you've done your homework well. Arend I've added
you given that upon review I see no direct issues related to backport code but
instead this seems to be a real valid upstream issue that can likely be
reproduced as an interoperability issue with the Dlink AP and TP-Link AP. Upon
my review the logs do not detail why you are getting authentication timeouts
and the deauthentications by "Deauthenticated because sending station is
leaving " seems to happen as per the iw event logs likely because of the "RSSI
went below threshold", but not sure if the supplicant would kick you off just
because of this if you don't have another AP that it would try that would have
a better signal. Also I believe your supplicant (v1.0) is using the wext driver
and while this should work I encourage Linux distributions to use both:

  * 1) a newer wpa_supplicant (possibly development version, don't get me
started), and
  * 2) nl80211 driver for wpa_supplicant

I'll let Arend dig into the logs to see if he recognizes the issue but in the
meantime Mario a few things you could do is upgrade wpa_supplicant to the
latest git version, and also use the nl80211 driver, you can test it out
manually. Here's an example config:

mcgrof@frijol ~/wpa $ cat tesla-2g-bcm.conf 

ctrl_interface=/var/run/wpa_supplicant

network={
        ssid="tesla-2g-bcm"
        bgscan="simple:30:-45:300"
        key_mgmt=WPA-PSK
        proto=RSN
        pairwise=CCMP
        group=CCMP
        psk="somefoobar"
}

You would run:

sudo wpa_supplicant -i wlan0 -D nl80211 -c tesla-2g-bcm.conf

Arend, for what its worth the APs are in two channels on the 2.4 GHz band,
either on freq 2462 MHz (channel 11) or freq 2442 (channel 7).

I should note that you do have the fglrx driver and while that is proprietary
and taints the kernel I do not suspect that is an issue here. Arend, I do
believe the warning spit out is real and not caused by backport work but
instead a real driver warning.

[ 1219.926123] ------------[ cut here ]------------
[ 1219.926168] WARNING: at
/usr/local/src/compat-wireless-3.6.6-1/drivers/net/wireless/brcm80211/brcmsmac/main.c:8000
brcms_c_wait_for_tx_co
mpletion+0x99/0xb0 [brcmsmac]()
[ 1219.926178] Hardware name: 305U1A
[ 1219.926182] Modules linked in: usb_storage uas sg snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mix
er_oss ipv6 nls_iso8859_1 nls_cp437 vfat fat cpufreq_ondemand lp ppdev
parport_pc parport fuse btusb bluetooth uvcvideo videobuf2_vmalloc vi
deobuf2_memops videobuf2_core videodev brcmsmac(O) ohci_hcd ssb fglrx(PO)
cordic mmc_core sp5100_tco joydev powernow_k8 brcmutil(O) mac80211
(O) ehci_hcd samsung_laptop pcmcia pcmcia_core agpgart video mperf i2c_piix4
processor battery freq_table evdev i2c_core button ac k10temp c
fg80211(O) rfkill bcma(O) psmouse serio_raw thermal_sys hwmon
snd_hda_codec_realtek r8169 snd_hda_codec_hdmi compat(O) mii snd_hda_intel snd
_hda_codec snd_hwdep snd_pcm snd_page_alloc snd_timer snd soundcore microcode
loop
[ 1219.926331] Pid: 827, comm: kworker/u:6 Tainted: P           O
3.4.18_MDeC-nov12 #1
[ 1219.926338] Call Trace:
[ 1219.926356]  [<ffffffff8105082f>] warn_slowpath_common+0x7f/0xc0
[ 1219.926368]  [<ffffffff8105088a>] warn_slowpath_null+0x1a/0x20
[ 1219.926391]  [<ffffffffa06d7859>] brcms_c_wait_for_tx_completion+0x99/0xb0
[brcmsmac]
[ 1219.926410]  [<ffffffffa06ca60b>] brcms_ops_flush+0x3b/0x60 [brcmsmac]
[ 1219.926442]  [<ffffffffa01f7c3b>] __ieee80211_recalc_idle+0x23b/0x2f0
[mac80211]
[ 1219.926470]  [<ffffffffa01f8093>] ieee80211_recalc_idle+0x33/0x60 [mac80211]
[ 1219.926498]  [<ffffffffa02130f2>] ieee80211_sta_rx_queued_mgmt+0x392/0x5a0
[mac80211]
[ 1219.926524]  [<ffffffffa01f766c>] ieee80211_iface_work+0x25c/0x360
[mac80211]
[ 1219.926537]  [<ffffffff8106ab3b>] process_one_work+0x12b/0x400
[ 1219.926562]  [<ffffffffa01f7410>] ? ieee80211_check_queues+0x100/0x100
[mac80211]
[ 1219.926574]  [<ffffffff8106c36e>] worker_thread+0x12e/0x2d0
[ 1219.926586]  [<ffffffff8106c240>] ? manage_workers.isra.26+0x1f0/0x1f0
[ 1219.926596]  [<ffffffff810714d3>] kthread+0x93/0xa0
[ 1219.926607]  [<ffffffff81572cd4>] kernel_thread_helper+0x4/0x10
[ 1219.926618]  [<ffffffff81071440>] ? kthread_freezable_should_stop+0x70/0x70
[ 1219.926627]  [<ffffffff81572cd0>] ? gs_change+0xb/0xb
[ 1219.926634] ---[ end trace 5e1a1376ac921f6e ]---


Mario another thing you could do is try a new upgraded release of
compat-drivers, now based on v3.7:

http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.7-rc1/compat-drivers-3.7-rc1-3.tar.bz2

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
