Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6787C433EF
	for <backports@archiver.kernel.org>; Fri, 27 May 2022 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiE0GnN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 27 May 2022 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiE0GnM (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 27 May 2022 02:43:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC12CED790
        for <backports@vger.kernel.org>; Thu, 26 May 2022 23:43:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w14so5394205lfl.13
        for <backports@vger.kernel.org>; Thu, 26 May 2022 23:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3n7ZV4Rhp1V8sHuBeRb4Wdw2yJPE+DH/Y0HfwGnL640=;
        b=RRbvSmjalG4NA89isprWqX87R7CXo8qAYfaABdqH5+C5GUY3mlbJTDIGO1+ygLxLES
         mUl2K+rusqRbG21d4PsJIDvNYSTXrJYcynRxgPqDEzga3JwkpaCXsQLFvaCtB3g/yy3O
         h0N9/eWQNaJRUL1A/wvJMbZ9h+KBCrTgEsp5/GmnBJjJDixDhLO+CtBzeLtU9y6+evmq
         2LOg7uvulzvvQ17AeYquXFIZDfwbq/egEHUkJ2Ya95mW5k4QIa7anZHYCFIIqYVIpbRi
         blzK+SHjYmhllEIZGbyxz40x3rZFoYSgL3ub2iO4/1Yr7evc1pNr2Z+LSXap5HZ1U4go
         GIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3n7ZV4Rhp1V8sHuBeRb4Wdw2yJPE+DH/Y0HfwGnL640=;
        b=MbCKalEj1/AO2WheE68WgeKjCSiNwmCcIaxFDAzuWOG+WNne92g7MQab6ca4uu4Hyf
         Wo9wKexZBo5ZlgZu0aU8mOT3ci+eZWRF6ltwXxun1+ohG2ddPkuyaVCFRQCY4CoMM+nv
         Nibgs/qCU+wRdSGBouwe3ppJDE1fdQWF+5mbbglVRhwDcUqi5a0vdd9eRvbm8OLCu618
         +eKCknqdwkr4pFJBF3AefctagpKnzr4IrhH8/oBu2doOVIf7eBaB4TTfArQMTy/tffzb
         oOHDg9HYqdvx5++CC/qvCVwESqZkAL5UKuTk+LyPGJFPC3Ea5Zz+VyRjO8SaBHOZeAWF
         V3wg==
X-Gm-Message-State: AOAM5310G6od2/XdD7j9zfu/VaL+QbrxWCMf9zK3Nrq0vvDdtQ0wOMU2
        SpvJ6ft/h2nzezHXVm3GV8eQTNML8jXNElde0mlBeJUB
X-Google-Smtp-Source: ABdhPJxUMAB7xxTk9p5dm2LHGeVbJsGvB+ssdvlAG3Nf0hdkVGHSUHIgeyWbCBbb8SObU42kMdZGf3oSj6LoBMIpgUU=
X-Received: by 2002:a05:6512:499:b0:477:c524:11bc with SMTP id
 v25-20020a056512049900b00477c52411bcmr26872204lfq.218.1653633788845; Thu, 26
 May 2022 23:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+BgFQUdDoCx_zrxNjWGKWNMjioimeO+CSzGkx3Zg14bbbNpQA@mail.gmail.com>
In-Reply-To: <CA+BgFQUdDoCx_zrxNjWGKWNMjioimeO+CSzGkx3Zg14bbbNpQA@mail.gmail.com>
From:   =?UTF-8?Q?Nicol=C3=B2_Sprea?= <nsprea@gmail.com>
Date:   Fri, 27 May 2022 08:42:57 +0200
Message-ID: <CA+BgFQX=E53UWdw0u+36eO8KZB5HwTFM8Usp5Ju2b4eC6ah_Fg@mail.gmail.com>
Subject: Backport wifi drivers from 5.15.8.1-1 to 4.15.0-38 not compatible
 with NetworkManager 1.2.6
To:     backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi backport team,
I'm trying to backport wifi drivers from 5.15.8.1-1 to 4.15.0-3.
However, starting NetworkManager results in the following kernel trace:

kernel: [ 1442.859649] BUG: unable to handle kernel NULL pointer
dereference at 00000000000001e8
kernel: [ 1442.859835] IP: cfg80211_init_wdev+0xa3/0x150 [cfg80211]
kernel: [ 1442.859917] PGD 8000000187ac4067 P4D 8000000187ac4067 PUD
186ce3067 PMD 0
kernel: [ 1442.860037] Oops: 0000 [#1] SMP PTI
kernel: [ 1442.860095] Modules linked in: ccm snd_hda_codec_hdmi bnep
binfmt_misc snd_soc_skl snd_soc_skl_ipc snd_hda_ext_core 8250_dw
snd_soc_sst_dsp snd_soc_sst_ipc snd_soc_acpi snd_soc_core snd_compress
ac97_bus snd_pcm_dmaengine snd_hda_intel snd_hda_codec snd_hda_core
snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi
ipt_REJECT nf_reject_ipv4 bridge ath10k_pci(OE) stp nf_log_ipv4 llc
nf_log_common ath10k_core(OE) snd_seq xt_LOG ath(OE) xt_limit
intel_rapl xt_tcpudp x86_pkg_temp_thermal intel_powerclamp xt_addrtype
coretemp snd_seq_device kvm_intel snd_timer kvm mac80211(OE) irqbypass
intel_cstate intel_rapl_perf btusb snd btrtl btbcm joydev btintel
input_leds bluetooth idma64 mei_me virt_dma intel_wmi_thunderbolt
cfg80211(OE) compat(OE) soundcore ecdh_generic mei intel_lpss_pci
intel_lpss shpchp
May 24 14:23:14 mir kernel: [ 1442.861207]  intel_pch_thermal
intel_vbtn sparse_keymap acpi_pad nf_conntrack_ipv4 nf_defrag_ipv4
mac_hid xt_conntrack ip6table_filter ip6_tables
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat
nf_conntrack_ftp nf_conntrack iptable_filter ip_tables x_tables
ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
scsi_transport_iscsi autofs4 btrfs zstd_compress raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear i915 crct10dif_pclmul
crc32_pclmul drm_kms_helper hid_logitech_hidpp ghash_clmulni_intel
syscopyarea pcbc hid_logitech_dj igb sysfillrect e1000e sysimgblt
aesni_intel fb_sys_fops dca i2c_algo_bit aes_x86_64 usbhid crypto_simd
ptp glue_helper wmi hid drm cryptd ahci pps_core libahci video
kernel: [ 1442.862346] CPU: 1 PID: 29290 Comm: wpa_supplicant Tainted:
G           OE    4.15.0-38-generic #41~16.04.1-Ubuntu
kernel: [ 1442.862492] Hardware name: DFI Inc. SU25x/EC70A, BIOS
B208.07C 08/07/2020
kernel: [ 1442.862644] RIP: 0010:cfg80211_init_wdev+0xa3/0x150 [cfg80211]
kernel: [ 1442.862737] RSP: 0018:ffffba9701feba20 EFLAGS: 00010282
kernel: [ 1442.862822] RAX: 0000000000000000 RBX: ffffa07e07ad0010
RCX: 0000000000000000
kernel: [ 1442.862938] RDX: ffffffffc09de1cc RSI: ffffffffc09bfa39
RDI: ffffa07e07ad0058
kernel: [ 1442.863054] RBP: ffffba9701feba28 R08: 0000000000000000
R09: ffffa07e07ad0010
kernel: [ 1442.863165] R10: ffffba9701feba08 R11: ffffa07e08ca0000
R12: ffffa07e07ad0010
kernel: [ 1442.863278] R13: ffffba9701febaf8 R14: ffffa07eb6f40000
R15: ffffa07eb6f40300
kernel: [ 1442.863410] FS:  00007f1e91b15880(0000)
GS:ffffa07ec2480000(0000) knlGS:0000000000000000
kernel: [ 1442.863541] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [ 1442.863637] CR2: 00000000000001e8 CR3: 0000000188968002
CR4: 00000000003606e0
kernel: [ 1442.863748] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
kernel: [ 1442.863857] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
kernel: [ 1442.863967] Call Trace:
kernel: [ 1442.864074]  nl80211_new_interface+0x348/0x4a0 [cfg80211]
kernel: [ 1442.864174]  genl_family_rcv_msg+0x1fe/0x3e0
kernel: [ 1442.864258]  genl_rcv_msg+0x4c/0x90
kernel: [ 1442.864327]  ? genl_family_rcv_msg+0x3e0/0x3e0
kernel: [ 1442.864416]  netlink_rcv_skb+0xd9/0x110
kernel: [ 1442.864489]  genl_rcv+0x28/0x40
kernel: [ 1442.864547]  netlink_unicast+0x198/0x260
kernel: [ 1442.864618]  netlink_sendmsg+0x2e2/0x3d0
kernel: [ 1442.869965]  sock_sendmsg+0x3e/0x50
kernel: [ 1442.874568]  ___sys_sendmsg+0x2e9/0x300
kernel: [ 1442.879477]  ? mem_cgroup_commit_charge+0x82/0x510
kernel: [ 1442.884419]  ? __handle_mm_fault+0xf96/0x11e0
kernel: [ 1442.889381]  __sys_sendmsg+0x54/0x90
kernel: [ 1442.893967]  ? __sys_sendmsg+0x54/0x90
kernel: [ 1442.898509]  SyS_sendmsg+0x12/0x20
kernel: [ 1442.903369]  do_syscall_64+0x73/0x130
kernel: [ 1442.906876]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
kernel: [ 1442.909850] RIP: 0033:0x7f1e903bd8a0
kernel: [ 1442.912841] RSP: 002b:00007ffd91351258 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
kernel: [ 1442.915343] RAX: ffffffffffffffda RBX: 00000000012d2900
RCX: 00007f1e903bd8a0
kernel: [ 1442.917929] RDX: 0000000000000000 RSI: 00007ffd913512e0
RDI: 0000000000000006
kernel: [ 1442.920371] RBP: 00000000012d3d00 R08: 0000000000000000
R09: 0000000000000000
kernel: [ 1442.922630] R10: 00000000012d4ca0 R11: 0000000000000246
R12: 00000000012d4c60
kernel: [ 1442.924470] R13: 00007ffd913512e0 R14: 00007ffd913514f0
R15: 0000000000000000
kernel: [ 1442.926252] Code: 00 48 b8 e0 ff ff ff 0f 00 00 00 48 89 83
d8 03 00 00 48 8d 83 e0 03 00 00 48 89 83 e0 03 00 00 48 89 83 e8 03
00 00 48 8b 43 20 <48> 83 b8 e8 01 00 00 00 0f 84 8a 00 00 00 48 8b 03
c6 83 b4 03
kernel: [ 1442.928219] RIP: cfg80211_init_wdev+0xa3/0x150 [cfg80211]
RSP: ffffba9701feba20
kernel: [ 1442.930159] CR2: 00000000000001e8
kernel: [ 1442.932054] ---[ end trace 0b637babb145a8e2 ]---

I'm running NetworkManager 1.2.6 and wpa_supplicant 2.4.
I don't get the same issue with netctl.

I encountered the same issue backporting from 4.19.221-1.

Do you have any suggestions?
--
To unsubscribe from this list: send the line "unsubscribe backports" in
