Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54107 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab2K2XN1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 29 Nov 2012 18:13:27 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D62462039E
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 23:13:25 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 20B3D20219
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 23:13:25 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51061] brcmsmac crashes and disconnects
In-Reply-To: <bug-51061-58281@https.bugzilla.kernel.org/>
References: <bug-51061-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121129231325.1C30211FAE1@bugzilla.kernel.org>
Date: Thu, 29 Nov 2012 23:13:25 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51061





--- Comment #2 from Arend van Spriel <aspriel@gmail.com>  2012-11-29 23:13:24 ---
The warning in the .flush() callback is an upstream issue indeed. I will dig a
bit deeper, but indeed this does not seem like a backport issue. Feel free to
reassign.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
