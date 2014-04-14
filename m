Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46482 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbaDNJPE (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Apr 2014 05:15:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 216E120136
	for <backports@vger.kernel.org>; Mon, 14 Apr 2014 09:15:03 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 6D85F20109
	for <backports@vger.kernel.org>; Mon, 14 Apr 2014 09:15:02 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] AWUS 036NHR v.2 8188RU cant associate and cant capture
 handshake.
Date: Mon, 14 Apr 2014 09:15:02 +0000
Message-ID: <bug-73861-58281-SAiq175j4R@https.bugzilla.kernel.org/> (sfid-20140414_111507_988815_CCC5E634)
In-Reply-To: <bug-73861-58281@https.bugzilla.kernel.org/>
References: <bug-73861-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

--- Comment #2 from youlold@gmail.com ---
(In reply to Larry Finger from comment #1)
> There were a lot of changes in kernel 3.14 for this driver that could not be
> backported to 3.12. Does Debian supply a 3.14 kernel?

I installed backports-20140221 to 3.14.0-5-ARCH i686 (Archlinux core), and
still "not associated", but on Fedora 3.15 i got associations. 
What's wrong with arch? Wrong core? Wrong core settings?

-- 
You are receiving this mail because:
You are the assignee for the bug.
