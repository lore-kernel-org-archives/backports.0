Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:59490 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbbDUGgm (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Apr 2015 02:36:42 -0400
Message-ID: <5535EE92.3010205@kpanic.de> (sfid-20150421_083647_293789_E1D9DF43)
Date: Tue, 21 Apr 2015 08:30:42 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: backports@vger.kernel.org, mcgrof@do-not-panic.com
Subject: Re: [PATCH 10/10] backports: require coccinelle version 1.0.0-rc24
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>	 <1424874054-22956-11-git-send-email-sassmann@kpanic.de>	 <55356F36.9070408@hauke-m.de> <1429597009.2045.0.camel@sipsolutions.net>
In-Reply-To: <1429597009.2045.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 21.04.2015 08:16, Johannes Berg wrote:
> On Mon, 2015-04-20 at 23:27 +0200, Hauke Mehrtens wrote:
>> On 02/25/2015 03:20 PM, Stefan Assmann wrote:
>>> The new more generic ethernet patches require spatch 1.0.0-rc24.
> 
>> do you need coccinelle 1.0.0-rc24 or would rc23 also work? Johannes
>> added a patch raising minimum coccinelle to rc23.
> 
> I believe his changes do require rc24.
> 
> johannes
> 

Correct, the ifdef handling requires rc24.

  Stefan
