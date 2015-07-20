Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49615 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755601AbbGTRdI (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 13:33:08 -0400
Date: Mon, 20 Jul 2015 19:33:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof
 support
In-Reply-To: <CAB=NE6WWVSNUWyZThBe+eXoUCV+RrDuDPjUqa8bJ5Uf0Dw93NQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507201932490.2475@hadrien> (sfid-20150720_193310_241749_DD46339D)
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com> <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6> <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com> <alpine.DEB.2.10.1507201826320.2475@hadrien>
 <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com> <alpine.DEB.2.10.1507201913370.2475@hadrien> <CAB=NE6UdMhy1WP+apzMKmCwe2eevwRy72h_5f0cx4_aYtQNofQ@mail.gmail.com> <alpine.DEB.2.10.1507201924530.2475@hadrien>
 <CAB=NE6WWVSNUWyZThBe+eXoUCV+RrDuDPjUqa8bJ5Uf0Dw93NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 20 Jul 2015, Luis R. Rodriguez wrote:

> On Mon, Jul 20, 2015 at 10:25 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> Ah, so it should be safe to just check for the glimpse index on the
> >> target directory, use it if its there, otherwise default to using
> >> --use-gitgrep as a second step should be safe, regardless of whether
> >> or not the target (directory or file) is part of a git tree?
> >
> > Yep.
>
> Great thanks, can you confirm if that safe for Coccinelle 1.0.1 or
> will that only be a safe bet for 1.0.2 ? If only safe for 1.0.2 then I
> can have it default only for 1.0.2 and for 1.0.2 leave the check in
> place?

It's only supported as of 1.0.2.

julia
--
To unsubscribe from this list: send the line "unsubscribe backports" in
