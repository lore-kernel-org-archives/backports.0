Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49322 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab3HMBUj (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 12 Aug 2013 21:20:39 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C920490
	for <backports@vger.kernel.org>; Tue, 13 Aug 2013 01:20:38 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 87F5020466
	for <backports@vger.kernel.org>; Tue, 13 Aug 2013 01:20:36 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Tue, 13 Aug 2013 01:20:36 +0000
Message-ID: <bug-59041-58281-4HHnl5zrky@https.bugzilla.kernel.org/> (sfid-20130813_032041_113018_FFCE41E4)
In-Reply-To: <bug-59041-58281@https.bugzilla.kernel.org/>
References: <bug-59041-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

Luis R. Rodriguez <mcgrof@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mcgrof@gmail.com

--- Comment #2 from Luis R. Rodriguez <mcgrof@gmail.com> ---
Please try the new backports releases, compat-drivers is deprecated.

-- 
You are receiving this mail because:
You are the assignee for the bug.
