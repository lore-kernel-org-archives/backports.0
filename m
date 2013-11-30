Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42392 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab3K3A6T (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 29 Nov 2013 19:58:19 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E570620616
	for <backports@vger.kernel.org>; Sat, 30 Nov 2013 00:58:18 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id B62BB205DB
	for <backports@vger.kernel.org>; Sat, 30 Nov 2013 00:58:17 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Sat, 30 Nov 2013 00:58:17 +0000
Message-ID: <bug-65881-58281-1EZd1PU12U@https.bugzilla.kernel.org/> (sfid-20131130_015832_251560_3B0AE956)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #3 from Hauke Mehrtens <hauke@hauke-m.de> ---
Created attachment 116841
  --> https://bugzilla.kernel.org/attachment.cgi?id=116841&action=edit
More SLES fixes

Is it correct that you are using Suse Linux Enterprise Server?

Their kernel probably has lots of patches like the Red Hat kernel and it is not
that easy to get backports running on such a kernel as nobody tried it before.

Could you try the attached patch, it will probably not work completely with
that patch, but you should get a set forward.

When you click on "attachment" and then on View you get the patch.

-- 
You are receiving this mail because:
You are the assignee for the bug.
