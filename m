Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:63833 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3HPWLX (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 18:11:23 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so2363834pac.3
        for <backports@vger.kernel.org>; Fri, 16 Aug 2013 15:11:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376674003-5801-2-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de> <1376674003-5801-2-git-send-email-hauke@hauke-m.de>
From: Arik Nemtsov <arik@wizery.com>
Date: Fri, 16 Aug 2013 22:32:11 +0300
Message-ID: <CA+XVXfdc9baMQzATby4Hs6ivCgxegyYTzrmosQMC6Hqdft19=g@mail.gmail.com> (sfid-20130817_001125_318387_25936BA2)
Subject: Re: [PATCH 02/13] backports: fix conditional include of arch_phys_wc_add()
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Aug 16, 2013 at 8:26 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This fixes a problem introduced in this commit:
> commit c871780b5afa182878884bf5ccd8df4817a2660f
> Author: Arik Nemtsov <arik@wizery.com>
> Date:   Wed Aug 14 10:48:05 2013 +0300
>
>     backports: rename some mem functions to not break custom kernels
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Arik Nemtsov <arik@wizery.com>

Thanks for the fix (again). Indeed it was stupid of me to make the
#ifndef redundant.
I'll test it on my setup next week.

Arik
