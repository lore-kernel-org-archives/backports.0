Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:18849 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbeHVOTD (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Aug 2018 10:19:03 -0400
Date: Wed, 22 Aug 2018 06:54:16 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Luca Coelho <luca@coelho.fi>
cc: cocci@systeme.lip6.fr, backports@vger.kernel.org
Subject: Re: [Cocci] Finding and replacing a struct inside another struct
In-Reply-To: <040d643bff98456efb34f1c4987a5e9e6ed0b93a.camel@coelho.fi>
Message-ID: <alpine.DEB.2.21.1808220653240.2365@hadrien> (sfid-20180822_125441_673185_40F4B887)
References: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi> <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi> <040d643bff98456efb34f1c4987a5e9e6ed0b93a.camel@coelho.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Wed, 22 Aug 2018, Luca Coelho wrote:

> On Wed, 2018-08-22 at 12:38 +0300, Luca Coelho wrote:
> > On Wed, 2018-08-22 at 12:30 +0300, Luca Coelho wrote:
> > > Hi,
> > >
> > > I need some help again. :)
> > >
> > > I have a struct (cfg80211_crypto_settings) that contains a new
> > > element
> > > that I want to substitute for a function call
> > > (cfg_control_port_over_nl80211).  But this struct appears inside
> > > another struct.
> > >
> > > So I tried this:
> > >
> > > First I try to find a struct that contains the struct I want (with
> > > the
> > > @parent_child@ rule):
> > >
> > > @parent_child@
> > > identifier child;
> > > identifier parent_type;
> > > @@
> > > struct parent_type
> > > {
> > > ...
> > > struct cfg80211_crypto_settings child;
> > > ...
> > > }
>
> Unfortunately it seems that the parent struct doesn't really match with
> this.  I guess I'll have to hardcode the parent struct as well.

Is this a Coccinelle problem, or is the code just not organized as you
would like.  If it is a Coccinelle problem, please send the source code as
well.

thanks,
julia
--
To unsubscribe from this list: send the line "unsubscribe backports" in
