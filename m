Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33699 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbbCCRGu (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 3 Mar 2015 12:06:50 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F0FBF20397
	for <backports@vger.kernel.org>; Tue,  3 Mar 2015 17:06:48 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8F2038E
	for <backports@vger.kernel.org>; Tue,  3 Mar 2015 17:06:48 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94131] Unable to do make menuconfig in backports-3.18.1-1
Date: Tue, 03 Mar 2015 17:06:47 +0000
Message-ID: <bug-94131-58281-XX2unV5aAr@https.bugzilla.kernel.org/> (sfid-20150303_180653_047657_F38813A4)
In-Reply-To: <bug-94131-58281@https.bugzilla.kernel.org/>
References: <bug-94131-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94131

--- Comment #2 from Michal Dziczkowski <m.dziczkowski@prokonto.pl> ---
(In reply to Johannes Berg from comment #1)

I had tryed multiple times doing make menuconfig and I get same errors.


Possible solution (TODO):

> add all required packages "lxdialog" and others to the package of backports and modify the configure and make enviroment that they get compiled before backports to make the requirments meet before it get compiled

-- 
You are receiving this mail because:
You are the assignee for the bug.
