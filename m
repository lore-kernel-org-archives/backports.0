Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45929 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713AbaAaXvx (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 Jan 2014 18:51:53 -0500
Message-ID: <52EC370B.3090103@hauke-m.de> (sfid-20140201_005157_006083_F31F2562)
Date: Sat, 01 Feb 2014 00:51:39 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH v4 00/12] backports: add igb driver
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/29/2014 10:18 AM, Stefan Assmann wrote:
> This is a patchset for inclusion of the Intel igb wired ethernet driver.
> Patches are split per kernel release that makes it easier to review
> the changes and gives a nice history of what was necessary for each
> release. Also the igb driver changes have been split up into individual
> patches in patches/collateral-evolutions/network/84-ethernet. This and
> file names are up for discussion, suggestions welcome.
> 
> v2:
> Instead of backporting struct ethtool_ops the code in igb has been
> wrapped in if LINUX_VERSION_CODE statements. This will result in higher
> maintenance because of conflicts with future upstream igb changes but it
> seems there's no better solution so far.
> The patches in patches/collateral-evolutions/network/84-ethernet have
> been kept separate but with a leading number to make sure they get
> applied in the correct order.
> The code that activates igb has been pushed to the end of the series to
> not break any bisecting.
> v3:
> Use original struct ptp_clock and handle ptp_clock_register() with a
> define. Also removed unused function warnings by wrapping the code
> in if LINUX_VERSION_CODE statements.
> v4:
> Add several LINUX_BACKPORT defines to prevent possible clashes with
> distro backports. Patches rebased and tested against next-20140124.
> 

Thank you Stefan for the patches.

I applied them with some changes. backports did not compile on some
older kernels, because include/linux/u64_stats_sync.h was missing there.
I also fixed some problems on CentOS 6.5 and Suse SLES 11 SP3. Some
strutes that are not used were removed too.

Hauke
