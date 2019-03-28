Return-Path: <SRS0=kVHn=R7=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB260C43381
	for <backports@archiver.kernel.org>; Thu, 28 Mar 2019 00:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E82082F
	for <backports@archiver.kernel.org>; Thu, 28 Mar 2019 00:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfC1ABn convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:01:43 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57960 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfC1ABn (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 27 Mar 2019 20:01:43 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4A09B28B5B
        for <backports@vger.kernel.org>; Thu, 28 Mar 2019 00:01:42 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3E14028BED; Thu, 28 Mar 2019 00:01:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 203075] New: Login not working
Date:   Thu, 28 Mar 2019 00:01:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: trivial
X-Bugzilla-Severity: high
X-Bugzilla-Who: stanley.ukah1@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status keywords
 bug_severity priority component assigned_to reporter cc cf_regression
Message-ID: <bug-203075-58281@https.bugzilla.kernel.org/>
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

               URL: http://SENECACOLLEGE.CA
            Bug ID: 203075
           Summary: Login not working
           Product: Backports project
           Version: unspecified
    Kernel Version: 768
          Hardware: PPC-32
                OS: Linux
              Tree: Mainline
            Status: NEW
          Keywords: trivial
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: stanley.ukah1@gmail.com
                CC: wiseokey@gmail.com
        Regression: No

this is not working at all

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
