Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51592 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdJMJgc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:36:32 -0400
Received: by mail-wm0-f50.google.com with SMTP id f4so20144474wme.0
        for <backports@vger.kernel.org>; Fri, 13 Oct 2017 02:36:31 -0700 (PDT)
Subject: Re: [PATCH 5/5] backports: add signature verification code
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20171012210025.7490-1-johannes@sipsolutions.net>
 <20171012210025.7490-5-johannes@sipsolutions.net>
 <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com>
 <1507885767.2551.37.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2f943e21-1a4f-0863-dc7b-93640f9c4149@broadcom.com> (sfid-20171013_113634_361720_22202E0F)
Date: Fri, 13 Oct 2017 11:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <1507885767.2551.37.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13-10-17 11:09, Johannes Berg wrote:
> Hi,
> 
> Please trim quotes, your email was 469K :)
> (and evolution gets slow replying to that :P)

Oops. My bad. It is indeed a sizable patch.

> On Fri, 2017-10-13 at 11:02 +0200, Arend van Spriel wrote:
>> On 12-10-17 23:00, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> Uh, this was awful. Because the crypto/ things are completely
>>> impossible to backport, I've actually implemented this by using
>>> mbedtls and embedding the relevant functions it has...
>>
>> Interesting approach. I guess the crypto/ things would simply pull
>> in  too much new kernel stuff in the compat layer. So how much does
>> mbedtls add to compat.ko?
> 
> Good question, let's try to compile:
> 
> add/remove: 246/0 grow/shrink: 1/0 up/down: 49050/0 (49050)

Not sure what tool output this is so I assume it means 49k increase? 
That looks good I would say.

Gr. AvS
--
To unsubscribe from this list: send the line "unsubscribe backports" in
