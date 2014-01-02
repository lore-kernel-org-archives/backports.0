Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:55194 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbaABSke (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 Jan 2014 13:40:34 -0500
Message-ID: <1388688031.4326.3.camel@jlt4.sipsolutions.net> (sfid-20140102_194036_777913_8BC513B7)
Subject: Re: problems building iwlwifi for kernel 2.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Kurt Bodiker <kebodiker@gmail.com>
Cc: backports@vger.kernel.org
Date: Thu, 02 Jan 2014 19:40:31 +0100
In-Reply-To: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com> (sfid-20140102_185429_936242_E622A8EA)
References: <CAOzu-jgfXjXt-_YQmcZqiD2zKiZkgT_VD8dMoi-WqW=Jw8QX_w@mail.gmail.com>
	 (sfid-20140102_185429_936242_E622A8EA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-01-02 at 12:54 -0500, Kurt Bodiker wrote:
> I'm trying to build iwlwifi for a compiled 2.6.32 kernel for use in
> Citrix XenClient XT v3.1.2. Using backports 3.10-2, no problem,
> iwlwifi, mac80211, cfg80211, etc... build. If I use the release file
> for 3.13-rc2, then only kernel modules that are built are compat and
> cfg80211.
> 
> Here are the commands I run and the output:
> root@debian-build:/usr/src/backports/backports-3.13-rc2-1# make
> KLIB_BUILD=/usr/src/linux-xenclient-ndvm_2.6.32-r0 KLIB=/fakeroot
> defconfig-iwlwifi
> Generating local configuration database from kernel ... done.
> cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
> -fomit-frame-pointer   -c -o conf.o conf.c
> cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
> -fomit-frame-pointer   -c -o zconf.tab.o zconf.tab.c
> cc   conf.o zconf.tab.o   -o conf
> #
> # configuration written to .config

maybe check dependencies for iwlwifi in 'make KLIB_BUILD=... menuconfig'
by hitting '/' key and typing IWLWIFI or so

johannes

