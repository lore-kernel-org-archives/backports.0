Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62769 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162121Ab3DERVN (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 13:21:13 -0400
Message-ID: <515F0801.7020507@linux.intel.com> (sfid-20130405_192116_443453_E71D25D0)
Date: Fri, 05 Apr 2013 19:21:05 +0200
From: Thierry Escande <thierry.escande@linux.intel.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v2 2/5] backports: Add NFC core and drivers
References: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com>  (sfid-20130405_171658_345140_E6DC5D9A) <1365176113.8515.33.camel@jlt4.sipsolutions.net>
In-Reply-To: <1365176113.8515.33.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/05/2013 05:35 PM, Johannes Berg wrote:
>> +# NFC core needs PF_NFC defined in socket.h which was
>> +# only introduced in kernel 3.1
>> +NFC 3.1
> 
> Just PF_NFC could be defined in compat, no?

That's right for compilation but sock_register for PF_NFC will fail and the module won't load.

 Thierry

