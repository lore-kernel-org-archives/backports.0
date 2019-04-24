Return-Path: <SRS0=014i=S2=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85055C282E1
	for <backports@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED5E218B0
	for <backports@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfDXL2c convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:28:32 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:42882 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfDXL2c (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Apr 2019 07:28:32 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0026628924
        for <backports@vger.kernel.org>; Wed, 24 Apr 2019 11:28:31 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id E5BC42893D; Wed, 24 Apr 2019 11:28:31 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 203075] Login not working
Date:   Wed, 24 Apr 2019 11:28:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Other
X-Bugzilla-Component: Spam
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: high
X-Bugzilla-Who: johannes@sipsolutions.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: other_spam@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version assigned_to product
Message-ID: <bug-203075-58281-w9KNJnasa0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203075-58281@https.bugzilla.kernel.org/>
References: <bug-203075-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203075

Johannes Berg (johannes@sipsolutions.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Backports                   |Spam
            Version|unspecified                 |2.5
           Assignee|backports@vger.kernel.org   |other_spam@kernel-bugs.kern
                   |                            |el.org
            Product|Backports project           |Other

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
