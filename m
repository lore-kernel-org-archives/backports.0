Return-Path: <SRS0=jC9z=2H=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27948C43603
	for <backports@archiver.kernel.org>; Tue, 17 Dec 2019 01:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F122A21835
	for <backports@archiver.kernel.org>; Tue, 17 Dec 2019 01:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLQByk convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfLQByj (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 16 Dec 2019 20:54:39 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 205799] kernel panic always in skb_get_hash_perturb entering
 runlevel 2
Date:   Tue, 17 Dec 2019 01:54:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: vicamo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205799-58281-5td25vkt1d@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205799-58281@https.bugzilla.kernel.org/>
References: <bug-205799-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205799

--- Comment #4 from You-Sheng Yang (vicamo@gmail.com) ---
@Hauke, this was intended for backport-iwlwifi[1], so I re-filed as bug 205839
under wireless component.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
