Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47947 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbbFCESJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 00:18:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 501BD205FC
	for <backports@vger.kernel.org>; Wed,  3 Jun 2015 04:18:08 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 87E59203E5
	for <backports@vger.kernel.org>; Wed,  3 Jun 2015 04:18:07 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 99361] New: 0001-enable-backports-built-in.patch fails to apply
 when using --integrate
Date: Wed, 03 Jun 2015 04:18:07 +0000
Message-ID: <bug-99361-58281@https.bugzilla.kernel.org/> (sfid-20150603_061811_913453_66F0081A)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=99361

            Bug ID: 99361
           Summary: 0001-enable-backports-built-in.patch fails to apply
                    when using --integrate
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.4.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: net147@gmail.com
        Regression: No

Failed to apply changes from
001-enable-backports/0001-enable-backports-built-in.patch
> patching file Makefile
> Hunk #1 succeeded at 506 (offset -36 lines).
> Hunk #2 succeeded at 715 (offset -106 lines).
> Hunk #3 FAILED at 841.
> 1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 1078, in process
    bpid.project_dir, logwrite)
  File "./gentree.py", line 552, in apply_patches
    raise Exception('Patch failed')
Exception: Patch failed

-- 
You are receiving this mail because:
You are the assignee for the bug.
