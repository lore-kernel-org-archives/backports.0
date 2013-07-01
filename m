Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:39947 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab3GAVaD (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 1 Jul 2013 17:30:03 -0400
MIME-Version: 1.0
In-Reply-To: <CAFVW_7nkkPO62Zs=bPPrze-390hijx47061SXuf0FfPOPc547Q@mail.gmail.com>
References: <CAB=NE6UV_CG+UKiUoUZi=M8eN_D0bWY1kUccifvoV3QC6q2Gug@mail.gmail.com>
 <CAFVW_7nkkPO62Zs=bPPrze-390hijx47061SXuf0FfPOPc547Q@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 1 Jul 2013 14:24:27 -0700
Message-ID: <CAB=NE6Uco7tMVFdYtm8gWC66exhAaf4s=PdKuvz+1j7Dg_PpZg@mail.gmail.com> (sfid-20130701_233005_699308_D34FC5D9)
Subject: Re: alx unification project dead
To: piruthiviraj natarajan <piruthiviraj@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jun 19, 2013 at 5:12 PM, piruthiviraj natarajan
<piruthiviraj@gmail.com> wrote:
> On Thu, Jun 20, 2013 at 3:05 AM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> Given no one worked on pushing this driver upstream... Johannes Berg
>> has posted alx for integration upstream, and his changes pushed the
>> driver under the GPLv2. This project is now dead.
>>
> Is there a possiblity for this driver to move to Linux kernel?

Its now merged upstream as part of the Linux kernel but that driver
was modified a bit to get cleaned up given the Linux alx upstreaming
effort was dropped. The driver was cleaned up by Johannes Berg and
relicensed to GPLv2 or later. I just kicked out a backports release
that lets you use the new upstreamed driver:

https://www.kernel.org/pub/linux/kernel/projects/backports/2013/06/18/backports-20130618.tar.bz2

Please try that!

The QCA alx team, or anyone wishing to fix bugs, should use the new
upstreamed driver for future fixes / enhancements / etc.

> There are practically users who don't care about FreeBSD anyway.

This is not true! FreeBSD has many users and lets recall that the
reason we wanted to work on this approach was to help pave the way as
an approach to help kill proprietary drivers, which are simply
grotesque and the reason why tons of original driver code is simply an
engineering reckless mess. Device driver development *cannot* and
*should not* be left up to corporations to lead. This effort failed
simply because we lacked assigned resources to work on this both on
the FreeBSD and on the final stretch of Linux upstreaming, the general
groundwork and ideas are there though and as far as I can tell I think
a few companies got the hint and hopefully are looking into this as a
future venue. BSD folks can simply use the external unified tree now
to port the driver to BSD but given the license divergence the alx
driver on Linux will remain GPLv2 or later and fixes / enhancements as
well, as such the drivers will unfortunately diverge.

The ideas expressed on this e-mail are my own and in no way shape or
form represent who I work for.

  Luis
