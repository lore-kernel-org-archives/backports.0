Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41503 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3CQL0h convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 07:26:37 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so5979962iea.10
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 04:26:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFub=KTb2PrCVYoxc5mts3CTAypEzKwZjbRiBNpMoVz7yz-s5g@mail.gmail.com>
References: <20130317085202.GB3547@stt008.linux.site>
	<CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
	<CAKprTDEyC54zL8zBOHW-De3bVRxiLaAzNAq+Jd39f67gX2waPQ@mail.gmail.com>
	<CAFub=KTb2PrCVYoxc5mts3CTAypEzKwZjbRiBNpMoVz7yz-s5g@mail.gmail.com>
Date: Sun, 17 Mar 2013 12:26:36 +0100
Message-ID: <CAKprTDEtReToSww5_YhXhj2f0YtsmQczpexf4a-_aEtvaFTXdQ@mail.gmail.com>
Subject: Re: Unable to compile "compat-drivers" in Debian Wheezy
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2013/3/17 Ozan Çağlayan <ozancag@gmail.com>:
> insmod doesn't resolve module dependencies. You have to use modprobe
> or load dependencies of alx before insmod'ding alx by looking at the
> output of modinfo alx.

Ah, okay.

> By the way make install should install the modules under a different
> subdirectory of /lib/modules/<your kernel>. So this wouldn't overwrite
> your already install stuff.

Well, I finally run "make install", then "make unload" and finally
"modprobe alx" but I get:

root@stt300:/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su# modprobe alx
ERROR: could not insert 'alx': Exec format error

While loading Debian's stock module seems to be fine:

root@stt300:/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su# insmod
/lib/modules/3.2.0-4-686-pae/kernel/drivers/net/ethernet/atheros/alx/alx.ko

root@stt300:/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su# lsmod|grep alx
alx                    59294  0

Again, thanks for any hint :-)

Greetings,

-- 
Camaleón
