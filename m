Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48918 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755700AbeFYUdz (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 25 Jun 2018 16:33:55 -0400
Message-ID: <1529958832.10347.5.camel@sipsolutions.net> (sfid-20180625_223422_995705_473ED4D7)
Subject: Re: [Cocci] Parse error with genl-const.cocci
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>,
        Remington Furman <remicles2@gmail.com>
Cc: backports@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Date: Mon, 25 Jun 2018 22:33:52 +0200
In-Reply-To: <alpine.DEB.2.20.1712141614460.5502@hadrien>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
         <1512116859.25588.4.camel@sipsolutions.net>
         <alpine.DEB.2.20.1712011015160.2865@hadrien>
         <1512120542.25588.7.camel@sipsolutions.net>
         <alpine.DEB.2.20.1712011059360.2865@hadrien>
         <e589e785-6e08-8b37-8017-09ffc8627de2@gmail.com>
         <alpine.DEB.2.20.1712141614460.5502@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Julia,

> I updated the github version of Coccinelle such that
> patches/0027-genl-const/genl-const.cocci
> will almost parse correctly.  The only thing that remains is to change
> attribute into attribute name.

I'm not sure why, but for some reason I thought back then (https://git.k
ernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=98
272f479c2126a135dfcb12484e93d5888164ab) that the following would work
with 1.0.6:

@@
attribute name __genl_const;
@@
(
-const struct genl_multicast_group
+__genl_const struct genl_multicast_group
|
-const struct genl_ops
+__genl_const struct genl_ops
)



However, Hauke pointed out it doesn't, and I can confirm. On 1.0.6, I
can't get this to work at all, it refuses to parse "attribute name" and
it refuses to parse the patch part with just "attribute".

Is there any way to get this to work again?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
