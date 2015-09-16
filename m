Return-path: <backports-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43412 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbbIPOAv (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 16 Sep 2015 10:00:51 -0400
Subject: Re: parse-integer support
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
References: <55F8E3E9.9090901@linux.intel.com>
 (sfid-20150916_053717_657974_49EDAFEA)
 <1442383450.2280.2.camel@sipsolutions.net> <55F92480.50004@broadcom.com>
 <1442391470.2280.4.camel@sipsolutions.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55F97611.30809@linux.intel.com> (sfid-20150916_160055_791684_A5E5E589)
Date: Wed, 16 Sep 2015 09:00:49 -0500
MIME-Version: 1.0
In-Reply-To: <1442391470.2280.4.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 9/16/15 3:17 AM, Johannes Berg wrote:
> On Wed, 2015-09-16 at 10:12 +0200, Arend van Spriel wrote:
>>
>> Probably it is not in because it was tagged as crap and not merged
>
>
> Oh, that thing. I actually saw that but didn't remember it was called
> 'parse-integer' :)

It is part of next-20150818, include/linux/parse-integer.h
It's also used by quite a few drivers now...

--
To unsubscribe from this list: send the line "unsubscribe backports" in
