Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50796 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdFUVRc (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 21 Jun 2017 17:17:32 -0400
Message-ID: <1498079849.9688.1.camel@sipsolutions.net> (sfid-20170621_231734_218189_1DFF2325)
Subject: Re: [PATCH V2] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 21 Jun 2017 23:17:29 +0200
In-Reply-To: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170621_225830_268542_FFBDC610)
References: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170621_225830_268542_FFBDC610)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-06-21 at 21:58 +0100, Arend van Spriel wrote:
> This patch deals with changes made in struct net_device by commit
> cf124db566e6 ("net: Fix inconsistent teardown and release of private
> netdev state.").
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> Hi Johannes,
> 
> It took a while for me to be happy with this version. More so because
> I
> found that brcmfmac has a double-free bug if register_netdevice()
> fails
> so I needed to solve that puzzle. Below is the changelog.
> 
> Regards,
> Arend
> 
>  V2:
>   - changed netdev_set_priv_destructor() to macro.
>   - revised semantic patch covering drivers only needing
> free_netdev().
>   - used some tricks suggested by Julia in semantic patch.
>   - added more version checks against 4.13.
> ---
>  backport/backport-include/linux/netdevice.h |  9 ++++
>  patches/0079-netdev-destructor.cocci        | 84
> +++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 patches/0079-netdev-destructor.cocci
> 
> diff --git a/backport/backport-include/linux/netdevice.h
> b/backport/backport-include/linux/netdevice.h
> index 06230b5..0f5b198 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -320,4 +320,13 @@ static inline void netif_trans_update(struct
> net_device *dev)
>  }
>  #endif
>  
> +#if LINUX_VERSION_IS_LESS(4,13,0)
> +#define netdev_set_priv_destructor(_dev, _destructor) \
> +	(_dev)->destructor = __ ## _destructor
> +#else

Won't this cause annoying warnings, that __##_destructor is an unused
function, when compiling for higher kernels?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
