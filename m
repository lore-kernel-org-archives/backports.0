Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:36454 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeIZNFW (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 26 Sep 2018 09:05:22 -0400
Message-ID: <1537944825.28767.2.camel@sipsolutions.net> (sfid-20180926_085359_874503_CB6FBA13)
Subject: Re: backports-4.19-rc5-1 released
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 26 Sep 2018 08:53:45 +0200
In-Reply-To: <3e70e3c3-ad52-5005-0354-31f25a9a3378@hauke-m.de> (sfid-20180925_225025_615547_5743766B)
References: <3e70e3c3-ad52-5005-0354-31f25a9a3378@hauke-m.de>
         (sfid-20180925_225025_615547_5743766B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-09-25 at 22:50 +0200, Hauke Mehrtens wrote:

> This release should compile on most kernel versions, we still have some
> problems on older kernel versions, probably some configurations will
> also work on older kernel versions, but not everything will work.

In particular
 * mt76 drivers don't compile on many kernels, due to missing
   #include <linux/module.h> in some files - fix is going upstream
 * if skcipher is required and enabled (lib80211 wep/tkip), things fail
   to compile - this affects most kernel versions less than 4.3
   (if I find a way to test it, I'll remove skcipher from lib80211)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
