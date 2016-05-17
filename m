Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34897 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcEQJGI (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 17 May 2016 05:06:08 -0400
Received: by mail-pa0-f49.google.com with SMTP id gj5so4671465pac.2
        for <backports@vger.kernel.org>; Tue, 17 May 2016 02:06:08 -0700 (PDT)
Subject: Re: wireless_nlevent_flush backported to stable kernels
To: Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <egrumbach@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
References: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com>
 <5738467E.4020005@broadcom.com> <1463426768.2179.3.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <573ADEF3.8030408@broadcom.com> (sfid-20160517_110610_633935_36037EAE)
Date: Tue, 17 May 2016 11:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <1463426768.2179.3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 16-5-2016 21:26, Johannes Berg wrote:
> On Sun, 2016-05-15 at 11:50 +0200, Arend Van Spriel wrote:
>>  
>>> On my system, I fixed it with the patch below, but it is surely not
>>> good enough.
>> In general this is avoided by preceeding the stub function with:
>>
>> #define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
>>
>> This way you will use the stub and not the in-kernel function.
> 
> That's normally fine, but not a good idea here because this really is a
> *stub*, and thus using the stub instead of the real function removes
> the ability to actually get the bugfix. So in this case, where it's a
> stub and not a full backport, it's better to try to get the original
> function in as many situations as possible.
> 
>> There has
>> been discussions about adding a mechanism to avoid backport if kernel
>> has the function available. No actual work in that area has been done
>> yet.
> 
> Oh, I've done that - but it was so terribly slow that it was
> essentially unusable...

I remember and so the suggestion was to maintain a list of functions to
check. Or did you pursue that as well with same result?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
