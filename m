Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48735 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbbF1WJC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 18:09:02 -0400
Message-ID: <5590707C.8010208@hauke-m.de> (sfid-20150629_000904_985567_4EEB4C03)
Date: Mon, 29 Jun 2015 00:09:00 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Florian Grandel <fgrandel@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] patches: backport termios usage in hci_ldisc
References: <1435357230-9712-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1435357230-9712-1-git-send-email-fgrandel@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/27/2015 12:20 AM, Florian Grandel wrote:
> The file net/bluetooth/hci_ldisc.c contains references to tty->termios.
> These changed from pointer to instance in 3.7.0. This patch backports
> all references by introducing kernel version defines.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
>  .../0020-tty-termios/net_bluetooth_hci_ldisc.patch | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
> 
Thank you for the patch, it is applied and included in the recent release.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
