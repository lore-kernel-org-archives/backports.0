Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50758 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCLS (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:11:18 -0400
Message-ID: <1537733544.1707.9.camel@sipsolutions.net> (sfid-20180923_221237_388483_9F6D50B9)
Subject: Re: [PATCH 05/10] dependencies: Make WIL6210 depend on kernel >= 4.8
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:12:24 +0200
In-Reply-To: <20180923174535.16198-6-hauke@hauke-m.de> (sfid-20180923_194551_041786_E1F84913)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-6-hauke@hauke-m.de>
         (sfid-20180923_194551_041786_E1F84913)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> The WIL6210 driver now uses pci_alloc_irq_vectors() which is only
> available in kernel >= 4.8, only build this driver against such kernel
> versions.

>From the description of the function, it seems like it should be pretty
simple to backport?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
