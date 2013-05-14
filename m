Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50152 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab3ENGZ6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 02:25:58 -0400
Message-ID: <1368512752.8252.3.camel@jlt4.sipsolutions.net> (sfid-20130514_082601_805752_63483AB4)
Subject: Re: [PATCH 01/12] backports: make compat module use
 subsys_initcall()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Paul Stewart <pstew@chromium.org>
Date: Tue, 14 May 2013 08:25:52 +0200
In-Reply-To: <CAB=NE6U1VbZTogeXVmwFN8WxHCHcWN+Ofn5SwiW1ceg2V3ujdQ@mail.gmail.com> (sfid-20130513_192936_710997_8585D690)
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com>
	 <1368446524.8300.22.camel@jlt4.sipsolutions.net>
	 <CAB=NE6U1VbZTogeXVmwFN8WxHCHcWN+Ofn5SwiW1ceg2V3ujdQ@mail.gmail.com>
	 (sfid-20130513_192936_710997_8585D690)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> > I applied all but this one, it caused a compiler warning that seemed
> > important (missing an include?)
> >
> > /tmp/i/compat/main.c:83:1: warning: data definition has no type or
> > storage class [enabled by default]
> > /tmp/i/compat/main.c:83:1: warning: type defaults to ‘int’ in
> > declaration of ‘__exitcall’ [-Wimplicit-int]
> > /tmp/i/compat/main.c:83:1: warning: parameter names (without types) in
> > function declaration [enabled by default]
> > /tmp/i/compat/main.c:76:123: warning: ‘backport_exit’ defined but not
> > used [-Wunused-function]
> 
> Sorry can you try this?

It can't work, because the definition of __exitcall is under "#ifndef
MODULE" in include/init.h. But since module_exit() is defined to be
__exitcall (in case the module is built-in) why not just keep
module_exit()? And vice versa, subsys_init() is defined to be
module_init() in case of being built modular.

johannes

