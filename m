Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:44637 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbaABT6G (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 2 Jan 2014 14:58:06 -0500
Message-ID: <52C5C4C9.30203@broadcom.com> (sfid-20140102_205808_872751_B46FAB8E)
Date: Thu, 2 Jan 2014 20:58:01 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH V2] network: mac80211: rework multicast patches for mac80211
References: <1387709465-19004-1-git-send-email-arend@broadcom.com> <52C46B63.50207@hauke-m.de>
In-Reply-To: <52C46B63.50207@hauke-m.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/01/2014 08:24 PM, Hauke Mehrtens wrote:
> On 12/22/2013 11:51 AM, Arend van Spriel wrote:
>> Fixing up the patches for mac80211 that were located under
>> collateral-evolutions/network/25-multicast-list_head.
>>
>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>> ---
>>  .../include_net_mac80211.patch                     |   14 +--------
>>  .../net_mac80211_driver-ops.patch                  |   33 +-------------------
>>  .../net_mac80211_iface.patch                       |   16 +++-------
>>  3 files changed, 6 insertions(+), 57 deletions(-)
> 
> This patch does not apply for me on current master:
> 
> hauke@hauke-desktop:~/compat-wireless/backports$ patch -p1 < tmp.patch
> patching file
> patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
> Hunk #1 FAILED at 1.
> 1 out of 2 hunks FAILED -- saving rejects to file
> patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch.rej
> patching file
> patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
> patching file
> patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 14.
> 2 out of 2 hunks FAILED -- saving rejects to file
> patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch.rej
> 
> 
> Is it based on master of this repository:
> git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

Had a good vacation so .... let me check. Oh, and best wishes ;-)

Gr. AvS

