Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51592 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3KSVyM (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 19 Nov 2013 16:54:12 -0500
Message-ID: <528BDDF9.7080400@hauke-m.de> (sfid-20131119_225414_935209_919A664E)
Date: Tue, 19 Nov 2013 22:54:01 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Jason Mobarak <jam@cozybit.com>
CC: backports@vger.kernel.org, wcn36xx@lists.infradead.org
Subject: Re: [PATCH] backports: add support for wcn36xx
References: <1384893931-21178-1-git-send-email-jam@cozybit.com>
In-Reply-To: <1384893931-21178-1-git-send-email-jam@cozybit.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/19/2013 09:45 PM, Jason Mobarak wrote:
> ---
>  backport/defconfigs/wcn36xx |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 backport/defconfigs/wcn36xx
> 
> diff --git a/backport/defconfigs/wcn36xx b/backport/defconfigs/wcn36xx
> new file mode 100644
> index 0000000..374eb11
> --- /dev/null
> +++ b/backport/defconfigs/wcn36xx
> @@ -0,0 +1,13 @@
> +CPTCFG_CFG80211=m
> +CPTCFG_CFG80211_DEFAULT_PS=y
> +CPTCFG_CFG80211_DEBUGFS=y
> +CPTCFG_MAC80211=m
> +# CPTCFG_MAC80211_RC_PID is not set
> +# CPTCFG_MAC80211_RC_MINSTREL is not set
> +# CPTCFG_MAC80211_RC_DEFAULT_MINSTREL is not set
> +CPTCFG_MAC80211_DEBUGFS=y
> +CPTCFG_MAC80211_MESSAGE_TRACING=y
> +CPTCFG_WLAN=y
> +CPTCFG_ATH_CARDS=m
> +CPTCFG_WCN36XX=m
> +CPTCFG_WCN36XX_DEBUGFS=y
> 

Could you add CPTCFG_CFG80211_WEXT=y please otherwise we will get bug
reports where people are complaining that iwconfig does not work.
And please add a Signed-off-by line.

Hauke
