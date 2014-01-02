Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:55918 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaABWkp (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 Jan 2014 17:40:45 -0500
Message-ID: <1388702439.4326.4.camel@jlt4.sipsolutions.net> (sfid-20140102_234047_092620_33D5AF10)
Subject: Re: problems building iwlwifi for kernel 2.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Kurt Bodiker <kebodiker@gmail.com>
Cc: backports <backports@vger.kernel.org>
Date: Thu, 02 Jan 2014 23:40:39 +0100
In-Reply-To: <CAOzu-jgPRK9Q5_g=A9aPBvHe8XGuRZDQ=vyKk0dTPp_+-=bL3w@mail.gmail.com> (sfid-20140102_203412_078952_CDFCEEB4)
References: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com>
	 <1388688031.4326.3.camel@jlt4.sipsolutions.net>
	 <CAOzu-jgPRK9Q5_g=A9aPBvHe8XGuRZDQ=vyKk0dTPp_+-=bL3w@mail.gmail.com>
	 (sfid-20140102_203412_078952_CDFCEEB4)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-01-02 at 14:34 -0500, Kurt Bodiker wrote:
> when searching for IWLWIFI in the .config, it states the following
> dependencies: "Depends on: WLAN [=y] && m && <choice> && PCI [=y] &&
> MAC80211 [=n] && HAS_IOMEM [=y] ". Shouldn't MAC80211 be listed as 'm'
> instead of 'n' as it is in the .config for my kernel build?

No, backports requires all backported components - you need to use the
backport's mac80211, not the kernel's.

johannes

