Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35404 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdCQK3S (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 17 Mar 2017 06:29:18 -0400
Received: by mail-qt0-f180.google.com with SMTP id x35so58724556qtc.2
        for <backports@vger.kernel.org>; Fri, 17 Mar 2017 03:29:17 -0700 (PDT)
Subject: Re: Errors using linux-4.4.y against kernel target v3.19
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
References: <CAAEAJfDinWQ+GdU7hJR3z79LMu8whduStXUHJqihXW0MmWBLYQ@mail.gmail.com>
 <4f3274fd-c310-f30b-7883-2bf67125c360@broadcom.com>
 <CAAEAJfCTnpLc1BeDrkavyy6OJLK_W8jo7Zm4tfA=NYTmH5x=3g@mail.gmail.com>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <be61848d-0e08-5d21-145a-4082347e46ef@broadcom.com> (sfid-20170317_112919_932422_3D38C1F8)
Date: Fri, 17 Mar 2017 11:29:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAAEAJfCTnpLc1BeDrkavyy6OJLK_W8jo7Zm4tfA=NYTmH5x=3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 16-3-2017 0:45, Ezequiel Garcia wrote:
> Hey Arend,
> 
> On 15 March 2017 at 16:40, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> [..]
>>
>> I honestly don't know the current state of backports integration
>> feature. My use-case is creating a tarball that can be built against any
>> target kernel.
>>
>> In your case can you try it with v4.4 kernel?
>>
> 
> Well, not surprisingly it works. Mostly because the errors I've mentioned
> (except the coccinelle one) are related exclusively to kernel integration.

Yeah, I meant retry kernel integration with the v4.4 kernel instead of
v4.4.53. However, I think we can safely assume kernel integration to be
broken. Not sure whether Johannes want to support it moving forward. I
think for now it has low priority.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
