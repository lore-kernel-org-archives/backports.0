Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46858 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab3KXN2u (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 08:28:50 -0500
Message-ID: <5291FF06.10607@hauke-m.de> (sfid-20131124_142851_796271_D5B54315)
Date: Sun, 24 Nov 2013 14:28:38 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: fix genetlink backport
References: <1385148102-1224-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1385148102-1224-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/22/2013 08:21 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> On kernels that already have pre_doit/post_doit, we don't
> fake them by re-assigning all ops and their doit, but then
> we clearly need to copy the pointers. Fix that oversight.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thank you for the patch, it was applied.

Now backports works again for me.

Hauke

