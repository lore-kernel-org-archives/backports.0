Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49341 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbaDEUDF (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 16:03:05 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so3423308lbi.8
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 13:03:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140405141358.GA30323@omega>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
 <1396701662-15165-24-git-send-email-mcgrof@do-not-panic.com> <20140405141358.GA30323@omega>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 5 Apr 2014 13:02:42 -0700
Message-ID: <CAB=NE6WkzZKfL4OWxnh5wsHCBiS+K7-cVkQ9kJwuNwxOx7jXXg@mail.gmail.com> (sfid-20140405_220307_973458_E52170AC)
Subject: Re: [PATCH 23/27] backports: backport ieee802154 6lowpan support down
 to 3.5
To: Alexander Aring <alex.aring@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Amerigo Wang <amwang@redhat.com>,
	linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Apr 5, 2014 at 7:14 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> Hi,
>
> On Sat, Apr 05, 2014 at 05:40:57AM -0700, Luis R. Rodriguez wrote:
>> Commit 633fc86ff62 added the ieee802154_6lowpan namespace
>> and 7240cdec60b extended it (as on linux-next next-20140311).
>> Its important to note though that 633fc86ff62 also extends the
>> global net namespace. Since we cannot extend the global net
>> namespace we define our own backport namespace for 6lowpan
>> that can be used only be used by our backported subsystems,
>> nothing more. Since ieee802154_6lowpan requires support for
>> net_get_random_once() which uses static keys and a slew of
>> new skb fragment support we simply require at least 3.5 to
>> use 6lowpan. I did my best effort to backport this to kernels
>> older than 3.5 but quickly ran into a slew of hairy issues.
>>
>> The last thing we needed to address was usage of the helper
>> inet_frag_evictor() added by Alexander via commit 6b102865e7
>> through v3.7. Since we can't backport that with macros or
>> inline helpers we add a patch to carry the changes there. If
>> that grows we can consider using Coccinelle.
>>
>> If you are going to try to backport 6lowpan to kernels older
>> than 3.5 be warned that the litmus test for patches will be
>> to pass ckmake --allyesconfig for all supported kernels for
>> every patch you provide.
>
> thanks for this backport, but in the olders 6LoWPAN implementation too
> many things are broken. I stopped to fix issues in net and push my fixes
> in net-next. The current stack in net-next is in a more useable state.

The way Linux backports works is we always backport the latest
linux-next, this lets us branch out a stable release branch once Linus
releases an rc1. There however has been a period of idleness on
backports so we're only caught up to next-2014031, that said the delta
for backporting 6lowpan is only applicable to the master branch of
Linux backports right now as it didn't make it to v3.14. What this
means is that as linux-next moves forward we keep on chugging and
backporting any new collateral evolutions as they come along. We'll
eventually catch up to to today's linux-next. In principle, once we're
caught up we should not let go, and then its a daily thing.

> For making a backport which make sense you need to take many other patches:
>
> e5d966eff3ac364e4505c7c4da632321657029b3 ("6lowpan: fix udp byte ordering")
> 5cede84c9897f9db522699c4b3ff6ffe3d11e038 ("6lowpan: udp
> use lowpan_push_hc_data function")
> c04fe5483df3b23beec9a21a285606f5e34768f1 ("6lowpan: set and use mac_len
> for mac header length")
> ...
>
> Also some patches which aren't from me and which are in net-next:
> 8cfad496c4257441710735ccef622f3829870164 ("ieee802154: properly unshare
> skbs in ieee802154 *_rcv functions")
> ...
>
> and some patches which has issues with 6LoWPAN upper layer protocols:
> d1c53c8e870cdedb6fc9550f41c558bab45b5219 ("icmpv6_filter: allow ICMPv6
> messages with bodies < 4 bytes")
>
> ... this will end in a huge list.

I'm sure :) Moving to a newer version is quit simple and is what we
intend to do.

> Sorry but I see no sense to backport these 6LoWPAN patches because there
> are too many issues and the active mainline IEEE 802.15.4 6LoWPAN
> developers hope that there are no users below net-next there.

The grunt work has been done, I'll bump linux-next today a bit further
to see where we end up. The question should not be what version of
linux-next we're on, as we'll catch up soon, the question should be
does it make sense to provide a backport of the latest 6lowpan on
linux-next to users. The next question is to what oldest kernel we we
strive to backport to? Hauke Mehrtens had added the original first
backport of the ieee802154 subsystem back in June 15, 2013. 6lowpan is
new though, and as such I felt compelled to try to at least upkeep
Hauke's port down to the kernel he had provided backport support for.
It wasn't possible, so we bumped the required lowest kernel to 3.5,.

> If you are from a distribution I can give you the advice to disable IEEE
> 802.15.4 6LoWPAN until it's in a more useable state. Sorry!

That's fine, at the point its ready it can be used by users. Not
carrying over a subsytem to backport poses more work than to backport
it later, so I'd like for you to consider us not carrying the current
state but the latest state as of linux-next. When and if 6lowpan is
ready upstream you'd just have to point users to daily snapshots of
Linux backport based on linux-next, and once the stability train
reaches Linus' tree, it'd go out into a respective stable Linux
release. I'm curious more about your expected users and the types of
kernels they run.

I'm happy for us to rip all this out though and not provide support if
no users are found, but I suspect Hauke backported this with the
expecation that OpenWrt would have some use for this in some embedded
environments. Is there potential for usage of 6lowpan for OpenWrt ?
They carry Linux backports.

  Luis
