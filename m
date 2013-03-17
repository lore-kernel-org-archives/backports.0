Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54833 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3CQKUM convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 06:20:12 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so5852407iea.7
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 03:20:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
References: <20130317085202.GB3547@stt008.linux.site>
	<CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
Date: Sun, 17 Mar 2013 11:20:12 +0100
Message-ID: <CAKprTDEyC54zL8zBOHW-De3bVRxiLaAzNAq+Jd39f67gX2waPQ@mail.gmail.com>
Subject: Re: Unable to compile "compat-drivers" in Debian Wheezy
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2013/3/17 Ozan Çağlayan <ozancag@gmail.com>:

> This is caused because Debian already defined those
> structures/functions/etc in their vendor kernel using 2 patches:
> - features/all/ethernet-define-eth_hw_addr_random.patch
> - features/all/drm/slab-introduce-kmalloc_array.patch

I see, thanks for the explanation, really appreciated.

> This kind of problems occur from time to time with other distributions
> too. I don't know if in the code level there is a dynamic way to
> detect whether those symbols are already defined or not but for now
> you can edit compat-3.4.h in the compat-drivers folder and comment out
> the lines defining kmalloc_array and eth_hw_addr_random.

It works, thanks :-)

As I don't want to "make install" I first try to load the module using "insmod":

hpc03@stt300:~/Escritorio/compat-drivers-3.9-rc2-2-su$ su -c "insmod
/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/drivers/net/ethernet/atheros/alx/alx.ko"
Contraseña:
Error: could not insert module
/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su/drivers/net/ethernet/atheros/alx/alx.ko:
Unknown symbol in module

 And dmesg shows:

[ 6042.342598] alx: Unknown symbol compat_dependency_symbol (err 0)
[ 6042.342883] alx: Unknown symbol mdio_mii_ioctl (err 0)

Should I try with a different version of the compat-drivers instead?
Or maybe is that I commented out too much from "compat-3.4.h"?

Thanks for any hint.

-- 
Camaleón
