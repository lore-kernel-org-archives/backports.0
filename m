Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42926 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927AbcDYQEh (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 Apr 2016 12:04:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 874AE201EC
	for <backports@vger.kernel.org>; Mon, 25 Apr 2016 16:04:35 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB5200D4
	for <backports@vger.kernel.org>; Mon, 25 Apr 2016 16:04:34 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94131] Unable to do make menuconfig in backports-3.18.1-1
Date: Mon, 25 Apr 2016 16:04:34 +0000
Message-ID: <bug-94131-58281-LCd2z4TqMj@https.bugzilla.kernel.org/> (sfid-20160425_180448_511495_77593183)
In-Reply-To: <bug-94131-58281@https.bugzilla.kernel.org/>
References: <bug-94131-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94131

--- Comment #5 from Vincent Cesson <vincent.cesson@smile.fr> ---
I had the same issue on Ubuntu 14.04, kernel 4.2. It seems to be a problem with
kconf/Makefile. Fixed on my machine with patch attached.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
