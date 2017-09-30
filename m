Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:37553 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbdI3Wbi (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 30 Sep 2017 18:31:38 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0DB9D4C35E
        for <backports@vger.kernel.org>; Sun,  1 Oct 2017 00:31:36 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id qLnsre_meOOR for <backports@vger.kernel.org>;
        Sun,  1 Oct 2017 00:31:33 +0200 (CEST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: backports-4.14-rc2-1 released
Message-ID: <44a41bfb-239b-26f3-5627-f6501a2b6ef5@hauke-m.de> (sfid-20171001_003054_982330_910048FC)
Date: Sun, 1 Oct 2017 00:31:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

backports-4.14-rc2 was released. This is based on Linux 4.14-rc2.

https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v4.14-rc2/backports-4.14-rc2-1.tar.xz

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

This release should compile on kernel 3.13 to 4.13, we still have some
problems on older kernel versions, probably some configurations will
also work on older kernel versions, but not everything will work.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
