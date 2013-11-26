Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55509 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab3KZP5M convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 26 Nov 2013 10:57:12 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 94DFB20149
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 15:57:10 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 73D5C20124
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 15:57:09 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] New: errors compiling after make defconfig-alx
Date: Tue, 26 Nov 2013 15:57:09 +0000
Message-ID: <bug-65881-58281@https.bugzilla.kernel.org/> (sfid-20131126_165714_214991_CEF0C822)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

            Bug ID: 65881
           Summary: errors compiling after make defconfig-alx
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.0.76-0.11-default
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: kolson@wsd1.org
        Regression: No

Just trying to compile the alx driver for my kernel (3.0.76-0.11-default). Ran
make defconfig-alx, then make and got the following:

=======================================================================
In file included from /usr/src/linux-3.0.76-0.11/include/linux/cache.h:4,
                 from /usr/src/linux-3.0.76-0.11/include/linux/time.h:7,
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/time.h:3,
                 from /usr/src/linux-3.0.76-0.11/include/linux/stat.h:60,
                 from /usr/src/linux-3.0.76-0.11/include/linux/module.h:10,
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/module.h:3,
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/main.c:1:
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/kernel.h:35:
error: redefinition of ‘hex_byte_pack’
/usr/src/linux-3.0.76-0.11/include/linux/kernel.h:402: error: previous
definition of ‘hex_byte_pack’ was here
make[8]: *** [/root/Documents/Downloads/backports-3.13-rc1-1/compat/main.o]
Error 1
make[7]: *** [/root/Documents/Downloads/backports-3.13-rc1-1/compat] Error 2
make[6]: *** [_module_/root/Documents/Downloads/backports-3.13-rc1-1] Error 2
make[5]: *** [sub-make] Error 2
make[4]: *** [all] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2
=======================================================================

My apologies is this is a newbie mistake on my part, but I couldn't find any
forums with this error in it. Or perhaps it's a problem with my kernel?
Recently moved from SLES 11.2 TO 11.3.

-- 
You are receiving this mail because:
You are the assignee for the bug.