Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60728 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdIHJZE (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 05:25:04 -0400
Message-ID: <1504862702.6177.17.camel@sipsolutions.net> (sfid-20170908_112506_348214_CF96B659)
Subject: Re: [PATCH 12/21] compat: avoid usage of kvzalloc() in rhashtable.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Date: Fri, 08 Sep 2017 11:25:02 +0200
In-Reply-To: <97c46ee3-1a5c-d3cc-21ba-8bd8a2a02ee7@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-13-hauke@hauke-m.de>
         <1504710345.23905.14.camel@sipsolutions.net>
         <97c46ee3-1a5c-d3cc-21ba-8bd8a2a02ee7@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-09-07 at 00:12 +0200, Hauke Mehrtens wrote:
> On 09/06/2017 05:05 PM, Johannes Berg wrote:
> > On Tue, 2017-08-22 at 00:28 +0200, Hauke Mehrtens wrote:
> > > This reverts commit 12e8fd6fd3802 ("lib/rhashtable.c: use
> > > kvzalloc()
> > > in
> > > bucket_table_alloc() when possible") from upstream kernel.
> > > Kernel versions older that 4.12 do not have kvzalloc() try to
> > > avoid
> > > the
> > > usage of this.
> > 
> > Can't we backport these? There was a patch from AceLan Kao to do so
> > in
> > a pretty simple fashion, but that should still be better than a
> > patch?
> > 
> > johannes
> 
> Hi,
> 
> I think AceLan Kao's patch misses the implementation of
> kvmalloc_node().
> We can implement this for node == NUMA_NO_NODE by using __vmalloc()
> instead of __vmalloc_node_flags_caller() which should be fine.

Sounds reasonable to me.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
