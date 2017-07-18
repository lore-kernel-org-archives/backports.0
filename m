Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39192 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751348AbdGRJg3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 18 Jul 2017 05:36:29 -0400
Message-ID: <1500370585.22048.233.camel@coelho.fi> (sfid-20170718_113631_475670_DF3ABC47)
From: Luca Coelho <luca@coelho.fi>
To: Emmanuel Grumbach <egrumbach@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 18 Jul 2017 12:36:25 +0300
In-Reply-To: <CANUX_P2yPeeN5k-F-56jKTMaTY=4e6_KTkBreS9OC2oube3S4w@mail.gmail.com>
References: <1498116664-18399-1-git-send-email-arend.vanspriel@broadcom.com>
         <CANUX_P2yPeeN5k-F-56jKTMaTY=4e6_KTkBreS9OC2oube3S4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V3] backport: handle change in netdevice destructor usage
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

On Mon, 2017-07-10 at 12:43 +0300, Emmanuel Grumbach wrote:
> On Thu, Jun 22, 2017 at 10:31 AM, Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> > This patch deals with changes made in struct net_device by commit
> > cf124db566e6 ("net: Fix inconsistent teardown and release of private
> > netdev state.").
> > 
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > ---
> > After a (somewhat) good night sleep here is V3.
> > 
> 
> I can't claim I understand any of this, but I can say that this
> davem's patch has been applied on 4.11.X and is included in 4.11.9.

It seems that this made it into 4.12-rc6 as well, so stable aside we
need at least to change it to LINUX_VERSION_IS_LESS(4,12,0)...

I'll send a patch for that.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
