Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:36438 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3GUGjq (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 21 Jul 2013 02:39:46 -0400
Message-ID: <1374388784.8376.5.camel@jlt4.sipsolutions.net> (sfid-20130721_083948_014543_10395CF0)
Subject: Re: [PATCH v2 02/10] backport: backport sprintf-style workqueue
 naming
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, jani.nikula@intel.com
Date: Sun, 21 Jul 2013 09:39:44 +0300
In-Reply-To: <1374272009-26152-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001420_265127_CD842305)
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
	 <1374272009-26152-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130720_001420_265127_CD842305)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-07-19 at 15:13 -0700, Luis R. Rodriguez wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since kernel version 3.3, workqueue names could be
> sprintf'ed instead of just pointing to a name. This
> wasn't used a lot so never needed to be backported,
> but now it's used everywhere. Backport this API.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [mcgrof: add WQ_HIGHPRI and WQ_MEM_RECLAIM defines]

Were they needed somehow? Thye shouldn't have been, since users of this
don't usually use the flags directly?

If they _are_ needed, then we probably need to do something different?
My patch only backported "regular" and "ordered" workqueue, not the
other flags, and I suspect the other flags can't actually be backported.

> +#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,36)
> +#define WQ_HIGHPRI 0
> +#define WQ_MEM_RECLAIM 0
>  #endif

Ah, here. I think that would cause problems?
 

> +static DEFINE_SPINLOCK(wq_name_lock);
> +static struct list_head wq_name_list;

FWIW, my patch was [RFC] for a reason, I hadn't tested it... Now that I
did, I can tell you that this must be

static LIST_HEAD(wq_name_list);

to get the list properly initialised.

johannes

