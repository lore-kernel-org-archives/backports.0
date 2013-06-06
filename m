Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:51503 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3FFEit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Jun 2013 00:38:49 -0400
Received: by mail-la0-f49.google.com with SMTP id fp12so1530720lab.22
        for <backports@vger.kernel.org>; Wed, 05 Jun 2013 21:38:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 5 Jun 2013 21:38:27 -0700
Message-ID: <CAB=NE6Vmhd_J95WRCZp8GruYtyEiaJ+qKbC1W1tYUbssb9J_=g@mail.gmail.com> (sfid-20130606_063851_531727_CB66A364)
Subject: Re: [PATCH 00/11] backports: add support for RHEL 6.4
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jun 1, 2013 at 9:00 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This patch series adds support for RHEL 6.4 This was tested with a
> fully patched CentOS 6.4. I just did compile tests and load tests of
> some modules, no actual wifi card was used.
>
> Later I verified that it still compiles on all supported mainline
> kernel versions.
>
> 1   2.6.24              [  OK  ]
> 2   2.6.25              [  OK  ]
> 3   2.6.26              [  OK  ]
> 4   2.6.27              [  OK  ]
> 5   2.6.28              [  OK  ]
> 6   2.6.29              [  OK  ]
> 7   2.6.30              [  OK  ]
> 8   2.6.31              [  OK  ]
> 9   2.6.32              [  OK  ]
> 10  2.6.33              [  OK  ]
> 11  2.6.34              [  OK  ]
> 12  2.6.35              [  OK  ]
> 13  2.6.36              [  OK  ]
> 14  2.6.37              [  OK  ]
> 15  2.6.38              [  OK  ]
> 16  2.6.39              [  OK  ]
> 17  3.0.79              [  OK  ]
> 18  3.1.10              [  OK  ]
> 19  3.10-rc1            [  OK  ]
> 20  3.2.45              [  OK  ]
> 21  3.3.8               [  OK  ]
> 22  3.4.46              [  OK  ]
> 23  3.5.7               [  OK  ]
> 24  3.6.11              [  OK  ]
> 25  3.7.10              [  OK  ]
> 26  3.8.13              [  OK  ]
> 27  3.9.3               [  OK  ]

Awesome, applied and pushed!

  Luis
