Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:37345 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab3LVKdw (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 05:33:52 -0500
Message-ID: <1387708422.4346.0.camel@jlt4.sipsolutions.net> (sfid-20131222_113354_616473_6935E0DC)
Subject: Re: [PATCH] network: mac80211: rework multicast patches for mac80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Sun, 22 Dec 2013 11:33:42 +0100
In-Reply-To: <1387706902-12322-1-git-send-email-arend@broadcom.com> (sfid-20131222_110836_368323_821C7D89)
References: <1387706902-12322-1-git-send-email-arend@broadcom.com>
	 (sfid-20131222_110836_368323_821C7D89)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-12-22 at 11:08 +0100, Arend van Spriel wrote:
> Fixing up the patches for mac80211 that were located under
> collateral-evolutions/network/25-multicast-list_head.

I had an almost identical patch, sorry for not sending that out.


> --- a/gen-brcm-backport.sh
> +++ b/gen-brcm-backport.sh
> @@ -34,7 +34,6 @@ function get_sha1ref() {
>  }
>  
>  parse_cmdline $*
> -echo ${GITTREE}
>  SHA1REF=$(get_sha1ref)
>  BACKPORT_RELEASE=brcm-backports${REPOTAG}-g$(get_sha1ref)
>  TMPDIR=/tmp/${BACKPORT_RELEASE}

?

johannes

