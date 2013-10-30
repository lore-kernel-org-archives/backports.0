Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:42690 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3J3VLN (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 30 Oct 2013 17:11:13 -0400
Message-ID: <527175E5.6000201@hauke-m.de> (sfid-20131030_221132_074965_0002E804)
Date: Wed, 30 Oct 2013 22:11:01 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
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
> ---
>  gentree.py                                         |  36 +++
>  .../network/0005-netlink-portid.cocci              |  25 ++
>  .../network/0005-netlink-portid/INFO               |  42 ----
>  .../0005-netlink-portid/mac80211_hwsim.patch       |  24 --
>  .../network/0005-netlink-portid/nl80211.patch      | 267 ---------------------
>  5 files changed, 61 insertions(+), 333 deletions(-)
>  create mode 100644 patches/collateral-evolutions/network/0005-netlink-portid.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/INFO
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch

Getting rid of the big patches and replacing them with a semantic patch
is worth the extra time needed.

Would you like to resend it with the other netlink-portid patches (nfc,
ieee80154) also removed or should I add that to the patch.

Hauke
