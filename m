Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37198 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbaDOHSZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 15 Apr 2014 03:18:25 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C752920200
	for <backports@vger.kernel.org>; Tue, 15 Apr 2014 07:18:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DBA40201BF
	for <backports@vger.kernel.org>; Tue, 15 Apr 2014 07:18:22 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] AWUS 036NHR v.2 8188RU cant associate and cant capture
 handshake.
Date: Tue, 15 Apr 2014 07:18:22 +0000
Message-ID: <bug-73861-58281-Hhmd0oWOtl@https.bugzilla.kernel.org/> (sfid-20140415_091827_603693_CD6A4CC1)
In-Reply-To: <bug-73861-58281@https.bugzilla.kernel.org/>
References: <bug-73861-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

--- Comment #4 from youlold@gmail.com ---
(In reply to Larry Finger from comment #1)
> There were a lot of changes in kernel 3.14 for this driver that could not be
> backported to 3.12. Does Debian supply a 3.14 kernel?

Anytime i configure backports-2014022 with key defconfig-wifi. Today i wanna
test it with archlinux kernel 3.15

-- 
You are receiving this mail because:
You are the assignee for the bug.
