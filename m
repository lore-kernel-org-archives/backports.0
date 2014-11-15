Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36559 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114AbaKOT4o (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Nov 2014 14:56:44 -0500
Message-ID: <5467AFF9.5060809@hauke-m.de> (sfid-20141115_205646_354719_989E725A)
Date: Sat, 15 Nov 2014 20:56:41 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backport: genl: add __genl_const for new hwsim mcast
 group
References: <1415271730-19194-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1415271730-19194-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/06/2014 12:02 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../collateral-evolutions/network/0027-genl-const/hwsim.patch | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
> index 33cba175dda6..d6cb0350f1d1 100644
> --- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
> +++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
> @@ -1,5 +1,16 @@
>  --- a/drivers/net/wireless/mac80211_hwsim.c
>  +++ b/drivers/net/wireless/mac80211_hwsim.c
> +@@ -491,7 +491,7 @@ enum hwsim_multicast_groups {
> + 	HWSIM_MCGRP_CONFIG,
> + };
> + 
> +-static const struct genl_multicast_group hwsim_mcgrps[] = {
> ++static __genl_const struct genl_multicast_group hwsim_mcgrps[] = {
> + 	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
> + };
> + 
> +--- a/drivers/net/wireless/mac80211_hwsim.c
> ++++ b/drivers/net/wireless/mac80211_hwsim.c

The last two lines are wrong, now we have to of these in the patch.

>  @@ -2483,7 +2483,7 @@ static int hwsim_destroy_radio_nl(struct
>   }
>   
> 

