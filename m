Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:53992 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758431Ab3DCObe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Apr 2013 10:31:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8965320456
	for <backports@vger.kernel.org>; Wed,  3 Apr 2013 14:31:32 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 9E64420314
	for <backports@vger.kernel.org>; Wed,  3 Apr 2013 14:31:26 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 55971] redefined error in 2.6.32-279.22.1.el6.x86_64 kernel
In-Reply-To: <bug-55971-58281@https.bugzilla.kernel.org/>
References: <bug-55971-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130403143126.78C5E11FA61@bugzilla.kernel.org> (sfid-20130403_163136_650786_3392A58A)
Date: Wed,  3 Apr 2013 14:31:26 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=55971





--- Comment #2 from Andy Gospodarek <andy@greyhouse.net>  2013-04-03 14:31:26 ---
This should be pretty easy to fix.  I'll fire up a RHEL6.3 host with the latest
kernel and verify a fix.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
