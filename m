Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:54162 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdIRHQm (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 18 Sep 2017 03:16:42 -0400
Received: by mail-wr0-f178.google.com with SMTP id l22so5444401wrc.10
        for <backports@vger.kernel.org>; Mon, 18 Sep 2017 00:16:41 -0700 (PDT)
Subject: Re: [PATCH 16/21] patches: brcmfmac: fix netdev destructor
To: Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-17-hauke@hauke-m.de>
 <7fad164c-e46f-ad64-4586-5521c2fc770d@broadcom.com>
 <1505373667.31630.0.camel@sipsolutions.net>
 <77ecd9e5-3d0b-d86a-a6bf-15b200c6bd20@hauke-m.de>
Cc: backports@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <59BF72D7.7060702@broadcom.com> (sfid-20170918_091644_221475_2F0F3213)
Date: Mon, 18 Sep 2017 09:16:39 +0200
MIME-Version: 1.0
In-Reply-To: <77ecd9e5-3d0b-d86a-a6bf-15b200c6bd20@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 9/18/2017 12:00 AM, Hauke Mehrtens wrote:
> On 09/14/2017 09:21 AM, Johannes Berg wrote:
>> On Wed, 2017-09-13 at 21:36 +0200, Arend van Spriel wrote:
>>>
>>> Way overdue, but better late than never.
>>
>> No worries, I already applied the patch anyway ;-)
>>
>>> I think we prefer to use
>>> spatch, but I understand the destructor handling in brcmfmac is
>>> complicated.
>>
>> Agree - and making changes across header files is hard in spatch.
>
> I have no idea how to do this with spatch, I would appreciate if you
> could convert this to an spatch, I do not know how.

No problem. Well, maybe it is, but I will give it a try ;-)

>>> The story above does not tell it right. brcmf_add_if() is called
>>> first
>>> doing the alloc_netdev() setting needs_free_netdev to true and
>>> subsequently brcmf_net_attach() is called doing the
>>> register_netdevice(). When that is successful and only then I set
>>> the
>>> priv_destructor. The reason for this was to keep the error path
>>> simple,
>>> because when register_netdevice() fails it calls the priv_destructor
>>> although that is not documented in struct net_device:
>>>
>>>    *	@priv_destructor:	Called from unregister
>>
>> Ok, too late now I guess, since the patch is in. But at least we'll
>> have your explanation here :)
>>
>>> I think I will make an attempt to change brcmfmac so we can get rid
>>> of this patch file and rely on the spatch, but for now I am fine with
>>> it.
>>
>> Thanks for the review!
>
> I fixed this patch in a later commit again, there was a problem with
> recent kernel versions.

I saw that patch, but did not incorporate it in this response. Thanks 
for fixing it.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
