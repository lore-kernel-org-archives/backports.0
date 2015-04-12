Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43638 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbbDLTzc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 12 Apr 2015 15:55:32 -0400
Message-ID: <552ACDB0.2000607@hauke-m.de> (sfid-20150412_215534_648177_6765AF13)
Date: Sun, 12 Apr 2015 21:55:28 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: backport fails for brcmfmac
References: <552AA8FA.5070004@broadcom.com>
In-Reply-To: <552AA8FA.5070004@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/12/2015 07:18 PM, Arend van Spriel wrote:
> I rebased our internel backports tree to backports/master and now I get
> the following build error when backporting to 3.13 kernel:
> 
> /tmp/brcm-backports-gb8d29dc/drivers/net/wireless/brcm80211/brcmfmac/p2p.c:2315:11:
> error: ���struct net_device��� has no member named ���name_assign_type���
>   ifp->ndev->name_assign_type = name_assign_type;
> 
> Obviously struct netdevice does not have name_assign_type in older
> kernels, ie. kernels < 3.17 looking at
> backport-include/linux/netdevice.h. Just not sure what made this issue
> come up. The assignment was introduced by:
> 
> commit 6bab2e19c5ffd1f21b28c2cabb3801a37b77ae69
> Author: Tom Gundersen <teg@jklm.no>
> Date:   Wed Mar 18 11:13:39 2015 +0100
> 
>     cfg80211: pass name_assign_type to rdev_add_virtual_intf()
> 
> Probably need to rework brcmfmac code to avoid the assignment and pass
> the name_assign_type to the alloc_netdev call. If there is an easier way
> feel free to let me know.

I think this name_assign_type member is only used to show how the device
name was assigned to the device. See name_assign_type in
Documentation/ABI/testing/sysfs-class-net
On kernel versions which do not support this sysfs entry, we can just
ignore this new member. I think it is save to just add an "#if linux >=
3.17" around this assignment.

Hauke
