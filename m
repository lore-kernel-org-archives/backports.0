Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38077 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbdIFWOi (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 18:14:38 -0400
Subject: Re: [PATCH 21/21] copy-list: add quantenna qtnfmac driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-22-hauke@hauke-m.de>
 <1504710640.23905.16.camel@sipsolutions.net>
 <1504710827.23905.18.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <b52519bd-9b30-fa75-e4a5-58364eb44fe5@hauke-m.de> (sfid-20170907_001440_248717_D992820E)
Date: Thu, 7 Sep 2017 00:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <1504710827.23905.18.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/06/2017 05:13 PM, Johannes Berg wrote:
> On Wed, 2017-09-06 at 17:10 +0200, Johannes Berg wrote:
>>
>> And finally 19, it seems like we should be able to just add something
>> like
>>
>> config BPAUTO_REFCOUNT
>> 	def_bool y
>> 	#h-file linux/refcount.h
> 
> And perhaps that also needs
> 	#c-file lib/refcount.c
> 
> but even that seems reasonably self-contained?
> 
> johannes

I will try this. Currently the drivers are only using the header file
implementation.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
