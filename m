Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:2793 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbbDLRSx (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 12 Apr 2015 13:18:53 -0400
Message-ID: <552AA8FA.5070004@broadcom.com> (sfid-20150412_191856_328707_8361BFF4)
Date: Sun, 12 Apr 2015 19:18:50 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: backport fails for brcmfmac
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I rebased our internel backports tree to backports/master and now I get 
the following build error when backporting to 3.13 kernel:

/tmp/brcm-backports-gb8d29dc/drivers/net/wireless/brcm80211/brcmfmac/p2p.c:2315:11: 
error: ���struct net_device��� has no member named ���name_assign_type���
   ifp->ndev->name_assign_type = name_assign_type;

Obviously struct netdevice does not have name_assign_type in older 
kernels, ie. kernels < 3.17 looking at 
backport-include/linux/netdevice.h. Just not sure what made this issue 
come up. The assignment was introduced by:

commit 6bab2e19c5ffd1f21b28c2cabb3801a37b77ae69
Author: Tom Gundersen <teg@jklm.no>
Date:   Wed Mar 18 11:13:39 2015 +0100

     cfg80211: pass name_assign_type to rdev_add_virtual_intf()

Probably need to rework brcmfmac code to avoid the assignment and pass 
the name_assign_type to the alloc_netdev call. If there is an easier way 
feel free to let me know.

Regards,
Arend
