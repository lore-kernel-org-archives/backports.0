Return-Path: <SRS0=hPYX=RW=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EBC43381
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 22:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989122085A
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCSWDE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:03:04 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:45824 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCSWDE (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 19 Mar 2019 18:03:04 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9DDC54D72C;
        Tue, 19 Mar 2019 23:03:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 6Pmi_KqtfXP1; Tue, 19 Mar 2019 23:02:51 +0100 (CET)
Subject: Re: [PATCH v3] backports: handle RHEL 7.6 kernel
To:     Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
References: <20190307074824.17022-1-luca@coelho.fi>
 <20190307075050.17248-1-luca@coelho.fi>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hauke@hauke-m.de; keydata=
 mQINBFtLdKcBEADFOTNUys8TnhpEdE5e1wO1vC+a62dPtuZgxYG83+9iVpsAyaSrCGGz5tmu
 BgkEMZVK9YogfMyVHFEcy0RqfO7gIYBYvFp0z32btJhjkjBm9hZ6eonjFnG9XmqDKg/aZI+u
 d9KGUh0DeaHT9FY96qdUsxIsdCodowf1eTNTJn+hdCudjLWjDf9FlBV0XKTN+ETY3pbPL2yi
 h8Uem7tC3pmU7oN7Z0OpKev5E2hLhhx+Lpcro4ikeclxdAg7g3XZWQLqfvKsjiOJsCWNXpy7
 hhru9PQE8oNFgSNzzx2tMouhmXIlzEX4xFnJghprn+8EA/sCaczhdna+LVjICHxTO36ytOv7
 L3q6xDxIkdF6vyeEtVm1OfRzfGSgKdrvxc+FRJjp3TIRPFqvYUADDPh5Az7xa1LRy3YcvKYx
 psDDKpJ8nCxNaYs6hqTbz4loHpv1hQLrPXFVpoFUApfvH/q7bb+eXVjRW1m2Ahvp7QipLEAK
 GbiV7uvALuIjnlVtfBZSxI+Xg7SBETxgK1YHxV7PhlzMdTIKY9GL0Rtl6CMir/zMFJkxTMeO
 1P8wzt+WOvpxF9TixOhUtmfv0X7ay93HWOdddAzov7eCKp4Ju1ZQj8QqROqsc/Ba87OH8cnG
 /QX9pHXpO9efHcZYIIwx1nquXnXyjJ/sMdS7jGiEOfGlp6N9IwARAQABtCFIYXVrZSBNZWhy
 dGVucyA8aGF1a2VAaGF1a2UtbS5kZT6JAk4EEwEIADgCGwEFCwkIBwIGFQgJCgsCBBYCAwEC
 HgECF4AWIQS4+/Pwq1ZO6E9/sdOT3SBjCRC1FQUCW0t9TwAKCRCT3SBjCRC1FRetEACWaCie
 dED+Y6Zps5IQE9jp1YCaqQAEC78sj4ALeU4kdZ35Obe99uyQ0q/vvPlnFigkp7yeBDP+wPHH
 c613/ONkaz+vXSItz5oHCt6o2QuelDX8cKCD4zexmiPfysJDwTcwmg8oPnfMqmob/97l1IoT
 nfkgWPYjfjjj2CUkXIJTYx13q6bHFYQ8FBur8PRWMt+xOlZI33HsQCMjc+akdA/ULclpauD6
 4nYL/a0kakUgv9wgZ0aET++VOpBPQQfvfzJJFKsBEWmZdtMql8XgyzTiIUu9oH3CqLNCgdB3
 vekYPw3ltV3MxvUtCCsZMzApidOyJnCc3BJElf3g7gV1W67NnqGm4U8Kj0uoG4MHh/Z0raqf
 rNVrbwKPVDeLkBgkdDud9TuTH35adTYPHQEGaof5zqOJk0jOZYC0D5TCKsGeRnCSR+WRYLLv
 ifNQhyaLmTGA1dw3FUgsKje7ydRP0ypMnOJpLYFRSgkum18C7eBfgk9KRqXFglIrh7h2bryU
 EyvR4r4gABi966uU2TnfGOZapDHbwgEK/2d7/ixL19B8vZlvBNQdpKa2yO9Eq/oeDV8vZzVr
 9DhwpBEcAw7XsaXAfvH3eMttiP6DJGVzju0bWUDu0Xqo4PhJlYm4rmo7bAl5EThAUttcUJz1
 ruS7ck6WznuFwqd3niYX080Sy2rltrkBDQRbS3sDAQgA4DtYzB73BUYxMaU2gbFTrPwXuDba
 +NgLpaF80PPXJXacdYoKklVyD23vTk5vw1AvMYe32Y16qgLkmr8+bS9KlLmpgNn5rMWzOqKr
 /N+m2DG7emWAg3kVjRRkJENs1aQZoUIFJFBxlVZ2OuUSYHvWujej11CLFkxQo9Efa35QAEei
 zEGtjhjEd4OUT5iPuxxr5yQ/7IB98oTT17UBs62bDIyiG8Dhus+tG8JZAvPvh9pMMAgcWf+B
 su4A00r+Xyojq06pnBMa748elV1Bo48Bg0pEVncFyQ9YSEiLtdgwnq6W8E00kATGVpN1fafv
 xGRLVPfQbfrKTiTkC210L7nv2wARAQABiQI2BBgBCAAgFiEEuPvz8KtWTuhPf7HTk90gYwkQ
 tRUFAltLewMCGwwACgkQk90gYwkQtRXUDw//ZlG04aPiPuRXcueSguNEdlvUoU7EQPeQt69+
 7gZwN+0+jH/F9vHn3h3O0UUF+HkaSjJqDTDNIHltaEOa4al/bpgCZHUjv6yq6Wdvjsuh6IXo
 XCptXEWKC8OPa5ZWRczIaGpTY4yEwkYi0wTMvFYIO1WPaaAqUWI7p63XqIoC5q0YB8ELYxwV
 WukezpUw+umxuvz/ksk0JHAsfXjTMnYHGYqOyu+5gdZcl7Hc+IpDnjeTu7jwMJTUWE/3umyM
 kTrnSx5l0/hZIo7IO5mciYibp9aAGhpGAemdLpOgFY8tQne/2kxgVP+Pgpzp82LOeVDSeHXj
 HRS8rhnU8Wu70fGC752LpwCzdsS53sURfofAeXEw8A6Cbcw1igEi21rOi3VIeCxwDonozVQM
 8hdBW5jfJmwn598P0MPESSx3Z1MQ3onuopNcnsr9Lu2t5bFN289n7AM9UVGvrloN/FKMyRzC
 lRVFsc1KRFwVaHNLYw8jlwTlR8tgZ4QNUYj0QDrof/ItdZZ0KcmmnSYKACjqwbKuiCUanaVJ
 DibyTrQmi0vwz/0PyIAWsaF4pQZ78dRwA0B/jEewY3RDA1BOy35dn9gG+qr0fbkYY9YZYFik
 1p/PYOBFn0a/8tFp8ePsZGQAuLdAANcJdoiyeGUejktsWHOww4CwVJvdgxeNK7tyI3azmoK5
 AQ0EW0t7cQEIAOZqnCTnoFeTFoJU2mHdEMAhsfh7X4wTPFRy48O70y4PFDgingwETq8njvAB
 MDGjN++00F8cZ45HNNB5eUKDcW9bBmxrtCK+F0yPu5fy+0M4Ntow3PyHMNItOWIKd//EazOK
 iuHarhc6f1OgErMShe/9rTmlToqxwVmfnHi1aK6wvVbTiNgGyt+2FgA6BQIoChkPGNQ6pgV5
 QlCEWvxbeyiobOSAx1dirsfogJwcTvsCU/QaTufAI9QO8dne6SKsp5z58yigWPwDnOF/LvQ2
 6eDrYHjnk7kVuBVIWjKlpiAQ00hfLU7vwQH0oncfB5HT/fL1b2461hmwXxeV+jEzQkkAEQEA
 AYkDbAQYAQgAIBYhBLj78/CrVk7oT3+x05PdIGMJELUVBQJbS3txAhsCAUAJEJPdIGMJELUV
 wHQgBBkBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAltLe3EACgkQ8bdnhZyy68d1Wgf8
 Dabx9vKo1usbgDHl4LZzrJhfRm2I3+J5FTboLJsFe8jpRNcf6eGJpGLeW3s/wqWd8cYsLtbz
 Ja1znoz3EwPhHaIHmwXw4TgYm+NVu2Cm9dg2aLNQj8haNfOPhIGqr5unvhnlwrbG+Yjl0er2
 sAdB5zXlIx8hIjHofMJIoW4yB79T4eZseFyrwA+OeI6pJTgQ1daXlOph26ZGulMy++pviIP/
 Ab57PJ81/DTSPWXqmEe72nLW5jWKXeHbTMaH9KVNdxJCIl8ZZgq4zN2msnpliJ+EoNVgGOgK
 iRckeGlkWtcezQ0Ir5yBaABkVVZCSydYfETSJ7TrFwY1wQwyCFcL78I7D/9UA3T1GJebF9QG
 zorfw1AcWZrEbv2kr01mTdmcw65Kd6BN8GpwPcmMYNlYQvUCFsOmoA9Hif292fUY1l1s0aYV
 yBFwaZNbkcniXY80X0jIEmmVaJci/PNrp5GRg3W4x7DXFsUKi2yUCXk5Y7YCDce2cJhqA+mQ
 +nqDEvjoLvoJFUaCDIvC+BBP9DgjrJ1s/rYASYitSsnkoNmArt2umAJ8VOY+7Q2SsVflzuXK
 nmjnHkXRuh8srxyzck/a9EombaSvfRpV2K0nmB8qdXNxKWtWT0N/7KbOlPkqkZKBAZSgTXBE
 Lqhmi7SgUDc4F8nEwR3RnjZRsel8flyQoIr5qp2KWJ4buK9c5OijYRhvN8jFpw/s7z7mM9N3
 PnHQqyOcIK1j6lqMQjC/kmRKpN+0TraMz8lX8TI9dNty/XFuVt9Y9Yv1vfSFHZEYqWQfRFAY
 SIA/ovBb7CRBo8Sd4nbLk7z+7Q/tO1Zy/XS+UGpwgBtQyf0WTC2WDSK/gmTwFhWva4+19KGu
 qW4TeDaiKtaki/NrHwCH3aOWx0xrxj4Vr2qVEO9Qksk+4RZt2QLX9PClmDDZR/KgnAGIVaHc
 w6Onn02ka7+V9c8DcJjQpD6IysI0r4U0LCUMddtwqaDk/0LR8M3+LhQ70+kWRCAY0QCZa5pC
 U9K2P2+nz7is4sF1hNVarw==
Message-ID: <61d1300a-a37b-a6b4-1ed3-81c590116d5e@hauke-m.de>
Date:   Tue, 19 Mar 2019 23:02:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190307075050.17248-1-luca@coelho.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 3/7/19 8:50 AM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> RHEL 7.6 uses kernel v3.10 with a lot of backports from newer
> kernels.  This causes compilation to break in many places when the
> backports project is used.  To solve the issue, check for RHEL release
> code 7.6 where appropriate.  This doesn't take into consideration
> lower versions of the kernel (i.e. < 7.6), because it's very difficult
> to find the information about when each feature was backported.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
> 
> In v2:
> 
>    * Fix some linking issues;
>    * Fix some duplicate symbols due to backporting stuff that was
>      already in RHEL's kernel;
> 
> In v3:
> 
>    * Remove gerrit tag.
> 
> 
> .../backport-include/linux/bp-devcoredump.h   |   3 +-
>  backport/backport-include/linux/etherdevice.h |   6 +-
>  backport/backport-include/linux/firmware.h    |   6 +-
>  .../backport-include/linux/ftrace_event.h     |   3 +-
>  backport/backport-include/linux/jiffies.h     |   5 +
>  backport/backport-include/linux/kernel.h      |   3 +-
>  backport/backport-include/linux/ktime.h       |   3 +-
>  backport/backport-include/linux/mm.h          |  55 ++++++
>  backport/backport-include/linux/moduleparam.h |   3 +-
>  backport/backport-include/linux/netdevice.h   |  12 +-
>  backport/backport-include/linux/netlink.h     |   3 +-
>  backport/backport-include/linux/page_ref.h    |   3 +-
>  backport/backport-include/linux/pci.h         |   3 +-
>  backport/backport-include/linux/percpu.h      |   3 +-
>  backport/backport-include/linux/pm_runtime.h  |   3 +-
>  backport/backport-include/linux/property.h    |   3 +-
>  backport/backport-include/linux/rtnetlink.h   |   3 +-
>  backport/backport-include/linux/skbuff.h      |   6 +-
>  backport/backport-include/linux/string.h      |   3 +-
>  backport/backport-include/linux/time.h        |   6 +
>  backport/backport-include/linux/time64.h      |   3 +-
>  backport/backport-include/linux/timekeeping.h |  15 +-
>  .../backport-include/linux/u64_stats_sync.h   |   3 +-
>  backport/backport-include/linux/uuid.h        |   3 +-
>  backport/backport-include/linux/wait.h        |   6 +-
>  backport/backport-include/net/genetlink.h     |   6 +-
>  backport/backport-include/net/inet_frag.h     |   6 +-
>  backport/backport-include/net/iw_handler.h    |   3 +-
>  backport/backport-include/net/net_namespace.h |   3 +-
>  backport/backport-include/net/netlink.h       |   6 +-
>  backport/compat/backport-3.11.c               |   2 +
>  backport/compat/backport-3.13.c               |   3 +-
>  backport/compat/backport-3.17.c               |   7 +-
>  backport/compat/backport-3.19.c               |   5 +-
>  backport/compat/backport-4.0.c                | 184 +++++++++++++++++-
>  backport/compat/backport-4.1.c                |   2 +
>  backport/compat/backport-4.2.c                |   4 +-
>  backport/compat/backport-4.4.c                |   3 +-
>  backport/compat/backport-4.6.c                |   4 +-
>  backport/compat/backport-4.7.c                |   3 +-
>  backport/compat/backport-genetlink.c          |   6 +-
>  patches/0028-select_queue/mac80211.patch      |  10 +-
>  patches/0073-netdevice-mtu-range.cocci        |   4 +-
>  patches/0075-ndo-stats-64.cocci               |   4 +-
>  44 files changed, 371 insertions(+), 59 deletions(-)
> 

.......

> diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
> index bbadcc8cd27e..caef7db30004 100644
> --- a/backport/backport-include/linux/jiffies.h
> +++ b/backport/backport-include/linux/jiffies.h
> @@ -1,5 +1,10 @@
>  #ifndef __BACKPORT_LNIUX_JIFFIES_H
>  #define __BACKPORT_LNIUX_JIFFIES_H
> +
> +#ifndef NSEC_PER_SEC
> +#define NSEC_PER_SEC	1000000000L
> +#endif

This is strange, why is this only needed on RHEL?

.....

> diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
> index b28156d33625..0806f4df8f5d 100644
> --- a/backport/backport-include/linux/mm.h
> +++ b/backport/backport-include/linux/mm.h
> @@ -12,6 +12,61 @@
>  void kvfree(const void *addr);
>  #endif /* < 3.15 */
>  
> +#if LINUX_VERSION_IS_LESS(3,20,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
> +long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +		    int write, int force, struct page **pages, int *locked);
> +#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
> +long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> +		    int write, int force, struct page **pages);
> +#elif LINUX_VERSION_IS_LESS(4,6,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +static inline
> +long backport_get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +		    int write, int force, struct page **pages, int *locked)
> +{
> +	return get_user_pages_locked(current, current->mm, start, nr_pages,
> +		    write, force, pages, locked);
> +}
> +#define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
> +
> +static inline
> +long backport_get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> +				      int write, int force, struct page **pages)
> +{
> +	return get_user_pages_unlocked(current, current->mm, start,  nr_pages,
> +		    write, force, pages);
> +}
> +#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
> +#endif
> +
> +#if LINUX_VERSION_IS_LESS(4,6,0)
> +static inline
> +long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
> +			    int write, int force, struct page **pages,
> +			    struct vm_area_struct **vmas)
> +{
> +	return get_user_pages(current, current->mm, start,  nr_pages,
> +		    write, force, pages, vmas);
> +}
> +#define get_user_pages LINUX_BACKPORT(get_user_pages)
> +#endif
> +
> +#ifndef FOLL_TRIED
> +#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
> +#endif
> +
> +#if LINUX_VERSION_IS_LESS(4,1,9) && \
> +     LINUX_VERSION_IS_GEQ(3,6,0) && \
> +	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> +#define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
> +static inline bool page_is_pfmemalloc(struct page *page)
> +{
> +	return page->pfmemalloc;
> +}
> +#endif /* < 4.2 */
> +

