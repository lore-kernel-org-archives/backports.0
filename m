Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38570 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933566Ab3LINyi (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 9 Dec 2013 08:54:38 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AE93B202C8
	for <backports@vger.kernel.org>; Mon,  9 Dec 2013 13:54:36 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id A298620279
	for <backports@vger.kernel.org>; Mon,  9 Dec 2013 13:54:35 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 66601] [PATCH] missing of.h include in compat-*.c
Date: Mon, 09 Dec 2013 13:54:35 +0000
Message-ID: <bug-66601-58281-P4AOReEVan@https.bugzilla.kernel.org/> (sfid-20131209_145440_434922_F3E7A768)
In-Reply-To: <bug-66601-58281@https.bugzilla.kernel.org/>
References: <bug-66601-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=66601

Luis R. Rodriguez <mcgrof@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mcgrof@gmail.com

--- Comment #1 from Luis R. Rodriguez <mcgrof@gmail.com> ---
Thanks for the patch !

If this fixes an issue opening up a bugzilla entry seems like a rather
cumbersome way to get the changes merged. Please consider sending the patch
with an appropriate Singed-off-by tag if you agree to the Developer Certificate
of Origin (same as the Linux kernel) and send it to backports mailing list.
Will you close the bug entry yourself?

-- 
You are receiving this mail because:
You are the assignee for the bug.
