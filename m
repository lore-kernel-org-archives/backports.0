Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56462 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab3JUKrC (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 06:47:02 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7B2EF201FE
	for <backports@vger.kernel.org>; Mon, 21 Oct 2013 10:47:01 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0C0712015D
	for <backports@vger.kernel.org>; Mon, 21 Oct 2013 10:46:57 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 63381] cpumask.h error
Date: Mon, 21 Oct 2013 10:46:54 +0000
Message-ID: <bug-63381-58281-j206eY0SSq@https.bugzilla.kernel.org/> (sfid-20131021_124705_977907_CE611EE7)
In-Reply-To: <bug-63381-58281@https.bugzilla.kernel.org/>
References: <bug-63381-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=63381

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #1 from Hauke Mehrtens <hauke@hauke-m.de> ---
What kernel are you compiling against? We only test this with mainline kernels,
but when you have a patched kernel like one provided by distributions like
RedHat, they contain many patches which are conflicting with backports.

Are you compiling for x86 or for some other arch?

-- 
You are receiving this mail because:
You are the assignee for the bug.
