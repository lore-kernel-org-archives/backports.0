Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:60056 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIXQu2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 12:50:28 -0400
Message-ID: <1537786129.1707.28.camel@sipsolutions.net> (sfid-20180924_124903_203274_FE806BD3)
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Mon, 24 Sep 2018 12:48:49 +0200
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

Looks like this broke b43 at least up to around 3.12:

b43/main.c:5331:25: error: ‘struct ssb_sprom’ has no member named ‘dev_id’

ssb: sprom: add dev_id field for value overriding standard ID

3.16, actually. I think I'll revert this.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
