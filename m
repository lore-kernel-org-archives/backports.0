Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33265 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab2LQDTV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Dec 2012 22:19:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 63BBE20258
	for <backports@vger.kernel.org>; Mon, 17 Dec 2012 03:19:20 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id F0CC320240
	for <backports@vger.kernel.org>; Mon, 17 Dec 2012 03:19:18 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121217031917.E30C211FB37@bugzilla.kernel.org>
Date: Mon, 17 Dec 2012 03:19:17 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #5 from QCA Ethernet team <nic-devel@qca.qualcomm.com>  2012-12-17 03:19:17 ---
(In reply to comment #3)
> 
> (In reply to comment #2)
> > compat-driver of 20121204, just pass compiler, all of tx/rx function is
> > abnormal, we are debugging it internally.
> 
> So, there's no way to use this driver with 3.7 kernel?

yes, but we'll publish a real usable one soon.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
