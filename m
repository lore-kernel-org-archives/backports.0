Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:47365 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab3LIULz (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 15:11:55 -0500
Received: by mail-we0-f176.google.com with SMTP id w62so3942378wes.21
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 12:11:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386617105.5042.0.camel@jlt4.sipsolutions.net>
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
 <1386613665-11656-2-git-send-email-mcgrof@do-not-panic.com> <1386617105.5042.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 9 Dec 2013 21:11:33 +0100
Message-ID: <CAB=NE6VHM3bSXb_3eeEOJ4QLQd3MKkABE=Ky1BdJLZqhjdmFxg@mail.gmail.com> (sfid-20131209_211157_084172_4AC51D1E)
Subject: Re: [PATCH 1/3] backports: convert the 62-usb_driver_lpm patch series
 to SmPL
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Dec 9, 2013 at 8:25 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Mon, 2013-12-09 at 19:27 +0100, Luis R. Rodriguez wrote:
>
>> +++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
>> @@ -0,0 +1,9 @@
>> +@@
>> +identifier backport_driver;
>> +@@
>> +struct usb_driver backport_driver = {
>
> You don't need "..." here?

Not in this case, it works, adding it actually doesn't work right now as I wish.

>> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>> +     .disable_hub_initiated_lpm = 1,
>> ++#endif
>> +...
>> +};

  Luis
