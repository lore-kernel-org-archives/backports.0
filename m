Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53140 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab3HPKiq (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 06:38:46 -0400
Message-ID: <520E012F.6020108@hauke-m.de> (sfid-20130816_123849_237344_6EAED078)
Date: Fri, 16 Aug 2013 12:38:39 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with kernels
 < 3.2
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org> <1376571357-16506-2-git-send-email-pizza@shaftnet.org> <20130816030715.GB9574@garbanzo.do-not-panic.com>
In-Reply-To: <20130816030715.GB9574@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/16/2013 05:07 AM, Luis R. Rodriguez wrote:
> On Thu, Aug 15, 2013 at 08:55:57AM -0400, Solomon Peachy wrote:
>> Without this patch, the hardware *will* hang on <3.2 kernels when a
>> 512-byte SDIO transfer occurs.
>>
>> 3.2-rc added an SDIO quirk to work around this, so this code was
>> stripped from the driver when committed to the mainline.
>>
>> Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
> 
> Thanks, applied both and pushed!
> 
>   Luis

Hi Solomon,

I just compile tested cw1200 against many kernel versions and I always
get an error of a missing symbol for kernel <= 3.9:

WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/2.6.39/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.0.89/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.1.10/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.2.50/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.3.8/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.4.56/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.5.7/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.6.11/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.7.10/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.8.13/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!
WARNING: "get_random_int"
[/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.9.11/drivers/net/wireless/cw1200/cw1200_core.ko]
undefined!

I deactivate compiling against older kernels than 3.6.39 because that
caused some other problems like starting with 3.6.37 and missing
hw_features in 2.6.38:

    drivers/net/wireless/cw1200/bh.c: In function ‘cw1200_register_bh’:
    drivers/net/wireless/cw1200/bh.c:62:72: error: ‘WQ_CPU_INTENSIVE’
undeclared (first use in this function)
    drivers/net/wireless/cw1200/bh.c:62:72: note: each undeclared
identifier is reported only once for each function it appears in
    make[7]: *** [/drivers/net/wireless/cw1200/bh.o] Error 1

Hauke
