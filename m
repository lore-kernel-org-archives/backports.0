Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33968 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab3LPIjL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Dec 2013 03:39:11 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8B67920353
	for <backports@vger.kernel.org>; Mon, 16 Dec 2013 08:39:10 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 84FB320328
	for <backports@vger.kernel.org>; Mon, 16 Dec 2013 08:39:09 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Mon, 16 Dec 2013 08:39:09 +0000
Message-ID: <bug-65881-58281-JfegD74ZCY@https.bugzilla.kernel.org/> (sfid-20131216_093914_003882_CB5949AB)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #7 from Johannes Berg <johannes@sipsolutions.net> ---
FWIW, it probably won't be supported unless somebody like you actually works on
it - I upstreamed the alx driver but Qualcomm never picked up maintenance and
don't seem to be even thinking about helping with the driver.

-- 
You are receiving this mail because:
You are the assignee for the bug.
