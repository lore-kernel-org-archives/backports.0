Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from novprvoes0310.provo.novell.com ([137.65.248.74]:58857 "EHLO
	novprvoes0310.provo.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756036Ab2JKUTM convert rfc822-to-8bit
	(ORCPT <rfc822;groupwise-backports@vger.kernel.org:1:1>);
	Thu, 11 Oct 2012 16:19:12 -0400
Message-Id: <5076D55D020000D6000EA457@novprvoes0310.provo.novell.com>
Date: Thu, 11 Oct 2012 14:19:09 -0600
From: "Ann Davis" <andavis@suse.com>
To: <backports@vger.kernel.org>
Subject: compat-drivers rpm builds on Open Build Service (OBS)
References: <5075ABFB020000D6000EA32E@novprvoes0310.provo.novell.com>
 <5076D55D020000D6000EA457@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

I've set up a project on the Open(SUSE) Build Service to build compat-drivers rpms for a bunch of our SUSE distros (and RHEL 6, just for fun ;))  My intention is to use this to catch any build problems that might occur when building on SUSE.  (Seems to me that it makes more sense for the main backports.kernel.org project to concentrate on building for standard kernels and each distro to concentrate on building/maintaining for their own stuff.)  Details/Notes:

1)  Project/package page is 
https://build.opensuse.org/package/show?package=compat-drivers&project=home%3Aandavis%3Acompat-drivers .  OBS login is required but free and easy to set up.

2)  I'm working on a cron job to do periodic (daily?) builds w/ the most recent compat-drivers snapshot on http://www.kernel.org/pub/linux/kernel/projects/backports/ .   I can change the download/build frequency and/or work off the git repo instead of the tarballs, but this seems easiest right now...

3)  I'm not sure there's really any need for a compat-drivers rpm (or deb package), but doing the build is what matters and if we get the rpm for free, so much the better.  :)

4)  WRT having an rpm:  I think it _would_ be helpful (at least from our distro-vendor perspective) to quickly build rpms that contain a subset of compat-drivers.    Maybe using the driver-select script?  Will look into that next.

5)  The package is successfully building for all distros/arch's _except_SLES 11 SP2 i586.  Error is:

[ 3801s]   CC [M]  /usr/src/packages/BUILD/compat-drivers-2012-10-08/obj/xen/compat/compat-3.1.o
[ 3802s] In file included from /usr/src/packages/BUILD/compat-drivers-2012-10-08/obj/xen/compat/compat-3.1.c:12:
[ 3802s] /usr/src/linux-3.0.13-0.27/include/linux/cpufreq.h:333: error: static declaration of 'compat_cpufreq_quick_get_max' follows non-static declaration
[ 3802s] /usr/src/packages/BUILD/compat-drivers-2012-10-08/obj/xen/include/linux/compat-3.1.h:117: error: previous declaration of 'compat_cpufreq_quick_get_max' was here

Not sure what's happening yet but will look into it.

c/ya,

Ann 




