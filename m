Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46533 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935341Ab3DILYI (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 9 Apr 2013 07:24:08 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7E4372068B
	for <backports@vger.kernel.org>; Tue,  9 Apr 2013 11:24:07 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 34DAF20689
	for <backports@vger.kernel.org>; Tue,  9 Apr 2013 11:24:06 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51851] Unable to use alx driver without CONFIG_MDIO
In-Reply-To: <bug-51851-58281@https.bugzilla.kernel.org/>
References: <bug-51851-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130409112406.2C56311FA1A@bugzilla.kernel.org> (sfid-20130409_132411_453861_6A2F06C0)
Date: Tue,  9 Apr 2013 11:24:06 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51851


Bruno Santos <feiticeir0@whatgeek.com.pt> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |feiticeir0@whatgeek.com.pt




--- Comment #1 from Bruno Santos <feiticeir0@whatgeek.com.pt>  2013-04-09 11:24:05 ---
compat-drivers-3.8.3-2-snpu with kernel-3.8.3-ck on Gentoo Linux still not
working - the same error applies !

And I'm still not able to load the module - always the same error

---

[ 2981.813060] alx: Unknown symbol mdio_mii_ioctl (err 0)

---

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
