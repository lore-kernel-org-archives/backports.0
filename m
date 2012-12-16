Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47372 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2LPMQm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Dec 2012 07:16:42 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9837E20293
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 12:16:41 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id D4817202AB
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 12:16:39 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121216121639.3300211FA39@bugzilla.kernel.org>
Date: Sun, 16 Dec 2012 12:16:39 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #3 from Hexchain Tong <i@hexchain.org>  2012-12-16 12:16:38 ---
(In reply to comment #1)
> Can you post the output of dmesg ?

I think it is in the first post. I'm using systemd and the log was grep'd from
systemd journal, so it may look a bit strange.

(In reply to comment #2)
> compat-driver of 20121204, just pass compiler, all of tx/rx function is
> abnormal, we are debugging it internally.

So, there's no way to use this driver with 3.7 kernel?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
