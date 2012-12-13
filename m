Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54321 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab2LMFyJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 13 Dec 2012 00:54:09 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4397C201D6
	for <backports@vger.kernel.org>; Thu, 13 Dec 2012 05:54:07 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 4EE30201AD
	for <backports@vger.kernel.org>; Thu, 13 Dec 2012 05:54:06 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] New: ALX driver unusable on new kernel
Message-ID: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Thu, 13 Dec 2012 05:54:04 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671

           Summary: ALX driver unusable on new kernel
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.7.0
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Compat-Drivers
        AssignedTo: backports@vger.kernel.org
        ReportedBy: i@hexchain.org
        Regression: No


After upgraded to kernel 3.7, the ALX driver in compat-drivers nolonger
functions. Building is successful, but it is unable to load.

dmesg before kernel update, using compat-wireless 20121003:
Dec 12 12:12:09 lightning.hexchain.org kernel: alx 0000:03:00.0: DMA to 64-BIT
addresses
Dec 12 12:12:09 lightning.hexchain.org kernel: alx 0000:03:00.0: (unregistered
net_device): HW Flags = 0x415
Dec 12 12:12:09 lightning.hexchain.org kernel: alx 0000:03:00.0: (unregistered
net_device): reset PHY, pws = 1, az = 0, ptp = 0
Dec 12 12:12:09 lightning.hexchain.org kernel: alx 0000:03:00.0: (unregistered
net_device): speed = 0x2f, autoneg = 1
Dec 12 12:12:09 lightning.hexchain.org kernel: alx 0000:03:00.0: irq 45 for
MSI/MSI-X
Dec 12 12:12:09 lightning.hexchain.org kernel: alx: Atheros Gigabit Network
Connection

After kernel update, any version of compat-driver before 20121204 fails to
build.
dmesg after kernel update, using the newest compat-driver-u:
Dec 12 22:31:21 lightning.hexchain.org kernel: alx 0000:03:00.0: DMA to 64-BIT
addresses
Dec 12 22:31:21 lightning.hexchain.org kernel: alx 0000:03:00.0: config PHY
speed/duplex failed,err=4
Dec 12 22:31:21 lightning.hexchain.org kernel: alx 0000:03:00.0: error when
probe device, error = -5
Dec 12 22:31:21 lightning.hexchain.org kernel: alx: probe of 0000:03:00.0
failed with error -5

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
