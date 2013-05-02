Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:58691 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3EBH2g (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 May 2013 03:28:36 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so242490lbj.38
        for <backports@vger.kernel.org>; Thu, 02 May 2013 00:28:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367479139-32655-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367479139-32655-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 2 May 2013 00:28:15 -0700
Message-ID: <CAB=NE6V=S04iKLM-NaNvdvS0EJohbbAt7WrnA7DYwcyAve0WtA@mail.gmail.com> (sfid-20130502_092839_285108_6DF13E95)
Subject: Re: [PATCH] compat: fix dma_common_get_sgtable() backport placements
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 2, 2013 at 12:18 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> We added dma_common_get_sgtable() assuming it should only
> be available to older kernels as of 3.6 but it was only
> up to 3.8 where it was detangled from depending on
> CONFIG_HAVE_GENERIC_DMA_COHERENT. Its a mess to express
> this on compat files so just word it via kconfig and throw this
> onto its own files given that there may be other helpers
> we may need to backport later with the same circumstances.
>
> time ckmake --check-exports --allyesconfig
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
> 17  3.0.65              [  OK  ]
> 18  3.1.10              [  OK  ]
> 19  3.2.38              [  OK  ]
> 20  3.3.8               [  LINK  ]
> 21  3.4.32              [  LINK  ]
> 22  3.5.7               [  LINK  ]
> 23  3.6.11              [  OK  ]
> 24  3.7.9               [  OK  ]
> 25  3.8.0               [  OK  ]
> 26  3.9-rc1             [  OK  ]
>
> real    30m3.120s
> user    795m40.684s
> sys     123m29.995s
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Dah, jumped the gun, 3.3 - 3.5 still link fails on this.

   Luis
