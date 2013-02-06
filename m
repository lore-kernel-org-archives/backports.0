Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60445 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab3BFPuo (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 6 Feb 2013 10:50:44 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF220396
	for <backports@vger.kernel.org>; Wed,  6 Feb 2013 15:50:43 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 5143D2037E
	for <backports@vger.kernel.org>; Wed,  6 Feb 2013 15:50:41 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 53421] eeprom init error of AR9582
In-Reply-To: <bug-53421-58281@https.bugzilla.kernel.org/>
References: <bug-53421-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130206155041.4E35111FE9A@bugzilla.kernel.org>
Date: Wed,  6 Feb 2013 15:50:41 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=53421


John W. Linville <linville@tuxdriver.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linville@tuxdriver.com,
                   |                            |shafi.wireless@gmail.com
          Component|Compat                      |network-wireless
            Version|unspecified                 |2.5
         AssignedTo|backports@vger.kernel.org   |drivers_network-wireless@ke
                   |                            |rnel-bugs.osdl.org
            Product|Backports project           |Drivers




-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
