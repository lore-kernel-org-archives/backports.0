Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38194 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbdILJfz (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 12 Sep 2017 05:35:55 -0400
Message-ID: <1505208953.1974.5.camel@sipsolutions.net> (sfid-20170912_113557_365929_B2D2B4A8)
Subject: Re: [PATCH 6/8] header: add pm_system_wakeup()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Tue, 12 Sep 2017 11:35:53 +0200
In-Reply-To: <20170910221020.13067-7-hauke@hauke-m.de> (sfid-20170911_001052_010594_5AEDB503)
References: <20170910221020.13067-1-hauke@hauke-m.de>
         <20170910221020.13067-7-hauke@hauke-m.de>
         (sfid-20170911_001052_010594_5AEDB503)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-09-11 at 00:10 +0200, Hauke Mehrtens wrote:
> 
> +#if LINUX_VERSION_IS_LESS(3,18,0)
> +static inline void pm_system_wakeup(void)
> +{
> +	freeze_wake();
> +}
> +#endif

freeze_wake() was also "only" added around 3.10 or something like that,
so perhaps we should just not backport this at all but version-guard
the drivers needing it? I'm not super comfortable with the reduced
functionality anyway.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
