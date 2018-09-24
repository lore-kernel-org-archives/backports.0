Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:57226 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeIXNTF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 09:19:05 -0400
Message-ID: <1537773492.1707.20.camel@sipsolutions.net> (sfid-20180924_091825_877152_5AD40070)
Subject: Re: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 24 Sep 2018 09:18:12 +0200
In-Reply-To: <1537735763.1707.18.camel@sipsolutions.net> (sfid-20180923_224935_958639_C79130DB)
References: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
         <1537733001.1707.5.camel@sipsolutions.net>
         <1537733344.1707.7.camel@sipsolutions.net>
         <1f853fa4-0915-c5a9-f168-1d618aa36804@hauke-m.de>
         <1537735763.1707.18.camel@sipsolutions.net>
         (sfid-20180923_224935_958639_C79130DB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 22:49 +0200, Johannes Berg wrote:
> On Sun, 2018-09-23 at 22:48 +0200, Hauke Mehrtens wrote:
> > 
> > > Seems simple enough though, just make cc-option := instead of = in
> > > scripts/Kbuild.include? Or maybe not, dunno.
> > 
> > This works for me, will you add a patch?
> 
> Sure, I can do that.

Done now.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
