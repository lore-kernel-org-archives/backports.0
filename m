Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49638 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbDYOAc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:00:32 -0400
Message-ID: <553B9DFA.5010308@hauke-m.de> (sfid-20150425_160034_319557_C5A25262)
Date: Sat, 25 Apr 2015 16:00:26 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 0/4] backports: deal with timespec64 changes
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1429788825-18466-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/23/2015 01:33 PM, Stefan Assmann wrote:
> This series adds cocci patches to deal with struct timespec64 changes
> and also has several other bits to get igb working again. Patches have
> been tested against next-20150402.
> 
> The struct timespec64 patches are not perfect, but they should get us
> started. There are still some warnings, which we can fix along the way.
> 
> Stefan Assmann (4):
>   backports: handle ndo_gso_check() to ndo_features_check() changes
>   backports: add passthru_features_check()
>   backports: deal with struct timespec64 changes
>   backports: deal with struct struct ptp_clock_info get/settime64
>     changes
> 
>  backport/backport-include/linux/netdevice.h        |  6 ++
>  backport/compat/Makefile                           |  1 +
>  backport/compat/backport-4.1.c                     | 19 +++++
>  .../network/0056-ndo_features_check/INFO           | 12 ++++
>  .../0056-ndo_features_check/features_check.cocci   | 19 +++++
>  .../network/0057-timespec64/INFO                   | 11 +++
>  .../network/0057-timespec64/igb.patch              | 16 +++++
>  .../network/0057-timespec64/timespec64.cocci       | 83 ++++++++++++++++++++++
>  .../network/0058-ptp_getsettime64/INFO             | 11 +++
>  .../0058-ptp_getsettime64/ptp_getsettime64.cocci   | 33 +++++++++
>  10 files changed, 211 insertions(+)
>  create mode 100644 backport/compat/backport-4.1.c
>  create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/INFO
>  create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci
>  create mode 100644 patches/collateral-evolutions/network/0057-timespec64/INFO
>  create mode 100644 patches/collateral-evolutions/network/0057-timespec64/igb.patch
>  create mode 100644 patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci
>  create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO
>  create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci
> 
Thank you for the patches, I applied and pushed them.

In the patch "backports: add passthru_features_check()" I change the
EXPORT_SYMBOL() to a EXPORT_SYMBOL_GPL().

In "backports: deal with struct timespec64 changes" v2 I moved the
defines into the header files with the same name as where they are
defined in the kernel. If later some code is including time64.h directly
this will now work. In addition I removed some ktime_* defines, because
they are already in all supported kernel versions.

Hauke
