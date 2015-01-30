Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36729 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763285AbbA3WkJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Jan 2015 17:40:09 -0500
Message-ID: <54CC0846.7000103@hauke-m.de> (sfid-20150130_234014_563371_D71C98AF)
Date: Fri, 30 Jan 2015 23:40:06 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH V2] backport: add backport for get_net_ns_by_fd()
References: <1422651176-5433-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1422651176-5433-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 01/30/2015 09:52 PM, Arend van Spriel wrote:
> In mac80211-next a call to get_net_ns_by_fd() has been added in cfg80211
> which resides in networking core. This function has been backported
> such that it will always fail, ie. as it would when CONFIG_NET_NS
> is not defined. The call was added by:
> 
>    commit 4b681c82d2f9bef121c912ffcaac89a004af3f2c
>    Author: Vadim Kochan <vadim4j@gmail.com>
>    Date: Mon Jan 12 16:34:05 2015 +0200
> 
>      nl80211: Allow set network namespace by fd
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> This patch replaces the commit
> "backport: add backport file for the next kernel release" which
> has Message-ID: <1422648758-31361-2-git-send-email-arend@broadcom.com>
> 
> Changes:
>  V2
>   - solve backport using LINUX_BACKPORT macro (Johannes Berg)
> ---
>  backport/backport-include/net/net_namespace.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
> index e83b103..8927af7 100644
> --- a/backport/backport-include/net/net_namespace.h
> +++ b/backport/backport-include/net/net_namespace.h
> @@ -24,4 +24,10 @@ net_ieee802154_lowpan(struct net *net)
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
>  #endif /* CPTCFG_IEEE802154_6LOWPAN */
>  

When we are on a kernel which exports this function like 3.20, this code
should not get compiled in. Your should add something like this:
#if LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0)

> +#define get_net_ns_by_fd	LINUX_BACKPORT(get_net_ns_by_fd)
> +static inline struct net *get_net_ns_by_fd(int fd)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
> 
