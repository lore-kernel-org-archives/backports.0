Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52580 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab3JGS66 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Oct 2013 14:58:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3B62B20218
	for <backports@vger.kernel.org>; Mon,  7 Oct 2013 18:58:57 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7C20211
	for <backports@vger.kernel.org>; Mon,  7 Oct 2013 18:58:56 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Mon, 07 Oct 2013 18:58:56 +0000
Message-ID: <bug-59041-58281-xctWOHAivW@https.bugzilla.kernel.org/> (sfid-20131007_205901_415465_03A6A004)
In-Reply-To: <bug-59041-58281@https.bugzilla.kernel.org/>
References: <bug-59041-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

CSS <c.s.sigman@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |c.s.sigman@gmail.com

--- Comment #3 from CSS <c.s.sigman@gmail.com> ---
I've tried 3.10.4-1 as well as the latest development release (20130802), and
had this issue with kernel 3.6.10 in Fedora 18.  I did not have this issue
however in Fedora 19 with kernel 3.9.5

-- 
You are receiving this mail because:
You are the assignee for the bug.
