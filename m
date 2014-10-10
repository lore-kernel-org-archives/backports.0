Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34927 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaJJNHq (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 10 Oct 2014 09:07:46 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <johannes@sipsolutions.net>)
	id 1XcZv5-00013v-PT
	for backports@vger.kernel.org; Fri, 10 Oct 2014 15:07:43 +0200
Message-ID: <1412946459.3206.0.camel@jlt4.sipsolutions.net> (sfid-20141010_150748_356813_372DEBC7)
Subject: Re: [PATCH] backports: add device coredump framework
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Fri, 10 Oct 2014 15:07:39 +0200
In-Reply-To: <1412866665-31445-1-git-send-email-johannes@sipsolutions.net> (sfid-20141009_165753_508429_C3F2A6E9)
References: <1412866665-31445-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20141009_165753_508429_C3F2A6E9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-10-09 at 16:57 +0200, Johannes Berg wrote:
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
>  backport/compat/Kconfig                        | 11 +++++
>  backport/compat/backports.h                    | 10 +++++
>  backport/compat/main.c                         |  7 ++++
>  patches/backport-adjustments/devcoredump.patch | 57 ++++++++++++++++++++++++++

Apparently this needs to be extended to compile on other kernels due to
the dev attr stuff... will have a new version eventually.

johannes

