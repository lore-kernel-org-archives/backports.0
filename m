Return-path: <backports-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40648 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756899AbaKTVbR (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 20 Nov 2014 16:31:17 -0500
Date: Thu, 20 Nov 2014 22:31:13 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, julia.lawall@lip6.fr, oblinger@gmail.com
Subject: Re: [PATCH 1/5] backports: rename wpan-phy.h to cfg802154.h
Message-ID: <20141120213113.GT24486@wotan.suse.de> (sfid-20141120_223119_474146_B625391C)
References: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com> <1416518183-7347-2-git-send-email-mcgrof@do-not-panic.com> <546E5BB1.2010007@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <546E5BB1.2010007@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Nov 20, 2014 at 10:22:57PM +0100, Hauke Mehrtens wrote:
> On 11/20/2014 10:16 PM, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > Address the renaming. This is an example type of upstream that
> > we should easily be able to automatically backport through
> > inference. Logic:
> > 
> >   for f in copy_list:
> >     if f in git_delta_renamed:
> >       adjust_copy_list(f)
> > 
> > We'd first have to build a series of types of changes from
> > the delta between the last linux-next tag we tracked and the
> > currenty evaluated one, the git_delta_renamed would contain
> > a list of renames that happened between the two tags.
> > 
> > commit 5ad60d36993596f7b3b958500f9c66c5338cd855
> > Author: Alexander Aring <alex.aring@gmail.com>
> > Date:   Sat Oct 25 09:41:02 2014 +0200
> > 
> >     ieee802154: move wpan-phy.h to cfg802154.h
> > 
> >     The wpan-phy header contains the wpan_phy struct information. Later this
> >     header will be have similar function like cfg80211 header. The cfg80211
> >     header contains the wiphy struct which is identically the wpan_phy
> >     struct inside 802.15.4 subsystem.
> > 
> >     Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >     Cc: Alan Ott <alan@signal11.us>
> >     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> > ---
> >  copy-list | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/copy-list b/copy-list
> > index d11b051..b7ac165 100644
> > --- a/copy-list
> > +++ b/copy-list
> > @@ -167,7 +167,7 @@ include/linux/ieee802154.h
> >  include/net/af_ieee802154.h
> >  include/linux/nl802154.h
> >  include/net/ieee802154_netdev.h
> > -include/net/wpan-phy.h
> > +include/net/cfg802154.h
> 
> I added cfg802154.h in an earlier patch, but I mossed removing wpan-phy.h .

Thanks, failed to see that, adjusted:

>From f6b7140c9a1f0c724ad0eb462f66a7f5baadf009 Mon Sep 17 00:00:00 2001
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 19 Nov 2014 11:28:14 -0800
Subject: [PATCH] backports: remove wpan-phy.h after rename to cfg802154.h

Address the renaming. cfg802154.h was already added but we forgot
to remove wpan-phy.h. This is an example type of upstream that
we should easily be able to automatically backport through
inference. Logic:

  for f in copy_list:
    if f in git_delta_renamed:
      adjust_copy_list(f)

We'd first have to build a series of types of changes from
the delta between the last linux-next tag we tracked and the
currenty evaluated one, the git_delta_renamed would contain
a list of renames that happened between the two tags.

commit 5ad60d36993596f7b3b958500f9c66c5338cd855
Author: Alexander Aring <alex.aring@gmail.com>
Date:   Sat Oct 25 09:41:02 2014 +0200

    ieee802154: move wpan-phy.h to cfg802154.h

    The wpan-phy header contains the wpan_phy struct information. Later this
    header will be have similar function like cfg80211 header. The cfg80211
    header contains the wiphy struct which is identically the wpan_phy
    struct inside 802.15.4 subsystem.

    Signed-off-by: Alexander Aring <alex.aring@gmail.com>
    Cc: Alan Ott <alan@signal11.us>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 copy-list | 1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index d11b051..3eff5ab 100644
--- a/copy-list
+++ b/copy-list
@@ -167,7 +167,6 @@ include/linux/ieee802154.h
 include/net/af_ieee802154.h
 include/linux/nl802154.h
 include/net/ieee802154_netdev.h
-include/net/wpan-phy.h
 include/linux/spi/at86rf230.h
 include/linux/spi/cc2520.h
 net/6lowpan/
-- 
2.1.1

