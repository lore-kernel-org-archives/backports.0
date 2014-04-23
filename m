Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47966 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbaDWQWo (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Apr 2014 12:22:44 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9159C2010C
	for <backports@vger.kernel.org>; Wed, 23 Apr 2014 16:22:43 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 890DB201E7
	for <backports@vger.kernel.org>; Wed, 23 Apr 2014 16:22:42 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] AWUS 036NHR v.2 8188RU cant associate and cant capture
 handshake.
Date: Wed, 23 Apr 2014 16:22:42 +0000
Message-ID: <bug-73861-58281-zQnDbSurTJ@https.bugzilla.kernel.org/> (sfid-20140423_182247_037107_FD0D90A2)
In-Reply-To: <bug-73861-58281@https.bugzilla.kernel.org/>
References: <bug-73861-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

--- Comment #9 from Larry Finger <Larry.Finger@lwfinger.net> ---
That driver does not use mac80211. For that reason, it could never be an
official part of the kernel. You may use it at your own risk, but it is
unsupported.

-- 
You are receiving this mail because:
You are the assignee for the bug.
