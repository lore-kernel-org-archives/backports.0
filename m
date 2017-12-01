Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:38552 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdLASJW (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 13:09:22 -0500
Received: by mail-pf0-f181.google.com with SMTP id u25so4969934pfg.5
        for <backports@vger.kernel.org>; Fri, 01 Dec 2017 10:09:22 -0800 (PST)
Subject: Re: Parse error with genl-const.cocci
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: cocci <cocci@systeme.lip6.fr>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 <1512151378.25588.20.camel@sipsolutions.net>
From: Remington Furman <remicles2@gmail.com>
Message-ID: <9df770ed-da27-95c6-6f8a-bafbfcbc90e9@gmail.com> (sfid-20171201_190924_829668_8953A882)
Date: Fri, 1 Dec 2017 10:09:19 -0800
MIME-Version: 1.0
In-Reply-To: <1512151378.25588.20.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


On 12/01/2017 10:02 AM, Johannes Berg wrote:
> On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
>> Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
>> fine.  But, later on my CPU was held at 100% for 29 minutes:
> Yeah, known issue. Give it more time - that particular patch is
> *really* slow. Yes, more than 29 minutes, on my system as well.
>
> What I can recommend is that you remove things from copy-list that you
> don't care about, e.g. bluetooth drivers if you don't need them,
> certain wifi drivers you don't need, etc. (before running gentree.py)
>
> johannes

Ok, that's great to know.  I will restart it.  I didn't know
about the copy list yet, that will be helpful.

Thank you again for your help.

-Remington

--
To unsubscribe from this list: send the line "unsubscribe backports" in
