Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49005 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060Ab3JaV4k (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 17:56:40 -0400
Message-ID: <5272D20E.7040201@hauke-m.de> (sfid-20131031_225642_837802_7BD8BEC1)
Date: Thu, 31 Oct 2013 22:56:30 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: replace netlink portid by semantic patch
References: <1383167629-22457-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1383167629-22457-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/30/2013 10:13 PM, Johannes Berg wrote:
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
>  .../0001-netlink-portid/ieee802154.patch           |  40 ---
>  .../network/0005-netlink-portid.cocci              |  25 ++
>  .../network/0005-netlink-portid/INFO               |  42 ----
>  .../0005-netlink-portid/mac80211_hwsim.patch       |  24 --
>  .../network/0005-netlink-portid/nl80211.patch      | 267 ---------------------
>  .../nfc/01-netlink-portid/INFO                     |  42 ----
>  .../nfc/01-netlink-portid/net_nfc_netlink.patch    |  71 ------
>  8 files changed, 61 insertions(+), 486 deletions(-)
>  delete mode 100644 patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch
>  create mode 100644 patches/collateral-evolutions/network/0005-netlink-portid.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/INFO
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
>  delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
>  delete mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/INFO
>  delete mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch

Thank you for the patch, it was applied and a new released is being pushed.

Hauke
