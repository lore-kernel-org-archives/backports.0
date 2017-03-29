Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33470 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdC2Idw (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 29 Mar 2017 04:33:52 -0400
Received: by mail-it0-f67.google.com with SMTP id w11so958796itb.0
        for <backports@vger.kernel.org>; Wed, 29 Mar 2017 01:33:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490775563.7948.4.camel@sipsolutions.net>
References: <CAFED-jmLaRiM5b7XotQDrhtphSMtLDO565xCjobTnwhtipuuUQ@mail.gmail.com>
 <1490775563.7948.4.camel@sipsolutions.net>
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Wed, 29 Mar 2017 16:33:30 +0800
Message-ID: <CAN+BLYHsge-FXDR25_58HGUYVaPjj9QnWjQUiXJ8aA-MdGp=_A@mail.gmail.com> (sfid-20170329_103434_149590_72FBA875)
Subject: Re: ib-rhashtable.c:90:17: error
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I had encountered same problem. And i solved by some procedures below:

Step 1: linux-next check out to latest version, backports also
checkout to master and apply ccm patch.
Step 2: generate tree by ./gentree.py --verbose --clean ~/linux-next/
~/backports-output
Step 3: modify DECLARE_EWMA(signal, 10, 8) to DECLARE_EWMA(signal,
2014, 8) in ../mac80211/sta_info.h of backports-output
Step 4: modify "skb=3Didr_remove(...);" to "skb=3Didr_find(...); if (skb)
idr_remove(...);"  in ../mac80211/status.h of backports-output
Step 5: Target linux kernel (the lower version or your specific
version ) need to be compiled first.
Step 6: export KLIB_BUILD=3D"path/to/your_lower_linux_kernel"
Step 7: export KLIB=3D"path/to/your/build/object" (I am about to get
*.ko, thus i point the directory to backports-output)
Step 8: make defconfig-your_choice (I am using defconfig-ath10k)
Step 9: make the backports-output and wait to compile.

My compile environment is Ubuntu16.04 with kernel 4.4 and I am porting
ath10k in linux kernel 4.11 back to linux 4.2.
I hope this information will help you.

On Wed, Mar 29, 2017 at 4:19 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>>     tbl->locks =3D kvmalloc(size * sizeof(spinlock_t), gfp);
>
> Looks like we need to backport kvmalloc(), and perhaps something around
> the free as well.
>
>> Is there any fix for that?
>
> No, not yet, but shouldn't be hard.
>
> johannes
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in



--=20
=E5=90=B3=E9=87=8D=E6=AF=85 Wu Chung-yi
--
To unsubscribe from this list: send the line "unsubscribe backports" in
