Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39962 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422692Ab2LFPqG (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 6 Dec 2012 10:46:06 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 67C002035C
	for <backports@vger.kernel.org>; Thu,  6 Dec 2012 15:46:05 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 800BD20357
	for <backports@vger.kernel.org>; Thu,  6 Dec 2012 15:46:03 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51361] Executing skype result in a kernel panic
In-Reply-To: <bug-51361-58281@https.bugzilla.kernel.org/>
References: <bug-51361-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121206154603.7D16411FB38@bugzilla.kernel.org>
Date: Thu,  6 Dec 2012 15:46:03 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51361


John W. Linville <linville@tuxdriver.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |Larry.Finger@lwfinger.net,
                   |                            |linville@tuxdriver.com
          Component|network-wireless            |Compat-Drivers
            Version|2.5                         |unspecified
         AssignedTo|drivers_network-wireless@ke |backports@vger.kernel.org
                   |rnel-bugs.osdl.org          |
            Product|Drivers                     |Backports project




-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
