Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33769 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbdIGJR4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 7 Sep 2017 05:17:56 -0400
Received: by mail-wr0-f180.google.com with SMTP id a43so18154382wrc.0
        for <backports@vger.kernel.org>; Thu, 07 Sep 2017 02:17:55 -0700 (PDT)
Subject: Re: compilation errors in ath10k driver with latest backports git
To: KAVITA MATHUR <kavitam@cdot.in>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-17-hauke@hauke-m.de>
 <1504710312.23905.13.camel@sipsolutions.net>
 <cd9ddade-391a-686a-c023-c7a10a575cdc@broadcom.com>
 <20170907090319.M77568@cdot.in>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <1598f002-8650-6c98-6095-877a771428b6@broadcom.com> (sfid-20170907_111757_609495_2551B1FC)
Date: Thu, 7 Sep 2017 11:17:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170907090319.M77568@cdot.in>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07-09-17 11:04, KAVITA MATHUR wrote:
> Hi,
> 
> I am using backports git and ath10k git to download latest changes in ath0k driver.
> There are build errors in ath10k drivers due to definitions not backported from kernel
> 4.12. Backpors-git is backported kernel till 4.8. Please suggest how to fix these issues.
> 
> Following is the build error log:
> 
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.13.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.15.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.18.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.19.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.1.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.2.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.4.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.5.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.7.o
> LD [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/compat.o
> CC [M]
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/main.o
> CC [M]
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/regd.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/hw.o
> CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/key.o
> CC [M]
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/dfs_pattern_detector.o
> CC [M]
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/dfs_pri_detector.o
> LD [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath.o
> CC [M]
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.o
> In file included from
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.h:22,
>                 from
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:18:
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/core.h:465:
> error: expected specifier-qualifier-list before 'guid_t'
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:
> In function 'ath10k_tx_h_add_p2p_noa_ie':
> /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:3492:
> error: implicit declaration of function 'skb_put_data'
> make[8]: ***
> [/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.o]
> Error 1
> make[7]: ***
> [/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k]
> Error 2
> make[6]: ***
> [/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath] Error 2
> make[5]: *** [/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless]
> Error 2
> make[4]: *** [_module_/home/shw/kavita/backports/backports-output_14Aug17] Error 2
> make[3]: *** [modules] Error 2
> make[2]: *** [modules] Error 2
> make[1]: *** [modules] Error 2
> make: *** [default] Error 2

Hi Kavita,

You could try the patch submitted by Hauke titled "[PATCH 03/21] header: 
skbuff: add skb_put_zero(), skb_put_data() and skb_put_u8()", but you 
will likely stumble on more. His entire patch series should do the 
trick. It is still under review.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
