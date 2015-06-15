Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41768 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbbFOSUZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jun 2015 14:20:25 -0400
Message-ID: <557F1767.3040706@hauke-m.de> (sfid-20150615_202026_449620_3894E432)
Date: Mon, 15 Jun 2015 20:20:23 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 02/21] patches: deactivate tracing for ath6kl, cfg80211
 and wil6210 only on kernel < 3.4
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>	 <1434292162-2261-3-git-send-email-hauke@hauke-m.de>	 (sfid-20150614_162942_666968_4E02D0D5) <1434351759.2177.0.camel@sipsolutions.net>
In-Reply-To: <1434351759.2177.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/15/2015 09:02 AM, Johannes Berg wrote:
> On Sun, 2015-06-14 at 16:29 +0200, Hauke Mehrtens wrote:
>> On kernel version >= 3.4 we can normally include tracing, only on such
>> old kernel we have to deactivate the tracing code.
> 
> This is very annoying - why is this needed?
> 
> johannes
> 
Thanks for asking, I looked into this again and there is only an include
of linux/interrupt.h missing for these drivers. mt7601u needs it for
kernel < 3.4 and the others for kernel < 3.1.

I will send a new patch.

Hauke
