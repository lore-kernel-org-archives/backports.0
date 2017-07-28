Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:40784 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751007AbdG1Iig (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 28 Jul 2017 04:38:36 -0400
Message-ID: <1501231112.20057.123.camel@coelho.fi> (sfid-20170728_103838_985903_918B581F)
From: Luca Coelho <luca@coelho.fi>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        egrumbach@gmail.com
Cc: johannes@sipsolutions.net, backports@vger.kernel.org
Date: Fri, 28 Jul 2017 11:38:32 +0300
In-Reply-To: <9cef262a-3331-d4cd-8874-dc68f7a9e36e@broadcom.com>
References: <20170718133338.16475-1-luca@coelho.fi>
         <9cef262a-3331-d4cd-8874-dc68f7a9e36e@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: fix netdev destructor backport
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2017-07-22 at 10:01 +0200, Arend van Spriel wrote:
> On 18-07-17 15:33, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > The commit that changed the netdev destructor was also applied in
> > v4.12-rc6, so we need to update the backport.
> > 
> > Another issue was that when the default free_netdev() destructor was supposed to be used, we would get compilation errors, such as this one in hwsim:
> 
> [...]
> 
> > Fixes: 721ae78f9355 ("backport: handle change in netdevice destructor usage")
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Thanks, Arend.  Applied.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
