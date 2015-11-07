Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52944 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGRHv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 12:07:51 -0500
Subject: Re: [PATCH v2] backport: backport debugfs_create_bool()
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1446797040-23973-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <563E2FE5.10103@hauke-m.de> (sfid-20151107_180752_508269_9E2DC2D2)
Date: Sat, 7 Nov 2015 18:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <1446797040-23973-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/06/2015 09:04 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The prototype for this function is changing upstream, so backport
> a copy of the new one that has a bool * argument instead of u32 *.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/debugfs.h | 15 ++++++++
>  backport/compat/Makefile                  |  1 +
>  backport/compat/backport-4.4.c            | 64 +++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 backport/compat/backport-4.4.c
> 

Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
