Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58147 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbaFAMfA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 08:35:00 -0400
Message-ID: <538B1DDE.9020702@hauke-m.de> (sfid-20140601_143502_541294_CC97D820)
Date: Sun, 01 Jun 2014 14:34:38 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Samuel Martin <s.martin49@gmail.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 0/10] Cross-compilation support improvement
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com> <5389BD34.4010006@hauke-m.de> <CAHXCMMKJRmx88Qp=MP4Oir8rX2w8QNNAQsSg8mvdmXEWDErRWg@mail.gmail.com>
In-Reply-To: <CAHXCMMKJRmx88Qp=MP4Oir8rX2w8QNNAQsSg8mvdmXEWDErRWg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/01/2014 10:47 AM, Samuel Martin wrote:
> Hi Hauke,
> 
> On Sat, May 31, 2014 at 1:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> On 05/08/2014 10:39 PM, Samuel Martin wrote:
> [...]
>>> Samuel Martin (10):
>>>   backports: Makefile: introduce KROOT and fix INSTALL_MOD_PATH
>>>     definition
>>>   backports: Makefile: introduce KVERSION and rework KLIB definition
>>>   backports: Makefile: export KROOT and KVERSION variables
>>>   backports: blacklist.sh: support install root not in /
>>>   backports: check_depmod.sh: support install root not in /
>>>   backports: Makefile.real: use depmod.sh instead of the depmod program
>>>   backports: Makefile.real: disable update-initramfs.sh execution when
>>>     cross-compiling
>>>   backports: Makefile.real: silent reboot message when cross-compiling
>>>   backports: compress_module.sh: gzip silently overrides existing
>>>     compressed modules
>>>   backports: Makefile: update help text
>>>
>>>  backport/Makefile                    | 33 ++++++++++++++++++++++++---------
>>>  backport/Makefile.real               | 24 ++++++++++++++++--------
>>>  backport/scripts/blacklist.sh        |  7 ++++---
>>>  backport/scripts/check_depmod.sh     |  7 ++++---
>>>  backport/scripts/compress_modules.sh |  2 +-
>>>  5 files changed, 49 insertions(+), 24 deletions(-)
>>>
>>> --
>>> 1.9.2
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> Hi,
>>
>> I am getting some errors when using a configuration generated with
>> allyesconfig on an ubuntu 14.04 AMD64 system.
>>
>> Hauke
>>
>> hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20 make -j5
>> /usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
>> CONFIG_X86_X32 enabled but no binutils support
>> scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
>> scripts/basic/.fixdep.d: Permission denied
>>  }
>>  ^
>> compilation terminated.
>> make[3]: *** [scripts/basic/fixdep] Error 1
>> make[2]: *** [scripts_basic] Error 2
>> /usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
>> CONFIG_X86_X32 enabled but no binutils support
>> scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
>> scripts/basic/.fixdep.d: Permission denied
>>  }
> 
> I don't really see how this is related to this series.
> It seems coming from the kernel sources itself, not the backport ones

Git bisect showed me that this commit is causing the problem:
backports: Makefile: introduce KVERSION and rework KLIB definition

I ran the following commands to build backports:
make -j4 allyesconfig
make -j4

Hauke
