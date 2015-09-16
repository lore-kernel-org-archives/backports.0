Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:36157 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbbIPIMx (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 16 Sep 2015 04:12:53 -0400
Message-ID: <55F92480.50004@broadcom.com> (sfid-20150916_101257_375846_E55877EB)
Date: Wed, 16 Sep 2015 10:12:48 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	<backports@vger.kernel.org>
Subject: Re: parse-integer support
References: <55F8E3E9.9090901@linux.intel.com>	 (sfid-20150916_053717_657974_49EDAFEA) <1442383450.2280.2.camel@sipsolutions.net>
In-Reply-To: <1442383450.2280.2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/16/2015 08:04 AM, Johannes Berg wrote:
> Hi,
>
>> I've progressed a bit in my endeavor to backport the sound drivers with
>> only a few compilation errors but I've reached a blocking point. The
>> audio drivers were converted to use parse_integer this summer but I
>> can't figure out how to back port this.
>
> Err, I can't even figure out what "parse_integer" is? Such a function
> doesn't exist in my kernel
>
>> If I add include/linux/parse-integer to copy-list then there are tons of
>> redeclations.
>
> Neither does a file called include/linux/parse-integer(.h)
>
> If you can point out what you really meant here then I'm sure this is
> easy to fix, but without looking at the code (which clearly I can't)
> there's not much I can do.

Probably it is not in because it was tagged as crap and not merged [1].

Regards,
Arend

[1] 
http://mid.gmane.org/CA+55aFxN7ebRPpayOQSznjJobz1UVQRQ5rMAKjxGvc3vW6fNYg@mail.gmail.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
