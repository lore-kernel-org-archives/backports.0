Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52949 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGRIp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 12:08:45 -0500
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <563E301B.7090609@hauke-m.de> (sfid-20151107_180846_901637_18715F55)
Date: Sat, 7 Nov 2015 18:08:43 +0100
MIME-Version: 1.0
In-Reply-To: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2015 01:52 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since commit 84b00607aeb8 ("mac80211: use ktime_get_seconds")
> mac80211 uses ktime_get_seconds(). This patch provide a backport
> using ktime_get_ts() for it.
> 
> [commit message and time64_t taken from Arend's patch]
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/ktime.h       |  1 +
>  backport/backport-include/linux/timekeeping.h | 21 +++++++++++++++++++++
>  backport/backport-include/linux/types.h       | 10 ++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100644 backport/backport-include/linux/timekeeping.h
>  create mode 100644 backport/backport-include/linux/types.h
> 
Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
