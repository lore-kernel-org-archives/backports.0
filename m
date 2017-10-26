Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:38334 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdJZIGu (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 26 Oct 2017 04:06:50 -0400
Message-ID: <1509005208.2421.51.camel@sipsolutions.net> (sfid-20171026_100654_665631_5F5B08F1)
Subject: Re: Compiling error of backport-4.12.c
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=90=B3=E9=87=8D=E6=AF=85?= <uranus0206@gmail.com>
Cc: backports@vger.kernel.org
Date: Thu, 26 Oct 2017 10:06:48 +0200
In-Reply-To: <1509002960.2421.50.camel@sipsolutions.net> (sfid-20171026_092934_213999_8CEEC02D)
References: <CAN+BLYGmKpHm+iJOMynv6Qhvyh=ECaJnAM96QiU=LptiisW0xw@mail.gmail.com>
         <1508843560.2639.28.camel@sipsolutions.net>
         <1508854185.2639.32.camel@sipsolutions.net>
         <CAN+BLYEfk4_ntabp+Yxdmu8eV_f7knefRwPmbH1b=VV0POoGaQ@mail.gmail.com>
         (sfid-20171026_055256_037938_4070B188) <1509002960.2421.50.camel@sipsolutions.net>
         (sfid-20171026_092934_213999_8CEEC02D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-10-26 at 09:29 +0200, Johannes Berg wrote:
> On Thu, 2017-10-26 at 11:52 +0800, 吳重毅 wrote:
> > Thankd for fixing, i am able compile now.
> 
> Ok, great.
> 
> > But when i load the modules and firmware.bin, it crash.
> 
> Crap, sorry about that. I'll see what I can do about it right now.

Ok, I see the bug. Not sure yet how to fix, but yeah.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
