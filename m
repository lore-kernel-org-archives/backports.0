Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42234 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753959AbdC2IT0 (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 29 Mar 2017 04:19:26 -0400
Message-ID: <1490775563.7948.4.camel@sipsolutions.net> (sfid-20170329_101930_736256_6152FE46)
Subject: Re: ib-rhashtable.c:90:17: error
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>,
        backports@vger.kernel.org
Date: Wed, 29 Mar 2017 10:19:23 +0200
In-Reply-To: <CAFED-jmLaRiM5b7XotQDrhtphSMtLDO565xCjobTnwhtipuuUQ@mail.gmail.com> (sfid-20170329_100904_084825_40B6ACA5)
References: <CAFED-jmLaRiM5b7XotQDrhtphSMtLDO565xCjobTnwhtipuuUQ@mail.gmail.com>
         (sfid-20170329_100904_084825_40B6ACA5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


>     tbl->locks = kvmalloc(size * sizeof(spinlock_t), gfp);

Looks like we need to backport kvmalloc(), and perhaps something around
the free as well.

> Is there any fix for that?

No, not yet, but shouldn't be hard.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
