Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40832 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdINHVK (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 14 Sep 2017 03:21:10 -0400
Message-ID: <1505373667.31630.0.camel@sipsolutions.net> (sfid-20170914_092112_262786_13A5CBAD)
Subject: Re: [PATCH 16/21] patches: brcmfmac: fix netdev destructor
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Thu, 14 Sep 2017 09:21:07 +0200
In-Reply-To: <7fad164c-e46f-ad64-4586-5521c2fc770d@broadcom.com> (sfid-20170913_213617_763307_FCD99C6F)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-17-hauke@hauke-m.de>
         <7fad164c-e46f-ad64-4586-5521c2fc770d@broadcom.com>
         (sfid-20170913_213617_763307_FCD99C6F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-09-13 at 21:36 +0200, Arend van Spriel wrote:
> 
> Way overdue, but better late than never. 

No worries, I already applied the patch anyway ;-)

> I think we prefer to use 
> spatch, but I understand the destructor handling in brcmfmac is
> complicated.

Agree - and making changes across header files is hard in spatch.

> The story above does not tell it right. brcmf_add_if() is called
> first 
> doing the alloc_netdev() setting needs_free_netdev to true and 
> subsequently brcmf_net_attach() is called doing the 
> register_netdevice(). When that is successful and only then I set
> the 
> priv_destructor. The reason for this was to keep the error path
> simple, 
> because when register_netdevice() fails it calls the priv_destructor 
> although that is not documented in struct net_device:
> 
>   *	@priv_destructor:	Called from unregister

Ok, too late now I guess, since the patch is in. But at least we'll
have your explanation here :)

> I think I will make an attempt to change brcmfmac so we can get rid
> of this patch file and rely on the spatch, but for now I am fine with
> it.

Thanks for the review!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
