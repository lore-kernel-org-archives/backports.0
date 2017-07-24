Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37045 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdGXCkW (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Jul 2017 22:40:22 -0400
Received: by mail-wm0-f54.google.com with SMTP id c184so20419502wmd.0
        for <backports@vger.kernel.org>; Sun, 23 Jul 2017 19:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C01EE046-1B86-499B-9D64-2219AEC94552@coelho.fi>
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
 <1500643281.20057.0.camel@coelho.fi> <2ad34c26-a8d2-fd9c-4d3c-77a3c6ec0d46@broadcom.com>
 <C01EE046-1B86-499B-9D64-2219AEC94552@coelho.fi>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 24 Jul 2017 10:40:20 +0800
Message-ID: <CAFv23Qn9rNnEXUT9SX-hGbODt-tEqbz2M9rYZLp_AMMPpgezjA@mail.gmail.com> (sfid-20170724_044025_173104_16C885A0)
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
To: Luca Coelho <luca@coelho.fi>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, hauke@hauke-m.de,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Yes, I'm compiling the backport driver with bt enabled.
I'll keep all bt related commits until I resolved all the issue.

BTW, the new introduced functions are required by the lib/rhashtable.c

2017-07-22 19:29 GMT+08:00 Luca Coelho <luca@coelho.fi>:
>
>
> On July 22, 2017 10:52:13 AM GMT+03:00, Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
>>On 21-07-17 15:21, Luca Coelho wrote:
>>> On Fri, 2017-07-21 at 14:55 +0800, AceLan Kao wrote:
>>>> add some new kv[mz]alloc functions which introduced after v4.12
>>>> by this commit
>>>>
>>>> commit a7c3e901a46ff54c016d040847eda598a9e3e653
>>>> Author: Michal Hocko <mhocko@suse.com>
>>>> Date:   Mon May 8 15:57:09 2017 -0700
>>>>
>>>>     mm: introduce kv[mz]alloc helpers
>>>>
>>>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>>>> ---
>>>
>>> I don't see any backported code using any of these yet... Why do you
>>> need it?
>>
>>AceLan is trying to reinstate BT subsystem/drivers in backports so it
>>may be needed for that. If that is true I think this patch should go in
>>that "BT reinstatement" patch series.
>
>
> Yeah, but I even checked BT stuff and didn't find any occurrences...
>
> --
> Luca.
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
--
To unsubscribe from this list: send the line "unsubscribe backports" in
