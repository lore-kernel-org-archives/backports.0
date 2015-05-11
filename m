Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49130 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbbEKV5G (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:57:06 -0400
Message-ID: <555125B0.2000200@hauke-m.de> (sfid-20150511_235715_973594_22CE33AD)
Date: Mon, 11 May 2015 23:57:04 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: update mac80211 LED patch
References: <1430829478-13959-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1430829478-13959-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/05/2015 02:37 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The recent mac80211 LED changes broke the patch, fix it
> up and make it apply again.
> 
> Change-Id: I4bf9595fb947886e68fa08592bd2cd3b7965f223
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../network/0024-led-blink-api/mac80211.patch      | 56 +++++++++++-----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
Thank you for the patch, it was applied and pushed out.

Hauke

