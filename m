Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47974 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733Ab3HOLjh (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 Aug 2013 07:39:37 -0400
Message-ID: <520CBDF1.7020406@hauke-m.de> (sfid-20130815_133939_472795_06C57CF6)
Date: Thu, 15 Aug 2013 13:39:29 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 2/2] backports:  Add patch for cw1200_sdio with kernels
 < 3.2
References: <1375367966-10863-1-git-send-email-pizza@shaftnet.org> <1375367966-10863-2-git-send-email-pizza@shaftnet.org>
In-Reply-To: <1375367966-10863-2-git-send-email-pizza@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/01/2013 04:39 PM, Solomon Peachy wrote:
> It's probably not feasible to backport the SDIO quirk mechanism, but
> without the qurik or this patch, the hardware will hang with 512-byte
> transfers.
> 
> Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
> ---
>  .../network/0001-cw1200-sdio-quirk/cw1200.patch           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch
> 
> diff --git a/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch b/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch
> new file mode 100644
> index 0000000..2533051
> --- /dev/null
> +++ b/patches/unified-drivers/network/0001-cw1200-sdio-quirk/cw1200.patch

Please move this patch to
patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch

I can not say anything to the content of this patch, but otherwise these
two patches are looking good.

Hauke
