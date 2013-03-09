Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56961 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab3CIWnI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Mar 2013 17:43:08 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A19D6201CE
	for <backports@vger.kernel.org>; Sat,  9 Mar 2013 22:43:06 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 91DDD201C7
	for <backports@vger.kernel.org>; Sat,  9 Mar 2013 22:43:04 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130309224303.8128111F8A1@bugzilla.kernel.org>
Date: Sat,  9 Mar 2013 22:43:03 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #13 from QCA Ethernet team <nic-devel@qca.qualcomm.com>  2013-03-09 22:43:03 ---
(In reply to comment #12)
> compat-drivers-2013-03-04-u is working on F18 (at least kernel 3.7.9-205 and
> 3.8.1-201 / Asus N76VM), but after suspend-resume the device is gone (`sudo
> rmmod alx; sudo modprobe alx` is fixing this).

could you post the dmesg log ?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
