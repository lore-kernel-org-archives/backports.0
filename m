Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37810 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab3KUWoS (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 17:44:18 -0500
Message-ID: <528E8CBA.9000302@hauke-m.de> (sfid-20131121_234419_399705_604ADE74)
Date: Thu, 21 Nov 2013 23:44:10 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: [PATCH v2] backports: replace linux/bitops.h header
References: <1385045517-15868-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1385045517-15868-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/21/2013 03:51 PM, Stefan Assmann wrote:
> Instead of copying bitops.h from upstream just add what's missing in
> older kernel.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  backport/backport-include/linux/bitops.h | 217 +++----------------------------
>  1 file changed, 20 insertions(+), 197 deletions(-)

Thank you for the patch, it was applied and a new version of backports
was pushed out.

Hauke
