Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39242 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751358AbdGRLiy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 18 Jul 2017 07:38:54 -0400
Message-ID: <1500377929.22048.235.camel@coelho.fi> (sfid-20170718_133856_256283_7C88DAC9)
From: Luca Coelho <luca@coelho.fi>
To: Emmanuel Grumbach <egrumbach@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 18 Jul 2017 14:38:49 +0300
In-Reply-To: <1500370585.22048.233.camel@coelho.fi>
References: <1498116664-18399-1-git-send-email-arend.vanspriel@broadcom.com>
         <CANUX_P2yPeeN5k-F-56jKTMaTY=4e6_KTkBreS9OC2oube3S4w@mail.gmail.com>
         <1500370585.22048.233.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V3] backport: handle change in netdevice destructor usage
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-07-18 at 12:36 +0300, Luca Coelho wrote:
> Hi,
> 
> On Mon, 2017-07-10 at 12:43 +0300, Emmanuel Grumbach wrote:
> > On Thu, Jun 22, 2017 at 10:31 AM, Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> > > This patch deals with changes made in struct net_device by commit
> > > cf124db566e6 ("net: Fix inconsistent teardown and release of private
> > > netdev state.").
> > > 
> > > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > > ---
> > > After a (somewhat) good night sleep here is V3.
> > > 
> > 
> > I can't claim I understand any of this, but I can say that this
> > davem's patch has been applied on 4.11.X and is included in 4.11.9.
> 
> It seems that this made it into 4.12-rc6 as well, so stable aside we
> need at least to change it to LINUX_VERSION_IS_LESS(4,12,0)...
> 
> I'll send a patch for that.

I'm also having problems with mac80211_hwsim.  The reason is that if we
have needs_free_netdev = true but don't define explicitly set the
destructor function, we hit this rule:

@r5@
struct net_device *NDEV;
identifier TRUE =~ "true";
@@

-NDEV->needs_free_netdev = TRUE;
+netdev_set_priv_destructor(NDEV, free_netdev);

But free_netdev() is not define here, so the rule that should add
__free_netdev() doesn't match and we end up with an undefined function
call:

In file included from ./include/net/dst.h:12:0,
                 from /home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:22:
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c: In function ‘hwsim_mon_setup’:
/home/luca/iwlwifi/stack-dev/backport-include/linux/netdevice.h:325:23: error: ‘__free_netdev’ undeclared (first use in this function)
  (_dev)->destructor = __ ## _destructor
                       ^
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:2977:2: note: in expansion of macro ‘netdev_set_priv_destructor’
  netdev_set_priv_destructor(dev, free_netdev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
/home/luca/iwlwifi/stack-dev/backport-include/linux/netdevice.h:325:23: note: each undeclared identifier is reported only once for each function it appears in
  (_dev)->destructor = __ ## _destructor
                       ^
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:2977:2: note: in expansion of macro ‘netdev_set_priv_destructor’
  netdev_set_priv_destructor(dev, free_netdev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/Makefile.build:300: recipe for target '/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.o' failed


I guess one way to fix that would be to define another macro,
netdev_set_default_destructor or something...

I'll try to cook something up.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
