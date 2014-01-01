Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47749 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbaAATY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Jan 2014 14:24:28 -0500
Message-ID: <52C46B63.50207@hauke-m.de> (sfid-20140101_202430_978082_F810AC3A)
Date: Wed, 01 Jan 2014 20:24:19 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH V2] network: mac80211: rework multicast patches for mac80211
References: <1387709465-19004-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1387709465-19004-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/22/2013 11:51 AM, Arend van Spriel wrote:
> Fixing up the patches for mac80211 that were located under
> collateral-evolutions/network/25-multicast-list_head.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  .../include_net_mac80211.patch                     |   14 +--------
>  .../net_mac80211_driver-ops.patch                  |   33 +-------------------
>  .../net_mac80211_iface.patch                       |   16 +++-------
>  3 files changed, 6 insertions(+), 57 deletions(-)

This patch does not apply for me on current master:

hauke@hauke-desktop:~/compat-wireless/backports$ patch -p1 < tmp.patch
patching file
patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
Hunk #1 FAILED at 1.
1 out of 2 hunks FAILED -- saving rejects to file
patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch.rej
patching file
patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
patching file
patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 14.
2 out of 2 hunks FAILED -- saving rejects to file
patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch.rej


Is it based on master of this repository:
git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

Hauke
