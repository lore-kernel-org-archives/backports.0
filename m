Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BEC433EF
	for <backports@archiver.kernel.org>; Sun,  3 Apr 2022 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356897AbiDCXV6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 3 Apr 2022 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354780AbiDCXV6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 3 Apr 2022 19:21:58 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7219326DA
        for <backports@vger.kernel.org>; Sun,  3 Apr 2022 16:19:59 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4KWqcs5D49z9sRt;
        Mon,  4 Apr 2022 01:19:57 +0200 (CEST)
Message-ID: <5a212284-063d-0b94-0186-cec415647e08@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649027995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7YjwDUV1QIsJ4QzNF0RdlripzIykR8uY42Drt5Fgss=;
        b=i3wIJoHmPJIz22TP0NzZoPnltcoohOPwA6eydFhlDb5VV/ZA2FudMYdJbaLlEJZUUbU/Hw
        BFJIYZGnY0ToxR+EctDcdmfH3X8LtMsAz/paVdHJH9qif76vG7AGaZpl/EpTu+Pk1UfN8E
        ln1w9IZRcEUIgBu9I5xLazotcTTB7m1xDAZp8f+RQDJjuDSED4lF1onpH0Mq0Wk6aObQL4
        YaL7Mk2bHCibJILRUbQjpUyy+Bz3d+U7xaMd3bYGxiKWUVvPXHl6SWw8ciz03WcujiR++T
        QwdfpOTzPk0SL5ci6bdLjw/6AlmteFHqN55gfB366XL87JKLeibgzsmuIFZTOw==
Date:   Mon, 4 Apr 2022 01:19:53 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
 <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
 <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
 <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
 <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
 <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
 <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
 <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
 <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
 <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
 <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
 <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
 <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
 <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
 <7c1fd2554ae907eded15dd247bbda5bc5c28cbe7.camel@sipsolutions.net>
 <64e20adf-b959-414f-8104-728ea8d23f76@www.fastmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Dealing with SUBLEVEL overflow in backports
In-Reply-To: <64e20adf-b959-414f-8104-728ea8d23f76@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/10/22 15:05, Jiaxun Yang wrote:
> 
> 
> 在2022年2月10日二月 上午8:17，Johannes Berg写道：
>> On Thu, 2022-02-10 at 00:44 +0100, Hauke Mehrtens wrote:
>>>
>>> What build problem do you get when you include "#include <linux/bug.h>"
>>> here on kernel 4.9.299?
>>>
>>
>> I haven't tried, but per the explanation, you get issues if you tried to
>> include bug.h in the first place, since then you get
>>
>> bug.h
>> -> includes build_bug.h (since the patch)
>> -> uses build_bug.h from backports
>> -> includes bug.h (does nothing, double include)
>>
> 
> Yep that's the problem.
> 
> What I'm trying is something like:
> Though it won't work in kernel intergration mode. My makefile foo does not
> allow me to come up a idea.
> 
> diff --git a/backport/Makefile.real b/backport/Makefile.real
> index 65508028..26482e52 100644
> --- a/backport/Makefile.real
> +++ b/backport/Makefile.real
> @@ -83,8 +83,19 @@ backport-include/backport/autoconf.h: .config Kconfig.versions Kconfig.kernel
>          ) > backport-include/backport/autoconf.h
>          @echo " done."
>   
> +.PHONY: backport-include/backport/version.h
> +backport-include/backport/version.h:
> +       @echo -n "Building backport-include/backport/version.h ..."
> +       @echo "#ifndef COMPAT_VERSION_INCLUDED" > $@
> +       @echo "#define COMPAT_VERSION_INCLUDED" >> $@
> +       @echo '#define COMPAT_LINUX_VERSION $(VERSION)' >> $@
> +       @echo '#define COMPAT_LINUX_PATCHLEVEL $(PATCHLEVEL)' >> $@
> +       @echo '#define COMPAT_LINUX_SUBLEVEL $(SUBLEVEL)' >> $@
> +       @echo "#endif" >> $@
> +       @echo " done."
> +
>   .PHONY: modules
> -modules: backport-include/backport/autoconf.h
> +modules: backport-include/backport/autoconf.h backport-include/backport/version.h
>          @$(MAKE) -f Makefile.build modules

This does not work for me.
We have to do this inside the kernel make call, when the kernel build 
system calls backports again, we should have the needed information in 
that call only.

The build works like this:
1. The normal make call to backports, KERNELRELEASE is not set and
    Makefile forwards the call to Makefile.real.
2. This calls "Makefile.build modules" in the next step.
3. This calls the kernel build system with
    "@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR) modules"
4. This calls again Makefile, but now with KERNELRELEASE set.
5. This calls Makefile.kernel and uses the kernel build system to build
    the backports code.

I tried adding a new rule to Makefile.kernel and then call it in 
Makefile.build using the kernel build system, but it looks like it only 
supports make targets supported by the kernel build system.

How do we make the kernel build system call our make target first?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
