Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52954 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGRIz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 12:08:55 -0500
Subject: Re: [PATCH] backports: handle "genetlink: simplify genl_notify"
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1445584976-11197-1-git-send-email-johannes@sipsolutions.net>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <563E3025.5050502@hauke-m.de> (sfid-20151107_180856_887651_6A7A236A)
Date: Sat, 7 Nov 2015 18:08:53 +0100
MIME-Version: 1.0
In-Reply-To: <1445584976-11197-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2015 09:22 AM, Johannes Berg wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> Handle the recent genl_notify() prototype change.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/net/genetlink.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
