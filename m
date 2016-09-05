Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754731AbcIEG5T (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Sep 2016 02:57:19 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B8372202EB
        for <backports@vger.kernel.org>; Mon,  5 Sep 2016 06:57:17 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id A9135202E5
        for <backports@vger.kernel.org>; Mon,  5 Sep 2016 06:57:16 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 156111] New: Ath10k driver kickout STA occasionally.
Date: Mon, 05 Sep 2016 06:57:16 +0000
Message-ID: <bug-156111-58281@https.bugzilla.kernel.org/> (sfid-20160905_085720_745838_3E6C99DF)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=156111

            Bug ID: 156111
           Summary: Ath10k driver kickout STA occasionally.
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.18.23
          Hardware: Mips32
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: hawk717@126.com
        Regression: No

[524653.490000] ath10k_warn: 8 callbacks suppressed
[524653.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
50:7a:55:2f:62:05
[524653.500000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
2c:f0:a2:3b:d0:49
[524653.510000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
74:a5:28:b9:3a:1c
[524654.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
50:7a:55:2f:62:05
[524654.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
2c:f0:a2:3b:d0:49
[524654.500000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
74:a5:28:b9:3a:1c
[524655.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
50:7a:55:2f:62:05
[524655.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
2c:f0:a2:3b:d0:49
[524655.500000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
74:a5:28:b9:3a:1c
[524656.490000] ath10k_pci 0000:00:00.0: Spurious quick kickout for STA
50:7a:55:2f:62:05


I user ath10k+QCA9887 for 5G and ath10k driver seemly have some bugs.

-- 
You are receiving this mail because:
You are the assignee for the bug.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
