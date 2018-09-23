Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50696 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCH6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:07:58 -0400
Message-ID: <1537733344.1707.7.camel@sipsolutions.net> (sfid-20180923_220921_997288_0CE63A7D)
Subject: Re: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sun, 23 Sep 2018 22:09:04 +0200
In-Reply-To: <1537733001.1707.5.camel@sipsolutions.net> (sfid-20180923_220334_818247_9A235E8D)
References: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
         (sfid-20180923_161658_834557_1648CD51) <1537733001.1707.5.camel@sipsolutions.net>
         (sfid-20180923_220334_818247_9A235E8D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 22:03 +0200, Johannes Berg wrote:
> On Sun, 2018-09-23 at 16:16 +0200, Hauke Mehrtens wrote:
> > Hi,
> > 
> > I tried to compile backports against kernel 4.18 and 4.19-rc4 (header
> > files from Ubuntu) and ran into this problem when it wants to link the
> > kernel:
> > 
> >   LD [M]
> > /home/hauke/compat-wireless/backports-4.19-rc4-1/drivers/net/wireless/realtek/rtlwifi/rtl_usb.o
> >   Building modules, stage 2.
> > scripts/Makefile.lib:10: *** Recursive variable 'KBUILD_CFLAGS'
> > references itself (eventually).  Stop.
> 
> Hmm. I vaguely remember something like that with our driver, but can't
> find it now? I also remember trying to fix it in the upstream kernel ...

Hmm. Well, I can't find any changes from me upstream in this area, so
either I didn't succeed or it didn't get applied. I also can't find a
public record of a patch, so I guess I didn't succeed?

Seems simple enough though, just make cc-option := instead of = in
scripts/Kbuild.include? Or maybe not, dunno.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
