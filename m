Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57974 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbbEYVwE (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:52:04 -0400
Message-ID: <55639982.3080202@hauke-m.de> (sfid-20150525_235206_975548_A06800A2)
Date: Mon, 25 May 2015 23:52:02 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: fix netdev->tstats backport
References: <1431631482-5810-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1431631482-5810-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/14/2015 09:24 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Given a correct spatch, there's no need for the other manual
> patch. Thanks to Julia for pointing out my error in building
> the original spatch, and how to fix it.
> 
> Change-Id: I0226a6c4d0fb7630abee315f1839ba63534aacbb
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../collateral-evolutions/network/0055-netdev-tstats-tx.patch | 11 -----------
>  ...55-netdev-tstats-assign.cocci => 0055-netdev-tstats.cocci} |  9 +++++----
>  .../collateral-evolutions/network/0056-netdev-tstats.cocci    |  9 ---------
>  3 files changed, 5 insertions(+), 24 deletions(-)
>  delete mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
>  rename patches/collateral-evolutions/network/{0055-netdev-tstats-assign.cocci => 0055-netdev-tstats.cocci} (61%)
>  delete mode 100644 patches/collateral-evolutions/network/0056-netdev-tstats.cocci
> 
Thank you for the patch, it was applied and pushed.

Hauke

