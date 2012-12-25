Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53469 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919Ab2LYPj2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 25 Dec 2012 10:39:28 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C3201A7
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 15:39:27 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 453E12012B
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 15:39:26 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51751] debug build of ath9k fails.
In-Reply-To: <bug-51751-58281@https.bugzilla.kernel.org/>
References: <bug-51751-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121225153926.3495411FBAA@bugzilla.kernel.org>
Date: Tue, 25 Dec 2012 15:39:26 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51751





--- Comment #4 from arclanceSignup@gmail.com  2012-12-25 15:39:25 ---
(In reply to comment #3)
> For compat-drivers, you can just uncomment this line in config.mk:
> # export CONFIG_MAC80211_DEBUGFS=y

It did not build the ath9k module that time either.
Maybe it is a problem with that compat-drivers release?
I will try a older one to see if it works there.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
