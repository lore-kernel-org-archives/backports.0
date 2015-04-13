Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51855 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243AbbDMJZR (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 13 Apr 2015 05:25:17 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AD54220149
	for <backports@vger.kernel.org>; Mon, 13 Apr 2015 09:25:16 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 09E8920173
	for <backports@vger.kernel.org>; Mon, 13 Apr 2015 09:25:15 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 96581] New: A kernel built from >gentoo-sources-3.10.63, not
 starts. The  kernel 3.10.63 works fine. sys-kernel/gentoo-sources-3.10.73 - ?
Date: Mon, 13 Apr 2015 09:25:14 +0000
Message-ID: <bug-96581-58281@https.bugzilla.kernel.org/> (sfid-20150413_112520_542122_2BF8A600)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=96581

            Bug ID: 96581
           Summary: A kernel built from >gentoo-sources-3.10.63, not
                    starts. The  kernel 3.10.63 works fine.
                    sys-kernel/gentoo-sources-3.10.73 - ?
           Product: Backports project
           Version: unspecified
    Kernel Version: >3.10.63
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: strangers495@ymail.com
                CC: other_other@kernel-bugs.osdl.org
        Regression: No

Created attachment 173861
  --> https://bugzilla.kernel.org/attachment.cgi?id=173861&action=edit
Kernel .config

All kernels built from the stable branch of gentoo-sources version of the above
3.10.63 when booting stops on the first step when determining the type of
processor. Kernel version 3.10.63 is operating normally, the kernel parameters
were not changed. This is a repeated message (
https://bugs.gentoo.org/show_bug.cgi?id=539846) after a complete system
upgrade.

-- 
You are receiving this mail because:
You are the assignee for the bug.
