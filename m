Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47759 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab3KXTSG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 14:18:06 -0500
Message-ID: <529250E2.9000403@hauke-m.de> (sfid-20131124_201808_130539_83488536)
Date: Sun, 24 Nov 2013 20:17:54 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 3/3] backports: refresh on next-20131122
References: <1385299666-18712-1-git-send-email-hauke@hauke-m.de>	 <1385299666-18712-3-git-send-email-hauke@hauke-m.de>	 (sfid-20131124_142817_764648_78EE0130) <1385318202.23961.1.camel@jlt4.sipsolutions.net>
In-Reply-To: <1385318202.23961.1.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/24/2013 07:36 PM, Johannes Berg wrote:
> On Sun, 2013-11-24 at 14:27 +0100, Hauke Mehrtens wrote:
>> == ckmake-report.log ==
>>
>> 1   2.6.24              [  FAIL  ]
> 
> That was kinda expected, why are you even still trying? :)
> 
> johannes

Somehow the cron job installed kernel 2.6.24 again and I haven't removed
it. I know that it does not work, and I do not care.

Hauke
