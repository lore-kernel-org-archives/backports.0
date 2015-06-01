Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23788
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751588AbbFAUDX (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 1 Jun 2015 16:03:23 -0400
Date: Mon, 1 Jun 2015 22:03:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Felix Fietkau <nbd@openwrt.org>
cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Uses of Linux backports in the industry
In-Reply-To: <556CA991.7030302@openwrt.org>
Message-ID: <alpine.DEB.2.02.1506012203070.2222@localhost6.localdomain6> (sfid-20150601_220327_251297_A12F5211)
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com> <556CA991.7030302@openwrt.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 1 Jun 2015, Felix Fietkau wrote:

> On 2015-05-29 04:54, Luis R. Rodriguez wrote:
> > Me and Julia are working on a paper which evaluates use of Coccinelle
> > on backports, a preliminary draft of such paper can be found on github
> > [0]. We are making some tweaks to this, one of which is covering the
> > uses of Linux backports [1] in the industry, for this we'd like to try
> > to get feedback as to where and how folks are using backports. Please
> > let me and Julia know -- or if the information is not sensitive please
> > feel free to just reply to this thread and share with others. All
> > feedback is greatly appreciated. If you are OK in having us list or
> > generalize your usage please indicate so.
> In OpenWrt, we use backports to stay up to date with current wireless
> drivers without being forced into frequently updating the kernels as
> well. We support many different platforms, and sometimes it takes a
> while to update the kernel on them.
> Using backports significantly reduces the amount of effort that we need
> to put into maintaining the wireless drivers.
> When making changes to wireless drivers or mac80211, which I submit
> upstream, I also develop them in our most recent backports snapshot
> first (typically generated from wireless-testing). When they are done, I
> port them to a proper git tree and submit them from there.
> 
> In OpenWrt, we typically update the backports snapshot outside of the
> normal kernel release cycle (always to latest wireless-testing) and
> stabilize that by cherry-picking individual patches on top of it.

Thanks for the feedback!

julia
