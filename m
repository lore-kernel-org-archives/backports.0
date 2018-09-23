Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50714 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCJH (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:09:07 -0400
Message-ID: <1537733414.1707.8.camel@sipsolutions.net> (sfid-20180923_221027_281716_D4D7C489)
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:10:14 +0200
In-Reply-To: <20180923174535.16198-2-hauke@hauke-m.de> (sfid-20180923_194547_614863_47F61E59)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-2-hauke@hauke-m.de>
         (sfid-20180923_194547_614863_47F61E59)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> Use the versions shipped with the kernel instead.
> bcma and ssb didn't change much in the last few years, most of the
> changes were related to code only used on embedded devices. Removing
> this reduces the number of parts we have to backport. b43, b43legacy and
> brcmsmac work well with the in kernel version.

>  patches/0051-no-wakeup_path/ssb.patch              | 12 -----------
>  patches/0069-remove-of_irq/bcma.patch              | 24 ----------------------
>  11 files changed, 23 insertions(+), 80 deletions(-)

Is that really worth it?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
