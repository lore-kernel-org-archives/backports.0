Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35825 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcKNT00 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 14 Nov 2016 14:26:26 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so117204489wmd.0
        for <backports@vger.kernel.org>; Mon, 14 Nov 2016 11:26:24 -0800 (PST)
Subject: Re: [PATCH 3/3] backports: empty define for __ro_after_init
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>
References: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
 <1478981923-12298-3-git-send-email-arend.vanspriel@broadcom.com>
 <1478984842.4226.1.camel@sipsolutions.net>
 <20161114185917.GZ13978@wotan.suse.de>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c36c06eb-41b9-cd72-0260-317410e77a63@broadcom.com> (sfid-20161114_202628_521372_B46FF4B8)
Date: Mon, 14 Nov 2016 20:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <20161114185917.GZ13978@wotan.suse.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 14-11-2016 19:59, Luis R. Rodriguez wrote:
> On Sat, Nov 12, 2016 at 10:07:22PM +0100, Johannes Berg wrote:
>> On Sat, 2016-11-12 at 20:18 +0000, Arend van Spriel wrote:
>>> nl80211 now uses section qualifier __ro_after_init. However, this
>>> is not available in kernels before v4.6. Neither is the section
>>> itself hence adding an empty define in backports.
>>
>>> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
>>> +#define __ro_after_init
>>> +#endif
>>
>> Due to how __ro_after_init works, it *has* to be a macro originally, so
>> you could just ifndef on itself:
>>
>> #ifndef __ro_after_init
>> #define __ro_after_init
>> #endif
>>
>> and be slightly more compatible in case somebody ever backports it.
> 
> Agreed.

Agree as well hence I posted a V2 yesterday ;-)

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
