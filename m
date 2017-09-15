Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34248 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdIOHcz (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 15 Sep 2017 03:32:55 -0400
Message-ID: <1505460772.31630.31.camel@sipsolutions.net> (sfid-20170915_093300_464362_3465CBFB)
Subject: Re: [PATCH 6/8] header: add pm_system_wakeup()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Fri, 15 Sep 2017 09:32:52 +0200
In-Reply-To: <a5a744b1-a7fe-0015-5f09-5463100407db@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
         <20170910221020.13067-7-hauke@hauke-m.de>
         <1505208953.1974.5.camel@sipsolutions.net>
         <a5a744b1-a7fe-0015-5f09-5463100407db@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-09-12 at 23:39 +0200, Hauke Mehrtens wrote:
> On 09/12/2017 11:35 AM, Johannes Berg wrote:
> > On Mon, 2017-09-11 at 00:10 +0200, Hauke Mehrtens wrote:
> > > 
> > > +#if LINUX_VERSION_IS_LESS(3,18,0)
> > > +static inline void pm_system_wakeup(void)
> > > +{
> > > +	freeze_wake();
> > > +}
> > > +#endif
> > 
> > freeze_wake() was also "only" added around 3.10 or something like
> > that,
> > so perhaps we should just not backport this at all but version-
> > guard
> > the drivers needing it? I'm not super comfortable with the reduced
> > functionality anyway.
> 
> Hi,
> 
> This is only used by mwifiex so I am also fine with making mwifiex
> depend on kernel 3.18 or higher.
> 
> Will you create a patch and revert mine?

Done.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
