Return-path: <backports-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:47555 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3KTHCR (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 Nov 2013 02:02:17 -0500
Received: by mail-vc0-f178.google.com with SMTP id lh4so487655vcb.9
        for <backports@vger.kernel.org>; Tue, 19 Nov 2013 23:02:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1384903178-27357-1-git-send-email-jam@cozybit.com>
References: <528BF081.5060201@hauke-m.de>
	<1384903178-27357-1-git-send-email-jam@cozybit.com>
Date: Wed, 20 Nov 2013 07:02:16 +0000
Message-ID: <CAFSJ42Z4kJUuN4H=QbAPaK8SZ6tboCT3naRt9c8=Qb8=3n-DLA@mail.gmail.com> (sfid-20131120_080221_027251_45529A20)
Subject: Re: [PATCH v3] backports: add defconfig for wcn36xx
From: Eugene Krasnikov <k.eugene.e@gmail.com>
To: Jason Mobarak <jam@cozybit.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	wcn36xx <wcn36xx@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Without CPTCFG_CFG80211_WEXT looks better to me.

On Tue, Nov 19, 2013 at 11:19 PM, Jason Mobarak <jam@cozybit.com> wrote:
> Signed-off-by: Jason Mobarak <jam@cozybit.com>
> ---
>
> v2: Added CPTCFG_CFG80211_WEXT and Signed-of-by line.
> v3: Alternate version without CPTCFG_CFG80211_WEXT.
>
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
> --
> 1.7.10.4
>
>
> _______________________________________________
> wcn36xx mailing list
> wcn36xx@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wcn36xx



-- 
Best regards,
Eugene
