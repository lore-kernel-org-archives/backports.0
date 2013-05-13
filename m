Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:43920 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab3EMCgq (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 12 May 2013 22:36:46 -0400
Received: by mail-la0-f49.google.com with SMTP id ee20so2404155lab.36
        for <backports@vger.kernel.org>; Sun, 12 May 2013 19:36:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
 <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
 <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
 <CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com> <CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 19:36:24 -0700
Message-ID: <CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com> (sfid-20130513_043649_077009_B75C5BE4)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 6:30 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
>
> No worries we have a crazy build box for the backports project that
> lets us test compile these releases across 26 kernels (2.6.24-3.9) in
> about 30 minutes using our script ckmake, all in RAM, so I just
> integrated your changes and in 30 minutes we'll know if anything
> broke, and I can provide the log then.

$ time ckmake --allyesconfig

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
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
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m53.311s
user    817m3.260s
sys     127m37.555s

>> The net/bluetooth/hidp/core.c file is attached. It is from the tarball
>> you created above (2013-04-26). I fixed some other small issues.
>
> Nice, can you provide me a Signed-off-by tag ? With it I'd just amend
> it to my commit provided everything compiles fine.

Just need a Signed-off-by from you and we're good, thanks so much.

  Luis
