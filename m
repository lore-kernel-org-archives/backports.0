Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60368 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3EGWWB (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 18:22:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so1258878lbi.5
        for <backports@vger.kernel.org>; Tue, 07 May 2013 15:21:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VEzLRPumquo-2MnJ3txvAUKsWQfSh3y9wuYOh1ds-keg@mail.gmail.com>
References: <1367925800-18555-1-git-send-email-mcgrof@do-not-panic.com>
 <1367925800-18555-2-git-send-email-mcgrof@do-not-panic.com>
 <1367929330.8328.4.camel@jlt4.sipsolutions.net> <CAB=NE6VEzLRPumquo-2MnJ3txvAUKsWQfSh3y9wuYOh1ds-keg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 7 May 2013 15:21:39 -0700
Message-ID: <CAB=NE6WXt0eyO3UAV_utFtZmFuPRM-2cRx3nufwKv=w6wST9sg@mail.gmail.com> (sfid-20130508_002204_734233_8632C85F)
Subject: Re: [PATCH 2/2] backports: refresh patches for next-20130403
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 7, 2013 at 12:25 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Tue, May 7, 2013 at 5:22 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
>> Did you mean next-20130503? I was already on next-20130405.
>
> Sorry it seems I was behind you so that's good. I'll jump to next-20130405.

Well so this is odd, with next-20130405 I get:

== ckmake-report.log ==

1   2.6.24              [  FAIL  ]
2   2.6.25              [  FAIL  ]
3   2.6.26              [  FAIL  ]
4   2.6.27              [  FAIL  ]
5   2.6.28              [  FAIL  ]
6   2.6.29              [  FAIL  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  FAIL  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  FAIL  ]
22  3.5.7               [  FAIL  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    24m52.933s
user    644m22.124s
sys     99m41.010s

Perhaps you only tested iwlwifi on next-20130405 ? I'm testing everything.

  Luis
