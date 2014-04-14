Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41121 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbaDNRym (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Apr 2014 13:54:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 31F7E201F9
	for <backports@vger.kernel.org>; Mon, 14 Apr 2014 17:54:41 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id D695820160
	for <backports@vger.kernel.org>; Mon, 14 Apr 2014 17:54:39 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] AWUS 036NHR v.2 8188RU cant associate and cant capture
 handshake.
Date: Mon, 14 Apr 2014 17:54:39 +0000
Message-ID: <bug-73861-58281-ECi6x12bJD@https.bugzilla.kernel.org/> (sfid-20140414_195445_079863_7A8F4F44)
In-Reply-To: <bug-73861-58281@https.bugzilla.kernel.org/>
References: <bug-73861-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

--- Comment #3 from youlold@gmail.com ---
(In reply to Larry Finger from comment #1)
> There were a lot of changes in kernel 3.14 for this driver that could not be
> backported to 3.12. Does Debian supply a 3.14 kernel?

Okay. Now i'm installed backports-20140221 into debian 3.14-rc7-amd64, and dont
have associations again. Now im seriously disappointed. 
Maybe you know something what i didnt know?

-- 
You are receiving this mail because:
You are the assignee for the bug.
