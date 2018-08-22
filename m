Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:43236 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728246AbeHVNCj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Aug 2018 09:02:39 -0400
Message-ID: <74f2d0049e235c1bd02f94a83cdaf00eaf401174.camel@coelho.fi> (sfid-20180822_113835_047727_4CE405BE)
From: Luca Coelho <luca@coelho.fi>
To: cocci@systeme.lip6.fr
Cc: backports@vger.kernel.org
Date: Wed, 22 Aug 2018 12:38:30 +0300
In-Reply-To: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi>
References: <ea981773c0caca06958f6dc5f5238954b520056b.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Finding and replacing a struct inside another struct
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-08-22 at 12:30 +0300, Luca Coelho wrote:
> Hi,
> 
> I need some help again. :)
> 
> I have a struct (cfg80211_crypto_settings) that contains a new
> element
> that I want to substitute for a function call
> (cfg_control_port_over_nl80211).  But this struct appears inside
> another struct.
> 
> So I tried this:
> 
> First I try to find a struct that contains the struct I want (with
> the
> @parent_child@ rule):
> 
> @parent_child@
> identifier child;
> identifier parent_type;
> @@
> struct parent_type
> {
> ...
> struct cfg80211_crypto_settings child;
> ...
> }
> 
> And then I try to match usage of the parent struct that I found:
> 
> @@
> identifier parent_child.child;
> identifier parent_child.parent_type;
> identifier p;
> @@
> struct parent_type *p;
> <...
> -p.child.control_over_nl80211
> +cfg_control_port_over_nl80211(&p.child)
> ...>

Ah, I think I found the problem... I was using p.child, but I was
defining p as a pointer!

I guess I should have this instead:

@@
identifier parent_child.child;
identifier parent_child.parent_type;
ide
ntifier p;
@@
struct parent_type *p;
<...
-p->child.control_over_nl80211
+cf
g_control_port_over_nl80211(&p->child)
...>

--
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
