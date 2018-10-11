Return-Path: <SRS0=/rDn=MX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CBFC677FC
	for <backports@archiver.kernel.org>; Thu, 11 Oct 2018 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C520644
	for <backports@archiver.kernel.org>; Thu, 11 Oct 2018 21:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9C520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeJLEgy convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:36:54 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:46150 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbeJLEgy (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 12 Oct 2018 00:36:54 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6694E2C0D9
        for <backports@vger.kernel.org>; Thu, 11 Oct 2018 21:07:52 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 582322C176; Thu, 11 Oct 2018 21:07:52 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     backports@vger.kernel.org
Subject: [Bug 201383] Intel AC9260 wifi does not get DHCP IP - SuSE 15 kernel
 4.12.14-25.16-default
Date:   Thu, 11 Oct 2018 21:07:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Wireless
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pradhan@hpe.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: backports@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version product
Message-ID: <bug-201383-58281-kiq5qxinzx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201383-58281@https.bugzilla.kernel.org/>
References: <bug-201383-58281@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201383

Ashutosh (pradhan@hpe.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Backports                   |Wireless
            Version|unspecified                 |2.5
            Product|Backports project           |Networking

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
