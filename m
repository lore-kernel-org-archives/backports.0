Return-Path: <SRS0=5vGP=WK=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B59C433FF
	for <backports@archiver.kernel.org>; Wed, 14 Aug 2019 07:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B1F206C2
	for <backports@archiver.kernel.org>; Wed, 14 Aug 2019 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHNH0l convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:26:41 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51874 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfHNH0l (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 14 Aug 2019 03:26:41 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 39B5D28751
        for <backports@vger.kernel.org>; Wed, 14 Aug 2019 07:26:40 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 29A6A28757; Wed, 14 Aug 2019 07:26:40 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 204573] New: kernel panic:"kernel BUG at
 /home/issuser/frm_build/kernel/bxt/include/linux/scatterlist.h:140!"
Date:   Wed, 14 Aug 2019 07:26:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yxhjack@163.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204573-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204573

            Bug ID: 204573
           Summary: kernel panic:"kernel BUG at
                    /home/issuser/frm_build/kernel/bxt/include/linux/scatt
                    erlist.h:140!"
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.9.107
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: yxhjack@163.com
        Regression: No

Hi,I found a kernel panic when I connect wifi with iwlwifi(hardware is intel
8265).My platform is intel,android 8.1 system. Below is panic stack.

[   99.038721] ------------[ cut here ]------------
[   99.043904] kernel BUG at
/home/issuser/frm_build/kernel/bxt/include/linux/scatterlist.h:140!
[   99.053457] invalid opcode: 0000 [#1] PREEMPT SMP
[   99.058726] Modules linked in: iwlmvm iwlwifi iwl_mac80211 iwl_cfg80211
compat btusb btrtl btbcm btintel ath3k bluetooth rfkill_gpio
intel_ipu4_mmu_bxtB0 lib2600_mod_bxtB0 intel_ipu4_isys_mod_bxtB0
lib2600psys_mod_bxtB0 intel_ipu4_psys_mod_bxtB0 mei_me mei r8169
intel_ipu4_mod_bxtB0 intel_ipu4_wrapper_bxtB0 intel_ipu4_acpi
videobuf2_dma_contig crlmodule
[   99.093975] CPU: 0 PID: 2487 Comm: irq/377-iwlwifi Tainted: G     U         
4.9.107-quilt-2e5dc0ac #1
[   99.104399] Hardware name: Minnowboard Vendor Benson Glacier B2
PLATFORM/MinnowBoard V3, BIOS SMARTTVA.X64.0071.R02.1811200558 11/20/2018
[   99.118243] task: ffff880266870100 task.stack: ffffc90000d10000
[   99.124877] RIP: 0010:[<ffffffffc02ce577>]  [<ffffffffc02ce577>]
ieee80211_aes_ccm_decrypt+0x2d7/0x310 [iwl_mac80211]
[   99.136826] RSP: 0018:ffffc90000d13700  EFLAGS: 00010246
[   99.142778] RAX: 0000000000000000 RBX: 1ffff920001a26e0 RCX:
0000000000000027
[   99.150772] RDX: 0000410000d139ea RSI: 0000000000000082 RDI:
ffffc90080d139ea
[   99.158769] RBP: ffffc90000d13998 R08: ffffc90000d138f0 R09:
ffffc90000d138f0
[   99.166767] R10: ffffc90000d139ea R11: 0000000000000002 R12:
ffff88025b5e2822
[   99.174762] R13: ffff880236dd2200 R14: 000000000000030a R15:
ffffc90000d13700
[   99.182758] FS:  0000000000000000(0000) GS:ffff88027fc00000(0000)
knlGS:0000000000000000
[   99.191824] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   99.198259] CR2: 00007153c8d03bd8 CR3: 0000000002210000 CR4:
00000000003406f0
[   99.206255] Stack:
[   99.208504]  0000000000000000 0000000000000000 0000000000000000
0000000000000000
[   99.216807]  0000000000000000 0000000000000000 0000000000000000
0000000000000000
[   99.225108]  0000000000000000 0000000000000000 0000000000000000
0000000000000000
[   99.233422] Call Trace:
[   99.236195]  [<ffffffffc02bb904>] ieee80211_crypto_ccmp_decrypt+0x2f4/0x340
[iwl_mac80211]
[   99.245493]  [<ffffffffc02d8d9d>] ieee80211_rx_handlers+0xa6d/0x21f0
[iwl_mac80211]
[   99.254082]  [<ffffffff81b24a68>] ? _raw_spin_unlock_irqrestore+0x28/0x50
[   99.261724]  [<ffffffffc02d8316>] ?
ieee80211_sta_reorder_release+0x376/0x390 [iwl_mac80211]
[   99.271228]  [<ffffffffc02da995>]
ieee80211_prepare_and_rx_handle+0x1a5/0x9b0 [iwl_mac80211]
[   99.280723]  [<ffffffffc02db43f>] __iwl_ieee80211_rx_napi+0x29f/0xa10
[iwl_mac80211]
[   99.289420]  [<ffffffffc03d89ff>] iwl_mvm_rx_rx_mpdu+0x56f/0xba0 [iwlmvm]
[   99.297044]  [<ffffffffc03d2d5b>] iwl_mvm_rx+0x5b/0xa0 [iwlmvm]
[   99.303694]  [<ffffffffc0392586>] iwl_pcie_rx_handle+0x306/0x950 [iwlwifi]
[   99.311410]  [<ffffffffc039420d>] iwl_pcie_irq_handler+0x6fd/0xc60 [iwlwifi]
[   99.319317]  [<ffffffff811004f0>] ? irq_forced_thread_fn+0x70/0x70
[   99.326268]  [<ffffffff810ba8c2>] ?
call_usermodehelper_exec_async+0x132/0x160
[   99.334362]  [<ffffffff81100516>] irq_thread_fn+0x26/0x60
[   99.340410]  [<ffffffff81100805>] irq_thread+0x145/0x1c0
[   99.346359]  [<ffffffff81100600>] ? wake_threads_waitq+0x30/0x30
[   99.353092]  [<ffffffff811006c0>] ? irq_thread_dtor+0xc0/0xc0
[   99.359533]  [<ffffffff810ba8c2>] ?
call_usermodehelper_exec_async+0x132/0x160
[   99.367631]  [<ffffffff810c4580>] kthread+0x100/0x120
[   99.373293]  [<ffffffff810c4480>] ? kthread_park+0x60/0x60
[   99.379440]  [<ffffffff810ba790>] ? umh_complete+0x40/0x40
[   99.385588]  [<ffffffff81b2508d>] ret_from_fork+0x3d/0x50
[   99.391637] Code: 40 4c 89 ff 48 8b 40 d0 e8 c7 c5 85 c1 48 8b 75 d0 65 48
33 34 25 28 00 00 00 75 1e 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b
0f 0b 0f 0b 0f 0b b8 ea ff ff ff eb d3 e8 15 54 dd c0 48 
[   99.413217] RIP  [<ffffffffc02ce577>] ieee80211_aes_ccm_decrypt+0x2d7/0x310
[iwl_mac80211]
[   99.422506]  RSP <ffffc90000d13700>
[   99.428591] ---[ end trace a58f1648e5d80a44 ]---
[   99.439048] Kernel panic - not syncing: Fatal exception in interrupt
[   99.446589] intel_tasks_dumper: intel_task_panic_hndl: Skip tasks dumper.
[   99.454207] Kernel Offset: disabled
[   99.463365] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
