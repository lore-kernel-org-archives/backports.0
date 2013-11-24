Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51137 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab3KXT30 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 14:29:26 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 90D9A203F4
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 19:29:25 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id BBE562010E
	for <backports@vger.kernel.org>; Sun, 24 Nov 2013 19:29:23 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51851] [TRIVIAL]Unable to use alx driver without CONFIG_MDIO
Date: Sun, 24 Nov 2013 19:29:23 +0000
Message-ID: <bug-51851-58281-m2k0IuH0Y9@https.bugzilla.kernel.org/> (sfid-20131124_202928_880441_ADD2B5B1)
In-Reply-To: <bug-51851-58281@https.bugzilla.kernel.org/>
References: <bug-51851-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51851

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #5 from Hauke Mehrtens <hauke@hauke-m.de> ---
The ALX driver needs MDIO and we do not provide that in backports. When you do
not use a normal distribution kernel with lots of modules activate you have to
activate some dependencies in your kernel by yourself. Sadly CONFIG_MDIO is a
hidden option so you have to build some other Ethernet driver which depends on
that option.

We do ot want to fix this in backports.

-- 
You are receiving this mail because:
You are the assignee for the bug.
