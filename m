Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40693 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbaJYTAw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 15:00:52 -0400
Message-ID: <544B8EDE.8080901@hauke-m.de> (sfid-20141025_210055_092128_6FD0BB40)
Date: Sat, 25 Oct 2014 13:51:58 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v3] backports: add device coredump framework
References: <1413909337-8938-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1413909337-8938-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/21/2014 06:35 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As drivers will start requiring the new framework and it has
> been merged to linux/master during the 3.18 merge window, we
> can include it into backports to compile if needed.
> 
> On kernels that do already have it but didn't want it built
> honor that, but if building otherwise don't. This may need
> to be revisited in the future.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/compat/Kconfig                        |  11 +++
>  backport/compat/backports.h                    |  10 ++
>  backport/compat/main.c                         |   7 ++
>  patches/backport-adjustments/devcoredump.patch | 121 +++++++++++++++++++++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 patches/backport-adjustments/devcoredump.patch
> 

Thank you for the patches, both are applied and pushed out.

hauke

