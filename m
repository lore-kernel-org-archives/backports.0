Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:46345 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdIMTgS (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 13 Sep 2017 15:36:18 -0400
Received: by mail-wm0-f48.google.com with SMTP id i189so14685054wmf.1
        for <backports@vger.kernel.org>; Wed, 13 Sep 2017 12:36:17 -0700 (PDT)
Subject: Re: [PATCH 16/21] patches: brcmfmac: fix netdev destructor
To: Hauke Mehrtens <hauke@hauke-m.de>, johannes@sipsolutions.net
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <20170821222817.17376-17-hauke@hauke-m.de>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7fad164c-e46f-ad64-4586-5521c2fc770d@broadcom.com> (sfid-20170913_213620_583829_9C954D84)
Date: Wed, 13 Sep 2017 21:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170821222817.17376-17-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 22-08-17 00:28, Hauke Mehrtens wrote:
> brcmfmac uses a complicated netdev destructor handling. The
> brcmf_net_attach() function just adds a normal destructor and later the
> brcmf_add_if() function sets the needs_free_netdev callback.
> 
> The normal spatch was not applied correctly to this file, add a patch
> before to try to fx this problem manually.

Way overdue, but better late than never. I think we prefer to use 
spatch, but I understand the destructor handling in brcmfmac is complicated.

The story above does not tell it right. brcmf_add_if() is called first 
doing the alloc_netdev() setting needs_free_netdev to true and 
subsequently brcmf_net_attach() is called doing the 
register_netdevice(). When that is successful and only then I set the 
priv_destructor. The reason for this was to keep the error path simple, 
because when register_netdevice() fails it calls the priv_destructor 
although that is not documented in struct net_device:

  *	@priv_destructor:	Called from unregister

I think I will make an attempt to change brcmfmac so we can get rid of 
this patch file and rely on the spatch, but for now I am fine with it.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
