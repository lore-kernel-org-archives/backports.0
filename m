Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53329 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192Ab3LJRMg convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 10 Dec 2013 12:12:36 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4DF6320566
	for <backports@vger.kernel.org>; Tue, 10 Dec 2013 17:12:35 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 535D82011E
	for <backports@vger.kernel.org>; Tue, 10 Dec 2013 17:12:34 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 66601] [PATCH] missing of.h include in compat-*.c
Date: Tue, 10 Dec 2013 17:12:34 +0000
Message-ID: <bug-66601-58281-yMVDCredHA@https.bugzilla.kernel.org/> (sfid-20131210_181238_681254_34F083BF)
In-Reply-To: <bug-66601-58281@https.bugzilla.kernel.org/>
References: <bug-66601-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=66601

Richard Röjfors <richard.rojfors@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Richard Röjfors <richard.rojfors@gmail.com> ---
Makes sense, mailed patch to the mailinglist.

-- 
You are receiving this mail because:
You are the assignee for the bug.