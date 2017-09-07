Return-path: <backports-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbdIGCrC (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Sep 2017 22:47:02 -0400
Received: from mail-wr0-f199.google.com ([209.85.128.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1dpmqL-00088X-KG
        for backports@vger.kernel.org; Thu, 07 Sep 2017 02:47:01 +0000
Received: by mail-wr0-f199.google.com with SMTP id h16so845680wrf.0
        for <backports@vger.kernel.org>; Wed, 06 Sep 2017 19:47:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <060d0213-2a3a-9490-b121-39a55e773822@hauke-m.de>
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com> <060d0213-2a3a-9490-b121-39a55e773822@hauke-m.de>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 7 Sep 2017 10:47:00 +0800
Message-ID: <CAFv23QkS2L3K3jvMWHymRcH-dKxCxyyj6c4uDNfL_6eMcB=uPQ@mail.gmail.com> (sfid-20170907_044704_546641_6EDC8F65)
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Sorry, please ignore this patch.
I reverted it in my tree but forgot to send a note out.


2017-09-07 6:05 GMT+08:00 Hauke Mehrtens <hauke@hauke-m.de>:
> On 07/21/2017 08:55 AM, AceLan Kao wrote:
>> add some new kv[mz]alloc functions which introduced after v4.12
>> by this commit
>>
>> commit a7c3e901a46ff54c016d040847eda598a9e3e653
>> Author: Michal Hocko <mhocko@suse.com>
>> Date:   Mon May 8 15:57:09 2017 -0700
>>
>>     mm: introduce kv[mz]alloc helpers
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> ---
>>  backport/backport-include/linux/mm.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
>> index 3234b37..8125310 100644
>> --- a/backport/backport-include/linux/mm.h
>> +++ b/backport/backport-include/linux/mm.h
>> @@ -123,4 +123,20 @@ static inline bool page_is_pfmemalloc(struct page *page)
>>  }
>>  #endif /* < 4.2 */
>>
>> +#if LINUX_VERSION_IS_LESS(4,12,0)
>> +extern void *kvmalloc_node(size_t size, gfp_t flags, int node);
>
> Is kvmalloc_node() implemented somewhere? It was added in kernel 4.12
> and is not available in older mainline kernel versions.
>
>> +static inline void *kvmalloc(size_t size, gfp_t flags)
>> +{
>> +     return kvmalloc_node(size, flags, NUMA_NO_NODE);
>> +}
>> +static inline void *kvzalloc_node(size_t size, gfp_t flags, int node)
>> +{
>> +     return kvmalloc_node(size, flags | __GFP_ZERO, node);
>> +}
>> +static inline void *kvzalloc(size_t size, gfp_t flags)
>> +{
>> +     return kvmalloc(size, flags | __GFP_ZERO);
>> +}
>> +#endif /* < 4.12.0 */
>> +
>>  #endif /* __BACKPORT_MM_H */
>>
>
> Hauke
>
--
To unsubscribe from this list: send the line "unsubscribe backports" in
