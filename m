Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58072 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbaG2EqG (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 29 Jul 2014 00:46:06 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6A2CF2014A
	for <backports@vger.kernel.org>; Tue, 29 Jul 2014 04:46:05 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id A92442015D
	for <backports@vger.kernel.org>; Tue, 29 Jul 2014 04:46:04 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 64091] backports build error
Date: Tue, 29 Jul 2014 04:46:04 +0000
Message-ID: <bug-64091-58281-vwPNQJcF5H@https.bugzilla.kernel.org/> (sfid-20140729_064609_062637_1C32DCBE)
In-Reply-To: <bug-64091-58281@https.bugzilla.kernel.org/>
References: <bug-64091-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64091

--- Comment #8 from DarinV <darin.vancoevering@gmail.com> ---
Well if you consider that the backports will not build on gcc 3.4.6 acceptable
then I guess it is. I am still wondering why you would build backports to only
work with newer gcc versions which in my opinion defeats the goal of backports,
but like I am saying if you feel the need to close this then go ahead.

-- 
You are receiving this mail because:
You are the assignee for the bug.
