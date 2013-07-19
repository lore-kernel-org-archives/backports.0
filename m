Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35156 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760278Ab3GSL4F (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 07:56:05 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so3289605lab.8
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 04:56:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E5A066.8070009@hauke-m.de>
References: <1373979477-11133-1-git-send-email-johannes@sipsolutions.net> <51E5A066.8070009@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Fri, 19 Jul 2013 04:55:44 -0700
Message-ID: <CAB=NE6XRSYq=_H-h63+A_KfQnt7WnoZeZrq=6tz-zBfjnT-KKQ@mail.gmail.com> (sfid-20130719_135631_796082_3B521B65)
Subject: Re: [RFC/RFT] backport: backport sprintf-style workqueue naming
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jul 16, 2013 at 12:35 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 07/16/2013 02:57 PM, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Since kernel version 3.3, workqueue names could be
>> sprintf'ed instead of just pointing to a name. This
>> wasn't used a lot so never needed to be backported,
>> but now it's used everywhere. Backport this API.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> ---
>>  backport/backport-include/linux/workqueue.h | 47 ++++++++++++++++----
>>  backport/compat/compat-3.3.c                | 69 +++++++++++++++++++++++++++++
>>  2 files changed, 108 insertions(+), 8 deletions(-)
>>
>> diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
>> index 9958715..54c9090 100644
>> --- a/backport/backport-include/linux/workqueue.h
>> +++ b/backport/backport-include/linux/workqueue.h
>> @@ -14,16 +14,47 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
>>  #define create_freezable_workqueue create_freezeable_workqueue
>>  #endif
>>
>> -#ifndef alloc_ordered_workqueue
>> -#define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
>
> Why not do a check for #ifndef WQ_UNBOUND that way we do not get that
> many problems when someone tries a kernel that already backported this.

Not sure I understood this. I tried though.

>> +#define WQ_UNBOUND   0
>>  #endif
>> -
>> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
>> -#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active)
>> +#define __WQ_ORDERED 0
>> +/*
>> + * commit b196be89cdc14a88cc637cdad845a75c5886c82d
>> + * Author: Tejun Heo <tj@kernel.org>
>> + * Date:   Tue Jan 10 15:11:35 2012 -0800
>> + *
>> + *     workqueue: make alloc_workqueue() take printf fmt and args for name
>> + */
>> +struct workqueue_struct *
>> +backport_alloc_workqueue(const char *fmt, unsigned int flags,
>> +                      int max_active, struct lock_class_key *key,
>> +                      const char *lock_name, ...);
>> +#undef alloc_workqueue
>> +#ifdef CONFIG_LOCKDEP
>> +#define alloc_workqueue(fmt, flags, max_active, args...)             \
>> +({                                                                   \
>> +     static struct lock_class_key __key;                             \
>> +     const char *__lock_name;                                        \
>> +                                                                     \
>> +     if (__builtin_constant_p(fmt))                                  \
>> +             __lock_name = (fmt);                                    \
>> +     else                                                            \
>> +             __lock_name = #fmt;                                     \
>> +                                                                     \
>> +     backport_alloc_workqueue((fmt), (flags), (max_active),          \
>> +                              &__key, __lock_name, ##args);          \
>> +})

BTW I believe using (perens)(like)(this) seems to help avoid
re-dup'ing the define effect see my last patch. Not sure if that helps
here.

>> +#else
>> +#define alloc_workqueue(fmt, flags, max_active, args...)             \
>> +     backport_alloc_workqueue((fmt), (flags), (max_active),          \
>> +                              NULL, NULL, ##args)
>>  #endif
>> -
>> -#ifndef alloc_workqueue
>> -#define alloc_workqueue(name, flags, max_active) __create_workqueue(name, flags, max_active, 0)
>> +#undef alloc_ordered_workqueue
>> +#define alloc_ordered_workqueue(fmt, flags, args...) \
>> +     alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
>> +#define destroy_workqueue backport_destroy_workqueue
>
> The #undef destroy_workqueue in compat-3.3.c does not look nice to me.
>
> What about this and then call orig_destroy_workqueue(wq)?
>
> static inline void orig_destroy_workqueue(struct workqueue_struct *wq)
> {
>         destroy_workqueue(wq);
> }
> #define destroy_workqueue(wq) backport_destroy_workqueue(wq)

I didn't get this either :(

>> +void backport_destroy_workqueue(struct workqueue_struct *wq);
>>  #endif
>>
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
>> diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
>> index a44f59d..d86b40e 100644
>> --- a/backport/compat/compat-3.3.c
>> +++ b/backport/compat/compat-3.3.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/version.h>
>>  #include <linux/skbuff.h>
>>  #include <linux/module.h>
>> +#include <linux/workqueue.h>
>>  #include <net/dst.h>
>>  #include <net/xfrm.h>
>>
>> @@ -171,3 +172,71 @@ out:
>>       return n;
>>  }
>>  EXPORT_SYMBOL_GPL(__pskb_copy);
>> +
>> +static DEFINE_SPINLOCK(wq_name_lock);
>> +static struct list_head wq_name_list;
>> +
>> +struct wq_name {
>> +     struct list_head list;
>> +     struct workqueue_struct *wq;
>> +     char name[24];
>> +};
>> +

Do we really need this on the backport?

>> +struct workqueue_struct *
>> +backport_alloc_workqueue(const char *fmt, unsigned int flags,
>> +                      int max_active, struct lock_class_key *key,
>> +                      const char *lock_name, ...)
>> +{
>> +     struct workqueue_struct *wq;
>> +     struct wq_name *n = kzalloc(sizeof(*n), GFP_KERNEL);
>> +     va_list args;
>> +
>> +     if (!n)
>> +             return NULL;
>> +
>> +     va_start(args, lock_name);
>> +     vsnprintf(n->name, sizeof(n->name), fmt, args);
>> +     va_end(args);
>> +
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
>> +     wq = __create_workqueue_key(n->name, max_active == 1, 0,
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)
>> +                                 0,
>> +#endif
>> +                                 key, lock_name);
>> +#else
>> +     wq = __alloc_workqueue_key(n->name, flags, max_active, key, lock_name);
>> +#endif
>> +     if (!wq) {
>> +             kfree(n);
>> +             return NULL;
>> +     }
>> +
>> +     n->wq = wq;
>> +     spin_lock(&wq_name_lock);
>> +     list_add(&n->list, &wq_name_list);
>> +     spin_unlock(&wq_name_lock);
>> +
>> +     return wq;
>> +}
>> +EXPORT_SYMBOL_GPL(backport_alloc_workqueue);
>> +
>> +void backport_destroy_workqueue(struct workqueue_struct *wq)
>> +{
>> +     struct wq_name *n, *tmp;
>> +
>> +     /* call original */
>> +#undef destroy_workqueue
>> +     destroy_workqueue(wq);
>> +
>> +     spin_lock(&wq_name_lock);
>> +     list_for_each_entry_safe(n, tmp, &wq_name_list, list) {
>> +             if (n->wq == wq) {
>> +                     list_del(&n->list);
>> +                     kfree(n);
>> +                     break;
>> +             }
>> +     }
>> +     spin_unlock(&wq_name_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(backport_destroy_workqueue);

For now I'm using a slightly modified version of this to get passed
through some linux-next tags, sorry I've been caught up. I'll post
what I have just now.

  Luis
