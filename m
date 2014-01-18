Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54044 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbaARPxS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 10:53:18 -0500
Message-ID: <52DAA366.6080601@hauke-m.de> (sfid-20140118_165319_762607_ADEFB162)
Date: Sat, 18 Jan 2014 16:53:10 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: backport hex2bin()
References: <1387572446-4446-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1387572446-4446-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/20/2013 09:47 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This changed from not having a return value to having one,
> so backport the version that has it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/kernel.h |  6 ++++++
>  backport/compat/Makefile                 |  1 +
>  backport/compat/backport-3.2.c           | 25 +++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100644 backport/compat/backport-3.2.c
> 
Thank you for the patch, it was applied.

Hauke

