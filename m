Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48788 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856AbcEPT0O (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 May 2016 15:26:14 -0400
Message-ID: <1463426768.2179.3.camel@sipsolutions.net> (sfid-20160516_212616_094004_0C68CBAF)
Subject: Re: wireless_nlevent_flush backported to stable kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Emmanuel Grumbach <egrumbach@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 16 May 2016 21:26:08 +0200
In-Reply-To: <5738467E.4020005@broadcom.com> (sfid-20160515_115109_089094_3A0AC8CB)
References: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com>
	 <5738467E.4020005@broadcom.com> (sfid-20160515_115109_089094_3A0AC8CB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2016-05-15 at 11:50 +0200, Arend Van Spriel wrote:
> 
> > On my system, I fixed it with the patch below, but it is surely not
> > good enough.
> In general this is avoided by preceeding the stub function with:
> 
> #define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
> 
> This way you will use the stub and not the in-kernel function.

That's normally fine, but not a good idea here because this really is a
*stub*, and thus using the stub instead of the real function removes
the ability to actually get the bugfix. So in this case, where it's a
stub and not a full backport, it's better to try to get the original
function in as many situations as possible.

> There has
> been discussions about adding a mechanism to avoid backport if kernel
> has the function available. No actual work in that area has been done
> yet.

Oh, I've done that - but it was so terribly slow that it was
essentially unusable...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
