Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:56698 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750888AbcFJTVV (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 Jun 2016 15:21:21 -0400
Message-ID: <1465586467.29614.15.camel@coelho.fi> (sfid-20160610_212123_536980_9597A9B6)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 10 Jun 2016 22:21:07 +0300
In-Reply-To: <CAF7Mx6qcFsG+AYOxoxKpBS+jU19rbBwpRHeUkg_43vnabLyb=w@mail.gmail.com>
References: <1465576858-1524-1-git-send-email-luca@coelho.fi>
	 <CAF7Mx6qcFsG+AYOxoxKpBS+jU19rbBwpRHeUkg_43vnabLyb=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: define nla_put_u64_64bit() for < 4.7 kernels
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2016-06-10 at 20:30 +0200, Arend Van Spriel wrote:
> Op 10 jun. 2016 18:59 schreef "Luca Coelho" <luca@coelho.fi>:
> >
> > From: Luca Coelho <luciano.coelho@intel.com>
> >
> > The nla_put_u64_64_bit() function was introduced in v4.7.  Define
> it
> > in netlink.h if the kernel is < 4.7.
> I already submitted a patch including this a couple of weeks ago
> titled: "backports: netlink: add 64-bit aligned helper functions" and
> Johannes also did something similar.

Argh! Sorry for the noise then.  I had written this patch back in May
23, but forgot about it and bumped into it today, so I decided to send
it out. ;)

I got unsubscribed from the backports list, apparently.  I think this
is because of the same issue my server had a while back... And I was
wondering why the list was so silent... heheh!

Time to subscribe again. :)

--
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
