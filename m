Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60162 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbaBHN53 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:57:29 -0500
Message-ID: <52F637C2.2070205@hauke-m.de> (sfid-20140208_145731_328074_D5692D0F)
Date: Sat, 08 Feb 2014 14:57:22 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: backport power efficient workqueues
References: <1391164432-8699-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1391164432-8699-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/31/2014 11:33 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> These only exist starting from 3.11, and wireless code will
> start using them soon. Backport them as simple defines using
> the corresponding non-power-efficient workqueues.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
Thank you for the patch, it was applied and pushed.

Hauke
