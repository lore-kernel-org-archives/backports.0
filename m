Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52988 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab3KXVfu (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:35:50 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3C6482037F
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 21:35:49 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 8D09A20379
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 21:35:48 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 63381] cpumask.h error
Date: Sun, 24 Nov 2013 21:35:48 +0000
Message-ID: <bug-63381-58281-6Lgj0eEnSS@https.bugzilla.kernel.org/> (sfid-20131124_223551_748904_8AC6C8BA)
In-Reply-To: <bug-63381-58281@https.bugzilla.kernel.org/>
References: <bug-63381-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=63381

--- Comment #4 from Hauke Mehrtens <hauke@hauke-m.de> ---
This was probably fixed in backports-20131122-2, please try that version and
report back.

-- 
You are receiving this mail because:
You are the assignee for the bug.
