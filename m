Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:56045 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbbE2IIZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 04:08:25 -0400
Message-ID: <55681E76.4070401@broadcom.com> (sfid-20150529_100828_564182_4F48AFCE)
Date: Fri, 29 May 2015 10:08:22 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>	 (sfid-20150529_045521_094351_3FF15D30) <1432882836.2104.1.camel@sipsolutions.net>
In-Reply-To: <1432882836.2104.1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/29/15 09:00, Johannes Berg wrote:
> -lkml, that list is overfull anyway ...
>
> On Thu, 2015-05-28 at 19:54 -0700, Luis R. Rodriguez wrote:
>> Me and Julia are working on a paper which evaluates use of Coccinelle
>> on backports, a preliminary draft of such paper can be found on github
>> [0]. We are making some tweaks to this, one of which is covering the
>> uses of Linux backports [1] in the industry, for this we'd like to try
>> to get feedback as to where and how folks are using backports. Please
>> let me and Julia know -- or if the information is not sensitive please
>> feel free to just reply to this thread and share with others. All
>> feedback is greatly appreciated.

We use the backports project solely for testing. We build and test 
nightly for a number of lab machines. Some are running recent 
wireless-testing kernel, but a number of those run a relatively old FC19 
kernel (3.11.1) for which we build backport brcm80211 drivers. We do 
that for our internal tree and for the wireless-testing tree.

>> If you are OK in having us list or
>> generalize your usage please indicate so.

Go ahead and make your list ;-)

Regards,
Arend

> We've just published one of our internal git trees that is actually
> based on backports:
> https://git.kernel.org/cgit/linux/kernel/git/iwlwifi/backport-iwlwifi.git/
>
> johannes
>
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

