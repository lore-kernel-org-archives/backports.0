Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56370 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab3CIWAw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Mar 2013 17:00:52 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DA36D201A0
	for <backports@vger.kernel.org>; Sat,  9 Mar 2013 22:00:51 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 1BDB2201C1
	for <backports@vger.kernel.org>; Sat,  9 Mar 2013 22:00:48 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130309220047.0C22D11F8CD@bugzilla.kernel.org>
Date: Sat,  9 Mar 2013 22:00:47 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #12 from mp-001@ponschab.de  2013-03-09 22:00:46 ---
compat-drivers-2013-03-04-u is working on F18 (at least kernel 3.7.9-205 and
3.8.1-201 / Asus N76VM), but after suspend-resume the device is gone (`sudo
rmmod alx; sudo modprobe alx` is fixing this).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
