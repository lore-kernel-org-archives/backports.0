Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37545 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbbJMUVN (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 13 Oct 2015 16:21:13 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B8E2B205E3
	for <backports@vger.kernel.org>; Tue, 13 Oct 2015 20:21:12 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id E1AAA205E9
	for <backports@vger.kernel.org>; Tue, 13 Oct 2015 20:21:11 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 105921] Backport releases GPG public key unavailable
Date: Tue, 13 Oct 2015 20:21:11 +0000
Message-ID: <bug-105921-58281-nGonW3jCMz@https.bugzilla.kernel.org/> (sfid-20151013_222115_947553_C13300D9)
In-Reply-To: <bug-105921-58281@https.bugzilla.kernel.org/>
References: <bug-105921-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=105921

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |hauke@hauke-m.de
         Resolution|---                         |INVALID

--- Comment #1 from Hauke Mehrtens <hauke@hauke-m.de> ---
Hi,

This is my signing subkey, see this
https://pgp.mit.edu/pks/lookup?op=vindex&search=0xADC5F48295C58E7B

When I search for 583D1332 at https://pgp.mit.edu/ I get the correct key.

Is there something wrong with this key?

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
