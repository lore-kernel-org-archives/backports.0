Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:56970 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751152Ab3LMHjK (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 13 Dec 2013 02:39:10 -0500
Message-ID: <52AAB99A.9080204@kpanic.de> (sfid-20131213_083913_327757_470145F5)
Date: Fri, 13 Dec 2013 08:39:06 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: mcgrof@kernel.org, backports@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] backports: add igb ethernet network driver
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de> <1386840482-585-2-git-send-email-sassmann@kpanic.de> <52AA5485.50001@hauke-m.de>
In-Reply-To: <52AA5485.50001@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13.12.2013 01:27, Hauke Mehrtens wrote:
> On 12/12/2013 10:27 AM, Stefan Assmann wrote:
>> - add igb to copy-list
>> - add igb defconfig
>> - refactor u64_stats_sync.h a bit
>> - add u64_stats_init define
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---

[...]

>> diff --git a/backport/defconfigs/igb b/backport/defconfigs/igb
>> new file mode 100644
>> index 0000000..1f85f18
>> --- /dev/null
>> +++ b/backport/defconfigs/igb
>> @@ -0,0 +1,7 @@
>> +CPTCFG_NETDEVICES=y
>> +CPTCFG_NET_ETHERNET=y
>> +CPTCFG_NETDEV_1000=y
>> +CPTCFG_ETHERNET=y
>> +CPTCFG_NET_VENDOR_INTEL=y
>> +CPTCFG_PCI=y
>> +CPTCFG_IGB=m
> 
> PCI should not be selected here, because it has to be selected in the
> kernel you are compiling against. I have not analyzed this, but I thing
> the defconfig should just contain these two options, the others should
> be already activated in the kernel:
> 
> CPTCFG_NET_VENDOR_INTEL=y
> CPTCFG_IGB=m

I'll see if I can boil this down. I had some trouble with older kernel
to get igb recognized.

  Stefan

> 
>> diff --git a/copy-list b/copy-list
>> index 9444aff..2b2e177 100644
>> --- a/copy-list
>> +++ b/copy-list
>> @@ -100,6 +100,10 @@ drivers/net/ethernet/broadcom/Makefile
>>  drivers/net/ethernet/broadcom/b44.c
>>  drivers/net/ethernet/broadcom/b44.h
>>  
>> +drivers/net/ethernet/intel/Kconfig
>> +drivers/net/ethernet/intel/Makefile
>> +drivers/net/ethernet/intel/igb/
>> +
> 
> This should be added in the last patch otherwise backports will not
> compile between this patch and the last one, becaise some parts are missing.
> 

Right, this was only a RFC and to see what breaks I had to enable it
early. :)

  Stefan
