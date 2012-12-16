Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48624 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab2LPNtK (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Dec 2012 08:49:10 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B3A2F201B7
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 13:49:09 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 50408201F9
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 13:49:06 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121216134905.4324F11FA39@bugzilla.kernel.org>
Date: Sun, 16 Dec 2012 13:49:05 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671


Oleksandr Natalenko <pfactum@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pfactum@gmail.com




--- Comment #4 from Oleksandr Natalenko <pfactum@gmail.com>  2012-12-16 13:49:05 ---
In rare cases alx fails with similar symptoms on 3.6 kernels. But it happens
rarely enough.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
