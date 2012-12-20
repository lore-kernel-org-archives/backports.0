Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35278 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2LTGf5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 20 Dec 2012 01:35:57 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9B770201E2
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 06:35:56 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id CE777201D8
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 06:35:53 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121220063552.B690511FA39@bugzilla.kernel.org>
Date: Thu, 20 Dec 2012 06:35:52 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #8 from Hexchain Tong <i@hexchain.org>  2012-12-20 06:35:52 ---
(In reply to comment #7)
> Try this guy:
> 
> http://www.kernel.org/pub/linux/kernel/projects/backports/2012/12/19/compat-drivers-2012-12-19-u.tar.bz2

I've successfully installed this driver on 3.7.1-1-ARCH. Works well so far.

$ dmesg | grep 03:00.0
[    0.462070] pci 0000:03:00.0: [1969:1091] type 00 class 0x020000
[    0.462100] pci 0000:03:00.0: reg 10: [mem 0xf1400000-0xf143ffff 64bit]
[    0.462115] pci 0000:03:00.0: reg 18: [io  0x2000-0x207f]
[    0.462250] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  274.912505] alx 0000:03:00.0: alx(5c:f9:dd:41:1d:0a): Qualcomm Atheros
Ethernet Network Connection
[  274.923191] alx 0000:03:00.0: irq 47 for MSI/MSI-X
[  274.923196] alx 0000:03:00.0: irq 48 for MSI/MSI-X
[  274.923200] alx 0000:03:00.0: irq 49 for MSI/MSI-X
[  274.923203] alx 0000:03:00.0: irq 50 for MSI/MSI-X
[  274.923206] alx 0000:03:00.0: irq 51 for MSI/MSI-X
[  274.923209] alx 0000:03:00.0: irq 52 for MSI/MSI-X
[  274.923213] alx 0000:03:00.0: irq 53 for MSI/MSI-X
[  274.923216] alx 0000:03:00.0: irq 54 for MSI/MSI-X
[  274.923249] alx 0000:03:00.0: irq 55 for MSI/MSI-X
[  276.549546] alx 0000:03:00.0 eth0: NIC Link Up: 100 Mbps Full

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
