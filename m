Return-path: <backports-owner@vger.kernel.org>
Received: from mail.sablalik.us ([74.111.177.26]:62207 "EHLO mail.sablalik.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbbD3NRr convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 Apr 2015 09:17:47 -0400
Date: Thu, 30 Apr 2015 09:17:42 -0400
Subject: Re: trouble building ath10k on newer versions
From: Peter Sabat <pete@sablalik.us>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <backports@vger.kernel.org>
Message-ID: <D167A39A.1821B0%pete@sablalik.us> (sfid-20150430_151749_353557_F62F38D6)
References: <D166E367.18190A%pete@sablalik.us>
 <1430377731.1963.0.camel@sipsolutions.net>
In-Reply-To: <1430377731.1963.0.camel@sipsolutions.net>
Mime-version: 1.0
Content-type: text/plain;
	charset="EUC-KR"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

That would explain it.  ;-)

Cheers

On 4/30/15, 3:08 AM, "Johannes Berg" <johannes@sipsolutions.net> wrote:

>On Wed, 2015-04-29 at 19:37 -0400, Peter Sabat wrote:
>> Just wondering if something has changed since backports-20150129 that
>> would only allow compat and cfg80211 build ?
>> 
>> I noticed that mac80211 isn©öt in the menuconfig now, but the build
>>worked
>> fine before.
>> 
>> 
>> 
>> I do have CONFIG_CRYPTO_CCM in my kernel config :
>
>You also need _GCM now.
>
>johannes
>



