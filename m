Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43856 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793Ab3GSVg7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 17:36:59 -0400
Date: Fri, 19 Jul 2013 23:27:09 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: Alan Stern <stern@rowland.harvard.edu>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	USB list <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
	Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH] backports: backport drvdata = NULL core driver fixes
In-Reply-To: <CAB=NE6VHgure2+2VA=XWtaii4Wc_rG7YZ=_ZetgGnvouh7HJPw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1307192326080.2229@localhost6.localdomain6> (sfid-20130719_233702_014136_0F4F2A4D)
References: <1374191339-10124-1-git-send-email-mcgrof@do-not-panic.com> <Pine.LNX.4.44L0.1307191012330.1055-100000@iolanthe.rowland.org> <CAB=NE6XmxX0UQkbchU_AKJOyENcn0auBGMPzru5C4nohg_v1sQ@mail.gmail.com>
 <CAB=NE6VHgure2+2VA=XWtaii4Wc_rG7YZ=_ZetgGnvouh7HJPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 19 Jul 2013, Luis R. Rodriguez wrote:

> On Fri, Jul 19, 2013 at 2:07 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> >> This is not a very good idea.  Although setting drvdata to NULL allowed
> >> a lot of code to be removed, it also exposed a bunch of hidden bugs --
> >> drivers were using the drvdata value even after their remove function
> >> returned.
> >
> > Eek, have we not SmPL'ify'd a proof yet to ensure code like this no
> > longer exists? Julia? :)
> 
> Come to think of it, perhaps we should require *proof* with SmPL like
> this in future to avoid regressions ?

Is it a concurrency problem?  SmPL is not so good at that in the general 
case.  One would have to know a specific case where other functions of the 
driver can be invoked after remove.

julia
