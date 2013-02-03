Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54766 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab3BCL30 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 3 Feb 2013 06:29:26 -0500
Message-ID: <510E4A0A.60309@hauke-m.de>
Date: Sun, 03 Feb 2013 12:29:14 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
CC: backports@vger.kernel.org
Subject: Re: Return values in ckmake
References: <CAFub=KRc30sW-zFKscTSOtAPa-jX-bLc777jcUX92eDgiSDBzg@mail.gmail.com>
In-Reply-To: <CAFub=KRc30sW-zFKscTSOtAPa-jX-bLc777jcUX92eDgiSDBzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/02/2013 01:49 PM, Ozan Çağlayan wrote:
> Hi,

Hi Ozan,

while Luis is on vacation for some weeks I took over compat and
compat-driver maintenance. I can not push to Luis git repositories so my
current changes are on github and I am making release based on these trees:

https://github.com/hauke/compat
https://github.com/hauke/compat-drivers

> I can't build current compat against 3.7:
> 
>  make -C /root/compat-ksrc/lib/modules/3.7.0-030700-generic/build/
> M=/root/git/compat/.tmp.ckmake/3.7.0 modules
> make[1]: Entering directory
> `/root/compat-ksrc/usr/src/linux-headers-3.7.0-030700-generic'
>    CC [M]  /root/git/compat/.tmp.ckmake/3.7.0/compat/main.o
>    CC [M]  /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.o
>  /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c: In function
> ‘netdev_set_default_ethtool_ops’:
>  /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c:34:27: error:
> ‘default_ethtool_ops’ undeclared (first use in this function)
>  /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c:34:27: note:
> each undeclared identifier is reported only once for each function it
> appears in
>  make[3]: *** [/root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.o] Error 1
>  make[2]: *** [/root/git/compat/.tmp.ckmake/3.7.0/compat] Error 2
>  make[1]: *** [_module_/root/git/compat/.tmp.ckmake/3.7.0] Error 2
>  make[1]: Leaving directory
> `/root/compat-ksrc/usr/src/linux-headers-3.7.0-030700-generic'
>  make: *** [modules] Error 2

This is fixed in:
https://github.com/hauke/compat/commit/670c4a3d46797a92fd15d201e5d9859393c7b2b6


> --
> 
> This returns 2 but ckmake interprets return values 0 and 2 to "OK" in
> get_status_name() thus logs and curses shows OK for this failed build.

This is fixed in:
https://github.com/hauke/compat/commit/9f0c7145e86d00246363c25d0f063994e17dd995

Hauke
