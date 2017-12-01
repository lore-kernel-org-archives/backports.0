Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pl0-f52.google.com ([209.85.160.52]:34349 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdLAXs6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 18:48:58 -0500
Received: by mail-pl0-f52.google.com with SMTP id d21so7116760pll.1
        for <backports@vger.kernel.org>; Fri, 01 Dec 2017 15:48:58 -0800 (PST)
Subject: Re: Parse error with genl-const.cocci
From: Remington Furman <remicles2@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: cocci <cocci@systeme.lip6.fr>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 <1512151378.25588.20.camel@sipsolutions.net>
 <9df770ed-da27-95c6-6f8a-bafbfcbc90e9@gmail.com>
Message-ID: <0a0862ea-f5ac-f172-064d-6d8531d4db2d@gmail.com> (sfid-20171202_004900_525571_C342096A)
Date: Fri, 1 Dec 2017 15:48:54 -0800
MIME-Version: 1.0
In-Reply-To: <9df770ed-da27-95c6-6f8a-bafbfcbc90e9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/01/2017 10:09 AM, Remington Furman wrote:
> On 12/01/2017 10:02 AM, Johannes Berg wrote:
>> On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
>>> Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
>>> fine.  But, later on my CPU was held at 100% for 29 minutes:
>> Yeah, known issue. Give it more time - that particular patch is
>> *really* slow. Yes, more than 29 minutes, on my system as well.
>>
>> What I can recommend is that you remove things from copy-list that you
>> don't care about, e.g. bluetooth drivers if you don't need them,
>> certain wifi drivers you don't need, etc. (before running gentree.py)
>>
>> johannes
>
> Ok, that's great to know.  I will restart it.  I didn't know
> about the copy list yet, that will be helpful.
>
> Thank you again for your help.
>
> -Remington
Following up, running gentree.py again (without modifying the
copy list) worked fine.

-Remington
--
To unsubscribe from this list: send the line "unsubscribe backports" in
