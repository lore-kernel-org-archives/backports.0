Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47233 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab3CaA6H (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Mar 2013 20:58:07 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CC245201CD
	for <backports@vger.kernel.org>; Sun, 31 Mar 2013 00:58:03 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 93F50201C0
	for <backports@vger.kernel.org>; Sun, 31 Mar 2013 00:58:01 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 55971] redefined error in 2.6.32-279.22.1.el6.x86_64 kernel
In-Reply-To: <bug-55971-58281@https.bugzilla.kernel.org/>
References: <bug-55971-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130331005800.C95FE11F9F4@bugzilla.kernel.org> (sfid-20130331_015811_183588_B166CA6F)
Date: Sun, 31 Mar 2013 00:58:00 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=55971





--- Comment #1 from sihara@ddn.com  2013-03-31 00:58:00 ---

> It needs to check in compat headers wether these macro are defined or not,
> doesn't it now? otherwise we see redefined error if both kernel header and
> compat headers are included for the souce codes..

oops.. typo s/wether/whether/

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
