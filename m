Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47589 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932982AbbDVIhJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 22 Apr 2015 04:37:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C73602020F
	for <backports@vger.kernel.org>; Wed, 22 Apr 2015 08:37:07 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A7ABC202EC
	for <backports@vger.kernel.org>; Wed, 22 Apr 2015 08:37:05 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94131] Unable to do make menuconfig in backports-3.18.1-1
Date: Wed, 22 Apr 2015 08:37:05 +0000
Message-ID: <bug-94131-58281-CRWxv5uRdc@https.bugzilla.kernel.org/> (sfid-20150422_103712_134691_C3545C91)
In-Reply-To: <bug-94131-58281@https.bugzilla.kernel.org/>
References: <bug-94131-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94131

rommon@t-online.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rommon@t-online.de

--- Comment #3 from rommon@t-online.de ---
I have the same here under Ubuntu 14.04 with kernel 3.13.

I remember that debian 7 didn't had this problem.

make defconfig-wifi && make did work. it seams to be just the menuconfig.

-- 
You are receiving this mail because:
You are the assignee for the bug.
