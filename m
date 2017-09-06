Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:50916 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbdIFWMk (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 18:12:40 -0400
Subject: Re: [PATCH 12/21] compat: avoid usage of kvzalloc() in rhashtable.c
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-13-hauke@hauke-m.de>
 <1504710345.23905.14.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <97c46ee3-1a5c-d3cc-21ba-8bd8a2a02ee7@hauke-m.de> (sfid-20170907_001340_817723_3990AC89)
Date: Thu, 7 Sep 2017 00:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <1504710345.23905.14.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/06/2017 05:05 PM, Johannes Berg wrote:
> On Tue, 2017-08-22 at 00:28 +0200, Hauke Mehrtens wrote:
>> This reverts commit 12e8fd6fd3802 ("lib/rhashtable.c: use kvzalloc()
>> in
>> bucket_table_alloc() when possible") from upstream kernel.
>> Kernel versions older that 4.12 do not have kvzalloc() try to avoid
>> the
>> usage of this.
> 
> Can't we backport these? There was a patch from AceLan Kao to do so in
> a pretty simple fashion, but that should still be better than a patch?
> 
> johannes

Hi,

I think AceLan Kao's patch misses the implementation of kvmalloc_node().
We can implement this for node == NUMA_NO_NODE by using __vmalloc()
instead of __vmalloc_node_flags_caller() which should be fine.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
