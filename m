Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36154 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbFZTHJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 26 Jun 2015 15:07:09 -0400
Received: by lbbpo10 with SMTP id po10so69951255lbb.3
        for <backports@vger.kernel.org>; Fri, 26 Jun 2015 12:07:08 -0700 (PDT)
Received: from [192.168.43.155] (host-95-199-159-58.mobileonline.telia.com. [95.199.159.58])
        by mx.google.com with ESMTPSA id wc8sm8379926lbb.37.2015.06.26.12.07.06
        for <backports@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2015 12:07:07 -0700 (PDT)
Message-ID: <558DA2D7.5000600@gmail.com> (sfid-20150626_210712_688157_EB0ECD0B)
Date: Fri, 26 Jun 2015 21:07:03 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Linux Backports <backports@vger.kernel.org>
Subject: Fwd: Re: [PATCH] Bluetooth: hci_ldisc: backport changes
References: <C64B93E8-D2FE-421F-B2D7-87A9C6AC22BA@holtmann.org>
In-Reply-To: <C64B93E8-D2FE-421F-B2D7-87A9C6AC22BA@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi!

Wanted to send a patch including version checking upstream to the 
bluetooth guys - but wasn't accepted, see below.

Now your README in the patches folder says that new patches are not 
usually acceptable on your side.

What would be the right approach to get the below define statements into 
the backports?

Regards,

Florian

-------- Forwarded Message --------
Subject: Re: [PATCH] Bluetooth: hci_ldisc: backport changes
Date: Fri, 26 Jun 2015 20:30:15 +0200
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Grandel <fgrandel@gmail.com>
CC: linux-bluetooth@vger.kernel.org

Hi Florian,

> The references to tty->termios in hci_ldisc were not backports
> compatible. Introducing #define statements to make this file compile
> against earlier kernel versions.
>
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 177dd69..14d08b1 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -24,6 +24,7 @@
>  */
>
> #include <linux/module.h>
> +#include <linux/version.h>
>
> #include <linux/kernel.h>
> #include <linux/init.h>
> @@ -277,7 +278,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>
> 	if (enable) {
> 		/* Disable hardware flow control */
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
> 		ktermios = tty->termios;
> +#else
> +		ktermios = *tty->termios;
> +#endif

such a patch is not acceptable upstream. This is something that the 
backports projects has to keep out-of-tree.

Regards

Marcel




--
To unsubscribe from this list: send the line "unsubscribe backports" in
