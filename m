Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51403 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab3G3OGh (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Jul 2013 10:06:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1D28720371
	for <backports@vger.kernel.org>; Tue, 30 Jul 2013 14:06:36 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 088152035C
	for <backports@vger.kernel.org>; Tue, 30 Jul 2013 14:06:35 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 59041] [PATCH 001/001] Compiling iwlwifi or alx against 3.4.47
 kernel gives redefinition error
Date: Tue, 30 Jul 2013 14:06:34 +0000
Message-ID: <bug-59041-58281-l50BufMRxv@https.bugzilla.kernel.org/> (sfid-20130730_160639_621967_0553FB00)
In-Reply-To: <bug-59041-58281@https.bugzilla.kernel.org/>
References: <bug-59041-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=59041

Konstantin Ryabitsev <mricon@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mricon@kernel.org
          Component|Compat-Drivers              |Backports

-- 
You are receiving this mail because:
You are the assignee for the bug.
