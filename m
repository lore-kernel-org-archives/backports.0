Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51230 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933741AbcA1AMf (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 27 Jan 2016 19:12:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6CAFA2026F
	for <backports@vger.kernel.org>; Thu, 28 Jan 2016 00:12:33 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id B426420117
	for <backports@vger.kernel.org>; Thu, 28 Jan 2016 00:12:31 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 111401] Missing country on atheros driver regd_common.h and
 regd.h
Date: Thu, 28 Jan 2016 00:12:31 +0000
Message-ID: <bug-111401-58281-Q2EMiCopU7@https.bugzilla.kernel.org/> (sfid-20160128_011236_405528_6D85F4DD)
In-Reply-To: <bug-111401-58281@https.bugzilla.kernel.org/>
References: <bug-111401-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=111401

--- Comment #1 from brunoaduarte@hotmail.com ---
You should use these
ftp://ftp.maths.tcd.ie/usr/include/net80211/ieee80211_regdomain.h

CTRY_GUYANA        = 328

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
