Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9552 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbbIRNHA (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Sep 2015 09:07:00 -0400
Subject: Re: [PATCH RFC 2/2] add script to enable audio backport
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1442526437-22392-3-git-send-email-pierre-louis.bossart@linux.intel.com>
 (sfid-20150917_234743_628456_B160EAFA)
 <1442560633.2168.6.camel@sipsolutions.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55FC0C72.20806@linux.intel.com> (sfid-20150918_150702_483804_E104602D)
Date: Fri, 18 Sep 2015 08:06:58 -0500
MIME-Version: 1.0
In-Reply-To: <1442560633.2168.6.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 9/18/15 2:17 AM, Johannes Berg wrote:
> On Thu, 2015-09-17 at 16:47 -0500, Pierre-Louis Bossart wrote:
>> bash enable_audio.sh will add the required files in copylist
>> and patch some of the backport headers
>>
> I don't think this should be part of backports - the code modifications
> shouldn't be necessary, you can add everything to copy-list as it
> should be (and run with your own copy-list for just sound), and provide
> a defconfig file.
>
> Scripting really shouldn't be there I think.

I guess I misunderstood an earlier email where you wrote

"You can submit this part upstream btw - it'll just be disabled in the
default copy-list... unless you also submit that upstream"

If you are ok to take the patches and have the upstream copy-list 
include the sound files then yes the script is not necessary. I just 
wanted to have a first pass that isn't intrusive or breaks all the 
backports, but simple enough for others to try and test.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
