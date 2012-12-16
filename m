Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab2LPWVI convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 16 Dec 2012 17:21:08 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6C201F9
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 22:21:07 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 3193A201E6
	for <backports@vger.kernel.org>; Sun, 16 Dec 2012 22:21:06 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51751] New: debug build of ath9k fails.
Message-ID: <bug-51751-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Sun, 16 Dec 2012 22:21:05 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51751

           Summary: debug build of ath9k fails.
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.6.9 - 3.6.10
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Not sure
        AssignedTo: backports@vger.kernel.org
        ReportedBy: arclanceSignup@gmail.com
        Regression: Yes


Since 2012-12-04 building the ath9k module from compat-wireless fails when
these build options are enabled.

export CONFIG_ATH9K_DEBUGFS=y
export CONFIG_ATH_DEBUG=y

This is the error message from a failed build.

  CC [M] 
/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.o
/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.c:
In function ‘ath9k_sta_add_debugfs’:
/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.c:1589:4:
error: ‘struct ath_node’ has no member named ‘node_stat’
/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.c:
In function ‘ath9k_sta_remove_debugfs’:
/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.c:1599:19:
error: ‘struct ath_node’ has no member named ‘node_stat’
make[5]: ***
[/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k/debug.o]
Error 1
make[4]: ***
[/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath/ath9k]
Error 2
make[3]: ***
[/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless/ath]
Error 2
make[2]: ***
[/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p/drivers/net/wireless]
Error 2
make[1]: ***
[_module_/media/Linux_Data/Programs_CB10/compat_wireless/compat-wireless-2012-12-15-p/compat-wireless-2012-12-15-p]
Error 2
make[1]: Leaving directory
`/usr/src/linux-headers-3.6.0-10.dmz.1-liquorix-amd64'
make: *** [modules] Error 2

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.