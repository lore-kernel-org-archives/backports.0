Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57805 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166Ab3JHLgS (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Oct 2013 07:36:18 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C10A620211
	for <backports@vger.kernel.org>; Tue,  8 Oct 2013 11:36:15 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id C8B0720134
	for <backports@vger.kernel.org>; Tue,  8 Oct 2013 11:36:14 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Tue, 08 Oct 2013 11:36:14 +0000
Message-ID: <bug-59041-58281-QmghzQY1Gx@https.bugzilla.kernel.org/> (sfid-20131008_133622_424847_354155D6)
In-Reply-To: <bug-59041-58281@https.bugzilla.kernel.org/>
References: <bug-59041-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

--- Comment #4 from CSS <c.s.sigman@gmail.com> ---
(In reply to CSS from comment #3)
> I've tried 3.10.4-1 as well as the latest development release (20130802),
> and had this issue with kernel 3.6.10 in Fedora 18.  I did not have this
> issue however in Fedora 19 with kernel 3.9.5

Specifically, I've tried backports 3.10.4-1.

-- 
You are receiving this mail because:
You are the assignee for the bug.
