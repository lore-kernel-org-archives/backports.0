Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:54358 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3GXFJY (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 24 Jul 2013 01:09:24 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so11845968obq.7
        for <backports@vger.kernel.org>; Tue, 23 Jul 2013 22:09:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WJCRG8Z0nkW=u20ehRXABxngA38GR0cgUUiDR5B0CpnQ@mail.gmail.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
	<1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com>
	<20130719123146.GC9288@cantiga.alporthouse.com>
	<CAB=NE6UEHomQAoQb3cV0Bdtpb5SEGTr0_TaPWTbvF6OHe2bguA@mail.gmail.com>
	<20130720162718.GA4376@cantiga.alporthouse.com>
	<CAB=NE6WJCRG8Z0nkW=u20ehRXABxngA38GR0cgUUiDR5B0CpnQ@mail.gmail.com>
Date: Wed, 24 Jul 2013 07:09:24 +0200
Message-ID: <CAKMK7uHYUvxOLmd0wT0dG7_vZxUEcwFhmL2GB9ggTb-c5F11Eg@mail.gmail.com> (sfid-20130724_070927_374783_08003F7E)
Subject: Re: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>,
	Andrey Li <annndddrr@gmail.com>,
	cornel panceac <cpanceac@gmail.com>,
	Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jul 24, 2013 at 2:24 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Sat, Jul 20, 2013 at 9:27 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> On Fri, Jul 19, 2013 at 02:04:47PM -0700, Luis R. Rodriguez wrote:
>>> Which ones? These two?
>>>
>>> dcf6d294830d46b0e6901477fb4bf455281d90c8 - drm/i915: quirk away
>>> phantom LVDS on Intel's D525MW mainboard
>>> e5614f0c2d0f4d7f0b8ef745d34593baf2c5dbf8 - drm/i915: quirk away
>>> phantom LVDS on Intel's D510MO mainboard
>>
>> Yes.
>
> OK, will do.
>
>>> Please let me know if you see any other way.
>>
>> An alternative ugly hack would be to encode some metadata into the
>> search string. I am a bit wary of simply converting the DMI_EXACT_MATCH
>> back into DMI_MATCH because that introduces a regression into working
>> machines if we blithely backport fixes like the two above. I'd rather
>> have the compile failure.
>
> How about then just backporting like this then:
>
> #define DMI_EXACT_MATCH(a, b) DMI_MATCH(DMI_PRODUCT_NAME, "BACKPORT_IGNORE")
>
> It'd mean no #ifdef'ing code and at the same time making the run time
> of the code of the mentioned patches skip.

Yeah, I think as a solution for the backport tree that's a neat hack
and would allow us to reuse the latest upstream drm/i915 code
unchanged, without the risk of breaking some machines. Of course we'll
miss a few quirk entries but the lack of such shouldn't ever cause
regressions.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
