Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50886 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIXCRm (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:17:42 -0400
Message-ID: <1537733927.1707.12.camel@sipsolutions.net> (sfid-20180923_221859_763415_7B7C5ABD)
Subject: Re: [PATCH 10/10] patches: Do not remove linux/kmemleak.h include
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:18:47 +0200
In-Reply-To: <20180923174535.16198-11-hauke@hauke-m.de> (sfid-20180923_194552_730396_7022A53B)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-11-hauke@hauke-m.de>
         (sfid-20180923_194552_730396_7022A53B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> This driver has to include linux/kmemleak.h to get kmemleak_not_leak in
> kernel 4.19. I haven't seen any problem when compiling against multiple
> other kernels, but didn't test all the 3.X versions.

Looks like kmemleak.h was added in 2.6.31, so ... should be fine.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
