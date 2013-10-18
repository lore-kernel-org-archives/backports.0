Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38003 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143Ab3JRPsz (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Oct 2013 11:48:55 -0400
Message-ID: <5261585F.8020000@hauke-m.de> (sfid-20131018_174857_575913_292201F1)
Date: Fri, 18 Oct 2013 17:48:47 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC] backports: replace netlink portid by semantic patch
References: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/18/2013 05:28 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Introduce the infrastructure to apply semantic patches
> and make use of it for the (frequently breaking) portid
> patch for netlink.
> 
> Unfortunately this is significantly slower:
> 
> before:
> real    0m14.312s
> user    0m12.144s
> sys     0m1.784s
> 
> after:
> real    0m25.932s
> user    0m21.768s
> sys     0m2.932s
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

There are two more patches doing the same thing for other subsystems, I
hope we could also replace the patches with this semantic patch:

patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch

How fast would it be when one more semantic patch would be added would
it increase in the same way? I am wondering if this is a constant
increase or does it depend on the number of patches.

Hauke
