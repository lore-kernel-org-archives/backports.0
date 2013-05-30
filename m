Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50217 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232Ab3E3ULh convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 May 2013 16:11:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A13E12069A
	for <backports@vger.kernel.org>; Thu, 30 May 2013 20:11:32 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id EF3CE2068F
	for <backports@vger.kernel.org>; Thu, 30 May 2013 20:11:27 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] New: [PATCH 001/001] Compiling iwlwifi or alx against
 3.4.47 kernel gives redefinition error
Message-ID: <bug-59041-58281@https.bugzilla.kernel.org/> (sfid-20130530_221142_804561_C84D759E)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Thu, 30 May 2013 20:11:27 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

           Summary: [PATCH 001/001] Compiling iwlwifi or alx against
                    3.4.47 kernel gives redefinition error
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.4.47
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Compat-Drivers
        AssignedTo: backports@vger.kernel.org
        ReportedBy: svrusso1@gmail.com
        Regression: No


from: Steve Russo <svrusso1@gmail.com>

Compiling iwlwifi or alx against 3.4.47 kernel gives redefinition error. Tried
using compat-drivers-3.9-rc4-2-su,  compat-drivers-3.9-rc2-2-su, and
compat-drivers-3.8.3-2-snpu. Does not work from any of them.

Patch against compat-drivers-3.9-rc4-2-su follows body.

Error:
auser@mycomputer:/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su# make
make -C /lib/modules/3.4.47/build
M=/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su modules
make[1]: Entering directory `/path/to/home/Dev/Kernel/generic/linux-3.4.47'
  CC [M]  /path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/compat/main.o
In file included from
/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/include/linux/compat-2.6.h:71:0,
                 from <command-line>:0:
/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/include/linux/compat-3.8.h:49:32:
error: redefinition of ‘kref_get_unless_zero’
In file included from include/linux/kobject.h:24:0,
                 from include/linux/device.h:17,
                 from include/linux/dmaengine.h:24,
                 from include/linux/skbuff.h:31,
                 from include/linux/if_ether.h:134,
                 from include/linux/netdevice.h:29,
                 from
/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/include/linux/compat-2.6.29.h:5,
                 from
/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/include/linux/compat-2.6.h:52,
                 from <command-line>:0:
include/linux/kref.h:113:32: note: previous definition of
‘kref_get_unless_zero’ was here
make[3]: ***
[/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/compat/main.o] Error 1
make[2]: *** [/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su/compat] Error
2
make[1]: *** [_module_/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su]
Error 2
make[1]: Leaving directory `/path/to/home/Dev/Kernel/generic/linux-3.4.47'
make: *** [modules] Error 2
auser@mycomputer:/path/to/home/Dev/Wired/compat-drivers-3.9-rc4-2-su#

Signed-off-by: Steve Russo <svrusso1@gmail.com>
---

The following patch against compat-drivers-3.9-rc4-2-su allowed compilation to
complete.

--- compat-3.8.h.0    2013-05-30 15:57:51.333132738 -0400
+++ compat-3.8.h    2013-05-30 15:59:12.689517900 -0400
@@ -22,6 +22,7 @@ extern void netdev_set_default_ethtool_o

 extern bool hid_ignore(struct hid_device *);

+#ifndef _KREF_H_
 /* This backports:
  *
  * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
@@ -50,6 +51,7 @@ static inline int __must_check kref_get_
 {
     return atomic_add_unless(&kref->refcount, 1, 0);
 }
+#endif

 /* This backports:
  *

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.