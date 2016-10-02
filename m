Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbcJBEJ6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Oct 2016 00:09:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id ECE1A202B8
        for <backports@vger.kernel.org>; Sun,  2 Oct 2016 04:09:54 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id AD437202AE
        for <backports@vger.kernel.org>; Sun,  2 Oct 2016 04:09:53 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 175381] New: WiFi Intermittently Disconnecting
Date: Sun, 02 Oct 2016 04:09:52 +0000
Message-ID: <bug-175381-58281@https.bugzilla.kernel.org/> (sfid-20161002_061001_795970_E6921653)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=175381

            Bug ID: 175381
           Summary: WiFi Intermittently Disconnecting
           Product: Backports project
           Version: unspecified
    Kernel Version: 4.2.0-35 + 4.4.0-38
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: tim@globaltimoto.com
        Regression: No

Created attachment 240541
  --> https://bugzilla.kernel.org/attachment.cgi?id=240541&action=edit
dmesg.log

Hello

Forgive me if this bug is submitted to the wrong location.

For some time wifi functioned well on this system dell-precision-5510.

Currently wifi disconnects intermittently.

The same system booting into W7 and W10 recently updated the wifi drivers to
19.10 and function well.

However Linux Mint 17.3 Rosa Xfce Kernel 4.2.0-35 became unstable. I tried
Kernel 4.4.0-38, but the issue persists.

The driver from intel had been installed here:
/lib/firmware/iwlwifi-8000C-13.ucode

>From the intel's iwlwifi-8000-ucode-25.30.13.0.tgz

~ $ ethtool -i wlan0 | grep firmware
firmware-version: 25.30.13.0

I'm not sure how to methodically troubleshoot this issue.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
