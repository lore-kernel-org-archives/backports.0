Return-path: <backports-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:38432 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaDEOOI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 10:14:08 -0400
Received: by mail-bk0-f42.google.com with SMTP id mx12so404494bkb.29
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 07:14:06 -0700 (PDT)
Date: Sat, 5 Apr 2014 16:14:00 +0200
From: Alexander Aring <alex.aring@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Amerigo Wang <amwang@redhat.com>,
	linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net
Subject: Re: [PATCH 23/27] backports: backport ieee802154 6lowpan support
 down to 3.5
Message-ID: <20140405141358.GA30323@omega> (sfid-20140405_161428_095025_E35DCFBF)
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
 <1396701662-15165-24-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1396701662-15165-24-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

On Sat, Apr 05, 2014 at 05:40:57AM -0700, Luis R. Rodriguez wrote:
> Commit 633fc86ff62 added the ieee802154_6lowpan namespace
> and 7240cdec60b extended it (as on linux-next next-20140311).
> Its important to note though that 633fc86ff62 also extends the
> global net namespace. Since we cannot extend the global net
> namespace we define our own backport namespace for 6lowpan
> that can be used only be used by our backported subsystems,
> nothing more. Since ieee802154_6lowpan requires support for
> net_get_random_once() which uses static keys and a slew of
> new skb fragment support we simply require at least 3.5 to
> use 6lowpan. I did my best effort to backport this to kernels
> older than 3.5 but quickly ran into a slew of hairy issues.
> 
> The last thing we needed to address was usage of the helper
> inet_frag_evictor() added by Alexander via commit 6b102865e7
> through v3.7. Since we can't backport that with macros or
> inline helpers we add a patch to carry the changes there. If
> that grows we can consider using Coccinelle.
> 
> If you are going to try to backport 6lowpan to kernels older
> than 3.5 be warned that the litmus test for patches will be
> to pass ckmake --allyesconfig for all supported kernels for
> every patch you provide.

thanks for this backport, but in the olders 6LoWPAN implementation too
many things are broken. I stopped to fix issues in net and push my fixes
in net-next. The current stack in net-next is in a more useable state.

For making a backport which make sense you need to take many other patches:

e5d966eff3ac364e4505c7c4da632321657029b3 ("6lowpan: fix udp byte ordering")
5cede84c9897f9db522699c4b3ff6ffe3d11e038 ("6lowpan: udp
use lowpan_push_hc_data function")
c04fe5483df3b23beec9a21a285606f5e34768f1 ("6lowpan: set and use mac_len
for mac header length")
...

Also some patches which aren't from me and which are in net-next:
8cfad496c4257441710735ccef622f3829870164 ("ieee802154: properly unshare
skbs in ieee802154 *_rcv functions")
...

and some patches which has issues with 6LoWPAN upper layer protocols:
d1c53c8e870cdedb6fc9550f41c558bab45b5219 ("icmpv6_filter: allow ICMPv6
messages with bodies < 4 bytes")

... this will end in a huge list.

Sorry but I see no sense to backport these 6LoWPAN patches because there
are too many issues and the active mainline IEEE 802.15.4 6LoWPAN
developers hope that there are no users below net-next there.

If you are from a distribution I can give you the advice to disable IEEE
802.15.4 6LoWPAN until it's in a more useable state. Sorry!

- Alex

