Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49651 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbbDYOB4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:01:56 -0400
Message-ID: <553B9E52.7030202@hauke-m.de> (sfid-20150425_160157_922035_C63E96E4)
Date: Sat, 25 Apr 2015 16:01:54 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH] backports: deal better with possible_net_t
References: <1428396138-11310-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1428396138-11310-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/07/2015 10:42 AM, Johannes Berg wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> Instead of just assuming CONFIG_NET_NS is defined, deal with
> this better. Sadly, it needs a header file patch (as an spatch
> doesn't deal properly with header files.)
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/net/net_namespace.h      | 22 +++++++++++++++++++++-
>  .../network/0053-possible_net_t.patch              | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 patches/collateral-evolutions/network/0053-possible_net_t.patch
> 

Thank you for the patch, I applied and pushed it out.

Hauke
