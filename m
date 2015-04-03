Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39452 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbbDCVlS (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 17:41:18 -0400
Message-ID: <551F08FB.2060600@hauke-m.de> (sfid-20150403_234120_209483_2063A4E9)
Date: Fri, 03 Apr 2015 23:41:15 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5/5] backports: backport kvfree
References: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net> <1427902299-24079-5-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1427902299-24079-5-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/01/2015 05:31 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This has been in the kernel for a long time, but wasn't
> used by anyone. Now it's used by rhashtable, so add it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/mm.h |  5 +++++
>  backport/compat/backport-3.15.c      | 11 +++++++++++
>  2 files changed, 16 insertions(+)
> 

Thank you for the patches. I applied the patch 3, 4 and 5, the other
patches will be applied for the next version.

Hauke
