Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326E3CE79A9
	for <backports@archiver.kernel.org>; Tue, 19 Sep 2023 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjISRaA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISR37 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Sep 2023 13:29:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC409D6
        for <backports@vger.kernel.org>; Tue, 19 Sep 2023 10:29:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A7EC433C8
        for <backports@vger.kernel.org>; Tue, 19 Sep 2023 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695144593;
        bh=TlmimCyCkbDmR0QHHKEayI9QmKTWdtMFFfq4KivgYtU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BnS0G19FHEXZ7HdSNk+sdRNiwZSxTm9qdLfRL4R5e3q2ZjqorPMGeyQ+A5ZRVV6tC
         m26009jRMgJKQXWGHQeoiA2MV1Q7vJUTCFNmpqxpq0MjsgFk/w95F90yr7ZAoFgMvY
         zvASx4T/Izsz7/PvUwW1QIPHINxWIEPGNFlpUgz6QN81dsJrC7gsMNKPlX4A+lobHg
         Zt4SbUkd6U7+u0kSNWsnG/FM2pmAZ0oUuXS+Wzea+MAnGZ3oONTZWdNP1AgVsT6NPu
         liO0aXKHGt+auExF4sE8Y+TuEdGaVodpJzanfZrZHm37JD+AihUQmOQC8zuNwl/9H6
         75xDWXK5xjmRw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 5964CC4332E; Tue, 19 Sep 2023 17:29:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 217925] Backporting ath11k QCN9074 support to kernel 5.10 - no
 network interface
Date:   Tue, 19 Sep 2023 17:29:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lakshmanakumar.mohan@celestica.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: keywords short_desc
Message-ID: <bug-217925-58281-iZxxDFpBBs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217925-58281@https.bugzilla.kernel.org/>
References: <bug-217925-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217925

Lakshmanakumar (lakshmanakumar.mohan@celestica.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Keywords|                            |trivial
            Summary|Backporting ath11k QCN9074  |Backporting ath11k QCN9074
                   |no network interface        |support to kernel 5.10 - no
                   |                            |network interface

--- Comment #1 from Lakshmanakumar (lakshmanakumar.mohan@celestica.com) ---
I'm trying to port the ath11k driver from kernel 5.15 to kernel 5.10 for
supporting the QCN9074 modules. I have also copied the firmwares from
https://github.com/kvalo/ath11k-firmware/tree/master/QCN9074/hw1.0=20=20
I could see the below logs after loading the ath11k_pci driver. But it does=
 not
proceed after the below state. Therefore the wireless network interface fai=
ls
loading.
[  520.582093] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory
database
[  520.594227] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  520.630560] ath11k_pci 0000:03:00.0: runtime IRQ mapping not provided by
arch
[  520.637930] ath11k_pci 0000:03:00.0: BAR 0: assigned [mem
0xdfa00000-0xdfbfffff 64bit]
[  520.646225] ath11k_pci 0000:03:00.0: qcn9074 hw1.0
[  520.654325] NET: Registered protocol family 42
[  520.714305] mhi 0000:03:00.0: Requested to power ON
[  520.719416] mhi 0000:03:00.0: Power on setup success

PCI list shows the interface as=20
root@localhost:/# lspci -v -s 0000:03:00.0
03:00.0 Network controller: Qualcomm Device 1104 (rev 01)
        Subsystem: Qualcomm Device 1104
        Flags: bus master, fast devsel, latency 0, IRQ 77
        Memory at dfa00000 (64-bit, non-prefetchable) [size=3D2M]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=3D16/32 Maskable+ 64bit-
        Capabilities: [70] Express Endpoint, MSI 00
        Kernel driver in use: ath11k_pci
        Kernel modules: ath11k_pci

root@localhost:/# tree /sys/bus/pci/devices/0000\:03\:00.0/
0000:03:00.0/             driver/                   rescan
0000:03:00.0_IPCR/        driver_override           reset
0000:03:00.0_LOOPBACK/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
