Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47857 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab3LMASN (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 19:18:13 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B03AF207E0
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:18:12 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 925CC207DD
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:18:10 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 66601] [PATCH] missing of.h include in compat-*.c
Date: Fri, 13 Dec 2013 00:18:10 +0000
Message-ID: <bug-66601-58281-eT5HIbsXFQ@https.bugzilla.kernel.org/> (sfid-20131213_011815_539710_8B1FBDE1)
In-Reply-To: <bug-66601-58281@https.bugzilla.kernel.org/>
References: <bug-66601-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=66601

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #3 from Hauke Mehrtens <hauke@hauke-m.de> ---
I already created a patch which adds the missing include, it was added in the
last release, see:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=a9081420811be2a9c7386b4693c5cf1b93b3ae23

This should be fixed in backports-20131206.

-- 
You are receiving this mail because:
You are the assignee for the bug.
