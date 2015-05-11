Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49138 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbbEKV51 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:57:27 -0400
Message-ID: <555125C5.8050306@hauke-m.de> (sfid-20150511_235728_769991_D49B0F92)
Date: Mon, 11 May 2015 23:57:25 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: arend@broadcom.com, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: handle netdev->tstats
References: <1430832125-3195-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1430832125-3195-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/05/2015 03:22 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This adds the necessary backporting to handle netdev->tstats which
> was introduced in 3.14 (and some helper macros in 3.15).
> 
> For some reason my spatch isn't reliably patching the occurrence
> in net/mac80211/tx.c, so for now I'm including a manual patch.
> 
> Change-Id: Ib22e307a9bd31f6c31372ef8cc2828ca6e14fce4
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/netdevice.h        | 30 ++++++++++++++++++++++
>  .../network/0055-netdev-tstats-assign.cocci        | 10 ++++++++
>  .../network/0055-netdev-tstats-tx.patch            | 11 ++++++++
>  .../network/0056-netdev-tstats.cocci               |  9 +++++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-assign.cocci
>  create mode 100644 patches/collateral-evolutions/network/0055-netdev-tstats-tx.patch
>  create mode 100644 patches/collateral-evolutions/network/0056-netdev-tstats.cocci
> 
Thank you for the patch, it was applied and pushed out.

Hauke
