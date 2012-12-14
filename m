Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35732 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309Ab2LNUvg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 14 Dec 2012 15:51:36 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 30DEA201B5
	for <backports@vger.kernel.org>; Fri, 14 Dec 2012 20:51:32 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id D96B720214
	for <backports@vger.kernel.org>; Fri, 14 Dec 2012 20:51:23 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51671] ALX driver unusable on new kernel
In-Reply-To: <bug-51671-58281@https.bugzilla.kernel.org/>
References: <bug-51671-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20121214205123.6B12711F9DF@bugzilla.kernel.org>
Date: Fri, 14 Dec 2012 20:51:23 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51671





--- Comment #2 from QCA Ethernet team <nic-devel@qca.qualcomm.com>  2012-12-14 20:51:23 ---
compat-driver of 20121204, just pass compiler, all of tx/rx function is
abnormal, we are debugging it internally.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
