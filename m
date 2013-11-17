Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55579 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab3KQI4g (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 17 Nov 2013 03:56:36 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 33910202F8
	for <backports@vger.kernel.org>; Sun, 17 Nov 2013 08:56:35 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A1DE42013A
	for <backports@vger.kernel.org>; Sun, 17 Nov 2013 08:56:33 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65031] iwlwif driver crahes while connecting from wifi display
 source
Date: Sun, 17 Nov 2013 08:56:33 +0000
Message-ID: <bug-65031-58281-a9U8RmLkKe@https.bugzilla.kernel.org/> (sfid-20131117_095641_969375_A256D6D7)
In-Reply-To: <bug-65031-58281@https.bugzilla.kernel.org/>
References: <bug-65031-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65031

Johannes Berg <johannes@sipsolutions.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |ilw@linux.intel.com
         Resolution|---                         |WILL_NOT_FIX

--- Comment #1 from Johannes Berg <johannes@sipsolutions.net> ---
The P2P support in iwlwifi/dvm is known buggy, we've decided to remove it
instead of attempting to fix it -- too many firmware issues. This particular
issue looks like a mac80211 or driver issue though.

If you wanted to debug this, then the first thing to do is probably to get
tracing data

 sudo trace-cmd record -e iwlwifi -e mac80211

and check which scan/roc overlaps.

-- 
You are receiving this mail because:
You are the assignee for the bug.
