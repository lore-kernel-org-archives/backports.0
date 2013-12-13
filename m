Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51867 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab3LMQ0z (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 13 Dec 2013 11:26:55 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7BF402056E
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 16:26:50 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 7111120561
	for <backports@vger.kernel.org>; Fri, 13 Dec 2013 16:26:44 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Fri, 13 Dec 2013 16:26:44 +0000
Message-ID: <bug-65881-58281-yB1lYm0jaT@https.bugzilla.kernel.org/> (sfid-20131213_172657_461503_15EAD2A9)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #6 from Kenn <kolson@wsd1.org> ---
(In reply to Hauke Mehrtens from comment #5)
> There are some fixes for problems with SLES 11 SP3 in the latest release,
> please try backports-20131206 and report your results.

Thanks! That compiled without any errors!

Unfortunately, the driver did not work for the laptop we were trying to get on
the network. It's an Alienware 17 with Qualcomm LAN Killer E2201 wireless.
Vendor ID 1969 Device ID E091. Unfortunately, I no longer have the device in my
office, so testing any further updates requires extra steps from my colleagues.

However, I will monitor backports releases and try new ones periodically.
Hopefully the NIC in the Alienware notebook will be supported soon.

Thanks again for your help!

-- 
You are receiving this mail because:
You are the assignee for the bug.
