Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47932 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab3LMAVq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 19:21:46 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5FDE9207FD
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:21:45 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 7E4FD207DD
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:21:43 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Fri, 13 Dec 2013 00:21:43 +0000
Message-ID: <bug-59041-58281-GpGAsnFGfJ@https.bugzilla.kernel.org/> (sfid-20131213_012147_617464_7811079C)
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
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #6 from Hauke Mehrtens <hauke@hauke-m.de> ---
This should be fixed in the latest releases.

-- 
You are receiving this mail because:
You are the assignee for the bug.
