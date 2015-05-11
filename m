Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49133 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbbEKV5Q (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:57:16 -0400
Message-ID: <555125BA.5040205@hauke-m.de> (sfid-20150511_235719_178375_C07F6AB7)
Date: Mon, 11 May 2015 23:57:14 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: include missing device.h
References: <1430831989-2716-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1430831989-2716-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/05/2015 03:19 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> debugfs.h needs device.h, otherwise you get a warning
> 
> backport-include/linux/debugfs.h:11:10: warning: ‘struct device’ declared inside parameter list
> 
> Change-Id: Ic669c855d47a8114649d1d319fcb1bcdc024415c
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/debugfs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
Thank you for the patch, it was applied and pushed out.

Hauke
