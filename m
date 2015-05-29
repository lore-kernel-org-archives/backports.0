Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:57148 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753234AbbE2I3v (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 04:29:51 -0400
Date: Fri, 29 May 2015 10:29:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Arend van Spriel <arend@broadcom.com>
cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Uses of Linux backports in the industry
In-Reply-To: <55681E76.4070401@broadcom.com>
Message-ID: <alpine.DEB.2.10.1505291029350.3538@hadrien> (sfid-20150529_102954_241116_2FCE2CF2)
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>  (sfid-20150529_045521_094351_3FF15D30) <1432882836.2104.1.camel@sipsolutions.net> <55681E76.4070401@broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Fri, 29 May 2015, Arend van Spriel wrote:

> On 05/29/15 09:00, Johannes Berg wrote:
> > -lkml, that list is overfull anyway ...
> >
> > On Thu, 2015-05-28 at 19:54 -0700, Luis R. Rodriguez wrote:
> > > Me and Julia are working on a paper which evaluates use of Coccinelle
> > > on backports, a preliminary draft of such paper can be found on github
> > > [0]. We are making some tweaks to this, one of which is covering the
> > > uses of Linux backports [1] in the industry, for this we'd like to try
> > > to get feedback as to where and how folks are using backports. Please
> > > let me and Julia know -- or if the information is not sensitive please
> > > feel free to just reply to this thread and share with others. All
> > > feedback is greatly appreciated.
>
> We use the backports project solely for testing. We build and test nightly for
> a number of lab machines. Some are running recent wireless-testing kernel, but
> a number of those run a relatively old FC19 kernel (3.11.1) for which we build
> backport brcm80211 drivers. We do that for our internal tree and for the
> wireless-testing tree.
>
> > > If you are OK in having us list or
> > > generalize your usage please indicate so.
>
> Go ahead and make your list ;-)

Thanks for the feedback!

julia
