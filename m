Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36215 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab3CETxq (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 5 Mar 2013 14:53:46 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 57A7B2033C
	for <backports@vger.kernel.org>; Tue,  5 Mar 2013 19:53:45 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id D3512202F4
	for <backports@vger.kernel.org>; Tue,  5 Mar 2013 19:53:43 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130305195342.C420B11FC76@bugzilla.kernel.org>
Date: Tue,  5 Mar 2013 19:53:42 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671


pru <prudy1@o2.pl> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |prudy1@o2.pl




--- Comment #11 from pru <prudy1@o2.pl>  2013-03-05 19:53:42 ---
The last working thing on F18 is compat-wireless-3.6.8-1-snpc.tar.bz2 (with
compilation fixes), but the compat-drivers-* do not.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
