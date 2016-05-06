Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:60912 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265AbcEFV3z (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 May 2016 17:29:55 -0400
Subject: Re: [PATCH] backport: add empty inline for wireless_nlevent_flush()
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1454928135-8154-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org, Luca Coelho <luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <572D0CD0.7020805@hauke-m.de> (sfid-20160506_232956_487653_8756177A)
Date: Fri, 6 May 2016 23:29:52 +0200
MIME-Version: 1.0
In-Reply-To: <1454928135-8154-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/08/2016 11:42 AM, Arend van Spriel wrote:
> The function was added in v4.5 kernel. As it can not be backported
> it is provided for older kernels as an empty inline.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> Not sure whether LINUX_BACKPORT() macro should be used. Let me
> know if that is needed.
> 
> Regards,
> Arend
> ---
>  backport/backport-include/net/iw_handler.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Thank you for the patch, it was applied with a minor modification.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
