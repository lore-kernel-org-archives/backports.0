Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:62917 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3E1SgV (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 14:36:21 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so7740868lab.39
        for <backports@vger.kernel.org>; Tue, 28 May 2013 11:36:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369597950-2926-5-git-send-email-hauke@hauke-m.de>
References: <1369597950-2926-1-git-send-email-hauke@hauke-m.de> <1369597950-2926-5-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 May 2013 11:35:59 -0700
Message-ID: <CAB=NE6VQ8QiqEi_HfY4UX2fZyx0O5KeJBA4wtdHq9tO_McaL5Q@mail.gmail.com> (sfid-20130528_203623_798486_95AFC546)
Subject: Re: [PATCH 5/5] backports: BCMA and SSB MIPS drivers are depending on
 kernel >= 3.3
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 26, 2013 at 12:52 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> The bcma and ssb mips driver are depending on kernel 3.3.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks, applied and pushed all 5!

  Luis
