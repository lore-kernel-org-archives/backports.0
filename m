Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50910 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeIXCT2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:19:28 -0400
Message-ID: <1537734032.1707.13.camel@sipsolutions.net> (sfid-20180923_222045_739767_417CE306)
Subject: Re: [PATCH 04/10] dependencies: Make RSI_COEX coexistence depend on
 kernel >= 4.17
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:20:32 +0200
In-Reply-To: <20180923174535.16198-5-hauke@hauke-m.de> (sfid-20180923_194549_145993_73713907)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-5-hauke@hauke-m.de>
         (sfid-20180923_194549_145993_73713907)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> When RSI_COEX is activated the driver wants to link against the
> rsi_bt_ops symbol from the bluetooth driver btrsi. This driver was only
> added in kernel 4.17. Deactivate bluetooth coexistence support for older
> kernel versions.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  dependencies | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/dependencies b/dependencies
> index 74f8a80f..555f31fb 100644
> --- a/dependencies
> +++ b/dependencies
> @@ -53,6 +53,9 @@ USB_NET_RNDIS_WLAN 4.6
>  # depends on struct mmc_card::ocr
>  RSI_SDIO 3.13
>  
> +# For Coexsitence the BT driver has to export rsi_bt_ops

Typo :)

But I guess I can fix it - I won't apply right now (need to sleep) but
hopefully tomorrow (though I'll probably have power cut some time during
the day, so who knows what'll happen)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
