Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49630 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbbLIW4s (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Dec 2015 17:56:48 -0500
Message-ID: <1449701805.22495.1.camel@sipsolutions.net> (sfid-20151209_235652_234383_D59FAA77)
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
Date: Wed, 09 Dec 2015 23:56:45 +0100
In-Reply-To: <5668B0AC.2080602@hauke-m.de>
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
	 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>
	 <1449565444.4154.1.camel@sipsolutions.net>
	 <1449566082.4154.6.camel@sipsolutions.net> <5666A2C8.3070002@broadcom.com>
	 <1449567481.4154.9.camel@sipsolutions.net> <5668B0AC.2080602@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-12-09 at 23:52 +0100, Hauke Mehrtens wrote:
> 
> We could search backport/compat/*.c for EXPORT_SYMBOL() and create
> the
> list based on that. Using compat.ko for that would mean we have to
> compile first.

EXPORT_SYMBOL is pretty simple to grep :)

I'm just not really sure I see the point - after all, we have to add
the #ifdefs manually as well?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
