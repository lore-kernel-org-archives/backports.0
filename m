Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:18319 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbbDMJfh (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 Apr 2015 05:35:37 -0400
Message-ID: <552B8DE5.7090206@broadcom.com> (sfid-20150413_113539_397222_14ECB993)
Date: Mon, 13 Apr 2015 11:35:33 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: backport fails for brcmfmac
References: <552AA8FA.5070004@broadcom.com> <552ACDB0.2000607@hauke-m.de>
In-Reply-To: <552ACDB0.2000607@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/12/15 21:55, Hauke Mehrtens wrote:
> On 04/12/2015 07:18 PM, Arend van Spriel wrote:
>> I rebased our internel backports tree to backports/master and now I get
>> the following build error when backporting to 3.13 kernel:
>>
>> /tmp/brcm-backports-gb8d29dc/drivers/net/wireless/brcm80211/brcmfmac/p2p.c:2315:11:
>> error: ���struct net_device��� has no member named ���name_assign_type���
>>    ifp->ndev->name_assign_type = name_assign_type;
>>
>> Obviously struct netdevice does not have name_assign_type in older
>> kernels, ie. kernels<  3.17 looking at
>> backport-include/linux/netdevice.h. Just not sure what made this issue
>> come up. The assignment was introduced by:
>>
>> commit 6bab2e19c5ffd1f21b28c2cabb3801a37b77ae69
>> Author: Tom Gundersen<teg@jklm.no>
>> Date:   Wed Mar 18 11:13:39 2015 +0100
>>
>>      cfg80211: pass name_assign_type to rdev_add_virtual_intf()
>>
>> Probably need to rework brcmfmac code to avoid the assignment and pass
>> the name_assign_type to the alloc_netdev call. If there is an easier way
>> feel free to let me know.
>
> I think this name_assign_type member is only used to show how the device
> name was assigned to the device. See name_assign_type in
> Documentation/ABI/testing/sysfs-class-net
> On kernel versions which do not support this sysfs entry, we can just
> ignore this new member. I think it is save to just add an "#if linux>=
> 3.17" around this assignment.

Well. I don't want to do that upstream so that would mean adding a patch 
in backports that needs to be maintained which I prefer to avoid. I will 
see whether I can rework the code.

Regards,
Arend
