Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50872 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeIXCQl (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:16:41 -0400
Message-ID: <1537733867.1707.11.camel@sipsolutions.net> (sfid-20180923_221759_605630_51A2520B)
Subject: Re: [PATCH 09/10] backports: Make netdev destructor spatch apply
 correctly again
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:17:47 +0200
In-Reply-To: <20180923174535.16198-10-hauke@hauke-m.de> (sfid-20180923_194552_237545_E7708305)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-10-hauke@hauke-m.de>
         (sfid-20180923_194552_237545_E7708305)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> The netdev destructor spatch did not apply to the wil6210 driver any
> more, because there the calls were done in a different order compared to
> the spatch. Add an additional rule which applies when the order is
> changed.

Weird, thanks! I compared the diffstat, but perhaps wil6210 also changed
in the meantime ... dunno, but whatever, thanks for fixing.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
