Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:53108 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbeEHJI0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 May 2018 05:08:26 -0400
Message-ID: <1525770503.14830.2.camel@sipsolutions.net> (sfid-20180508_110828_362939_B596F5E7)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>
Cc: backports@vger.kernel.org
Date: Tue, 08 May 2018 11:08:23 +0200
In-Reply-To: <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com> (sfid-20180508_105343_655114_35417EBF)
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
         <1525770549.14830.1.camel@sipsolutions.net>
         <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
         (sfid-20180508_105343_655114_35417EBF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-05-08 at 17:53 +0900, Masashi Honma wrote:

> I am using linux-4.4.y branch of backports.
> Do you mean older branch (like linux-4.2.y or linux-3.19.y or something) 
> should be used ?

No, that should be OK then.

> > No, looks fine - perhaps your spatch version isn't right? What version
> > do you have,
> 
> I am using a spatch binary build with latest git source because the 
> package is not enough fresh to build the backports. The version is this.
> 
> commit f9d474787c57f1d3cc3a73217e0f5d14ed958631
> Author: julia <julia.lawall@lip6.fr>
> Date:   Mon Apr 30 08:10:06 2018 +0200
> 
>      make pragmas more flexible, improve positioning of eoln when pragma 
> at the end of a file
> 
> > and what does it say if you run
> > 
> > mkdir /tmp/xyz && spatch --sp-file .../genl-const.cocci --dir /tmp/xyz
> > 
> > or something like that?
> 
> This is the result.
> 
> ------------------
> $ mkdir /tmp/xyz && spatch --sp-file 
> ./patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci 
> --dir /tmp/xyz
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> meta: parse error:
>    File 
> "./patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci", 
> line 2, column 10, charpos = 13
>    around = '__genl_const',
>    whole content = attribute __genl_const;
> ------------------

Yeah, thought so. You actually need to change the syntax here a bit, I
don't remember but you can search the mailing list here for the details.
Look for "Parse error with genl-const.cocci".

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
