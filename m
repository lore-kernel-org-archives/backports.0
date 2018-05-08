Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33392 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeEHIxm (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 May 2018 04:53:42 -0400
Received: by mail-pg0-f46.google.com with SMTP id i194-v6so20885034pgd.0
        for <backports@vger.kernel.org>; Tue, 08 May 2018 01:53:42 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Johannes Berg <johannes@sipsolutions.net>
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Masashi Honma <masashi.honma@gmail.com>
Message-ID: <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com> (sfid-20180508_105349_385066_FF1B4845)
Date: Tue, 8 May 2018 17:53:38 +0900
MIME-Version: 1.0
In-Reply-To: <1525770549.14830.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2018/05/08 18:09, Johannes Berg wrote:
> On Tue, 2018-05-08 at 12:05 +0900, Masashi Honma wrote:
>> I am trying to backport from Linux 4.4
> 
> This will probably not work unless you use an old backports git tree
> snapshot.

Thank you.

I am using linux-4.4.y branch of backports.
Do you mean older branch (like linux-4.2.y or linux-3.19.y or something) 
should be used ?

> No, looks fine - perhaps your spatch version isn't right? What version
> do you have,

I am using a spatch binary build with latest git source because the 
package is not enough fresh to build the backports. The version is this.

commit f9d474787c57f1d3cc3a73217e0f5d14ed958631
Author: julia <julia.lawall@lip6.fr>
Date:   Mon Apr 30 08:10:06 2018 +0200

     make pragmas more flexible, improve positioning of eoln when pragma 
at the end of a file

> and what does it say if you run
> 
> mkdir /tmp/xyz && spatch --sp-file .../genl-const.cocci --dir /tmp/xyz
> 
> or something like that?

This is the result.

------------------
$ mkdir /tmp/xyz && spatch --sp-file 
./patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci 
--dir /tmp/xyz
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
meta: parse error:
   File 
"./patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci", 
line 2, column 10, charpos = 13
   around = '__genl_const',
   whole content = attribute __genl_const;
------------------

Regards,
Masashi Honma.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
