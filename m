Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58178 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbaFQTRp (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 17 Jun 2014 15:17:45 -0400
Message-ID: <53A0944F.3070106@hauke-m.de> (sfid-20140617_211747_518531_7897D8DD)
Date: Tue, 17 Jun 2014 21:17:35 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH] backport: update drivers_net_wireless_iwlwifi_iwl-debug.patch
References: <1399987152-20197-1-git-send-email-emmanuel.grumbach@intel.com>
In-Reply-To: <1399987152-20197-1-git-send-email-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/13/2014 03:19 PM, Emmanuel Grumbach wrote:
> The driver was updated - need to update the patch accordingly
> 
> commit 7f715626a9ddfa7df13f076f59fc62e3c99066cf
> Author: Liad Kaufman <liad.kaufman@intel.com>
> Date:   Thu May 8 15:24:54 2014 +0300
> 
>     iwlwifi: use dev_printk instead of dev_dbg for debug logs
> 
> Change-Id: I4006303e36bc170c3e91bbb9e5d9437a1f345b9f
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  .../drivers_net_wireless_iwlwifi_iwl-debug.patch             | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Thank you for the patch, it was applied in pushed out.

Hauke

