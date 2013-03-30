Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37368 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759Ab3C3HcD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Mar 2013 03:32:03 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8CCBF201B6
	for <backports@vger.kernel.org>; Sat, 30 Mar 2013 07:32:01 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 99FC92019B
	for <backports@vger.kernel.org>; Sat, 30 Mar 2013 07:32:00 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 55971] New: redefined error in 2.6.32-279.22.1.el6.x86_64
 kernel
Message-ID: <bug-55971-58281@https.bugzilla.kernel.org/> (sfid-20130330_083205_979925_C4D1F1CE)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Sat, 30 Mar 2013 07:32:00 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=55971

           Summary: redefined error in 2.6.32-279.22.1.el6.x86_64 kernel
           Product: Backports project
           Version: unspecified
    Kernel Version: 2.6.32-279.22.1.el6.x86_64
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Compat
        AssignedTo: backports@vger.kernel.org
        ReportedBy: sihara@ddn.com
        Regression: No


Since RHEL6.3's security updated kernel (2.6.32-279.22.1.el6.x86_64) has
included two macros (rcu_dereference_protected and kfree_rcu) in
include/linux/rcupdate.h

These were not existed in original RHEL6.3's kernel (2.6.32-279) and even the
previous kernel of 2.6.32-279.22.1.el6.x86_64.

The other hand, these macros are defined in include/linux/compat-x.z.h.
(rcu_dereference_protected in compat-2.6.34.h and kfree_rcu in compat-3.0.h).

It needs to check in compat headers wether these macro are defined or not,
doesn't it now? otherwise we see redefined error if both kernel header and
compat headers are included for the souce codes..

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
