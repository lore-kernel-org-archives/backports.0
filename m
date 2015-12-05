Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36734 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbbLEUOF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Dec 2015 15:14:05 -0500
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5663458B.1070103@hauke-m.de> (sfid-20151205_211408_495778_1F398223)
Date: Sat, 5 Dec 2015 21:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <1448884387-20806-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/30/2015 12:53 PM, Arend van Spriel wrote:
> Patch for brcmfmac need update path as it now resides under
> the broadcom vendor directory.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  .../network/0055-name_assign_type/brcmfmac.patch                      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
> index c68e9d0..bcbac24 100644
> --- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
> +++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
> @@ -1,5 +1,5 @@
> ---- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
> -+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
> +--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> ++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>  @@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
>   	}
>   
> 
I will do this for all patches at once, but thanks.

Is it ok to replace the b43, b43legacy and brcm80211 by this single line?
drivers/net/wireless/broadcom/

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
