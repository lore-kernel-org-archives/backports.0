Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52735 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934121AbbIVVls (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 22 Sep 2015 17:41:48 -0400
Subject: Re: [PATCH] backports: fix typo in copy-list
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1441801369-6348-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5601CB1A.8090804@hauke-m.de> (sfid-20150922_234150_128786_AD74627E)
Date: Tue, 22 Sep 2015 23:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <1441801369-6348-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/09/2015 02:22 PM, Arend van Spriel wrote:
> The platform data file is called st-nci.h instead of st_nci.h.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  copy-list | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thank you for the patch, it was applied and pushed out.
For some time this file was in the under both names.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
