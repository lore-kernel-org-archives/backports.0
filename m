Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45019 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbaBJQzS (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 11:55:18 -0500
Message-ID: <52F90469.9070207@hauke-m.de> (sfid-20140210_175520_657907_19CAFC5E)
Date: Mon, 10 Feb 2014 17:55:05 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: mcgrof@do-not-panic.com, backports@vger.kernel.org,
	backports-owner@vger.kernel.org
Subject: Re: [PATCH 4/6] backports: update sch_fq_codel_core.c
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de> <1391867070-20031-5-git-send-email-hauke@hauke-m.de> (sfid-20140208_144450_603555_AE8C0E77) <fb08310d63963083bbe3ba8f98536def@sipsolutions.net>
In-Reply-To: <fb08310d63963083bbe3ba8f98536def@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/08/2014 11:08 PM, Johannes Berg wrote:
> On 2014-02-08 05:44, Hauke Mehrtens wrote:
>> This brings sch_fq_codel_core.c to the version used in kernel 3.14-rc1.
>> Most of the changes were done many kernel versions before 3.14-rc1, but
>> in kernel 3.14-rc1 net_random() was removed and not it does not even
>> compile any more.
> 
> I wonder if we should instead copy it while generating the backport?

Yes that should be possible and that is the better solution than
manually coping them.

Hauke
