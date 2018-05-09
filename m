Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32811 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964797AbeEIStJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 14:49:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so24536625wmc.0
        for <backports@vger.kernel.org>; Wed, 09 May 2018 11:49:09 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Steve deRosier <derosier@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
 <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net>
 <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
 <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
 <1525850665.6910.0.camel@sipsolutions.net>
 <1525852495.6910.2.camel@sipsolutions.net>
 <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com>
 <1525853548.6910.3.camel@sipsolutions.net>
 <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com>
 <1525856616.6910.7.camel@sipsolutions.net>
 <ba98f466-b6c0-4498-0597-57174b4f7fe5@gmail.com>
 <1525857931.6910.8.camel@sipsolutions.net>
 <CALLGbR+20QS3dpG0xMae+4gtw4osdaucT0OYj_6qj3TMKtp6ag@mail.gmail.com>
Cc: masashi.honma@gmail.com, backports@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AF342A2.1030801@broadcom.com> (sfid-20180509_204911_769118_97D4EC49)
Date: Wed, 9 May 2018 20:49:06 +0200
MIME-Version: 1.0
In-Reply-To: <CALLGbR+20QS3dpG0xMae+4gtw4osdaucT0OYj_6qj3TMKtp6ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 5/9/2018 4:19 PM, Steve deRosier wrote:
> On Wed, May 9, 2018 at 2:25 AM Johannes Berg <johannes@sipsolutions.net>
> wrote:
>
>> On Wed, 2018-05-09 at 18:24 +0900, Masashi Honma wrote:
>>> On 2018/05/09 18:03, Johannes Berg wrote:
>>>> We could also cherry-pick my trivial patch to the older branches I
>>>> guess. That'd still be simpler?
>>>
>>> Oh, you already have a plan.
>>> Then drop my plan.
>
>> Well, I wasn't really planning on doing it, but I could? :)
>
>> I guess it's easy enough though.
>
>
> That'd be my vote.
>
> I haven't looked at the docs in a long time - do we note a minimum required
> version of coccinelle?

Do we have docs :-p Anyway, the gentree script checks the spatch version 
and seems Johannes already took care of the script as well [1]

Gr. AvS

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=98272f479c2126a135dfcb12484e93d5888164ab

--
To unsubscribe from this list: send the line "unsubscribe backports" in
