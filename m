Return-Path: <SRS0=6/Bs=Z6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA3AC43603
	for <backports@archiver.kernel.org>; Sun,  8 Dec 2019 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A750420692
	for <backports@archiver.kernel.org>; Sun,  8 Dec 2019 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLHPCz convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLHPCz (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 8 Dec 2019 10:02:55 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 205799] New: kernel panic always in skb_get_hash_perturb
 entering runlevel 2
Date:   Sun, 08 Dec 2019 15:02:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: james@time4tea.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-205799-58281@https.bugzilla.kernel.org/>
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

            Bug ID: 205799
           Summary: kernel panic always in skb_get_hash_perturb entering
                    runlevel 2
           Product: Backports project
           Version: unspecified
    Kernel Version: 5.3.0-24
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: james@time4tea.net
        Regression: No

Created attachment 286225
  --> https://bugzilla.kernel.org/attachment.cgi?id=286225&action=edit
screenshot of panic stacktrace

Apologies if this is this wrong place to raise this bug.

I upgraded my ubuntu system to 5.3.0-24, and now get always-reproducible panic
on boot entering runlevel 2 in skb_get_hash_perturb.

this using version 8042-0ubuntu1 of backport-iwlwifi-dkms.

the same bug does not appear on 5.3.0-23.

I was unable to get a text version of the stacktrace, but i took a picture -
hopefully this is useful.

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
