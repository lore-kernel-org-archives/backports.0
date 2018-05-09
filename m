Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:40178 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933749AbeEIHy5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 03:54:57 -0400
Message-ID: <1525852495.6910.2.camel@sipsolutions.net> (sfid-20180509_095459_933710_ED1116F9)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>
Cc: backports@vger.kernel.org
Date: Wed, 09 May 2018 09:54:55 +0200
In-Reply-To: <1525850665.6910.0.camel@sipsolutions.net> (sfid-20180509_092429_663815_F4317767)
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
         <1525770549.14830.1.camel@sipsolutions.net>
         <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
         <1525770503.14830.2.camel@sipsolutions.net>
         <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
         <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
         (sfid-20180509_092122_486020_BC3800A2) <1525850665.6910.0.camel@sipsolutions.net>
         (sfid-20180509_092429_663815_F4317767)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-05-09 at 09:24 +0200, Johannes Berg wrote:
> On Wed, 2018-05-09 at 16:21 +0900, Masashi Honma wrote:
> > On 2018/05/09 06:42, Masashi Honma wrote:> It looks regression of 
> > latest(1.0.6+) coccinelle.
> > > This works with coccinelle 1.0.4.
> > 
> > I asked about this to coccinelle.
> > 
> > https://github.com/coccinelle/coccinelle/issues/135
> > 
> > julia says this notation is deprecated from 1.0.6.
> > 
> > @@
> > attribute __genl_const;
> > @@
> > 
> > from 1.0.6, "name" field is required.
> > 
> > @@
> > attribute name __genl_const;
> > @@
> > 
> > The coccinelle made a backward incompatible change...
> 
> Yes, I'm aware.
> 
> Just don't know how to solve it :)

Actually, since 1.0.6 has hit the distros, I'll just solve it by
requiring 1.0.6 and changing the spatch.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
