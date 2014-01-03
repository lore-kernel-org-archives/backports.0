Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:38348 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbaACTLc (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 3 Jan 2014 14:11:32 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so13708162wes.38
        for <backports@vger.kernel.org>; Fri, 03 Jan 2014 11:11:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52C5ECF0.2090608@hauke-m.de>
References: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com>
	<1388688031.4326.3.camel@jlt4.sipsolutions.net>
	<CAOzu-jgPRK9Q5_g=A9aPBvHe8XGuRZDQ=vyKk0dTPp_+-=bL3w@mail.gmail.com>
	<1388702439.4326.4.camel@jlt4.sipsolutions.net>
	<52C5ECF0.2090608@hauke-m.de>
Date: Fri, 3 Jan 2014 14:11:31 -0500
Message-ID: <CAOzu-jiCnGAVX_mEUOfPWv8bMV-h8YhRp=WdQTA+smw6pSnP-w@mail.gmail.com> (sfid-20140103_201135_035540_CCA0F335)
Subject: Re: problems building iwlwifi for kernel 2.6.32
From: Kurt Bodiker <kebodiker@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	backports <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks all for your help and assistance. Hauke, I did not have CCM
built into the kernel. After rebuilding the kernel with CCM, I was
able to build iwlwifi.

Kurt

On Thu, Jan 2, 2014 at 5:49 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 01/02/2014 11:40 PM, Johannes Berg wrote:
>> On Thu, 2014-01-02 at 14:34 -0500, Kurt Bodiker wrote:
>>> when searching for IWLWIFI in the .config, it states the following
>>> dependencies: "Depends on: WLAN [=y] && m && <choice> && PCI [=y] &&
>>> MAC80211 [=n] && HAS_IOMEM [=y] ". Shouldn't MAC80211 be listed as 'm'
>>> instead of 'n' as it is in the .config for my kernel build?
>>
>> No, backports requires all backported components - you need to use the
>> backport's mac80211, not the kernel's.
>>
>> johannes
>
> Kurt do you have CONFIG_CRYPTO_CCM set in your *kernel* config? This is
> needed by recent mac80211 versions.
>
> Hauke
>
