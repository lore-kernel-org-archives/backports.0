Return-path: <backports-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:3862 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754550AbaFYVIQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 25 Jun 2014 17:08:16 -0400
Received: from localhost ([127.0.0.1] helo=www.infidigm.net)
	by freiheit with esmtp (Exim 4.72)
	(envelope-from <drwho@infidigm.net>)
	id 1Wztwu-0002hQ-Jh
	for backports@vger.kernel.org; Wed, 25 Jun 2014 16:37:44 -0400
Message-ID: <c07041cc8dc2076d4fd4f10d8cf9ad33.squirrel@www.infidigm.net> (sfid-20140625_230818_748597_83650BE0)
Date: Wed, 25 Jun 2014 16:37:44 -0400
Subject: enable mac80211 config help?
From: drwho@infidigm.net
To: backports@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am cross compiling backports-3.13.2-1 and I can not enable mac80211
config to build drivers that depend on it.  In the backports src dir, when
I run

make menuconfig
CROSS_COMPILE=/opt/freescale/usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi/bin/arm-none-linux-gnueabi-
ARCH=arm KLIB_BUILD=/edit/ltibs/c390/rpm/BUILD/linux/
KLIB=/edit/ltibs/c390/rootfs/lib/modules/2.6.35.3-998-ga1cd8a7/

and search for mac80211 is shows it disabled.  I've run my kernel's
menuconfig to change mac80211 to n, m and y.  Running the backports
menuconfig afterwords shows mac80211 is disabled for all three states. 
The only way I can get the drivers that depend on mac80211 to appear is to
add

config MAC80211
	def_bool y

in the backports Kconfig file.  Then when I run the make I get....

/xxx/backports-3.13.2-1/backport-include/backport/checks.h:9:2: error:
#error "You must not have mac80211 built into your kernel if you want to
enable it"

Am I doing something wrong or is this a problem with backports against
2.6.35-3?

Am I correct in assuming mac80211 should be disabled in the kernel config?

Jon

