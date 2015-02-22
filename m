Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58792 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbbBVCFD (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 21:05:03 -0500
Message-ID: <54E9394D.1030104@hauke-m.de> (sfid-20150222_030506_138332_1C16DAF3)
Date: Sun, 22 Feb 2015 03:05:01 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH V2] patches: genl-const: fix nl80211.patch
References: <1421352942-21625-1-git-send-email-arend@broadcom.com>	 (sfid-20150115_211552_467265_F71FCF92) <1421406483.9214.5.camel@sipsolutions.net>
In-Reply-To: <1421406483.9214.5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/16/2015 12:08 PM, Johannes Berg wrote:
> On Thu, 2015-01-15 at 21:15 +0100, Arend van Spriel wrote:
>> nl80211.c recently changed using defined strings instead of hard-coded in
>> multi-cast group definitions:
>>
>>   commit 71b836eca7f380fbd4c025f8c4371f9a071bc909
>>   Author: Johannes Berg <johannes.berg@intel.com>
>>   Date:   Tue Dec 23 17:17:38 2014 +0100
>>
>>       nl80211: define multicast group names in header
>>
>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> 
> Thanks Arend!
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> johannes
Thank you for the patch, it was applied to backports.

Hauke

