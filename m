Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38310 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760286Ab3DCVPw (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Apr 2013 17:15:52 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B957620135
	for <backports@vger.kernel.org>; Wed,  3 Apr 2013 21:15:51 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id CB3E82045E
	for <backports@vger.kernel.org>; Wed,  3 Apr 2013 21:15:50 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 55971] redefined error in 2.6.32-279.22.1.el6.x86_64 kernel
In-Reply-To: <bug-55971-58281@https.bugzilla.kernel.org/>
References: <bug-55971-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130403211550.0728C11FB08@bugzilla.kernel.org> (sfid-20130403_231555_148810_82A88FB7)
Date: Wed,  3 Apr 2013 21:15:50 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=55971





--- Comment #3 from Andy Gospodarek <andy@greyhouse.net>  2013-04-03 21:15:49 ---
Created an attachment (id=97241)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=97241)
Initial fix for 6.3 update kernel

This has not been tested other than to be sure it compiles.  I'll post to the
list once I receive confirmation that it works for the reporter.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
