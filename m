Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56652 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbdJSIug (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Oct 2017 04:50:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so14816784wmd.5
        for <backports@vger.kernel.org>; Thu, 19 Oct 2017 01:50:35 -0700 (PDT)
Subject: Re: [PATCH] backports: remove CRYPTO_CCM backport
To: Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
References: <20171013103157.26545-1-johannes@sipsolutions.net>
 <1508391450.5497.177.camel@coelho.fi>
 <1508395260.8801.0.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <de5e50b5-c48f-560b-3c2d-bcbef3fdb6af@broadcom.com> (sfid-20171019_105040_681647_79BFEE32)
Date: Thu, 19 Oct 2017 10:50:33 +0200
MIME-Version: 1.0
In-Reply-To: <1508395260.8801.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 19-10-17 08:41, Johannes Berg wrote:
> On Thu, 2017-10-19 at 08:37 +0300, Luca Coelho wrote:
>>
>> Should backports then depend on CRYPTO_CCM? It didn't really work in
>> the past and I got a few reports of broken backport with old kernels
>> due to missing CRYPTO_CCM in the kernel config.
> 
> this change will automatically make mac80211 depend on it, after re-
> generation.

And that means you can not select and thus build mac80211 in the 
backport config if the target kernel has CRYPTO_CCM disabled. The only 
option people really have is enabling CRYPTO_CCM in the target kernel.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
