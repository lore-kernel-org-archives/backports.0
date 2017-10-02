Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:33936 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBMzD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 2 Oct 2017 08:55:03 -0400
Message-ID: <1506947972.25586.14.camel@sipsolutions.net> (sfid-20171002_145308_345469_764283FA)
Subject: Re: [PATCH] header: fix compile error on PowerPC (PPC_85xx)
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Mon, 02 Oct 2017 14:39:32 +0200
In-Reply-To: <20171001193823.22685-1-hauke@hauke-m.de> (sfid-20171001_213725_971296_CB3FECF9)
References: <20171001193823.22685-1-hauke@hauke-m.de>
         (sfid-20171001_213725_971296_CB3FECF9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2017-10-01 at 21:38 +0200, Hauke Mehrtens wrote:
> Including linux/interrupt.h in linux/hrtimer.h causes this error
> message
> on PowerPC builds on x86, ARM and MIPS it works:

I think I also saw this on x86 on older kernel versions, and couldn't
really figure out what was causing it...

> The backport of the hrtimer_start() functions needs the
> linux/interrupt.h because some parts are defined there. Fix this by
> moving the hrtimer_start() backport to the linux/interrupt.h backport
> header file.

Does hrtimre.h always include interrupt.h, so that we get it in when
somebody includes just hrtimer.h?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
