Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35286 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbbETPae (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 May 2015 11:30:34 -0400
Received: by oign205 with SMTP id n205so38783748oig.2
        for <backports@vger.kernel.org>; Wed, 20 May 2015 08:30:34 -0700 (PDT)
Message-ID: <555CA897.4010606@lwfinger.net> (sfid-20150520_173041_428688_BF5D2835)
Date: Wed, 20 May 2015 10:30:31 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>	 (sfid-20150519_154230_230935_983C6CAB) <1432110463.2174.2.camel@sipsolutions.net>	 <1432110664.5612.6.camel@intel.com>	 <1432110893.2174.3.camel@sipsolutions.net> <1432111194.8314.1.camel@intel.com>
In-Reply-To: <1432111194.8314.1.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/20/2015 03:39 AM, Grumbach, Emmanuel wrote:
> On Wed, 2015-05-20 at 10:34 +0200, Johannes Berg wrote:
>> On Wed, 2015-05-20 at 08:31 +0000, Grumbach, Emmanuel wrote:
>>> On Wed, 2015-05-20 at 10:27 +0200, Johannes Berg wrote:
>>>> On Tue, 2015-05-19 at 16:42 +0300, Emmanuel Grumbach wrote:
>>>>
>>>>> +#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)
>>>>
>>>> Now that I look at this again, I'm confused - shouldn't this whole thing
>>>> have a ! in front?
>>>>
>>>
>>> why?
>>> I need this definition only for Ubuntu releases that are below 24.
>>> Canonical ported that starting 24.
>>> What am I missing?
>>
>> But every mainline kernel, say 3.10, also needs it. Also Ubuntu with
>> 3.10, for example.
>>
>
> You are right obviously.

What happens if the user is not running a Ubuntu kernel and 
UTS_UBUNTU_RELEASE_ABI is undefined?

I am really pissed off about Ubuntu's backporting API changes so that testing 
LINUX_VERSION_CODE is no longer sufficient. In fact when someone complains the 
one of the out-of-kernel drivers that I maintain does not build with kernel X.Y, 
I check that version out in mainline, build the driver to make sure the problem 
is not mine, and then tell them to complain to their vendor. I no longer fix 
those problems. I think RHEL is also doing the same kind of thing - at least I 
did get one complaint about a build problem that seemed to be due to an API 
backport. Where do we stop?

Larry




