Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51651 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbcEDU7A (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 4 May 2016 16:59:00 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 330D7203E6
	for <backports@vger.kernel.org>; Wed,  4 May 2016 20:58:59 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 5F488203C1
	for <backports@vger.kernel.org>; Wed,  4 May 2016 20:58:58 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 111401] Missing country on atheros driver regd_common.h and
 regd.h
Date: Wed, 04 May 2016 20:58:58 +0000
Message-ID: <bug-111401-58281-qwpUWchBJx@https.bugzilla.kernel.org/> (sfid-20160504_225903_260952_0B92D8E1)
In-Reply-To: <bug-111401-58281@https.bugzilla.kernel.org/>
References: <bug-111401-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=111401

Luis R. Rodriguez <mcgrof@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |mcgrof@gmail.com
         Resolution|---                         |INVALID

--- Comment #2 from Luis R. Rodriguez <mcgrof@gmail.com> ---
Regulatory data is maintained separately in the wireless-regdb project.

https://wireless.wiki.kernel.org/en/developers/regulatory/wireless-regdb

As you noted GY is there already. The Atheros driver lacking a GY annotation is
up to the atheros driver, that needs to be addressed upstream and is therefore
not a backports specific issue. You should address this upstream:

For that see:

https://wireless.wiki.kernel.org/en/developers/mailinglists

The regd_common.h file is part of the ath module. As the Linux kernel ath
module maintainer, I welcome a patch but you must post it to the linux-wireless
list and also get Kalle Vallo to review it as he is at Atheros can also help
review Atheros' own position on this.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
