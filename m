Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41802 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdFLJWV (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 12 Jun 2017 05:22:21 -0400
Message-ID: <1497259338.18110.2.camel@sipsolutions.net> (sfid-20170612_112223_167146_9E63652F)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Mon, 12 Jun 2017 11:22:18 +0200
In-Reply-To: <f5b49f6d-7a18-ddec-9d51-6a3194168fa2@broadcom.com> (sfid-20170612_111529_660251_6BD900C2)
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
         <1497258670.18110.1.camel@sipsolutions.net>
         <f5b49f6d-7a18-ddec-9d51-6a3194168fa2@broadcom.com>
         (sfid-20170612_111529_660251_6BD900C2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-06-12 at 11:15 +0200, Arend van Spriel wrote:
> On 6/12/2017 11:11 AM, Johannes Berg wrote:
> > On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
> > > This patch deals with changes made in struct net_device by commit
> > > cf124db566e6 ("net: Fix inconsistent teardown and release of
> > > private
> > > netdev state."). This only looks for instances that need
> > > free_netdev() call, ie. struct net_device::needs_free_netdev ==
> > > true.
> > 
> > I think we may need to worry about more kernel versions than just
> > 4.12
> > here, since this stuff is getting backported, and then it would
> > cause
> > double-frees.
> > 
> > I'm also considering simply removing the priv_destructor entirely
> > from
> > mac80211, but I guess this would still apply to other drivers.
> 
> For current backports the only other driver is brcmfmac. 

Right.

> So you don't 
> need it in mac80211? Does that mean you move stuff to .ndo_uninit()?

No, just call more things explicitly and remove destructor usage
entirely. See the thread with davem?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
