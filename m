MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1364336362-10826-1-git-send-email-mcgrof@do-not-panic.com>
References: <1364336362-10826-1-git-send-email-mcgrof@do-not-panic.com>
Date: Tue, 26 Mar 2013 15:24:13 -0700
Message-ID: <CAB=NE6Xt-WNEre6bWP4zQdLjSb3+-s66gCYqehPCbAdCUa4h1Q@mail.gmail.com>
Subject: Re: [PATCH] compat: fix cordic backport header
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Mar 26, 2013 at 3:19 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> mcgrof@frijol ~/linux-next (git::master)$ git describe --contains \
>         10f8113ecb76eea72f96c7cfb72d7fed7c282565
> v3.1-rc1~24^2~10^2^2~515
>
> The cordic backport added the cordic library
> and the cordic header. It correctly only compiled
> cordic for kernels < 3.1 but the header however was
> left intact. This is non-issue until cordic itself
> gets updated with some new features or changes but
> also an issue was created when we switched the
> backort namespace. The issue is that the header
> declares backport_cordic_calc_iq() exists while
> it actually is not compiled on newer kernels.
>
> Fix this by doing the kernel revision check on the
> backported header, otherwise use #include_next to
> get the next header, the proper kernel header.
>
> This does not have to be added to the older releases
> given that the header is the same for older kernels,
> and we are not exporting the symbol twice given that
> the proper check was already in place for cordic.c.
>
> Reported-by: Camale=C3=B3n <noelamac@gmail.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

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
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

real    0m32.956s
user    12m14.398s
sys     2m12.304s

  Luis
