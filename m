Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:43012 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751926AbdJaL6p (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 31 Oct 2017 07:58:45 -0400
Message-ID: <1509451120.4492.216.camel@coelho.fi> (sfid-20171031_125851_316276_5FDEBC25)
From: Luca Coelho <luca@coelho.fi>
To: Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?=E5=90=B3=E9=87=8D=E6=AF=85?= <uranus0206@gmail.com>
Cc: backports@vger.kernel.org
Date: Tue, 31 Oct 2017 13:58:40 +0200
In-Reply-To: <1509393839.2637.3.camel@sipsolutions.net>
References: <CAN+BLYGmKpHm+iJOMynv6Qhvyh=ECaJnAM96QiU=LptiisW0xw@mail.gmail.com>
         <1508843560.2639.28.camel@sipsolutions.net>
         <1508854185.2639.32.camel@sipsolutions.net>
         <CAN+BLYEfk4_ntabp+Yxdmu8eV_f7knefRwPmbH1b=VV0POoGaQ@mail.gmail.com>
         (sfid-20171026_055256_037938_4070B188) <1509002960.2421.50.camel@sipsolutions.net>
         (sfid-20171026_092934_213999_8CEEC02D) <1509005208.2421.51.camel@sipsolutions.net>
         (sfid-20171026_100654_665631_5F5B08F1) <1509393839.2637.3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Compiling error of backport-4.12.c
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-10-30 at 21:03 +0100, Johannes Berg wrote:
> On Thu, 2017-10-26 at 10:06 +0200, Johannes Berg wrote:
> > On Thu, 2017-10-26 at 09:29 +0200, Johannes Berg wrote:
> > > On Thu, 2017-10-26 at 11:52 +0800, 吳重毅 wrote:
> > > > Thankd for fixing, i am able compile now.
> > > 
> > > Ok, great.
> > > 
> > > > But when i load the modules and firmware.bin, it crash.
> > > 
> > > Crap, sorry about that. I'll see what I can do about it right
> > > now.
> > 
> > Ok, I see the bug. Not sure yet how to fix, but yeah.
> 
> I thought I said I'd fixed it, but don't see that email.
> 
> Anyway, I did, but Luca found another bug ... where it compiles, this
> fixes it, I think:
> 
> --- a/compat/backport-4.12.c
> +++ b/compat/backport-4.12.c
> @@ -225,6 +225,7 @@ int bp_extack_genl_register_family(struct
> genl_family *family)
>  
>  	/* copy this since the family might access it directly */
>  	family->attrbuf = copy->family.attrbuf;
> +	family->mcgrp_offset = copy->family.mcgrp_offset;
>  
>  	mutex_lock(&copies_mutex);
>  	list_add_tail(&copy->list, &copies_list);
> 
> But on older kernels this doesn't compile, and needs more work.

FWIW, this fixes the problem I was having with nl80211 commands that
were never completing.  I tried it in kernel v4.7.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
