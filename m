Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33607 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdCOXqe (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 15 Mar 2017 19:46:34 -0400
Received: by mail-pf0-f178.google.com with SMTP id w189so15545437pfb.0
        for <backports@vger.kernel.org>; Wed, 15 Mar 2017 16:45:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f3274fd-c310-f30b-7883-2bf67125c360@broadcom.com>
References: <CAAEAJfDinWQ+GdU7hJR3z79LMu8whduStXUHJqihXW0MmWBLYQ@mail.gmail.com>
 <4f3274fd-c310-f30b-7883-2bf67125c360@broadcom.com>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Wed, 15 Mar 2017 20:45:06 -0300
Message-ID: <CAAEAJfCTnpLc1BeDrkavyy6OJLK_W8jo7Zm4tfA=NYTmH5x=3g@mail.gmail.com> (sfid-20170316_004807_754838_74CB4BCE)
Subject: Re: Errors using linux-4.4.y against kernel target v3.19
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hey Arend,

On 15 March 2017 at 16:40, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
[..]
>
> I honestly don't know the current state of backports integration
> feature. My use-case is creating a tarball that can be built against any
> target kernel.
>
> In your case can you try it with v4.4 kernel?
>

Well, not surprisingly it works. Mostly because the errors I've mentioned
(except the coccinelle one) are related exclusively to kernel integration.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe backports" in
