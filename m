Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37112 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdGMJVo (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Jul 2017 05:21:44 -0400
Received: by mail-wm0-f52.google.com with SMTP id i127so19108424wma.0
        for <backports@vger.kernel.org>; Thu, 13 Jul 2017 02:21:43 -0700 (PDT)
Message-ID: <59673BA0.20703@broadcom.com> (sfid-20170713_112146_359675_5B289153)
Date: Thu, 13 Jul 2017 11:21:36 +0200
From: Arend van Spriel <arend.vanspriel@broadcom.com>
MIME-Version: 1.0
To: AceLan Kao <acelan.kao@canonical.com>
CC: Johannes Berg <johannes.berg@intel.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: Adding the BT driver
References: <CAFv23QnvFGj3b2GCV=v=mGk8JgGwZRe+W-+m9gxbtAsChySz=Q@mail.gmail.com>
In-Reply-To: <CAFv23QnvFGj3b2GCV=v=mGk8JgGwZRe+W-+m9gxbtAsChySz=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 7/13/2017 5:07 AM, AceLan Kao wrote:
> Hi all,
>
> I'm working on adding BT driver back to linux backport driver, and got
> some questions.

I suppose it means you also want to maintain BT support in backports 
project?

> 1. Do we still do building the backport driver against all the
> supported kernels? I didn't see those reports in git log recently, so
> I'm wondering while backporting BT driver, can I skip some old
> kernels' support.

Well. You could limit the earliest kernel by adding a dependency in the 
dependencies file.

> 2. Is there a script that can help me to build the backport driver
> against certain kernels?

Not really. You just run make from the backports package and provide 
KLIB_BUILD=... on the command line referring to the target kernel headers.

> 3. Is there anything I should take care of while doing the BT backport?

I forgot the reason for dropping BT. Don't think it was anything 
technical. I guess there was nobody willing to put effort in it.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
