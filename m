Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52732 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934121AbbIVVlL (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 22 Sep 2015 17:41:11 -0400
Subject: Re: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>,
	emmanuel.grumbach@intel.com
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5601CAF5.4040907@hauke-m.de> (sfid-20150922_234113_949576_5475F0CF)
Date: Tue, 22 Sep 2015 23:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/09/2015 11:27 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This flag doesn't exist on newer kernels, but replaced the tx_queue_len
> assignment, so can't just be backported to have no effect. Instead, add
> a semantic patch that puts back the tx_queue_len=0 assignment on older
> kernel versions.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  patches/collateral-evolutions/network/0062-iff-no-queue.cocci | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0062-iff-no-queue.cocci
> 

Thank you for the patch, it was applied and pushed out.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
