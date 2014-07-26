Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbaGZRCt (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Jul 2014 13:02:49 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AC42D2015D
	for <backports@vger.kernel.org>; Sat, 26 Jul 2014 17:02:48 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 926F32015A
	for <backports@vger.kernel.org>; Sat, 26 Jul 2014 17:02:47 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 81151] New: backports installs /etc/depmod.conf to prefer
 updates/ over kernel/ - should be /etc/depmod.d/updates.conf
Date: Sat, 26 Jul 2014 17:02:47 +0000
Message-ID: <bug-81151-58281@https.bugzilla.kernel.org/> (sfid-20140726_190252_002357_D286EB74)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=81151

            Bug ID: 81151
           Summary: backports installs /etc/depmod.conf to prefer updates/
                    over kernel/ - should be /etc/depmod.d/updates.conf
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.12.21
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: doktor5000@arcor.de
        Regression: No

make install creates /etc/depmod.conf to prefer updates/ over kernel/ modules.
According to depmod manpage, /etc/depmod.conf is not even considered.
This is valid for at least
http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.15.1/backports-3.15.1-1.tar.xz

Had to move /etc/depmod.conf to /etc/depmod.d/backports.conf (and changed it to
"search updates built-in").
After next depmod -a module from updates/ tree got preferred, before it was
ignored.


Please fix.

-- 
You are receiving this mail because:
You are the assignee for the bug.
