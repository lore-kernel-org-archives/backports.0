Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:60893 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758397AbcEFV2f (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 May 2016 17:28:35 -0400
Subject: Re: [PATCH 1/2] backport: add stub for of_translate_address()
 function
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1459499619-16641-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <572D0C80.2010408@hauke-m.de> (sfid-20160506_232836_908495_61714EAD)
Date: Fri, 6 May 2016 23:28:32 +0200
MIME-Version: 1.0
In-Reply-To: <1459499619-16641-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/01/2016 10:33 AM, Arend van Spriel wrote:
> The stub for of_translate_address() was added in 4.4 kernel. Prior to
> that it was only available when CONFIG_OF_ADDRESS was selected. So
> backport the stub for kernel < 4.4 and !CONFIG_OF_ADDRESS.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  backport/backport-include/linux/of_address.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 backport/backport-include/linux/of_address.h
> 
Thank you for the patch, it was applied with a minor modification.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
