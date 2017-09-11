Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45902 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdIKOsE (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 11 Sep 2017 10:48:04 -0400
Message-ID: <1505141282.20347.8.camel@sipsolutions.net> (sfid-20170911_164807_388241_3E4FA26E)
Subject: Re: [PATCH 0/8] backports: misc fixes
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Mon, 11 Sep 2017 16:48:02 +0200
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-09-11 at 00:10 +0200, Hauke Mehrtens wrote:
> This fixes two problems introduced in my previous patches and also
> adds 
> some other small functions needed to build against kernel >= 3.13.

Thanks! I had some of this pending locally, but applied all of yours
now.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
