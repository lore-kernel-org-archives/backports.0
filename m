Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:54899 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935060Ab3FSVHh (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 19 Jun 2013 17:07:37 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so4924993lab.23
        for <backports@vger.kernel.org>; Wed, 19 Jun 2013 14:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 19 Jun 2013 14:07:16 -0700
Message-ID: <CAB=NE6VG5F+BR8F6NmfEiMh-PQc2yR_x7yb=CE6dL_DiuCXyxA@mail.gmail.com> (sfid-20130619_230739_366684_000FADB0)
Subject: Re: [PATCH 0/8] backports: build Ethernet driver on < 3.2 and add ieee802154
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jun 15, 2013 at 8:37 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> The first 4 patches are making the Ethernet driver compile on kernel
> versions < 3.2. The last 4 patches are adding support for ieee802154.
>
> Hauke Mehrtens (8):
>   backports: move netif_set_real_num_rx_queues() to compat-2.6.37.c
>   backports: alx driver needs at least kernel 2.6.31
>   backports: build ATL1E only on kernel > 2.6.26
>   backports: add NET_CORE config option
>   backports: use the given parameter in NETLINK_CB_PORTID()
>   backports: add module_spi_driver
>   backports: add cast in class_find_device()
>   backports: add ieee802154

Thanks, applied and pushed!

  Luis
