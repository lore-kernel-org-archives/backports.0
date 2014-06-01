Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59615 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaFAWeM (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:34:12 -0400
Message-ID: <538BAA5D.4080109@hauke-m.de> (sfid-20140602_003413_967474_3EBC342E)
Date: Mon, 02 Jun 2014 00:34:05 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
Subject: Re: [PATCH] backport: CCM: set correct dependencies
References: <1400145726-16520-1-git-send-email-johannes@sipsolutions.net>	 (sfid-20140515_112220_823082_F95EE84B) <1400145942.4146.0.camel@jlt4.sipsolutions.net>
In-Reply-To: <1400145942.4146.0.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/15/2014 11:25 AM, Johannes Berg wrote:
> On Thu, 2014-05-15 at 11:22 +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> If these aren't actually compiled in, then the mac80211
>> code will fail at runtime. Add these dependencies so we
>> at least get a warning at compile time about this.
> 
> The possibly preferable alternative would be to rip out the CCM backport
> again - if we want to have all those dependencies we'll quickly end up
> including the entire crypto subsystem (which would probably even be
> possible!) but it doesn't seem worth it.
> 
> johannes
> 

Thank you for the patch, is was applied, pushed and is included in the
backports-20140501 release.

The best solution would be to just depend on the stuff needed for
mac80211 in older kernel versions.

Hauke
