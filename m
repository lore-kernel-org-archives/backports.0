Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51458 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbbKHJdn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Nov 2015 04:33:43 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1B266204D3
	for <backports@vger.kernel.org>; Sun,  8 Nov 2015 09:33:42 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 96DCE204B5
	for <backports@vger.kernel.org>; Sun,  8 Nov 2015 09:33:39 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 107461] clients can not connect to the AP,AP is created over
 linux2.5 with ath9k wireless card
Date: Sun, 08 Nov 2015 09:33:39 +0000
Message-ID: <bug-107461-58281-D0cAMwUe6V@https.bugzilla.kernel.org/> (sfid-20151108_103346_108717_CD292986)
In-Reply-To: <bug-107461-58281@https.bugzilla.kernel.org/>
References: <bug-107461-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=107461

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #1 from Hauke Mehrtens <hauke@hauke-m.de> ---
I haven't understood what you do.

Do you have an Ubuntu system with ath9k and kernel 4.5 + backports 3.19 running
as an AP and this does not work? When you used an older kernel it worked?

I do not think that backports 3.19 works with kernel 4.5 at all, when you use a
recent kernel there is no need for backports.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
