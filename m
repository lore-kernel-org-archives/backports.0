Return-path: <backports-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:53072 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369AbcHKHwq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Aug 2016 03:52:46 -0400
MIME-Version: 1.0
Message-ID: <trinity-e021195e-a0df-484c-9ba9-6d30922988b8-1470901957548@3capp-gmx-bs55> (sfid-20160811_095248_857724_7C891D7A)
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org,
	"Hauke Mehrtens" <hauke@hauke-m.de>
Subject: backport-4.7.c fails due to missing rhashtable.h for target < 3.17
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Aug 2016 09:52:37 +0200
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
playing around with backports,
unfortunately the backport code for 4.7 fails to compile if the target kernel is < 3.18.

make allyesconfig
make 
...
  CC [M]  /home/peter/linux-3-backport/compat/backport-4.7.o
In file included from /home/peter/linux-3-backport/backport-include/linux/rhashtable.h:3:0,
                 from /home/peter/linux-3-backport/compat/backport-4.7.c:14:
/home/peter/linux-3-backport/include/linux/rhashtable.h:3:35: fatal error: linux/rhashtable.h: No such file or directory.
compilation terminated.


The linux/rhashtable was introduced in 3.17,

The backport-4.7 has however
#include <linux/export.h>
#include <linux/list.h>
#include <linux/rcupdate.h>
#include <linux/rhashtable.h>
#include <linux/slab.h>
#include <linux/spinlock.h>

#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)



Does the rhashtable.h need to be include-guarded somehow ? (e.g. moving the if LINUX_VERSION_CODE up and maybe even changing it to 3.17?).

Or do we have to add rhashtable.h to the copy-list?

Thanks,
Peter
--
To unsubscribe from this list: send the line "unsubscribe backports" in
