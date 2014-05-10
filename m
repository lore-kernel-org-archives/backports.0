Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55329 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbaEJMTd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 10 May 2014 08:19:33 -0400
Message-ID: <1399724370.4291.5.camel@jlt4.sipsolutions.net> (sfid-20140510_141935_313413_06E9BB20)
Subject: Re: [PATCH] backports: fix class/bus attribute group spatch
 conversion
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sat, 10 May 2014 14:19:30 +0200
In-Reply-To: <CAB=NE6Ua=H0HjyaL3c812rXFZHbcTaWatecP7u27hWdREjmqVg@mail.gmail.com> (sfid-20140509_213749_918649_800A6B8F)
References: <1399616596-12805-1-git-send-email-johannes@sipsolutions.net>
	 <CAB=NE6Ua=H0HjyaL3c812rXFZHbcTaWatecP7u27hWdREjmqVg@mail.gmail.com>
	 (sfid-20140509_213749_918649_800A6B8F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-05-09 at 12:37 -0700, Luis R. Rodriguez wrote:
> On Thu, May 8, 2014 at 11:23 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> >
> > The spatch conversion (commit 05d44557c6a83b4ecb935cb6306f62,
> > "backports: transform group attribute backport to SmPL form")
> > added an #ifdef that shouldn't be there - remove it.
> 
> When re-doing this I did make this change on purpose as I could not
> see how those were being defined for newer kernels, where is that?

Arguably you just got the ifdefs wrong - it should be < not >=. However,
the backport header file backport/backport-include/linux/device.h
#undef's ATTRIBUTE_GROUPS and redefines it so that we can call the init
function unconditionally. That's not strictly needed, but if we wanted
to do it differently we'd need to rewrite the header file a bit. I
originally did it this way to make the patch smaller, now that it's an
spatch it doesn't matter much.

johannes

