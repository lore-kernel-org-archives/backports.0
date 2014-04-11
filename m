Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43551 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbaDKSLK (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 11 Apr 2014 14:11:10 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7307C2018A
	for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:11:09 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 48AAD20171
	for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:11:08 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] AWUS 036NHR v.2 8188RU cant associate and cant capture
 handshake.
Date: Fri, 11 Apr 2014 18:11:07 +0000
Message-ID: <bug-73861-58281-XkBO3f1eua@https.bugzilla.kernel.org/> (sfid-20140411_201112_839086_1DD7E728)
In-Reply-To: <bug-73861-58281@https.bugzilla.kernel.org/>
References: <bug-73861-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

Larry Finger <Larry.Finger@lwfinger.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Larry.Finger@lwfinger.net

--- Comment #1 from Larry Finger <Larry.Finger@lwfinger.net> ---
There were a lot of changes in kernel 3.14 for this driver that could not be
backported to 3.12. Does Debian supply a 3.14 kernel?

-- 
You are receiving this mail because:
You are the assignee for the bug.
