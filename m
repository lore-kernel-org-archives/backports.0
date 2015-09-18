Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9666 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbbIRNBA (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Sep 2015 09:01:00 -0400
Subject: Re: [PATCH RFC 1/2] Add required changes for audio packports
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1442526437-22392-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 (sfid-20150917_234741_112317_5CC135D1)
 <1442560549.2168.5.camel@sipsolutions.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55FC0AFD.9010409@linux.intel.com> (sfid-20150918_150102_463129_B097D83E)
Date: Fri, 18 Sep 2015 08:00:45 -0500
MIME-Version: 1.0
In-Reply-To: <1442560549.2168.5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks for the review.

On 9/18/15 2:15 AM, Johannes Berg wrote:
> On Thu, 2015-09-17 at 16:47 -0500, Pierre-Louis Bossart wrote:
>
>> +#if  LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>> +
>> +#define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
>> +
>> +#endif /* < 4.2 */
>
> Do we need parentheses around that all?

Yes, and this needs more love to use hr timers as well in the compat c 
code. this was just to get past the compilation.

>> --- a/backport/backport-include/linux/skbuff.h
>> +++ b/backport/backport-include/linux/skbuff.h
>> @@ -258,6 +258,8 @@ static inline struct page *dev_alloc_page(void)
>>   #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
>>
>>   #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
>> +
>> +#include <linux/uio.h>
>
> That's a bit odd? But perhaps necessary - just better to have the blank
> line after the include :)
>
>> --- /dev/null
>> +++ b/backport/backport-include/linux/uio.h
>> @@ -0,0 +1,246 @@
>> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
>> +#include_next <linux/uio.h>
>> +
>> +#ifndef __iter_is_iovec_h_
>> +#define __iter_is_iovec_h_
>
> Perhaps better to simply protect the whole file?
>
>> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0))
>> +
>> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
>> +
>> +/* iov_iter is defined elsewhere */
>> +#include_next <linux/fs.h>
>> +static inline bool iter_is_iovec(struct iov_iter *i)
>> +{
>> +	return true;
>> +}
>> +
>> +#else
>> +static inline bool iter_is_iovec(struct iov_iter *i)
>> +{
>> +	return !(i->type & (ITER_BVEC | ITER_KVEC));
>> +}
>> +#endif
>> +#endif
>
> That could be written a bit clearer with #elif, I think.
>
>> +#endif /* __iter_is_iovec_h_ */
>> +
>> +#else
>> +
>> +#ifndef _LINUX_UIO_H
>> +#define _LINUX_UIO_H
>>
>
> This part looks like a straight-up copy - perhaps better to add it to
> copy-list and then provide a patch to patch around it the necessary
> modifications - see for example the devcoredump patch in
> patches/backport-adjustments/devcoredump.patch

Ah this whole thing is a nightmare. The definitions moved between files, 
I kept having issues between uio.h, aio.h and fs.h and warnings/errors 
of the iovec/kuiocb structures being redefined. I'll look at the example 
mentioned.

>> --- a/dependencies
>> +++ b/dependencies
>> @@ -178,3 +178,5 @@ IGB 3.5
>>
>>   # This driver needs mmc_hw_reset() which was added in kernel version
>> 3.2
>>   MWIFIEX_SDIO 3.2
>> +
>> +SOUND 3.13
>> \ No newline at end of file
>
> Please keep a newline at EOF.

yep

>> ++static ssize_t snd_pcm_aio_read(struct kiocb *iocb, const struct
>> iovec *iov,
>> ++			     unsigned long nr_segs, loff_t pos)
>> ++
>
> Is it possible to reduce this function to calling the existing
> snd_pcm_readv (and aio_write to writev) by suitable data structure
> manipulation?
>
> If so, it might be possible to create an spatch to make these changes,
> which would make them apply more generally and be less prone to
> breaking.

This was a first-order ugly backport to revert to what existed before.
I have no idea what an spatch is, if there is an example of such a 
'suitable data structure manipulation' I am all ears.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
