Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52323 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab3J3W4X (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 30 Oct 2013 18:56:23 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C14E020254
	for <backports@vger.kernel.org>; Wed, 30 Oct 2013 22:56:17 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 99EE1203FB
	for <backports@vger.kernel.org>; Wed, 30 Oct 2013 22:56:08 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 64091] backports build error
Date: Wed, 30 Oct 2013 22:56:08 +0000
Message-ID: <bug-64091-58281-Uy7FABbHr0@https.bugzilla.kernel.org/> (sfid-20131030_235632_475733_296A6F48)
In-Reply-To: <bug-64091-58281@https.bugzilla.kernel.org/>
References: <bug-64091-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64091

--- Comment #1 from DarinV <darin.vancoevering@gmail.com> ---
Retried with standard kernel and no patches and the same results from stock
kernel. Did you up the GCC version to build as that would explain a few things
as my kernel runs on a Slackware 11 base.

-- 
You are receiving this mail because:
You are the assignee for the bug.
