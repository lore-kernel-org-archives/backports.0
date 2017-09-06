Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54334 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbdIFPFr (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 11:05:47 -0400
Message-ID: <1504710345.23905.14.camel@sipsolutions.net> (sfid-20170906_170613_695243_3BD2C7D9)
Subject: Re: [PATCH 12/21] compat: avoid usage of kvzalloc() in rhashtable.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 17:05:45 +0200
In-Reply-To: <20170821222817.17376-13-hauke@hauke-m.de> (sfid-20170822_002849_246894_A23843F2)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-13-hauke@hauke-m.de>
         (sfid-20170822_002849_246894_A23843F2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-08-22 at 00:28 +0200, Hauke Mehrtens wrote:
> This reverts commit 12e8fd6fd3802 ("lib/rhashtable.c: use kvzalloc()
> in
> bucket_table_alloc() when possible") from upstream kernel.
> Kernel versions older that 4.12 do not have kvzalloc() try to avoid
> the
> usage of this.

Can't we backport these? There was a patch from AceLan Kao to do so in
a pretty simple fashion, but that should still be better than a patch?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
