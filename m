Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34565 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab3C2AgR (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 20:36:17 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so155432lab.14
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 17:36:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364498307-11855-5-git-send-email-hauke@hauke-m.de>
References: <1364498307-11855-1-git-send-email-hauke@hauke-m.de> <1364498307-11855-5-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 28 Mar 2013 17:35:54 -0700
Message-ID: <CAB=NE6XBBz2v-2bm9TZyJBfM=h9beyi-FHFgWqa94c5ojWNrfA@mail.gmail.com> (sfid-20130329_013618_819973_DEEDA0F5)
Subject: Re: [PATCH 5/5] compat: build kstrtox for kernel < 2.6.25
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 12:18 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> strict_strtol with one l is defined in compat-2.6.25.h code now and
> this deactivates this check, use strict_strtoll instead.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks so much, applied and pushed all for both compat and compat-drivers.

  Luis
