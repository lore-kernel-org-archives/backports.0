Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:48898 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab3CQLDS (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 07:03:18 -0400
Received: by mail-wg0-f49.google.com with SMTP id ds1so3176463wgb.4
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 04:03:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKprTDEyC54zL8zBOHW-De3bVRxiLaAzNAq+Jd39f67gX2waPQ@mail.gmail.com>
References: <20130317085202.GB3547@stt008.linux.site>
	<CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
	<CAKprTDEyC54zL8zBOHW-De3bVRxiLaAzNAq+Jd39f67gX2waPQ@mail.gmail.com>
Date: Sun, 17 Mar 2013 13:03:17 +0200
Message-ID: <CAFub=KTb2PrCVYoxc5mts3CTAypEzKwZjbRiBNpMoVz7yz-s5g@mail.gmail.com>
Subject: Re: Unable to compile "compat-drivers" in Debian Wheezy
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

insmod doesn't resolve module dependencies. You have to use modprobe
or load dependencies of alx before insmod'ding alx by looking at the
output of modinfo alx.

By the way make install should install the modules under a different
subdirectory of /lib/modules/<your kernel>. So this wouldn't overwrite
your already install stuff.
