Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40424 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbcGVLEE (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 22 Jul 2016 07:04:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 899012053E
	for <backports@vger.kernel.org>; Fri, 22 Jul 2016 11:04:02 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A8DFB2053C
	for <backports@vger.kernel.org>; Fri, 22 Jul 2016 11:04:01 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 139321] New: Warning in mac80211 driver from backports-4.4.2-1
Date: Fri, 22 Jul 2016 11:04:01 +0000
Message-ID: <bug-139321-58281@https.bugzilla.kernel.org/> (sfid-20160722_130407_570033_191BCBD9)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=139321

            Bug ID: 139321
           Summary: Warning in mac80211 driver from backports-4.4.2-1
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.12.37-rt51+
          Hardware: i386
                OS: Linux
              Tree: PREEMPT_RT
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: kavitam@cdot.in
        Regression: No

Hi,

I am running hostapd 2.5 and ath9k driver from backports-4.4.2-1.The system is
not acceible after sometime of powered on.This system can be configured as
AP/client or MESH.As soon as my system boots, following warning message
displays on the screen:

My system:

Linux CDOT-BBWT 3.12.37-rt51+ #1 SMP PREEMPT RT Thu Jul 21 12:15:34 IST 2016
ppc GNU/Linux

------------[ cut here ]------------
WARNING: at /home/lwbj/backports-4.4.2-1/net/mac80211/rx.c:3557
Modules linked in: ath9k(O) mac80211(O) ath9k_common(O) ath9k_hw(O) ath(O)
cfg80211(O) compat(O)
CPU: 0 PID: 1507 Comm: irq/21-ath9k Tainted: G           O 3.12.37-rt51+ #1
task: eac89f40 ti: d7b84000 task.ti: d7b84000
NIP: fa9b81d4 LR: facc5fd0 CTR: c006eeac
REGS: d7b85bf0 TRAP: 0700   Tainted: G           O  (3.12.37-rt51+)
MSR: 00029000 <CE,EE,ME>  CR: 22022042  XER: 20000000

GPR00: facc5fd0 d7b85ca0 eac89f40 d3144c20 d919fd80 00000000 eac89f40 00000000
GPR08: 00000000 00000001 00000004 00000000 c006eeac 00000000 00000000 0001d76e
GPR16: d31476fc d31463d4 d3028038 d30ce020 d30ce020 0001d896 d3144c20 1757ad80
GPR24: d3028010 d919fd98 fa9ed2a5 00000000 00000200 d919fd80 d919fd80 d3144c20
NIP [fa9b81d4] ieee80211_rx_napi+0x2c/0x8a0 [mac80211]
LR [facc5fd0] ath_rx_tasklet+0x7e8/0xac8 [ath9k]
Call Trace:
[d7b85ca0] [d757ad60] 0xd757ad60 (unreliable)
[d7b85d10] [facc5fd0] ath_rx_tasklet+0x7e8/0xac8 [ath9k]
[d7b85dd0] [facc3690] ath9k_tasklet+0xdc/0x274 [ath9k]
[d7b85df0] [c0043b04] __tasklet_action.isra.15+0xbc/0x170
[d7b85e20] [c00436b4] do_current_softirqs+0x1d8/0x258
[d7b85e70] [c00437b4] local_bh_enable+0x80/0x84
[d7b85e80] [c0086a7c] irq_forced_thread_fn+0x50/0x94
[d7b85ea0] [c0086c78] irq_thread+0xf0/0x140
[d7b85ee0] [c0060368] kthread+0x98/0x9c
[d7b85f40] [c000f5cc] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
4bfffc70 9421ff90 7c0802a6 be61003c 3f40fa9f 90010074 3b5ad2a5 7c7f1b78
7c9e2378 893a0002 7cbb2b78 69290001 <0f090000> 2f890000 89240032 409e064c
---[ end trace 0000000000000002 ]---

Is the kernel panic? How to fix this issue? Please suggest.

Thanks in advance.
Kavita

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
