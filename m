Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37440 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631Ab3LINcS (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 9 Dec 2013 08:32:18 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 44FCA201EC
	for <backports@vger.kernel.org>; Mon,  9 Dec 2013 13:32:17 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 4F5DC2017D
	for <backports@vger.kernel.org>; Mon,  9 Dec 2013 13:32:16 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 66601] [PATCH] missing of.h include in compat-*.c
Date: Mon, 09 Dec 2013 13:32:16 +0000
Message-ID: <bug-66601-58281-tYMJ9ANonU@https.bugzilla.kernel.org/> (sfid-20131209_143220_668596_DFCC5822)
In-Reply-To: <bug-66601-58281@https.bugzilla.kernel.org/>
References: <bug-66601-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=66601

Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
            Summary|Compile error               |[PATCH] missing of.h
                   |                            |include in compat-*.c

-- 
You are receiving this mail because:
You are the assignee for the bug.
