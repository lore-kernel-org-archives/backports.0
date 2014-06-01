Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47587 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaFAIsf (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 1 Jun 2014 04:48:35 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so3031487wib.11
        for <backports@vger.kernel.org>; Sun, 01 Jun 2014 01:48:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5389BD34.4010006@hauke-m.de>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com> <5389BD34.4010006@hauke-m.de>
From: Samuel Martin <s.martin49@gmail.com>
Date: Sun, 1 Jun 2014 10:47:53 +0200
Message-ID: <CAHXCMMKJRmx88Qp=MP4Oir8rX2w8QNNAQsSg8mvdmXEWDErRWg@mail.gmail.com> (sfid-20140601_104838_673102_244DC391)
Subject: Re: [PATCH 0/10] Cross-compilation support improvement
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Hauke,

On Sat, May 31, 2014 at 1:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 05/08/2014 10:39 PM, Samuel Martin wrote:
[...]
>> Samuel Martin (10):
>>   backports: Makefile: introduce KROOT and fix INSTALL_MOD_PATH
>>     definition
>>   backports: Makefile: introduce KVERSION and rework KLIB definition
>>   backports: Makefile: export KROOT and KVERSION variables
>>   backports: blacklist.sh: support install root not in /
>>   backports: check_depmod.sh: support install root not in /
>>   backports: Makefile.real: use depmod.sh instead of the depmod program
>>   backports: Makefile.real: disable update-initramfs.sh execution when
>>     cross-compiling
>>   backports: Makefile.real: silent reboot message when cross-compiling
>>   backports: compress_module.sh: gzip silently overrides existing
>>     compressed modules
>>   backports: Makefile: update help text
>>
>>  backport/Makefile                    | 33 ++++++++++++++++++++++++---------
>>  backport/Makefile.real               | 24 ++++++++++++++++--------
>>  backport/scripts/blacklist.sh        |  7 ++++---
>>  backport/scripts/check_depmod.sh     |  7 ++++---
>>  backport/scripts/compress_modules.sh |  2 +-
>>  5 files changed, 49 insertions(+), 24 deletions(-)
>>
>> --
>> 1.9.2
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Hi,
>
> I am getting some errors when using a configuration generated with
> allyesconfig on an ubuntu 14.04 AMD64 system.
>
> Hauke
>
> hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20 make -j5
> /usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
> CONFIG_X86_X32 enabled but no binutils support
> scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
> scripts/basic/.fixdep.d: Permission denied
>  }
>  ^
> compilation terminated.
> make[3]: *** [scripts/basic/fixdep] Error 1
> make[2]: *** [scripts_basic] Error 2
> /usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
> CONFIG_X86_X32 enabled but no binutils support
> scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
> scripts/basic/.fixdep.d: Permission denied
>  }

I don't really see how this is related to this series.
It seems coming from the kernel sources itself, not the backport ones

>  ^
> compilation terminated.
> make[5]: *** [scripts/basic/fixdep] Error 1
> make[4]: *** [scripts_basic] Error 2
> make[5]: `conf' is up to date.
> boolean symbol HWMON tested for 'm'? test forced to 'n'
> boolean symbol HWMON tested for 'm'? test forced to 'n'
> #
> # configuration written to .config
> #
> Building backport-include/backport/autoconf.h ... done.
>

Regards,

-- 
Samuel
