Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60142 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbcKYH6M (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 25 Nov 2016 02:58:12 -0500
Message-ID: <1480060687.4317.0.camel@sipsolutions.net> (sfid-20161125_085816_125313_35588E8E)
Subject: Re: unknown symbol CRYPTO_GCM
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?Franti=C5=A1ek_Hor=C3=ADnek?=
        <frantisekhorinek@gmail.com>, backports@vger.kernel.org
Date: Fri, 25 Nov 2016 08:58:07 +0100
In-Reply-To: <CAHU8GYNVMkbEH-Vp06DsKVV-x5nwfSMXL_fowOWMQoswTHfNyA@mail.gmail.com> (sfid-20161125_022459_769208_EDE7918F)
References: <CAHU8GYNVMkbEH-Vp06DsKVV-x5nwfSMXL_fowOWMQoswTHfNyA@mail.gmail.com>
         (sfid-20161125_022459_769208_EDE7918F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2016-11-25 at 02:24 +0100, František Horínek wrote:
> 
> there is also a warning before build:
> warning: (MAC80211 && MAC802154) selects BPAUTO_CRYPTO_CCM which has
> unmet direct dependencies (CRYPTO_AEAD && CRYPTO_CTR)

All of this stuff is broken.

> I am using backports-4.2.6-1 downloaded today (25. 11. 2016)
> 
> What should I do?

Enable CRYPTO_GCM in your base kernel.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
