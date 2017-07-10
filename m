Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35609 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdGJJnS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 10 Jul 2017 05:43:18 -0400
Received: by mail-it0-f68.google.com with SMTP id v193so12364399itc.2
        for <backports@vger.kernel.org>; Mon, 10 Jul 2017 02:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498116664-18399-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1498116664-18399-1-git-send-email-arend.vanspriel@broadcom.com>
From: Emmanuel Grumbach <egrumbach@gmail.com>
Date: Mon, 10 Jul 2017 12:43:17 +0300
Message-ID: <CANUX_P2yPeeN5k-F-56jKTMaTY=4e6_KTkBreS9OC2oube3S4w@mail.gmail.com> (sfid-20170710_114322_080259_569D3843)
Subject: Re: [PATCH V3] backport: handle change in netdevice destructor usage
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jun 22, 2017 at 10:31 AM, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> This patch deals with changes made in struct net_device by commit
> cf124db566e6 ("net: Fix inconsistent teardown and release of private
> netdev state.").
>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> After a (somewhat) good night sleep here is V3.
>

I can't claim I understand any of this, but I can say that this
davem's patch has been applied on 4.11.X and is included in 4.11.9.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
