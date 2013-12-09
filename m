Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:37230 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab3LITF2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 14:05:28 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so3972555wes.16
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 11:05:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
References: <1386515294-26231-1-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Mon, 9 Dec 2013 20:05:07 +0100
Message-ID: <CAB=NE6Va2n7k9iENcafBe5OLRxL6qSAm83WBtuuSUKaBrX059A@mail.gmail.com> (sfid-20131209_200530_804674_7368304F)
Subject: Re: [PATCH 0/8] backports: fixes for distribution kernels
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Dec 8, 2013 at 4:08 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> These patches are mostly containing fixes for the RHEL 6.5 and for the
> SLES 11 SP3 kernel. With these changes I was able to compile it on both
> distribution. The first patch fixes a problem with mainline kernel
> 3.10.21 and upwards and the second something when device tree support
> is activated as it was reported in the bugzilla bugreport.

Awesome thanks!

> If we want to support SLES 11 SP3 and RHEL 6.5 with backports 3.13.X
> the last 6 patches should go into that branch, but I haven't tested
> that, this was only tested with linux-next.

Will do thanks!

> These patches are based on the backports patches already posted on the
> mailing list.

Applied and pushed!

Folks -- all pending patches have been pushed out, please git fetch
for all new shiny stuff.

  Luis
