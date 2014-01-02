Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52839 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaABWt2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 2 Jan 2014 17:49:28 -0500
Message-ID: <52C5ECF0.2090608@hauke-m.de> (sfid-20140102_234929_770108_572804F6)
Date: Thu, 02 Jan 2014 23:49:20 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Kurt Bodiker <kebodiker@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
	backports <backports@vger.kernel.org>
Subject: Re: problems building iwlwifi for kernel 2.6.32
References: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com>	 <1388688031.4326.3.camel@jlt4.sipsolutions.net>	 <CAOzu-jgPRK9Q5_g=A9aPBvHe8XGuRZDQ=vyKk0dTPp_+-=bL3w@mail.gmail.com>	 (sfid-20140102_203412_078952_CDFCEEB4) <1388702439.4326.4.camel@jlt4.sipsolutions.net>
In-Reply-To: <1388702439.4326.4.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/02/2014 11:40 PM, Johannes Berg wrote:
> On Thu, 2014-01-02 at 14:34 -0500, Kurt Bodiker wrote:
>> when searching for IWLWIFI in the .config, it states the following
>> dependencies: "Depends on: WLAN [=y] && m && <choice> && PCI [=y] &&
>> MAC80211 [=n] && HAS_IOMEM [=y] ". Shouldn't MAC80211 be listed as 'm'
>> instead of 'n' as it is in the .config for my kernel build?
> 
> No, backports requires all backported components - you need to use the
> backport's mac80211, not the kernel's.
> 
> johannes

Kurt do you have CONFIG_CRYPTO_CCM set in your *kernel* config? This is
needed by recent mac80211 versions.

Hauke

