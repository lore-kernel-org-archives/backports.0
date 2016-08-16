Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39184 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751123AbcHPI33 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 16 Aug 2016 04:29:29 -0400
Message-ID: <1471336165.9777.559.camel@coelho.fi> (sfid-20160816_102932_576733_6DBBE9C9)
From: Luca Coelho <luca@coelho.fi>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org
Date: Tue, 16 Aug 2016 11:29:25 +0300
In-Reply-To: <1471000543-24994-1-git-send-email-luca@coelho.fi>
References: <1471000543-24994-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: use codel and fq headers from the kernel
 sources
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2016-08-12 at 14:15 +0300, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> We don't need to have a local copy of codel.h anymore, so it can be
> removed and copied from the kernel sources.  Additionally, it was
> split into 3 different headers, so copy the other 2 as well.
> 
> Also copy the fq header files, which are used by newer wireless
> subsystem versions, from the kernel sources.
> 
> Additionally, remove pkt_sched.h since it is not necessary anymore.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/linux/pkt_sched.h | 108 ---------
>  backport/backport-include/net/codel.h       | 350 ------------------
> ----------
>  copy-list                                   |   5 +
>  3 files changed, 5 insertions(+), 458 deletions(-)
>  delete mode 100644 backport/backport-include/linux/pkt_sched.h
>  delete mode 100644 backport/backport-include/net/codel.h

Unfortunately this patch doesn't help with < 4.2 kernels, due to
missing flow_dissector.c stuff, specifically skb_get_hash_perturb() and
all the new stuff it depends on... :(

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
