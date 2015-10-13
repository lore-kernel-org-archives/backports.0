Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33359 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbbJMTZZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 13 Oct 2015 15:25:25 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 21C3620811
	for <backports@vger.kernel.org>; Tue, 13 Oct 2015 19:25:24 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id F0E7420665
	for <backports@vger.kernel.org>; Tue, 13 Oct 2015 19:25:22 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 105921] New: Backport releases GPG public key unavailable
Date: Tue, 13 Oct 2015 19:25:22 +0000
Message-ID: <bug-105921-58281@https.bugzilla.kernel.org/> (sfid-20151013_212539_983313_B6101DE3)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=105921

            Bug ID: 105921
           Summary: Backport releases GPG public key unavailable
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.10.0-229.14.1.el7.x86_64 (Centos 7)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: bugzilla.kernel.org@gdavis.com
        Regression: No

The GPG public key is needed to verify the releases at:
http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

which is the download page referenced at:
https://backports.wiki.kernel.org/index.php/Main_Page

For instance, the release:
backports-3.19-rc1-1
is signed with key id 583D1332,
which doesn't seem to exist pgp.mit.edu or keyserver.pgp.com or
pool.sks-keyservers.net.

Various google searches did not yield any documentation on accessing the public
key.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
