Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:33220 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbcFEPAu (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Jun 2016 11:00:50 -0400
Message-ID: <1465138846.2304.0.camel@sipsolutions.net> (sfid-20160605_170053_039984_DEB19F04)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Sun, 05 Jun 2016 17:00:46 +0200
In-Reply-To: <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com> (sfid-20160605_113018_707595_A6BA1018)
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
	 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
	 (sfid-20160605_113018_707595_A6BA1018)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2016-06-05 at 11:30 +0200, Arend van Spriel wrote:
> Due to changes in include/linux/devcoredump.h the patch needs to
> be updated.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> This patch is another shot at devcoredump patch. It just fixes
> applying the patch. However, the resulting file now uses the
> scatterlist function sg_pcopy_to_buffer() so that will need a
> backport for kernels before v3.11.
> 
I think, in order to make the new dev_coredumpsg() [or whatever it's
called] function generally available, we have to also adjust the kernel
version where the backported one gets used.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
