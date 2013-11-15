Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47515 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab3KOGwY (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 15 Nov 2013 01:52:24 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AF0A320997
	for <backports@vger.kernel.org>; Fri, 15 Nov 2013 06:52:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC520995
	for <backports@vger.kernel.org>; Fri, 15 Nov 2013 06:52:23 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65031] New: iwlwif driver crahes while connecting from wifi
 display source
Date: Fri, 15 Nov 2013 06:52:22 +0000
Message-ID: <bug-65031-58281@https.bugzilla.kernel.org/> (sfid-20131115_075226_868253_C8109B40)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65031

            Bug ID: 65031
           Summary: iwlwif driver crahes while connecting from wifi
                    display source
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.5.0.17-generic kernel
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: vaisakh.n@allgosystems.com
        Regression: No

Created attachment 114831
  --> https://bugzilla.kernel.org/attachment.cgi?id=114831&action=edit
dmesg with crash lo9g

Hi, 
iwlwif Wifi driver is crashing while connecting to it from phone via wifi
direct.

My platform details follows
Kernel : 3.5.0.17-generic kernel
Wifi Chip :  INTEL  Centrino Advanced 6235 AGN,REV=0xB  
OS: ubuntu  12.10  (32bit)
iwlwifi driver :  backports-3.11.6-1 . ( p2p enabled )
Wpa supplicant :2.0-devel-3.4.0.171
Wifi Firmware loaded : 18.168.6.1

Full dmesg log attached with this bug

-- 
You are receiving this mail because:
You are the assignee for the bug.
