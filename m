Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57400 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305Ab3CQOfn convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 10:35:43 -0400
Received: by mail-ie0-f177.google.com with SMTP id 16so6060426iea.22
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 07:35:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKprTDEtReToSww5_YhXhj2f0YtsmQczpexf4a-_aEtvaFTXdQ@mail.gmail.com>
References: <20130317085202.GB3547@stt008.linux.site>
	<CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
	<CAKprTDEyC54zL8zBOHW-De3bVRxiLaAzNAq+Jd39f67gX2waPQ@mail.gmail.com>
	<CAFub=KTb2PrCVYoxc5mts3CTAypEzKwZjbRiBNpMoVz7yz-s5g@mail.gmail.com>
	<CAKprTDEtReToSww5_YhXhj2f0YtsmQczpexf4a-_aEtvaFTXdQ@mail.gmail.com>
Date: Sun, 17 Mar 2013 15:35:43 +0100
Message-ID: <CAKprTDFXG6FsHSy0oJGzZkzNaUA-30+CwtLRo-h54Wv9g665cA@mail.gmail.com>
Subject: Re: Unable to compile "compat-drivers" in Debian Wheezy
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2013/3/17 Camaleón <noelamac@gmail.com>:

> Well, I finally run "make install", then "make unload" and finally
> "modprobe alx" but I get:
>
> root@stt300:/home/hpc03/Escritorio/compat-drivers-3.9-rc2-2-su# modprobe alx
> ERROR: could not insert 'alx': Exec format error

Well, I'm afraid this is something on Debian's kernel side as I have
the same symptoms:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=703142#56

Going back to Debian BTS to continue there.

Ozan, thanks for your kind support! :-)

Greetings,

-- 
Camaleón
