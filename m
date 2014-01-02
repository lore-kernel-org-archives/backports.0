Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:53141 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaABTeM (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 Jan 2014 14:34:12 -0500
Received: by mail-wg0-f48.google.com with SMTP id z12so12615907wgg.3
        for <backports@vger.kernel.org>; Thu, 02 Jan 2014 11:34:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1388688031.4326.3.camel@jlt4.sipsolutions.net>
References: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com>
	<1388688031.4326.3.camel@jlt4.sipsolutions.net>
Date: Thu, 2 Jan 2014 14:34:11 -0500
Message-ID: <CAOzu-jgPRK9Q5_g=A9aPBvHe8XGuRZDQ=vyKk0dTPp_+-=bL3w@mail.gmail.com> (sfid-20140102_203414_390345_38E73E26)
Subject: Re: problems building iwlwifi for kernel 2.6.32
From: Kurt Bodiker <kebodiker@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

when searching for IWLWIFI in the .config, it states the following
dependencies: "Depends on: WLAN [=y] && m && <choice> && PCI [=y] &&
MAC80211 [=n] && HAS_IOMEM [=y] ". Shouldn't MAC80211 be listed as 'm'
instead of 'n' as it is in the .config for my kernel build?

On Thu, Jan 2, 2014 at 1:40 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2014-01-02 at 12:54 -0500, Kurt Bodiker wrote:
>> I'm trying to build iwlwifi for a compiled 2.6.32 kernel for use in
>> Citrix XenClient XT v3.1.2. Using backports 3.10-2, no problem,
>> iwlwifi, mac80211, cfg80211, etc... build. If I use the release file
>> for 3.13-rc2, then only kernel modules that are built are compat and
>> cfg80211.
>>
>> Here are the commands I run and the output:
>> root@debian-build:/usr/src/backports/backports-3.13-rc2-1# make
>> KLIB_BUILD=/usr/src/linux-xenclient-ndvm_2.6.32-r0 KLIB=/fakeroot
>> defconfig-iwlwifi
>> Generating local configuration database from kernel ... done.
>> cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
>> -fomit-frame-pointer   -c -o conf.o conf.c
>> cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
>> -fomit-frame-pointer   -c -o zconf.tab.o zconf.tab.c
>> cc   conf.o zconf.tab.o   -o conf
>> #
>> # configuration written to .config
>
> maybe check dependencies for iwlwifi in 'make KLIB_BUILD=... menuconfig'
> by hitting '/' key and typing IWLWIFI or so
>
> johannes
>
