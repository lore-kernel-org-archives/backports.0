Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:58462 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeIXOhO (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 10:37:14 -0400
Message-ID: <1537778165.1707.26.camel@sipsolutions.net> (sfid-20180924_103619_431679_C0B28536)
Subject: Re: [PATCH 08/10] patches: remove .coredump from struct driver for
 kernel < 4.16
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Mon, 24 Sep 2018 10:36:05 +0200
In-Reply-To: <20180923174535.16198-9-hauke@hauke-m.de> (sfid-20180923_194553_442604_1A88B709)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-9-hauke@hauke-m.de>
         (sfid-20180923_194553_442604_1A88B709)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> Kernel 4.16 added a new .coredump member to the driver structure which
> can be implemented by drivers. Remove this member on older kernel
> versions as they do not support this feature.

Note that this isn't sufficient.

On 4.16, the return value was int, now it's void. I'll change this patch
to be for < 4.17, but if somebody wants to submit an spatch to fix up
the difference that would work too.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
