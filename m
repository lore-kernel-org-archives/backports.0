Return-Path: <SRS0=7wC2=AR=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3DC433DF
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 09:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551132074F
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 09:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGFJxU convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJxT (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Jul 2020 05:53:19 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 208441] backports-iwlwifi: "compat: Unknown symbol
 hash_algo_name" when compiling master
Date:   Mon, 06 Jul 2020 09:53:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: say@say.od.ua
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-208441-58281-Y5Q9gl4KgK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208441-58281@https.bugzilla.kernel.org/>
References: <bug-208441-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208441

cryo (say@say.od.ua) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |say@say.od.ua

--- Comment #1 from cryo (say@say.od.ua) ---
We faced a similar issue some time ago and we have fixed it with the following
patch:

https://marc.info/?l=linux-backports&m=159402362503848&w=2

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
