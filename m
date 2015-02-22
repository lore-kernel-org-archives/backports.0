Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58786 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbbBVCCo (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 21:02:44 -0500
Message-ID: <54E938C1.1070606@hauke-m.de> (sfid-20150222_030246_089927_F10713D9)
Date: Sun, 22 Feb 2015 03:02:41 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: remove patches for SKBTX_WIFI_STATUS
References: <1422638605-11633-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1422638605-11633-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/30/2015 06:23 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The tx_flags haven't been a union since 2.6.37, so since we
> no longer support that kernel the '&' operation will now be
> possible on all supported kernels. Use that fact to get rid
> of the patch by defining SKBTX_WIFI_STATUS to 0 so the code
> also disappears, but doesn't have to be patched.
> 
> While at it, clean up a double #if.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thank you for the patch it was applied to backports.

Hauke

