Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46341 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbKAX4k (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 18:56:40 -0500
Message-ID: <5636A6B6.3010200@hauke-m.de> (sfid-20151102_005641_727479_95DE5D4A)
Date: Mon, 02 Nov 2015 00:56:38 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Felix Fietkau <nbd@openwrt.org>, backports@vger.kernel.org
Subject: Re: [PATCH] backports: fix version check for page_is_pfmemalloc
References: <1446127778-47105-1-git-send-email-nbd@openwrt.org>
In-Reply-To: <1446127778-47105-1-git-send-email-nbd@openwrt.org>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/29/2015 03:09 PM, Felix Fietkau wrote:
> The upstream commit that added it was backported in 4.1.9
> 
> Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> ---
>  backport/backport-include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Thank you for the patch I applied it.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
