Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:49895 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbaDGN5p (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Apr 2014 09:57:45 -0400
Message-ID: <5342AED7.5080505@kpanic.de> (sfid-20140407_155747_621390_17998CA3)
Date: Mon, 07 Apr 2014 15:57:43 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: backports@vger.kernel.org
CC: Hauke Mehrtens <hauke@hauke-m.de>
Subject: ckmake build issue with undefined symbol mcount
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Tree generated with
./gentree.py --clean --verbose --git-revision next-20140221 /root/linux-next /tmp/next

When running devel/ckmake I see the following
[...]
23  3.7.10              [  LINK  ]
24  3.8.13              [  LINK  ]
25  3.9.11              [  LINK  ]
26  3.10.29             [  LINK  ]
27  3.11.10             [  LINK  ]
28  3.12.10             [  LINK  ]
29  3.13.2              [  LINK  ]
30  3.14-rc1            [  LINK  ]

Looking at ckmake.log there seems to be a problem with mcount.
Building backport-include/backport/autoconf.h ... done.
/root/ksrc-backports/usr/src/linux-headers-3.7.10-030710-generic/arch/x86/Makefile:103: CONFIG_X86_X32 enabled but no binutils support
  CC [M]  /tmp/next/.tmp.ckmake/3.7.10/compat/lib-cordic.o
  LD [M]  /tmp/next/.tmp.ckmake/3.7.10/compat/compat.o
  LD [M]  /tmp/next/.tmp.ckmake/3.7.10/compat/cordic.o
  Building modules, stage 2.
  MODPOST 2 modules
WARNING: "mcount" [/tmp/next/.tmp.ckmake/3.7.10/compat/cordic.ko] undefined!
WARNING: "mcount" [/tmp/next/.tmp.ckmake/3.7.10/compat/compat.ko] undefined!

This is also the case for every kernel mentioned above.

  Stefan
