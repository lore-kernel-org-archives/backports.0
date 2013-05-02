Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44165 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759245Ab3EBQ2i (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 2 May 2013 12:28:38 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9A5DC20708
	for <backports@vger.kernel.org>; Thu,  2 May 2013 16:28:37 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id A6378206F8
	for <backports@vger.kernel.org>; Thu,  2 May 2013 16:28:35 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130502162834.964A911FA07@bugzilla.kernel.org> (sfid-20130502_182844_072515_4BF47082)
Date: Thu,  2 May 2013 16:28:34 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #15 from QCA Ethernet team <nic-devel@qca.qualcomm.com>  2013-05-02 16:28:34 ---
(In reply to comment #14)

please remove following lines in alx_resume

-    if (!netif_running(netdev))
-        return 0;
-


that should fix your issue.



> Here dmesg:
> 
> 
> 
> ###### sudo rmmod alx; sudo modprobe alx
> 
> 
> [  102.414400] Qualcomm Atheros(R) AR816x/AR817x PCI-E Ethernet Network Driver
> [  102.432649] alx 0000:04:00.0: alx(30:85:a9:01:9b:01): Qualcomm Atheros
> Ethernet Network Connection
> [  102.451912] systemd-udevd[2839]: renamed network interface eth0 to p3p1
> [  102.460935] alx 0000:04:00.0: irq 47 for MSI/MSI-X
> [  102.460958] alx 0000:04:00.0: irq 48 for MSI/MSI-X
> [  102.460974] alx 0000:04:00.0: irq 49 for MSI/MSI-X
> [  102.460991] alx 0000:04:00.0: irq 50 for MSI/MSI-X
> [  102.461007] alx 0000:04:00.0: irq 51 for MSI/MSI-X
> [  102.461025] alx 0000:04:00.0: irq 52 for MSI/MSI-X
> [  102.461042] alx 0000:04:00.0: irq 53 for MSI/MSI-X
> [  102.461059] alx 0000:04:00.0: irq 54 for MSI/MSI-X
> [  102.461077] alx 0000:04:00.0: irq 55 for MSI/MSI-X
> [  102.462652] IPv6: ADDRCONF(NETDEV_UP): p3p1: link is not ready
> [  104.329822] alx 0000:04:00.0 p3p1: NIC Link Up: 1 Gbps Full
> [  104.330071] IPv6: ADDRCONF(NETDEV_CHANGE): p3p1: link becomes ready

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
