Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54879 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086Ab2K2Xt1 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 29 Nov 2012 18:49:27 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B663320431
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 23:49:26 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id BBF8C203F3
	for <backports@vger.kernel.org>; Thu, 29 Nov 2012 23:49:25 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51061] brcmsmac crashes and disconnects
In-Reply-To: <bug-51061-58281@https.bugzilla.kernel.org/>
References: <bug-51061-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121129234924.B0B6511FAE1@bugzilla.kernel.org>
Date: Thu, 29 Nov 2012 23:49:24 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51061





--- Comment #3 from Luis R. Rodriguez <mcgrof@gmail.com>  2012-11-29 23:49:24 ---
Thanks for the review and confirmation. Konstantin, Alan, I tried to re-assign
the bug to Arend but bugzilla indicates the Assignee
(backports@vger.kernel.org) or someone with permissions needs to be able to do
this. Not sure if we ever got a password to use for backports@vger.kernel.org
to be able to re-assign bugs via bugzilla that were determined at a later time
are not backport related, I don't think so. Can we or can a few of us get
permissions to reassign bugs? Please note that in practice we have had so far
only 1 reported bug regarding compat-drivers / compat-wireless (back in the
day) that was an actual backport bug as such I suspect as with other bugs that
have been filed before just a heads up that most bugs on drivers that use
compat *will* likely be *real* driver bugs based on upstream linux-stable code.

I am also not sure if it is possible to modify the bug entry to re-assign to
networking for component.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
