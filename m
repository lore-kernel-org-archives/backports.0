Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58652 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaASRIO (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 12:08:14 -0500
Message-ID: <52DC0678.8060607@hauke-m.de> (sfid-20140119_180817_055539_94017681)
Date: Sun, 19 Jan 2014 18:08:08 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luis Rodriguez <mcgrof@do-not-panic.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] backports: fix iwlwifi threaded IRQ patches
References: <1388906284-28872-1-git-send-email-emmanuel.grumbach@intel.com>
In-Reply-To: <1388906284-28872-1-git-send-email-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/05/2014 08:18 AM, Emmanuel Grumbach wrote:
> Modifications upstream affected:
>  * drivers_net_wireless_iwlwifi_pcie_internal.patch
>  * drivers_net_wireless_iwlwifi_pcie_trans.patch
> 
> Manually refresh the patches.
> 
> Change-Id: Iad8218a243e644352c3b1029d12795c528259dde
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  .../09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch  | 2 +-
>  .../09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
Thank you for the patch, it was applied.

https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=4c0a53ddea49f6323b6e0da20936d62761235159

Hauke
