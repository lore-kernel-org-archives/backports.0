Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38308 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbdFNN05 (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 14 Jun 2017 09:26:57 -0400
Message-ID: <1497446815.9377.0.camel@sipsolutions.net> (sfid-20170614_152659_593618_D83ED48C)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 14 Jun 2017 15:26:55 +0200
In-Reply-To: <5d265e01-bd12-801b-b604-ef7107e9373c@broadcom.com> (sfid-20170614_152544_312266_545812F3)
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
         <1497387587.6068.15.camel@sipsolutions.net>
         <5d265e01-bd12-801b-b604-ef7107e9373c@broadcom.com>
         (sfid-20170614_152544_312266_545812F3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-06-14 at 15:25 +0200, Arend van Spriel wrote:
> On 13-06-17 22:59, Johannes Berg wrote:
> > On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
> > > This patch deals with changes made in struct net_device by commit
> > > cf124db566e6 ("net: Fix inconsistent teardown and release of
> > > private
> > > netdev state."). This only looks for instances that need
> > > free_netdev() call, ie. struct net_device::needs_free_netdev ==
> > > true.
> > 
> > Come to think of it, isn't this missing the part where we now call
> > priv_destructor when registering fails or something?
> 
> Ah. I should have studied the patch better to see what behavioral
> changes the commit imposed. 

Not sure, tbh. I just think there are issues there.

> So are you still considering the patch
> despite the likely backport of commit cf124db566e6. I can do my
> homework better and resubmit if needed.

Yeah I still think this backports patch makes sense, since I'm not sure
I want to fix mac80211 that way (the bits in unregistering multiple
netdevs are awkward) and brcmfmac would still need it.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
