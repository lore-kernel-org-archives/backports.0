Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:52773 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752445AbaBBV1g (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Feb 2014 16:27:36 -0500
Message-ID: <52EEB5EF.1060106@kpanic.de> (sfid-20140202_222738_692411_3C28B123)
Date: Sun, 02 Feb 2014 22:17:35 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH v4 00/12] backports: add igb driver
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de> <52EC370B.3090103@hauke-m.de>
In-Reply-To: <52EC370B.3090103@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01.02.2014 00:51, Hauke Mehrtens wrote:
> On 01/29/2014 10:18 AM, Stefan Assmann wrote:
>> This is a patchset for inclusion of the Intel igb wired ethernet driver.
>> Patches are split per kernel release that makes it easier to review
>> the changes and gives a nice history of what was necessary for each
>> release. Also the igb driver changes have been split up into individual
>> patches in patches/collateral-evolutions/network/84-ethernet. This and
>> file names are up for discussion, suggestions welcome.
>>
>> v2:
>> Instead of backporting struct ethtool_ops the code in igb has been
>> wrapped in if LINUX_VERSION_CODE statements. This will result in higher
>> maintenance because of conflicts with future upstream igb changes but it
>> seems there's no better solution so far.
>> The patches in patches/collateral-evolutions/network/84-ethernet have
>> been kept separate but with a leading number to make sure they get
>> applied in the correct order.
>> The code that activates igb has been pushed to the end of the series to
>> not break any bisecting.
>> v3:
>> Use original struct ptp_clock and handle ptp_clock_register() with a
>> define. Also removed unused function warnings by wrapping the code
>> in if LINUX_VERSION_CODE statements.
>> v4:
>> Add several LINUX_BACKPORT defines to prevent possible clashes with
>> distro backports. Patches rebased and tested against next-20140124.
>>
>
> Thank you Stefan for the patches.
>
> I applied them with some changes. backports did not compile on some
> older kernels, because include/linux/u64_stats_sync.h was missing there.
> I also fixed some problems on CentOS 6.5 and Suse SLES 11 SP3. Some
> strutes that are not used were removed too.

Great! Thanks a lot. I'll take a look at the changes. I didn't see any
trouble when running ckmake which makes me wonder if I missed out on
any testing I could've run.

   Stefan
