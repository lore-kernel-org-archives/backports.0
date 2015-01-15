Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:34282 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbbAOUJW (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Jan 2015 15:09:22 -0500
Message-ID: <54B81E6D.9090306@broadcom.com> (sfid-20150115_210925_117417_79CA5507)
Date: Thu, 15 Jan 2015 21:09:17 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH] patches: genl-const: fix nl80211.patch
References: <1421352158-20594-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1421352158-20594-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/15/15 21:02, Arend van Spriel wrote:
> nl80211.c recently changed using defined strings instead of hard-coded in
> multi-cast group definitions:
>
>    commit 71b836eca7f380fbd4c025f8c4371f9a071bc909
>    Author: Johannes Berg<johannes.berg@intel.com>
>    Date:   Tue Dec 23 17:17:38 2014 +0100
>
>        nl80211: define multicast group names in header
>
> Signed-off-by: Arend van Spriel<arend@broadcom.com>
> ---
>   .../network/0027-genl-const/nl80211.patch              | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
> index d8d67bb..51dead3 100644
> --- a/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
> +++ b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
> @@ -3,28 +3,28 @@
>   @@ -31,9 +31,9 @@ static int nl80211_crypto_settings(struc
>    				   struct cfg80211_crypto_settings *settings,
>    				   int cipher_limit);
> -
> +

Seems like my editor got a bit carried away fixing white-space stuff.

Regards,
Arend

>   -static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   +static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
>    			    struct genl_info *info);
>   -static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   +static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
>    			      struct genl_info *info);
> -
> +
>    /* the netlink family */
>   @@ -58,7 +58,7 @@ enum nl80211_multicast_groups {
>    	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
>    };
> -
> +
>   -static const struct genl_multicast_group nl80211_mcgrps[] = {
>   +static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
> - 	[NL80211_MCGRP_CONFIG] = { .name = "config", },
> - 	[NL80211_MCGRP_SCAN] = { .name = "scan", },
> - 	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
> + 	[NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
> + 	[NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
> + 	[NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
>   @@ -9938,7 +9938,7 @@ static int nl80211_tdls_cancel_channel_s
>    					 NL80211_FLAG_CHECK_NETDEV_UP)
>    #define NL80211_FLAG_CLEAR_SKB		0x20
> -
> +
>   -static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   +static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
>    			    struct genl_info *info)
> @@ -33,7 +33,7 @@
>   @@ -10007,7 +10007,7 @@ static int nl80211_pre_doit(const struct
>    	return 0;
>    }
> -
> +
>   -static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   +static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
>    			      struct genl_info *info)
> @@ -42,7 +42,7 @@
>   @@ -10036,7 +10036,7 @@ static void nl80211_post_doit(const stru
>    	}
>    }
> -
> +
>   -static const struct genl_ops nl80211_ops[] = {
>   +static __genl_const struct genl_ops nl80211_ops[] = {
>    	{

