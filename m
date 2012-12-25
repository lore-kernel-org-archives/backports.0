Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54241 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903Ab2LYQrf (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 25 Dec 2012 11:47:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7AC37201A2
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 16:47:29 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id F128E201A1
	for <backports@vger.kernel.org>; Tue, 25 Dec 2012 16:47:25 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51751] debug build of ath9k fails.
In-Reply-To: <bug-51751-58281@https.bugzilla.kernel.org/>
References: <bug-51751-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121225164725.4761C11FBAA@bugzilla.kernel.org>
Date: Tue, 25 Dec 2012 16:47:25 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51751





--- Comment #5 from arclanceSignup@gmail.com  2012-12-25 16:47:25 ---
Uncommenting export CONFIG_MAC80211_DEBUGFS=y works with
compat-wireless-2012-12-17-p.tar.bz2.
It seems that the ath9k module is broken in
compat-wireless-2012-12-18-p.tar.bz2, it does not build even with the default
options.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