I think these functions are not used anywhere, they wrere added for the
media backports. I had some compile problems here and just removed them.


> diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
> index 84a4c6bf27b7..0439bfa32abd 100644
> --- a/backport/compat/backport-4.0.c
> +++ b/backport/compat/backport-4.0.c
> @@ -17,6 +17,185 @@
>  #include <linux/trace_seq.h>
>  #include <asm/unaligned.h>
>  
> +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> + static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
> +						struct mm_struct *mm,
> +						unsigned long start,
> +						unsigned long nr_pages,
> +						int write, int force,
> +						struct page **pages,
> +						struct vm_area_struct **vmas,
> +						int *locked, bool notify_drop,
> +						unsigned int flags)
> +{
> +	long ret, pages_done;
> +	bool lock_dropped;
> +
> +	if (locked) {
> +		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
> +		BUG_ON(vmas);
> +		/* check caller initialized locked */
> +		BUG_ON(*locked != 1);
> +	}
> +
> +	if (pages)
> +		flags |= FOLL_GET;
> +	if (write)
> +		flags |= FOLL_WRITE;
> +	if (force)
> +		flags |= FOLL_FORCE;
> +
> +	pages_done = 0;
> +	lock_dropped = false;
> +	for (;;) {
> +		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
> +				       vmas, locked);
> +		if (!locked)
> +			/* VM_FAULT_RETRY couldn't trigger, bypass */
> +			return ret;
> +
> +		/* VM_FAULT_RETRY cannot return errors */
> +		if (!*locked) {
> +			BUG_ON(ret < 0);
> +			BUG_ON(ret >= nr_pages);
> +		}
> +
> +		if (!pages)
> +			/* If it's a prefault don't insist harder */
> +			return ret;
> +
> +		if (ret > 0) {
> +			nr_pages -= ret;
> +			pages_done += ret;
> +			if (!nr_pages)
> +				break;
> +		}
> +		if (*locked) {
> +			/* VM_FAULT_RETRY didn't trigger */
> +			if (!pages_done)
> +				pages_done = ret;
> +			break;
> +		}
> +		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
> +		pages += ret;
> +		start += ret << PAGE_SHIFT;
> +
> +		/*
> +		 * Repeat on the address that fired VM_FAULT_RETRY
> +		 * without FAULT_FLAG_ALLOW_RETRY but with
> +		 * FAULT_FLAG_TRIED.
> +		 */
> +		*locked = 1;
> +		lock_dropped = true;
> +		down_read(&mm->mmap_sem);
> +		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> +				       pages, NULL, NULL);
> +		if (ret != 1) {
> +			BUG_ON(ret > 1);
> +			if (!pages_done)
> +				pages_done = ret;
> +			break;
> +		}
> +		nr_pages--;
> +		pages_done++;
> +		if (!nr_pages)
> +			break;
> +		pages++;
> +		start += PAGE_SIZE;
> +	}
> +	if (notify_drop && lock_dropped && *locked) {
> +		/*
> +		 * We must let the caller know we temporarily dropped the lock
> +		 * and so the critical section protected by it was lost.
> +		 */
> +		up_read(&mm->mmap_sem);
> +		*locked = 0;
> +	}
> +	return pages_done;
> +}
> +
> +/*
> + * We can leverage the VM_FAULT_RETRY functionality in the page fault
> + * paths better by using either get_user_pages_locked() or
> + * get_user_pages_unlocked().
> + *
> + * get_user_pages_locked() is suitable to replace the form:
> + *
> + *      down_read(&mm->mmap_sem);
> + *      do_something()
> + *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      up_read(&mm->mmap_sem);
> + *
> + *  to:
> + *
> + *      int locked = 1;
> + *      down_read(&mm->mmap_sem);
> + *      do_something()
> + *      get_user_pages_locked(tsk, mm, ..., pages, &locked);
> + *      if (locked)
> + *          up_read(&mm->mmap_sem);
> + */
> +long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> +			   int write, int force, struct page **pages,
> +			   int *locked)
> +{
> +	return __get_user_pages_locked(current, current->mm, start, nr_pages,
> +				       write, force, pages, NULL, locked, true,
> +				       FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL_GPL(get_user_pages_locked);
> +
> +/*
> + * Same as get_user_pages_unlocked(...., FOLL_TOUCH) but it allows to
> + * pass additional gup_flags as last parameter (like FOLL_HWPOISON).
> + *
> + * NOTE: here FOLL_TOUCH is not set implicitly and must be set by the
> + * caller if required (just like with __get_user_pages). "FOLL_GET",
> + * "FOLL_WRITE" and "FOLL_FORCE" are set implicitly as needed
> + * according to the parameters "pages", "write", "force"
> + * respectively.
> + */
> +static __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
> +					       unsigned long start, unsigned long nr_pages,
> +					       int write, int force, struct page **pages,
> +					       unsigned int gup_flags)
> +{
> +	long ret;
> +	int locked = 1;
> +	down_read(&mm->mmap_sem);
> +	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, write, force,
> +				      pages, NULL, &locked, false, gup_flags);
> +	if (locked)
> +		up_read(&mm->mmap_sem);
> +	return ret;
> +}
> +
> +/*
> + * get_user_pages_unlocked() is suitable to replace the form:
> + *
> + *      down_read(&mm->mmap_sem);
> + *      get_user_pages(tsk, mm, ..., pages, NULL);
> + *      up_read(&mm->mmap_sem);
> + *
> + *  with:
> + *
> + *      get_user_pages_unlocked(tsk, mm, ..., pages);
> + *
> + * It is functionally equivalent to get_user_pages_fast so
> + * get_user_pages_fast should be used instead, if the two parameters
> + * "tsk" and "mm" are respectively equal to current and current->mm,
> + * or if "force" shall be set to 1 (get_user_pages_fast misses the
> + * "force" parameter).
> + */
> +long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
> +			     int write, int force, struct page **pages)
> +{
> +	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
> +					 write, force, pages, FOLL_TOUCH);
> +}
> +EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
> +#endif
> +
>  /**
>   * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
>   * @buf: data blob to dump

I think this also not needed.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
