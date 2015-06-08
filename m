Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:54861 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752033AbbFHIoL (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 04:44:11 -0400
Message-ID: <1433751430.3726.4.camel@coelho.fi> (sfid-20150608_104414_166795_CD62B45A)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org
Date: Mon, 08 Jun 2015 11:17:10 +0300
In-Reply-To: <556399B7.2040607@hauke-m.de>
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
	 <556399B7.2040607@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-05-25 at 23:52 +0200, Hauke Mehrtens wrote:
> On 05/19/2015 03:42 PM, Emmanuel Grumbach wrote:
> > Canonical backported:
> > 
> > Author: Or Gerlitz <ogerlitz@mellanox.com>
> > Date:   Mon Jan 20 13:59:19 2014 +0200
> > 
> >     net: Add GRO support for UDP encapsulating protocols
> > 
> > This is commit 2da204a8f67fbe25816cbce8cc8551f03d5b951a in their
> > tree.
> > Cope with that.
> > 
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > ---
> > Touch compiled only. And I don't really know how the UTS thing goes :)
> > ---
> >  backport/backport-include/linux/netdevice.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
> > index bb3fefb..61ac95c 100644
> > --- a/backport/backport-include/linux/netdevice.h
> > +++ b/backport/backport-include/linux/netdevice.h
> > @@ -81,6 +81,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
> >  	dev_kfree_skb_any(skb);
> >  }
> >  
> > +#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)
> >  struct pcpu_sw_netstats {
> >  	u64     rx_packets;
> >  	u64     rx_bytes;
> > @@ -88,6 +89,7 @@ struct pcpu_sw_netstats {
> >  	u64     tx_bytes;
> >  	struct u64_stats_sync   syncp;
> >  };
> > +#endif
> >  
> >  #define netdev_tstats(dev)	((struct pcpu_sw_netstats *)dev->ml_priv)
> >  #define netdev_assign_tstats(dev, e)	dev->ml_priv = (e);
> > 
> 
> 
> Thank you for the patch, it was applied and pushed.
> 
> I changed it into this:
> +#if (LINUX_VERSION_CODE != KERNEL_VERSION(3,13,11) ||
> UTS_UBUNTU_RELEASE_ABI < 24)
> ...
> #endif

Isn't this still wrong? What if the kernel is >= 3,13,11? In that case,
the struct will be already defined... and if it's an upstream kernel
(i.e. UTS_UBUNTU_RELEASE_ABI is not defined) we will still try to
redefine this struct, no?

--
Luca.

