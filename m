Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:43286 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728238AbeHVNo0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Aug 2018 09:44:26 -0400
Message-ID: <040d643bff98456efb34f1c4987a5e9e6ed0b93a.camel@coelho.fi> (sfid-20180822_122016_507978_5CC50C77)
From: Luca Coelho <luca@coelho.fi>
To: cocci@systeme.lip6.fr
Cc: backports@vger.kernel.org
Date: Wed, 22 Aug 2018 13:20:07 +0300
In-Reply-To: <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi>
References: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi>
         <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Finding and replacing a struct inside another struct
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-08-22 at 12:38 +0300, Luca Coelho wrote:
> On Wed, 2018-08-22 at 12:30 +0300, Luca Coelho wrote:
> > Hi,
> > 
> > I need some help again. :)
> > 
> > I have a struct (cfg80211_crypto_settings) that contains a new
> > element
> > that I want to substitute for a function call
> > (cfg_control_port_over_nl80211).  But this struct appears inside
> > another struct.
> > 
> > So I tried this:
> > 
> > First I try to find a struct that contains the struct I want (with
> > the
> > @parent_child@ rule):
> > 
> > @parent_child@
> > identifier child;
> > identifier parent_type;
> > @@
> > struct parent_type
> > {
> > ...
> > struct cfg80211_crypto_settings child;
> > ...
> > }

Unfortunately it seems that the parent struct doesn't really match with
this.  I guess I'll have to hardcode the parent struct as well.

--
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
