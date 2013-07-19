Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39076 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759986Ab3GSR2q (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 13:28:46 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so3592882lbf.22
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 10:28:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 19 Jul 2013 10:28:24 -0700
Message-ID: <CAB=NE6Vrg_xcu-JRavoin0KqQ3xYGjG2ZviEgOBqDBzV9pz13Q@mail.gmail.com> (sfid-20130719_192848_492207_F2306463)
Subject: Re: [RFC 0/9] backports: synch up to next-20130627
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jul 19, 2013 at 5:00 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> These try to get us caught up to next-20130627.
> The dmi one is not the best solution but an alternative
> really should be considered upstream as otherwise we'd
> end up with shit work arounds all over. Not sure if
> a reasonable alternative is possible upstream that is
> easier to backport.
>
> I am testing this with ckmake right now but its late so
> going to crash and report results in the morning. I think
> this should do it. If someone can take this further to get
> closer to the date circa v3.11-rc1 that'd help if not
> I can try to take care of that tomorrow.

I'll address the feedback and then move on with life.

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
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

real    34m5.379s
user    921m5.112s
sys     128m8.156s

  Luis
