Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:34338 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdJEGtk (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 5 Oct 2017 02:49:40 -0400
Message-ID: <1507186179.2387.12.camel@sipsolutions.net> (sfid-20171005_084942_554412_3C4B8BB7)
Subject: Re: [PATCH] header: fix compile error on PowerPC (PPC_85xx)
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Thu, 05 Oct 2017 08:49:39 +0200
In-Reply-To: <a47cbe26-26fb-cfb6-f7cd-17d77153ea66@hauke-m.de>
References: <20171001193823.22685-1-hauke@hauke-m.de>
         <1506947972.25586.14.camel@sipsolutions.net>
         <a47cbe26-26fb-cfb6-f7cd-17d77153ea66@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-10-02 at 20:31 +0200, Hauke Mehrtens wrote:
> On 10/02/2017 02:39 PM, Johannes Berg wrote:
> > On Sun, 2017-10-01 at 21:38 +0200, Hauke Mehrtens wrote:
> > > Including linux/interrupt.h in linux/hrtimer.h causes this error
> > > message
> > > on PowerPC builds on x86, ARM and MIPS it works:
> > 
> > I think I also saw this on x86 on older kernel versions, and
> > couldn't
> > really figure out what was causing it...
> 
> I haven't fully understood this issue, but the LEDE build bot found
> it
> on multiple PowerPC based systems. With this patch applied it is
> compiling on all targets.
> 
> I ran the build test script on the compat server and it was fine with
> this patch applied for all kernel versions that worked before.

Ok.

> > > The backport of the hrtimer_start() functions needs the
> > > linux/interrupt.h because some parts are defined there. Fix this
> > > by
> > > moving the hrtimer_start() backport to the linux/interrupt.h
> > > backport
> > > header file.
> > 
> > Does hrtimre.h always include interrupt.h, so that we get it in
> > when
> > somebody includes just hrtimer.h?
> 
> I do not know, it is not included directly.

I guess we'll find out :-)

I'll apply this.

thanks,
johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
