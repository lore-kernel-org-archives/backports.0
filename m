Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49660 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759465AbbDYOFH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:05:07 -0400
Message-ID: <553B9F11.9090104@hauke-m.de> (sfid-20150425_160509_824245_04F4B144)
Date: Sat, 25 Apr 2015 16:05:05 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: update cfg80211 wext Kconfig disable patch
References: <1425283335-4079-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1425283335-4079-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/02/2015 09:02 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The context change, update the patch.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
> index a6b09b39c3b4..658f2d81dcc3 100644
> --- a/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
> +++ b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
> @@ -31,6 +31,6 @@ so remove the Kconfig options for them.
>   	depends on CFG80211
>  -	select WEXT_CORE
>  +	depends on WEXT_CORE
> + 	default y if CFG80211_WEXT_EXPORT
>   	help
>   	  Enable this option if you need old userspace for wireless
> - 	  extensions with cfg80211-based drivers.
> 
Thank you for the patch, it was applied and pushed out.

Hauke
