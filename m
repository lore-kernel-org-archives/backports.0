Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39912 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2LTJZI (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 20 Dec 2012 04:25:08 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 188622022A
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 09:25:03 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 6C31B20227
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 09:25:01 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51851] New: Unable to use alx driver without CONFIG_MDIO
Message-ID: <bug-51851-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Thu, 20 Dec 2012 09:25:00 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51851

           Summary: Unable to use alx driver without CONFIG_MDIO
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.7.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Compat-Drivers
        AssignedTo: backports@vger.kernel.org
        ReportedBy: pfactum@gmail.com
        Regression: No


I use own customized kernel in which I've disabled all unnecessary ethernet
drivers. The fact is that new alx driver from 2012-12-19 tree depends on
CONFIG_MDIO, and if I do not select in-kernel driver that depends on it (e.g.,
some broadcom or so), inserting compiled alx module gives me this:

===
[   44.248978] alx: Unknown symbol mdio_mii_ioctl (err 0)
===

I've got this fixed by adding into drivers/net/ethernet/atheros/Kconfig of my
kernel tree "select MDIO" for Atheros drivers without selecting any other
drivers.

Probably, it's possible to get it fixed in compat-drivers tree?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
