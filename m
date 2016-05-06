Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:60905 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758397AbcEFV3P (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 May 2016 17:29:15 -0400
Subject: Re: [PATCH] backport: add pm_runtime_active() implementation for <
 3.9 kernels
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
References: <1461093191-461-1-git-send-email-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <572D0CA8.4070207@hauke-m.de> (sfid-20160506_232916_363249_63CC2F1D)
Date: Fri, 6 May 2016 23:29:12 +0200
MIME-Version: 1.0
In-Reply-To: <1461093191-461-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/19/2016 09:13 PM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The pm_runtime_active() helper function was introduced in kernel 3.9.
> In order to use it in earlier kernels, we need to add its
> implementation to the backports.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/linux/pm_runtime.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 backport/backport-include/linux/pm_runtime.h
> 

Thank you for the patch, it was applied with a minor modification.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
