Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36302 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbINVZk (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 17:25:40 -0400
Subject: Re: [PATCH] backports: remove AVERAGE, backport DECLARE_EWMA
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1440407954-9633-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <55F73B53.1010500@hauke-m.de> (sfid-20150914_232542_129819_772A327A)
Date: Mon, 14 Sep 2015 23:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <1440407954-9633-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/24/2015 11:19 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> My patches to remove the out-of-line EWMA implemenation (under
> Kconfig symbol AVERAGE) went into net-next, so now we only need
> to backport DECLARE_EWMA as the only necessary macro.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/average.h | 46 +++++++++++++++++++++++++++++++
>  backport/compat/Kconfig                   | 11 --------
>  2 files changed, 46 insertions(+), 11 deletions(-)
>  create mode 100644 backport/backport-include/linux/average.h
> 

Thank you for the patch, it was applied and pushed out.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
