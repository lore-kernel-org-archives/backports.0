Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:61848 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3JZJpj (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 26 Oct 2013 05:45:39 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so3744330lab.8
        for <backports@vger.kernel.org>; Sat, 26 Oct 2013 02:45:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <526AE34E.5020300@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
 <1382552852-15916-2-git-send-email-hauke@hauke-m.de> <1382690097.4461.0.camel@jlt4.sipsolutions.net>
 <526AE34E.5020300@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Sat, 26 Oct 2013 11:45:16 +0200
Message-ID: <CAB=NE6XpXqo09-vpkPaY=qMgpJfywS61oNjZ0nkm1Mpd1PrdHA@mail.gmail.com> (sfid-20131026_114541_851221_DCB4CC39)
Subject: Re: [PATCH 1/5] backports: fix kernel dependencies for regulator drivers
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Oct 25, 2013 at 11:31 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 10/25/2013 10:34 AM, Johannes Berg wrote:
>> On Wed, 2013-10-23 at 20:27 +0200, Hauke Mehrtens wrote:
>>> These drivers are depending on changes of the regulator core driver
>>> which are not in the specific kernel versions.
>>
>> These dependencies seem to continue moving forward - is it even worth
>> backporting?
>>
>> johannes
>>
> Yes moving the dependencies is easier than backporting the code which
> does not work any more. ;-) The problem here is that the regulator core
> can not be backported, because it is always build into the kernel and
> not as a module.
>
> I am also think if it is worth backporting this stuff, I think it is
> only used on embedded devices and there it is probably easier to just
> patch the kernel with the driver updates you need, I am for dropping this.
>
> Are there any users of the regulator drivers?

The regulator /  media drivers were added more as a proof of concept.
In fact I added the regulator drivers only after I added the media
drivers as I found inherent dependencies on them on regulator calls.
If we remove regulator drivers then we may need to remove some media
drivers. As for the issues with some functionality on the regulator
drivers requiring functionality from future kernels as its always
built-in, that can be addressed if we add support for non-modular
solutions on backports. This should be possible, in fact given that
these drivers are typically only shipped on non modular kernels it
does make sense to have that requirement for backporting some drivers.
Mauro had expressed some interest on reusing some of the backporting
we've done for media drivers, Mauro do you require the solution to be
non-modular? If so they'd be a good first target for that solution,
but note that that solution still requires work, right no we only have
them as modular. Does modular work for you as well? If not we might as
well rip the drivers out and consider adding them once we have
in-kernel support.

 Luis
