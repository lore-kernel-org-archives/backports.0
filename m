Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48732 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbbF1WIq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 18:08:46 -0400
Message-ID: <5590706D.3010302@hauke-m.de> (sfid-20150629_000850_060917_0CADAD5A)
Date: Mon, 29 Jun 2015 00:08:45 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Florian Grandel <fgrandel@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] patches: fix compile warning
References: <1435342454-21239-1-git-send-email-fgrandel@gmail.com> <1435342454-21239-2-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1435342454-21239-2-git-send-email-fgrandel@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/26/2015 08:14 PM, Florian Grandel wrote:
> Usage of the bt_tx_busylock variable was already patched but not the
> declaration which caused a compile warning. This patch introduces a
> define statement that also excludes the variable declaration.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---

Thank you for the patches, both are applied and included in the recent
release.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
