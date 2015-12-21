Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51846 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbbLUAKT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:10:19 -0500
Subject: Re: [PATCH v2] backports: add BIT_ULL
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1450356976-14446-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <56774369.9010305@hauke-m.de> (sfid-20151221_011023_051529_BFB0A726)
Date: Mon, 21 Dec 2015 01:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <1450356976-14446-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/17/2015 01:56 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add BIT_ULL() to bitops.h, this is only available since 3.13.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/bitops.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Thank you for the patch, it was applied and pushed out.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
