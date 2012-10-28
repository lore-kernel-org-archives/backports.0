Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56016 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240Ab2J1MuQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Oct 2012 08:50:16 -0400
Message-ID: <508D29FD.2020704@hauke-m.de>
Date: Sun, 28 Oct 2012 13:50:05 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
CC: backports@vger.kernel.org, mcgrof@kernel.org
Subject: Re: Regarding compat_autoconf.h generation
References: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
In-Reply-To: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/27/2012 04:25 PM, Ozan Çağlayan wrote:
> Hi,
>
> In the nouveau DRM driver there is a CONFIG_NOUVEAU_DEBUG which has to
> be an integer between 0 and 7 with the default as 3.
> Currently gen-compat-autoconf.sh defines this as a string by default:
>
>             *) # Assume string
>   61                 # XXX: add better checks to make sure what was on
>   62                 # the right was indeed a string
>   63                 echo "#ifndef $VAR"
>   64                 echo "#define $VAR \"$VALUE\""
>   65                 echo "#endif /* $VAR */ "
>   66                 ;;
>
> Is it OK to modify the script to allow defining integers? Also, it
> seems that there is no difference with =m and =y:
>
>                y)
>   51                 echo "#ifndef $VAR"
>   52                 echo "#define $VAR 1"
>   53                 echo "#endif /* $VAR */ "
>   54                 ;;
>   55         m)
>   56                 echo "#ifndef $VAR"
>   57                 echo "#define $VAR 1"
>   58                 echo "#endif /* $VAR */ "
>   59                 ;;
>
> How come this doesn't break things? Both =y and =m exist in config.mk.
>
> Thanks!
>

Hi,

are you working o making nouveau work with compat-drivers? I just 
noticed that i915 is only activated driver and I have some problems with 
my nvidia card running nouveau and wanted to try out a new version.

Hauke
