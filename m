Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37785 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983Ab3KUWnZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:43:25 -0500
Message-ID: <528E8C87.1000605@hauke-m.de> (sfid-20131121_234327_430685_6DED9647)
Date: Thu, 21 Nov 2013 23:43:19 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Jason Mobarak <jam@cozybit.com>, backports@vger.kernel.org
CC: wcn36xx@lists.infradead.org
Subject: Re: [PATCH v3] backports: add defconfig for wcn36xx
References: <528BF081.5060201@hauke-m.de> <1384903178-27357-1-git-send-email-jam@cozybit.com>
In-Reply-To: <1384903178-27357-1-git-send-email-jam@cozybit.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/20/2013 12:19 AM, Jason Mobarak wrote:
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
Thank you for the patch, I applied this version and a new version was
pushed out.

You do not have to send pull request over github, I will ignore then,
sending a patch to the mailing list is the correct way.

Hauke
