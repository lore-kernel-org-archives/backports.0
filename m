Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:33130 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab3EQMIe (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 May 2013 08:08:34 -0400
Message-ID: <1368792510.14961.4.camel@jlt4.sipsolutions.net> (sfid-20130517_140837_590454_481177FC)
Subject: Re: [PATCH 1/3] backports: address NFC LLCP code shift
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Fri, 17 May 2013 14:08:30 +0200
In-Reply-To: <1368788445-1641-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_130056_980511_5CEC505F)
References: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368788445-1641-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130517_130056_980511_5CEC505F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-05-17 at 04:00 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Samuel folded code under net/nfc/llcp/ onto
> the parent net/nfc/ directory with llcp_ prefixes
> for the files. Address this change introduced
> as of next-20130430.
> 
> commit 30cc4587659e1c9b1bfade8b2a757d91e04758ab
> Author: Samuel Ortiz <sameo@linux.intel.com>
> Date:   Fri Apr 26 11:49:40 2013 +0200
> 
>     NFC: Move LLCP code to the NFC top level diirectory
> 
>     And stop making it optional. LLCP is a fundamental part of the NFC
>     specifications and making it optional does not make much sense.
> 
>     Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  copy-list |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/copy-list b/copy-list
> index f2afa15..c7dcf39 100644
> --- a/copy-list
> +++ b/copy-list
> @@ -129,7 +129,6 @@ drivers/gpu/drm/
>  # NFC core
>  net/nfc/
>  net/nfc/hci/
> -net/nfc/llcp/

There isn't really any point in listing net/nfc/ and net/nfc/hci/, I'll
make a follow-up patch to remove all the subdirs that aren't needed.
Copying is recursive, after all.

johannes

