Return-Path: <SRS0=x9Y6=5H=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB1C4332D
	for <backports@archiver.kernel.org>; Sun, 22 Mar 2020 02:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4228420722
	for <backports@archiver.kernel.org>; Sun, 22 Mar 2020 02:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCVClt convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Sat, 21 Mar 2020 22:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgCVClt (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 21 Mar 2020 22:41:49 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 206907] New: backport_iwlwifi 8324 Can't be compiled after make
 clean
Date:   Sun, 22 Mar 2020 02:41:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: realasking@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-206907-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206907

            Bug ID: 206907
           Summary: backport_iwlwifi 8324 Can't be compiled after make
                    clean
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.19
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: realasking@outlook.com
        Regression: No

Hi all.
I failed to make the intel backport_iwlwifi driver for ax200 (version 8324)
after I make clean when I had update my kernel from 4.19.109 manjaro to
4.19.112 manjaro.

It reported that:
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c
-o conf.o conf.c
make[5]: *** 没有规则可制作目标“zconf.tab.o”，由“conf” 需求。 停止。
make[5]: *** 正在等待未完成的任务....
make[4]: *** [Makefile.real:39：oldconfig] 错误 2
make[3]: *** [Makefile:43：oldconfig] 错误 2
make[2]: *** [Makefile.real:73：backport-include/backport/autoconf.h] 错误 2
make[1]: *** [Makefile:43：modules] 错误 2
make: *** [Makefile:30：default] 错误 2

After comparing originally downloaded folder and my compilation folder, I found
that the two source files zconf.tab.c and zconf.lex.c in the kconf folder were
deleted when make clean was executed. If which were copied, the modules could
be successfully produced again.

But this would cause dkms compilation falls. Could you make a fix for it?

Thanks.

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
