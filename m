Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56140 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbbHZCmM convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 25 Aug 2015 22:42:12 -0400
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: backport IFF_NO_QUEUE net_device flag
Date: Wed, 26 Aug 2015 02:42:08 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB32E855856@hasmsx107.ger.corp.intel.com> (sfid-20150826_044220_196881_E66D0EC1)
References: <1440531399-29379-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20150825_213646_779513_F10D303E)
 <1440540311.2376.0.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 08/26/2015 01:05 AM, Johannes Berg wrote:
> On Tue, 2015-08-25 at 22:36 +0300, Emmanuel Grumbach wrote:
>> commit fa8187c96471c49419c25d4ec3299d17d3f274b2
>> Author: Phil Sutter <phil@nwl.cc>
>> Date:   Thu Aug 13 19:01:06 2015 +0200
>>
>>     net: declare new net_device priv_flag IFF_NO_QUEUE
>>
>>     This private net_device flag can be set by drivers to inform that a
>>     device runs fine without a qdisc attached. This was formerly done by
>>     setting tx_queue_len to zero.
>>
>> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>> ---
>>  backport/backport-include/linux/netdevice.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/backport/backport-include/linux/netdevice.h 
>> b/backport/backport-include/linux/netdevice.h
>> index 95189be..94d8613 100644
>> --- a/backport/backport-include/linux/netdevice.h
>> +++ b/backport/backport-include/linux/netdevice.h
>> @@ -292,4 +292,9 @@ netdev_features_t passthru_features_check(struct 
>> sk_buff *skb,
>>  })
>>  #endif /* netdev_alloc_pcpu_stats */
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
>> +#ifndef IFF_NO_QUEUE
>> +#define IFF_NO_QUEUE 1<<26
>> +#endif
>>
> That doesn't really help, does it? Need to add a semantic patch to
> backport this with an ifdef to set the tx_queue_len to 0 in the older
> kernel case?
> 
You are most probably right. I had to admit I just checked that it
compiles and probably didn't take enough time to see what it really
does... :(
--
To unsubscribe from this list: send the line "unsubscribe backports" in
