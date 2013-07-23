Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:43639 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933940Ab3GWXtt (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Jul 2013 19:49:49 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so6780649lbd.32
        for <backports@vger.kernel.org>; Tue, 23 Jul 2013 16:49:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374388784.8376.5.camel@jlt4.sipsolutions.net>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
 <1374272009-26152-3-git-send-email-mcgrof@do-not-panic.com> <1374388784.8376.5.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 23 Jul 2013 16:49:28 -0700
Message-ID: <CAB=NE6XnwY-JjHzYUsgp3qcVki33MbUyg9FgRvA6Lk5_DyafSA@mail.gmail.com> (sfid-20130724_014952_003601_E867E2CE)
Subject: Re: [PATCH v2 02/10] backport: backport sprintf-style workqueue naming
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jul 20, 2013 at 11:39 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2013-07-19 at 15:13 -0700, Luis R. Rodriguez wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Since kernel version 3.3, workqueue names could be
>> sprintf'ed instead of just pointing to a name. This
>> wasn't used a lot so never needed to be backported,
>> but now it's used everywhere. Backport this API.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> [mcgrof: add WQ_HIGHPRI and WQ_MEM_RECLAIM defines]
>
> Were they needed somehow? Thye shouldn't have been, since users of this
> don't usually use the flags directly?

There's not used but at compile time the flags arguments were kept, we
can surely nuke them if we #ifdef a call for older kernels.

> If they _are_ needed, then we probably need to do something different?
> My patch only backported "regular" and "ordered" workqueue, not the
> other flags, and I suspect the other flags can't actually be backported.

Indeed they can't, we just ignore them for older kernels, in fact
perhaps just using create_singlethread_workqueue(name) would suffice
for older kernels.

>> +#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,36)
>> +#define WQ_HIGHPRI 0
>> +#define WQ_MEM_RECLAIM 0
>>  #endif
>
> Ah, here. I think that would cause problems?

Not necessarily -- these are simply not usable / backportable on older
kernels. In part of my synch up of patches (see d7608058)  I nuked
patches/collateral-evolutions/network/46-use_other_workqueue/ which
used to backport alloc_workqueue() with
create_singlethread_workqueue() given older kernels do not support
WQ_HIGHPRI and WQ_MEM_RECLAIM. In your port you make use of
__create_workqueue_key() but that's available in older kernels as
well, its just the flags are kept in code, but they are not used per
se.

>> +static DEFINE_SPINLOCK(wq_name_lock);
>> +static struct list_head wq_name_list;
>
> FWIW, my patch was [RFC] for a reason, I hadn't tested it... Now that I
> did, I can tell you that this must be
>
> static LIST_HEAD(wq_name_list);
>
> to get the list properly initialised.

I'll add that. Sorry for jumping the gun here.

  Luis
