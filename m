Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39138 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaBHWIg (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 8 Feb 2014 17:08:36 -0500
To: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 4/6] backports: update =?UTF-8?Q?sch=5Ffq=5Fcodel=5Fco?=  =?UTF-8?Q?re=2Ec?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sat, 08 Feb 2014 14:08:27 -0800
From: Johannes Berg <johannes@sipsolutions.net>
Cc: mcgrof@do-not-panic.com, backports@vger.kernel.org,
	backports-owner@vger.kernel.org
In-Reply-To: <1391867070-20031-5-git-send-email-hauke@hauke-m.de>
 (sfid-20140208_144450_603555_AE8C0E77)
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
 <1391867070-20031-5-git-send-email-hauke@hauke-m.de>
 (sfid-20140208_144450_603555_AE8C0E77)
Message-ID: <fb08310d63963083bbe3ba8f98536def@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2014-02-08 05:44, Hauke Mehrtens wrote:
> This brings sch_fq_codel_core.c to the version used in kernel 3.14-rc1.
> Most of the changes were done many kernel versions before 3.14-rc1, but
> in kernel 3.14-rc1 net_random() was removed and not it does not even
> compile any more.

I wonder if we should instead copy it while generating the backport?

johannes
