Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33209 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbDQVlW (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Apr 2015 17:41:22 -0400
Received: by wgin8 with SMTP id n8so125778071wgi.0
        for <backports@vger.kernel.org>; Fri, 17 Apr 2015 14:41:21 -0700 (PDT)
Date: Fri, 17 Apr 2015 23:42:32 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Possible to build-in backports modules into kernel
Message-ID: <20150417214231.GA3800@t61> (sfid-20150417_234125_472771_FF0692C5)
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20150417133004.GC16380@vorel-pc>
 <5531314D.1000706@lwfinger.net>
 <1429291720.1885.5.camel@sipsolutions.net>
 <CAB=NE6X=-PQR3=uxmHZL+Jf8muX6QmmTjKkBnKXUWDk1Bkeccw@mail.gmail.com>
 <55314F5C.3000907@lwfinger.net>
 <1429295166.1885.6.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429295166.1885.6.camel@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi there,

> > > https://backports.wiki.kernel.org/index.php/Documentation/integration
thanks for your comments and the link. I skip that before as I thought it's actually for
backports developers, not users. I'll read it more carefully.

> > Just to clarify, the entire kernel will need to be built from some tree. In my 
> > reading of the original post, I got the impression that Petr wanted to use a 
> > pre-built kernel.

> Yes, indeed, that's not possible - and doesn't really make sense anyway,
> since if you have access to the kernel image and sources to build
> against, you might as well rebuild the whole kernel.

I'm stack with very old kernel (2.6.37 for arm TI's DM365). No pre-built kernel , I've
built the kernel as well, everything is working nice. But as I use embedded device, it
would be nice to have the drivers build-in (performance).

For some of modules I get message: "This feature depends on another which has been
configured as a module. As a result, this feature will be built as a module.". I'll try to
find the dependency, but is there any hint, how to search?

Thanks a lot for backports, it helped me already :-).

Kind regards,
Petr
