Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:47394 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbbDTVcZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Apr 2015 17:32:25 -0400
Message-ID: <55357066.1080405@hauke-m.de> (sfid-20150420_233227_850455_27471B9C)
Date: Mon, 20 Apr 2015 23:32:22 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
Subject: struct timespec64 in igb
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Stefan,

igb makes use of "struct timespec64" now, which was added with kernel
3.17. are you able to create a nice coccinelle patch for this?

The commit in question is this:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d4c496fe45de9dc33ace3a5796e4211e2e809231

Hauke
