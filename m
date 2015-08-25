Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41659 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbbHYWFN (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 25 Aug 2015 18:05:13 -0400
Message-ID: <1440540311.2376.0.camel@sipsolutions.net> (sfid-20150826_000516_090677_1A7B4FFB)
Subject: Re: [PATCH] backports: backport IFF_NO_QUEUE net_device flag
From: Johannes Berg <johannes@sipsolutions.net>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org
Date: Wed, 26 Aug 2015 00:05:11 +0200
In-Reply-To: <1440531399-29379-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20150825_213646_779513_F10D303E)
References: <1440531399-29379-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20150825_213646_779513_F10D303E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-08-25 at 22:36 +0300, Emmanuel Grumbach wrote:
> commit fa8187c96471c49419c25d4ec3299d17d3f274b2
> Author: Phil Sutter <phil@nwl.cc>
> Date:   Thu Aug 13 19:01:06 2015 +0200
> 
>     net: declare new net_device priv_flag IFF_NO_QUEUE
> 
>     This private net_device flag can be set by drivers to inform that a
>     device runs fine without a qdisc attached. This was formerly done by
>     setting tx_queue_len to zero.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  backport/backport-include/linux/netdevice.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/backport/backport-include/linux/netdevice.h 
> b/backport/backport-include/linux/netdevice.h
> index 95189be..94d8613 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -292,4 +292,9 @@ netdev_features_t passthru_features_check(struct 
> sk_buff *skb,
>  })
>  #endif /* netdev_alloc_pcpu_stats */
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
> +#ifndef IFF_NO_QUEUE
> +#define IFF_NO_QUEUE 1<<26
> +#endif
> 
That doesn't really help, does it? Need to add a semantic patch to
backport this with an ifdef to set the tx_queue_len to 0 in the older
kernel case?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
