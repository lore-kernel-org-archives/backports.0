Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37837 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3KUWpT (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:45:19 -0500
Message-ID: <528E8CF9.5090801@hauke-m.de> (sfid-20131121_234520_949740_F84EE9DB)
Date: Thu, 21 Nov 2013 23:45:13 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: support new generic netlink APIs
References: <1385063483-29198-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1385063483-29198-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/21/2013 08:51 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> I recently changed the generic netlink registration and multicast
> group APIs to be safer. Backport these changes by implementing all
> the new APIs in terms of what was in the kernel before.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> Apply this patch once the base kernel gets the netlink changes, obviously :)

Thank you for all three patches, they were applied and a new version of
backports was pushed out.

Hauke
