Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754920AbcHSBdr (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 18 Aug 2016 21:33:47 -0400
Date: Thu, 18 Aug 2016 18:18:41 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Peter Huewe <PeterHuewe@gmx.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: backport-4.7.c fails due to missing rhashtable.h for target <
 3.17
Message-ID: <20160818161841.GK3296@wotan.suse.de> (sfid-20160819_033428_881619_A2164A7C)
References: <trinity-e021195e-a0df-484c-9ba9-6d30922988b8-1470901957548@3capp-gmx-bs55>
 <trinity-15584ccd-5e19-4c65-93a1-97f688db43d7-1470904501866@3capp-gmx-bs55>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <trinity-15584ccd-5e19-4c65-93a1-97f688db43d7-1470904501866@3capp-gmx-bs55>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 11, 2016 at 10:35:01AM +0200, Peter Huewe wrote:
> ckmake says the same
> 
> 1   3.0.101             [  FAIL  ]
> 2   3.1.10              [  FAIL  ]
> 3   3.2.81              [  FAIL  ]
> 4   3.3.8               [  FAIL  ]
> 5   3.4.112             [  FAIL  ]
> 6   3.5.7               [  FAIL  ]
> 7   3.6.11              [  FAIL  ]
> 8   3.7.10              [  FAIL  ]
> 9   3.8.13              [  FAIL  ]
> 10  3.9.11              [  FAIL  ]
> 11  3.10.102            [  FAIL  ]
> 12  3.11.10             [  FAIL  ]
> 13  3.12.61             [  FAIL  ]
> 14  3.13.11             [  FAIL  ]
> 15  3.14.73             [  FAIL  ]
> 16  3.15.10             [  FAIL  ]
> 17  3.16.36             [  FAIL  ]
> 18  3.17.8              [  OK  ]
> 19  3.18.36             [  OK  ]
> 20  3.19.8              [  OK  ]
> 21  4.0.9               [  OK  ]
> 22  4.1.27              [  OK  ]
> 23  4.2.8               [  OK  ]
> 24  4.3.6               [  OK  ]
> 25  4.4.14              [  OK  ]
> 26  4.5.7               [  OK  ]
> 27  4.6.3               [  OK  ]
> 28  4.7-rc6             [  OK  ]
> 
> 
> 
> Was this all green for you?

I leave it to Hauke and Johannes to respond but I typically
use ckmake per commit.

> Do you think it makes sense to set up a small per-commit based build/compile test (e.g. with travis) to see whether commits really work?
> (I probably could do something like that)

We need to run this prior to integration so the work needs to be done
by the developer. One thing we could do, since compilation tests take a
while is perhaps set up registering trees for testing so that then
something similar to 0-day can fetch and test for you and you get a report
of results. You then can rely on this prior to pushing patches.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
