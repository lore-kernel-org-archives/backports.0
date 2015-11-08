Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49580 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbbKHIaO (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Nov 2015 03:30:14 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A5AD320639
	for <backports@vger.kernel.org>; Sun,  8 Nov 2015 08:30:13 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DF32320608
	for <backports@vger.kernel.org>; Sun,  8 Nov 2015 08:30:12 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 107461] New: clients can not connect to the AP,AP is created
 over linux2.5 with ath9k wireless card
Date: Sun, 08 Nov 2015 08:30:12 +0000
Message-ID: <bug-107461-58281@https.bugzilla.kernel.org/> (sfid-20151108_093042_852714_7EADD877)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=107461

            Bug ID: 107461
           Summary: clients can not connect to the AP,AP is created over
                    linux2.5 with ath9k wireless card
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.2.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: kmalekinasab@yahoo.com
        Regression: No

hi 
i use the ap mode for creat access point over ubuntu with backport 3.19
when i install  and update linux kernel to 4.5 then wireless clients can not
connect to the ap and conect to the internet  via this AP.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
