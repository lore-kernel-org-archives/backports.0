Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41682 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbbKWXUY (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:20:24 -0500
Subject: Re: [PATCH] header: move smp_mb__after_atomic definition to the
 correct file
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
References: <1447930121-3213-1-git-send-email-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <56539F36.4090503@hauke-m.de> (sfid-20151124_002025_990339_C882D193)
Date: Tue, 24 Nov 2015 00:20:22 +0100
MIME-Version: 1.0
In-Reply-To: <1447930121-3213-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/19/2015 11:48 AM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The smp_mb__after_atomic definition is in barrier.h in the mainline,
> but we currently include the backport in atomic.h.  This may cause
> problems with certain include chain combinations.
> 
> Move it to the correct place.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/asm/atomic.h  | 4 ----
>  backport/backport-include/asm/barrier.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Thank you for the patch it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
