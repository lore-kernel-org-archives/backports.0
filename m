Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44429 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946455Ab2LFRvL (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 6 Dec 2012 12:51:11 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C151F20388
	for <backports@vger.kernel.org>; Thu,  6 Dec 2012 17:51:10 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id AA54B2039A
	for <backports@vger.kernel.org>; Thu,  6 Dec 2012 17:51:08 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51361] Executing skype result in a kernel panic
In-Reply-To: <bug-51361-58281@https.bugzilla.kernel.org/>
References: <bug-51361-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121206175107.9BE7C11FA5F@bugzilla.kernel.org>
Date: Thu,  6 Dec 2012 17:51:07 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51361





--- Comment #2 from Hauke Mehrtens <hauke@hauke-m.de>  2012-12-06 17:51:07 ---
Hi John,

He never said that he uses compat-drivers and non of the functions in
the call trace are shipped and compiled with compat-drivers. These
functions prefixed with compat_ are from somewhere else in the kernel.

Could you or someone else please reassign this to the appropriate person
or list for the r8192u staging driver.

Hauke

On 12/06/2012 04:46 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=51361
> 
> 
> John W. Linville <linville@tuxdriver.com> changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |Larry.Finger@lwfinger.net,
>                    |                            |linville@tuxdriver.com
>           Component|network-wireless            |Compat-Drivers
>             Version|2.5                         |unspecified
>          AssignedTo|drivers_network-wireless@ke |backports@vger.kernel.org
>                    |rnel-bugs.osdl.org          |
>             Product|Drivers                     |Backports project
> 
> 
> 
>

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
