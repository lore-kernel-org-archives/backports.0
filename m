Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:38678 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab3LEL2o (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 5 Dec 2013 06:28:44 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2916E20240
	for <backports@vger.kernel.org>; Thu,  5 Dec 2013 11:28:39 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id EF302204E2
	for <backports@vger.kernel.org>; Thu,  5 Dec 2013 11:28:35 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 66601] New: Compile error
Date: Thu, 05 Dec 2013 11:28:35 +0000
Message-ID: <bug-66601-58281@https.bugzilla.kernel.org/> (sfid-20131205_122846_247202_524D97D4)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=66601

            Bug ID: 66601
           Summary: Compile error
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.4.x
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: richard.rojfors@gmail.com
        Regression: No

Created attachment 117591
  --> https://bugzilla.kernel.org/attachment.cgi?id=117591&action=edit
[PATCH] compat.3.7, compat.3.8: Adds missing of.h include

This applies to 3.13-rc2

The compat-3.7.c och compat-3.8.c uses of-functions if supported by the kernel,
but there is a missing include for linux/of.h

| NOTE: make -j 8 ARCH=arm KLIB_BUILD=/path/usr/src/kernel KLIB=/path/image
|   CC [M]  /path/backports-3.13-rc2-1/compat/compat-3.7.o
| /path/backports-3.13-rc2-1/compat/compat-3.7.c: In function
'of_get_child_by_name':
| /path/backports-3.13-rc2-1/compat/compat-3.7.c:274:1: error: unknown type
name 'z'
| /path/backports-3.13-rc2-1/compat/compat-3.7.c:276:3: error: expected '=',
',', ';', 'asm' or '__attribute__' before 'if'
| make[6]: *** [/path/backports-3.13-rc2-1/compat/compat-3.7.o] Error 1
| make[5]: *** [/path/backports-3.13-rc2-1/compat] Error 2
| make[4]: *** [_module_/path/backports/3.13-rc2-1-r0/backports-3.13-rc2-1]
Error 2
| make[3]: *** [modules] Error 2
| make[2]: *** [modules] Error 2
| make[1]: *** [modules] Error 2
| make: *** [default] Error 2

-- 
You are receiving this mail because:
You are the assignee for the bug.
