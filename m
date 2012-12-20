Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38841 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab2LTI2T (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 20 Dec 2012 03:28:19 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B2594201CD
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 08:28:18 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 96901201DD
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 08:28:17 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121220082816.84E1411FA1A@bugzilla.kernel.org>
Date: Thu, 20 Dec 2012 08:28:16 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #9 from Oleksandr Natalenko <pfactum@gmail.com>  2012-12-20 08:28:16 ---
Fixed with 3.6.11, thanks, guys.

===
[ 9135.574895] Qualcomm Atheros(R) AR816x/AR817x PCI-E Ethernet Network Driver
[ 9135.585114] alx 0000:02:00.0: alx(84:8f:69:d3:a6:09): Qualcomm Atheros
Ethernet Network Connection
[ 9156.532616] alx 0000:02:00.0: irq 45 for MSI/MSI-X
[ 9156.532641] alx 0000:02:00.0: irq 46 for MSI/MSI-X
[ 9156.532655] alx 0000:02:00.0: irq 47 for MSI/MSI-X
[ 9156.532671] alx 0000:02:00.0: irq 48 for MSI/MSI-X
[ 9156.532683] alx 0000:02:00.0: irq 49 for MSI/MSI-X
[ 9156.534190] alx 0000:02:00.0: eth0: NIC Link Up: 1 Gbps Full
===

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
