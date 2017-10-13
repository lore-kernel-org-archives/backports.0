Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:45781 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJMKWc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 06:22:32 -0400
Received: by mail-wm0-f52.google.com with SMTP id q124so20194081wmb.0
        for <backports@vger.kernel.org>; Fri, 13 Oct 2017 03:22:31 -0700 (PDT)
Subject: Re: [PATCH 5/5] backports: add signature verification code
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20171012210025.7490-1-johannes@sipsolutions.net>
 <20171012210025.7490-5-johannes@sipsolutions.net>
 <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com>
 <1507885767.2551.37.camel@sipsolutions.net>
 <2f943e21-1a4f-0863-dc7b-93640f9c4149@broadcom.com>
 <1507887514.2551.40.camel@sipsolutions.net>
 <1507887597.2551.41.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <898fb3d5-44bf-e176-ff29-40c4b5918c1f@broadcom.com> (sfid-20171013_122234_269730_7EDB39C7)
Date: Fri, 13 Oct 2017 12:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <1507887597.2551.41.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 13-10-17 11:39, Johannes Berg wrote:
> On Fri, 2017-10-13 at 11:38 +0200, Johannes Berg wrote:
>> On Fri, 2017-10-13 at 11:36 +0200, Arend van Spriel wrote:
>>
>>>> add/remove: 246/0 grow/shrink: 1/0 up/down: 49050/0 (49050)
>>>
>>> Not sure what tool output this is so I assume it means 49k
>>> increase?
>>> That looks good I would say.
>>
>> This was from scripts/bloat-o-meter (kernel sources). And yeah,
>> that's a hair under 48KiB :)
> 
> FWIW, the code is far larger because I just copied it with almost no
> modification, there's a lot of stuff that's not even compiled here, and
> for the things that are compiled, a lot isn't needed and not linked in.

It is probably better to keep it like that and leave the mbedtls code 
unmodified as much as possible.

So this stuff is going to be needed for mac80211. Also for the 
regulatory db loading you sent out I guess.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
