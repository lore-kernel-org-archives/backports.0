Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:39326 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeIYCdH (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 22:33:07 -0400
Message-ID: <1537820936.10538.7.camel@sipsolutions.net> (sfid-20180924_222911_034150_00FE991A)
Subject: Re: [PATCH 00/10] backports: misc fixes to improve support of 4.19
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Mon, 24 Sep 2018 22:28:56 +0200
In-Reply-To: <defcd01d-5146-4c58-1317-26fd90dcea5d@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <1537776741.1707.24.camel@sipsolutions.net>
         <defcd01d-5146-4c58-1317-26fd90dcea5d@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-09-24 at 22:27 +0200, Hauke Mehrtens wrote:

> > But that's sort of looking only perhaps? 3.10-4.2 fail on skcipher
> > backport, which was pretty much always doomed given the crypto API
> > complexity ...
> 
> If it is only needed for the drivers using lib80211, I think we can make
> them depend on kernel >= 4.2.

Indeed. I need to do a new run with that fixed (see my lib80211 skcipher
removal patch), but was waiting for Luca's updated iwlwifi patch since I
fail on that every time too.

> Did you test compile it on drvbp1.linux-foundation.org, or do I have to
> update the installed kernel versions there?

I did, but it's probably restricted to my account.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
