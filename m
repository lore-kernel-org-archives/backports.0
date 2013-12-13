Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47874 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571Ab3LMAUM (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 19:20:12 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6C1EF207E4
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:20:11 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id AA76C207DD
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 00:20:10 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Fri, 13 Dec 2013 00:20:10 +0000
Message-ID: <bug-65881-58281-0oKiumJKVd@https.bugzilla.kernel.org/> (sfid-20131213_012014_522024_2C31CCBB)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #5 from Hauke Mehrtens <hauke@hauke-m.de> ---
There are some fixes for problems with SLES 11 SP3 in the latest release,
please try backports-20131206 and report your results.

https://www.kernel.org/pub/linux/kernel/projects/backports/2013/12/06/

-- 
You are receiving this mail because:
You are the assignee for the bug.
