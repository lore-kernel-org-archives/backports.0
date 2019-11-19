Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B9C432C0
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 00:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DAC222A5
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 00:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKSA0f convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfKSA0f (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 18 Nov 2019 19:26:35 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 205573] iwlwifi backport breaks realtek and ralink drivers
Date:   Tue, 19 Nov 2019 00:26:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Backports project
X-Bugzilla-Component: Backports
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: julyighor@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-205573-58281-pYm7vrueg6@https.bugzilla.kernel.org/>
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

IGHOR (julyighor@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|4.9                         |4.9.140-tegra

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
