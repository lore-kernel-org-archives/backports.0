Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49795 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbaJaTJx (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Oct 2014 15:09:53 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so6593059lbi.31
        for <backports@vger.kernel.org>; Fri, 31 Oct 2014 12:09:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54523E51.5070205@kpanic.de>
References: <CAB=NE6XpVW1J1E-0mZQvsHgAnCzAsw+yJHpYyvtXMsc_9-2hUA@mail.gmail.com>
 <54523E51.5070205@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 31 Oct 2014 12:09:31 -0700
Message-ID: <CAB=NE6XZFd9Tn49ZMt2k64DAcubQmgkk_NTLwZZhfPOzecUaAg@mail.gmail.com> (sfid-20141031_200957_424698_3A9BA438)
Subject: Re: Integration issues found and status
To: Stefan Assmann <sassmann@kpanic.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Oct 30, 2014 at 6:34 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> On 29.10.2014 22:07, Luis R. Rodriguez wrote:
>> OK a few obvious issues and their status:
>>
>> 1) dependencies file does not use BACKPORT_ prefix and as such they
>> are not mapped correctly, I'm about to address this
>> 2) some Kconfig files don't get the change:
>>
>> -source "foo"
>> +source "backports/foo"
>>
>> This is not allowing them to creep up on integration menuconfig, I'll
>> look into that next.
>>
>> 3) vmlinux build - something is missing on the last step on gentree.py
>> for integration, this can be observed when using gitdebug, I'm hoping
>> Stefan can help with this :D
>
> Applying the attached patch gets us one step further. We probably
> need to make these modifications in place instead of pushing them to
> the end of the Makefile.
>
> ~/backports/linux-test-3.15> make -j16
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
> make[3]: `arch/x86/realmode/rm/realmode.bin' is up to date.
>   LINK    vmlinux
>   LD      vmlinux.o
> backports/built-in.o:(___ksymtab_gpl+devm_kstrdup+0x0): multiple definition of `__ksymtab_devm_kstrdup'
> drivers/built-in.o:(___ksymtab_gpl+devm_kstrdup+0x0): first defined here
> backports/built-in.o: In function `devm_kstrdup':
> (.text+0x10): multiple definition of `devm_kstrdup'
> drivers/built-in.o:(.text+0x14c3e0): first defined here
> make: *** [vmlinux] Error 1

Thanks, I've identified what causes this and fixed it, will roll your
patch into a series for integration. Shortly I'll test a non-modular
build but I think we got it, at least the build completes.

 Luis
