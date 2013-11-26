Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:32861 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab3KZSGV (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Nov 2013 13:06:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5ABB220445
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 18:06:20 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0622920434
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 18:06:19 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Tue, 26 Nov 2013 18:06:14 +0000
Message-ID: <bug-65881-58281-4JFTj38NG5@https.bugzilla.kernel.org/> (sfid-20131126_190623_622340_59A9178C)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #1 from Hauke Mehrtens <hauke@hauke-m.de> ---
Created attachment 116271
  --> https://bugzilla.kernel.org/attachment.cgi?id=116271&action=edit
backports: remove hex_byte_pack()

Please try this patch on top of the backports-3.13-rc1 release.

-- 
You are receiving this mail because:
You are the assignee for the bug.
