Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:41145 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3E3UYf (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 May 2013 16:24:35 -0400
Received: by mail-ve0-f174.google.com with SMTP id oz10so543664veb.19
        for <backports@vger.kernel.org>; Thu, 30 May 2013 13:24:34 -0700 (PDT)
Message-ID: <51A7B57F.3020000@lwfinger.net> (sfid-20130530_222437_499134_C6FB55A4)
Date: Thu, 30 May 2013 15:24:31 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: Question about configuration for alx
References: <51A797A6.5070804@lwfinger.net>  (sfid-20130530_201722_981325_81CBAC11) <1369940334.8421.4.camel@jlt4.sipsolutions.net>
In-Reply-To: <1369940334.8421.4.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/30/2013 01:58 PM, Johannes Berg wrote:
> On Thu, 2013-05-30 at 13:17 -0500, Larry Finger wrote:
>> I am trying to help an openSUSE user that needs driver alx for his wired device.
>> I see that backports has the code, but it cannot be configured due to the
>> following statements in drivers/net/wireless/atheros/Kconfig:
>
> I think you mean s/wireless/ethernet/, right?

Yes. Sorry for the typo.


>> config ALX
>>           depends on !BACKPORT_KERNEL_2_6_28
>>           depends on n
>>           tristate "Qualcomm Atheros L1F Gigabit Ethernet support"
>>           depends on m
>>
>> The "depends on n" is the culprit. Is this deliberate because the driver code is
>> not ready, or is this a bug?
>
> This is an interesting side-effect of how the system works.
>
> The ALX Kconfig is added by a patch
> (patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch) but
> the *code* itself needs to be copied from an external tree when building
> a backport tarball. To do this, the --extra-driver option in gentree.py
> exists.
>
> Are you using one of Luis's releases, or building an own backport
> tarball?

This was for the tarball named backports-3.10-rc1-1.tar.bz2.

> If the former, Luis should probably include ALX since it's his driver.
>
> For the latter, see also the copy-list.alx file in the backports tree.

Thanks for the info,

Larry


