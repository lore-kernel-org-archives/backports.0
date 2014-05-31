Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55004 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbaEaLjT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 07:39:19 -0400
Message-ID: <5389BD34.4010006@hauke-m.de> (sfid-20140531_133923_827832_A4ABCD44)
Date: Sat, 31 May 2014 13:29:56 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Samuel Martin <s.martin49@gmail.com>, backports@vger.kernel.org
Subject: Re: [PATCH 0/10] Cross-compilation support improvement
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/08/2014 10:39 PM, Samuel Martin wrote:
> Hi all,
> 
> 
> This patch series improves cross-compilation support, mostly fixing the
> scripts to support target root location.
> 
> Now, to cross-compile kernel-backports, KLIB_BUILD should still point to
> the linux kernel build tree and, the new KROOT variable, to the target
> root location (instead of the target kernel module location, as
> mentionned at [1]):
> ---
> make \
>   CROSS_COMPILE=<toolchain prefix> \
>   ARCH=<target architecture> \
>   KROOT=<target root directory> \
>   KLIB_BUILD=<kernel build directory>
> ---
> 
> This should not change anything when compiling backports for the build
> machine.
> 
> If this series breaks anything, please let me know.
> 
> 
> The following changes since commit 44554cd57d0016c52aeed2ce4f27081b9d9c915f:
> 
>   backports: select_queue patch: fix callback kernel version (2014-05-01 18:48:03 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/tSed/backports.git sma/cross-compilation
> 
> for you to fetch changes up to 99add35cab73b890dd6810fa303ec0c0fa06218c:
> 
>   backports: Makefile: update help text (2014-05-08 19:32:33 +0200)
> 
> 
> Yours,
> Samuel
> 
> 
> [1] https://backports.wiki.kernel.org/index.php/Documentation#Cross_compile_with_Freescale.27s_LTIB
> 
> 
> Samuel Martin (10):
>   backports: Makefile: introduce KROOT and fix INSTALL_MOD_PATH
>     definition
>   backports: Makefile: introduce KVERSION and rework KLIB definition
>   backports: Makefile: export KROOT and KVERSION variables
>   backports: blacklist.sh: support install root not in /
>   backports: check_depmod.sh: support install root not in /
>   backports: Makefile.real: use depmod.sh instead of the depmod program
>   backports: Makefile.real: disable update-initramfs.sh execution when
>     cross-compiling
>   backports: Makefile.real: silent reboot message when cross-compiling
>   backports: compress_module.sh: gzip silently overrides existing
>     compressed modules
>   backports: Makefile: update help text
> 
>  backport/Makefile                    | 33 ++++++++++++++++++++++++---------
>  backport/Makefile.real               | 24 ++++++++++++++++--------
>  backport/scripts/blacklist.sh        |  7 ++++---
>  backport/scripts/check_depmod.sh     |  7 ++++---
>  backport/scripts/compress_modules.sh |  2 +-
>  5 files changed, 49 insertions(+), 24 deletions(-)
> 
> --
> 1.9.2
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi,

I am getting some errors when using a configuration generated with
allyesconfig on an ubuntu 14.04 AMD64 system.

Hauke

hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20 make -j5
/usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
CONFIG_X86_X32 enabled but no binutils support
scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
scripts/basic/.fixdep.d: Permission denied
 }
 ^
compilation terminated.
make[3]: *** [scripts/basic/fixdep] Error 1
make[2]: *** [scripts_basic] Error 2
/usr/src/linux-headers-3.13.0-27-generic/arch/x86/Makefile:113:
CONFIG_X86_X32 enabled but no binutils support
scripts/basic/fixdep.c:462:1: fatal error: opening dependency file
scripts/basic/.fixdep.d: Permission denied
 }
 ^
compilation terminated.
make[5]: *** [scripts/basic/fixdep] Error 1
make[4]: *** [scripts_basic] Error 2
make[5]: `conf' is up to date.
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.

