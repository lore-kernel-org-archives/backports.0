Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FFBC432C3
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F94E20878
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 08:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfKSIw4 convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:52:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSIw4 (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 19 Nov 2019 03:52:56 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 205573] iwlwifi backport breaks realtek and ralink drivers
Date:   Tue, 19 Nov 2019 08:52:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johannes@sipsolutions.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-205573-58281-mEy2hrqnOI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205573-58281@https.bugzilla.kernel.org/>
References: <bug-205573-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205573

Johannes Berg (johannes@sipsolutions.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--- Comment #1 from Johannes Berg (johannes@sipsolutions.net) ---
This fundamentally cannot be solved - you have to install all wifi drivers that
you want to use from backports.

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
