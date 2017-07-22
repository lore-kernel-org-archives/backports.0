Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34645 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGVIBg (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 22 Jul 2017 04:01:36 -0400
Received: by mail-wm0-f47.google.com with SMTP id l81so7961401wmg.1
        for <backports@vger.kernel.org>; Sat, 22 Jul 2017 01:01:36 -0700 (PDT)
Subject: Re: [PATCH] backport: fix netdev destructor backport
To: Luca Coelho <luca@coelho.fi>, egrumbach@gmail.com
Cc: johannes@sipsolutions.net, backports@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
References: <20170718133338.16475-1-luca@coelho.fi>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <9cef262a-3331-d4cd-8874-dc68f7a9e36e@broadcom.com> (sfid-20170722_100138_987438_49219966)
Date: Sat, 22 Jul 2017 10:01:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170718133338.16475-1-luca@coelho.fi>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 18-07-17 15:33, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The commit that changed the netdev destructor was also applied in
> v4.12-rc6, so we need to update the backport.
> 
> Another issue was that when the default free_netdev() destructor was supposed to be used, we would get compilation errors, such as this one in hwsim:

[...]

> Fixes: 721ae78f9355 ("backport: handle change in netdevice destructor usage")

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/linux/netdevice.h | 9 ++++++---
>  patches/0079-netdev-destructor.cocci        | 8 ++++----
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
> index 98e781eeb740..d22eec2d3113 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -320,14 +320,17 @@ static inline void netif_trans_update(struct net_device *dev)
>  }
>  #endif
>  
> -#if LINUX_VERSION_IS_LESS(4,13,0)
> +#if LINUX_VERSION_IS_LESS(4,12,0)
>  #define netdev_set_priv_destructor(_dev, _destructor) \
>  	(_dev)->destructor = __ ## _destructor
> +#define netdev_set_def_destructor(_dev) \
> +	(_dev)->destructor = free_netdev

I tried to stick with one macro, but it is indeed awkward and oviously
incomplete. This looks better.

Thanks,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
