Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:58084 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIXONZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 10:13:25 -0400
Message-ID: <1537776741.1707.24.camel@sipsolutions.net> (sfid-20180924_101235_237046_0C7FC36D)
Subject: Re: [PATCH 00/10] backports: misc fixes to improve support of 4.19
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Mon, 24 Sep 2018 10:12:21 +0200
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de> (sfid-20180923_194546_955479_ADD694EF)
References: <20180923174535.16198-1-hauke@hauke-m.de>
         (sfid-20180923_194546_955479_ADD694EF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I applied pretty much everything, but the result isn't looking so
great...

But that's sort of looking only perhaps? 3.10-4.2 fail on skcipher
backport, which was pretty much always doomed given the crypto API
complexity ...

johannes
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
