Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34529 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761127Ab3DBVnS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 17:43:18 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so946202lbi.20
        for <backports@vger.kernel.org>; Tue, 02 Apr 2013 14:43:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364937780.8204.18.camel@jlt4.sipsolutions.net>
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
 <1364923241.8204.15.camel@jlt4.sipsolutions.net> <515B4994.3030309@pendre.co.uk>
 <1364937780.8204.18.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 2 Apr 2013 14:42:56 -0700
Message-ID: <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com> (sfid-20130402_234321_547441_29B4BB2E)
Subject: Re: [ANN] new backports project
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Phil Perry <phil@pendre.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 2, 2013 at 2:23 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> I only addressed what compat-drivers-... had a few days ago.
>
> However, I simplified the system a bit. I don't have any snapshot, but I
> did announce the git tree. Grab that, run ./gentree.py against
> linux-next and you should get something. Then you will have to hack up
> the Kconfig (backport/compat/Kconfig) and include files
> (backport/include/*), presumably.

Or you can wait until we merge. At this point I'm freezing development
on compat and compat-drivers to merge all this work onto Johannes'
tree.

> If you're interested in alx, you'd have to add that -- look at the
> copy-list.alx file for that.

Johannes already committed a few things here, I'll be sure to test it as well.

> I hope that soon enough Luis might cut some testing releases from this
> though.

Absolutely, full steam ahead, just give us a few days.

I should note that RHEL / SUSE / Debian all had the same issues --
running into symbols we are exporting with the same upstream name. The
move to use LINUX_BACKPORT() should help cure these issues in general
moving forward. Additionally if you really want to help in this area
please review commit 8ae96730 on compat.git specifically Andi Kleen's
work on module namespace. If we can figure out to support module
namespace *ourselves*, ie, without Linus having to carry this crap
around, then we'd solve all these issues easily, I believe we wouldn't
have to rely on LINUX_BACKPORT() and in fact that would also mean
renaming our *driver* symbols. This means for instance you can run one
drivers with your stock mac80211, another with the backported version,
should you ever have to support such crazy environement.

  Luis
