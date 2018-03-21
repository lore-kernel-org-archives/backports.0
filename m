Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:60830 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUH71 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Mar 2018 03:59:27 -0400
Message-ID: <1521619165.2645.11.camel@sipsolutions.net> (sfid-20180321_085929_481916_8708CAF6)
Subject: Re: [PATCH 03/14] patches: Use old parameter type for DEFINE_TIMER
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Wed, 21 Mar 2018 08:59:25 +0100
In-Reply-To: <20180304225717.20890-4-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
         <20180304225717.20890-4-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-03-04 at 23:57 +0100, Hauke Mehrtens wrote:
> Use the unsigned long parameters on kernel versions < 4.15 for the
> DEFINE_TIMER callback. This was changed in Linux mainline commit
> 24ed960abf1d ("treewide: Switch DEFINE_TIMER callbacks to struct
> timer_list *")

But before this, we had a macro that could deal with both ways - why
can't we backport using a similar macro, rather than doing a patch?

If we have

 static void at76_ledtrig_tx_timerfunc(struct timer_list *unused);

then we should be able to

#define DEFINE_TIMER(x, y) ... (cast)(y)

or something, no?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
