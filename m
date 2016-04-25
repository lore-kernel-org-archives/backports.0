Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42770 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948AbcDYQDp (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 Apr 2016 12:03:45 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F17F7201C7
	for <backports@vger.kernel.org>; Mon, 25 Apr 2016 16:03:38 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DC013201EF
	for <backports@vger.kernel.org>; Mon, 25 Apr 2016 16:03:37 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94131] Unable to do make menuconfig in backports-3.18.1-1
Date: Mon, 25 Apr 2016 16:03:37 +0000
Message-ID: <bug-94131-58281-m9XNFdBrYn@https.bugzilla.kernel.org/> (sfid-20160425_180402_579700_211AE507)
In-Reply-To: <bug-94131-58281@https.bugzilla.kernel.org/>
References: <bug-94131-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94131

Vincent Cesson <vincent.cesson@smile.fr> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vincent.cesson@smile.fr

--- Comment #4 from Vincent Cesson <vincent.cesson@smile.fr> ---
Created attachment 214071
  --> https://bugzilla.kernel.org/attachment.cgi?id=214071&action=edit
Patch to fix kconf/Makefile

Patch based on backports-4.1.1.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
