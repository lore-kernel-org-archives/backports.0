Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52790 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753691Ab2LYOvl (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 25 Dec 2012 09:51:41 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 84EC4201A5
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 14:51:38 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id C7F2120193
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 14:51:37 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51751] debug build of ath9k fails.
In-Reply-To: <bug-51751-58281@https.bugzilla.kernel.org/>
References: <bug-51751-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121225145137.2B18E11FBAA@bugzilla.kernel.org>
Date: Tue, 25 Dec 2012 14:51:37 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51751





--- Comment #2 from arclanceSignup@gmail.com  2012-12-25 14:51:36 ---
(In reply to comment #1)
> Patch here: https://patchwork.kernel.org/patch/1898351/

That did not work for me with compat-wireless-2012-12-18-p.tar.bz2. 
It did not even build the ath9k module.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
