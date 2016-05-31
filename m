Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33679 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbcEaTin (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 31 May 2016 15:38:43 -0400
Received: by mail-wm0-f46.google.com with SMTP id s131so24281429wme.0
        for <backports@vger.kernel.org>; Tue, 31 May 2016 12:38:43 -0700 (PDT)
Subject: Re: [PATCH] backports: add nla_put_u64_64bit()
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1464703661-10164-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <574DE840.4060009@broadcom.com> (sfid-20160531_213846_334790_00A9FDBC)
Date: Tue, 31 May 2016 21:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <1464703661-10164-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 31-05-16 16:07, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Backport it simply using nla_put_u64(). This is fine for all the
> current users, but probably should be fixed.

I submitted a patch including this a couple of weeks ago titled:
"backports: netlink: add 64-bit aligned helper functions".

Regards,
Arend

> Change-Id: I0a48b90cdd081a7cba67ad592933ab266093c831
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/net/netlink.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
> index 40160b57bc7a..570d440a9d2c 100644
> --- a/backport/backport-include/net/netlink.h
> +++ b/backport/backport-include/net/netlink.h
> @@ -189,4 +189,13 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
>  }
>  #endif /* < 4.4 */
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
> +#define nla_put_u64_64bit LINUX_BACKPORT(nla_put_u64_64bit)
> +static inline int nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
> +				    u64 value, int padattr)
> +{
> +	return nla_put_u64(skb, attrtype, value);
> +}
> +#endif /* < 4.7 */
> +
>  #endif /* __BACKPORT_NET_NETLINK_H */
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
