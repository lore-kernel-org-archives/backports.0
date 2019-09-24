Return-Path: <SRS0=oBsa=XT=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38AC432C1
	for <backports@archiver.kernel.org>; Tue, 24 Sep 2019 05:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E88E214AF
	for <backports@archiver.kernel.org>; Tue, 24 Sep 2019 05:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbfIXFoO convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Tue, 24 Sep 2019 01:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388254AbfIXFoO (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 24 Sep 2019 01:44:14 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 204959] iwlwifi: AX200: TOF_RANGE_REQ command is called, crash
 on firmware.
Date:   Tue, 24 Sep 2019 05:44:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: luca@coelho.fi
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linuxwifi@intel.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc component version assigned_to
 product
Message-ID: <bug-204959-58281-VnU5wZvRIT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204959-58281@https.bugzilla.kernel.org/>
References: <bug-204959-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204959

Luca Coelho (luca@coelho.fi) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |luca@coelho.fi
          Component|Backports                   |Wireless
            Version|unspecified                 |2.5
           Assignee|backports@vger.kernel.org   |linuxwifi@intel.com
            Product|Backports project           |Networking

--- Comment #1 from Luca Coelho (luca@coelho.fi) ---
This doesn't seem to be a backports bug per se.  Can you try it with a mainline
kernel without backports?

In any case, reassigning.

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
