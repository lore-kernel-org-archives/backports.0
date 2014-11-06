Return-path: <backports-owner@vger.kernel.org>
Received: from imta-35.everyone.net ([216.200.145.35]:44287 "EHLO
	imta-35.everyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaKFEo4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 5 Nov 2014 23:44:56 -0500
Received: from pps.filterd (omta006.sj2.proofpoint.com [127.0.0.1])
	by imta-38.everyone.net (8.14.5/8.14.5) with SMTP id sA64g8le021458
	for <backports@vger.kernel.org>; Wed, 5 Nov 2014 20:44:55 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-Id: <20141105204455.80F94044@m0048140.ppops.net> (sfid-20141106_054458_957212_C78ACA49)
Date: Wed, 5 Nov 2014 20:44:55 -0800
From: "Art Vandelay" <artvandelay@tbns.org>
Reply-To: <artvandelay@tbns.org>
To: <backports@vger.kernel.org>
Subject: Compiling backports-3.14.22-1 against kernel v2.6.32
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Everyone,

I'm currently running RHEL6 since it's still the latest stable release and can't upgrade to RHEL7. And the latest kernel version available for RHEL6 is v2.6.32.
So when I tried to build the driver for RTL8723AE from backports-3.14.22-1 (because the front page says to use 3.14 for kernel versions 2.6.26+), I got these compilation errors:

backports-3.14.22-1/backport-include/net/inet_frag.h: In function 'backport_frag_mem_limit':
backports-3.14.22-1/backport-include/net/inet_frag.h:11: error: 'struct netns_frags' has no member named 'mem'
backports-3.14.22-1/backport-include/net/inet_frag.h: In function 'backport_sub_frag_mem_limit':
backports-3.14.22-1/backport-include/net/inet_frag.h:17: error: 'struct netns_frags' has no member named 'mem'
backports-3.14.22-1/backport-include/net/inet_frag.h: In function 'backport_add_frag_mem_limit':
backports-3.14.22-1/backport-include/net/inet_frag.h:23: error: 'struct netns_frags' has no member named 'mem'
backports-3.14.22-1/backport-include/net/inet_frag.h: In function 'backport_init_frag_mem_limit':
backports-3.14.22-1/backport-include/net/inet_frag.h:29: error: 'struct netns_frags' has no member named 'mem'
backports-3.14.22-1/backport-include/net/inet_frag.h: In function 'backport_sum_frag_mem_limit':
backports-3.14.22-1/backport-include/net/inet_frag.h:35: error: 'struct netns_frags' has no member named 'mem'
make[6]: *** [backports-3.14.22-1/compat/compat-2.6.35.o] Error 1
make[5]: *** [backports-3.14.22-1/compat] Error 2
make[4]: *** [_module_backports-3.14.22-1] Error 2

I understand that only kernel versions >= 3.0 are being supported at the moment, but backports-3.14 was supposed to successfully build against kernel-2.6.32 and it doesn't in my case. Anyway, it doesn't seem like it would be a difficult fix; any help would be appreciated.

Thanks!

_____________________________________________________________
Brought to you by TBNS.net
