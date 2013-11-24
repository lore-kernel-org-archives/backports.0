Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52950 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab3KXVeA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:34:00 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6271620411
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 21:33:59 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 4DDDC20379
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 21:33:58 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Sun, 24 Nov 2013 21:33:57 +0000
Message-ID: <bug-59041-58281-5MrFKTLtYC@https.bugzilla.kernel.org/> (sfid-20131124_223402_686481_38ABA67A)
In-Reply-To: <bug-59041-58281@https.bugzilla.kernel.org/>
References: <bug-59041-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #5 from Hauke Mehrtens <hauke@hauke-m.de> ---
kref_get_unless_zero() was removed in backports-20131122-2, please try that
version, that should fix your problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
