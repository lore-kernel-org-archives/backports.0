Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45211 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab3GXAYf (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Jul 2013 20:24:35 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so6813976lbj.14
        for <backports@vger.kernel.org>; Tue, 23 Jul 2013 17:24:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130720162718.GA4376@cantiga.alporthouse.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
 <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com>
 <20130719123146.GC9288@cantiga.alporthouse.com> <CAB=NE6UEHomQAoQb3cV0Bdtpb5SEGTr0_TaPWTbvF6OHe2bguA@mail.gmail.com>
 <20130720162718.GA4376@cantiga.alporthouse.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 23 Jul 2013 17:24:13 -0700
Message-ID: <CAB=NE6WJCRG8Z0nkW=u20ehRXABxngA38GR0cgUUiDR5B0CpnQ@mail.gmail.com> (sfid-20130724_022437_788191_4CDAF0D6)
Subject: Re: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>,
	Andrey Li <annndddrr@gmail.com>,
	cornel panceac <cpanceac@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jul 20, 2013 at 9:27 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Fri, Jul 19, 2013 at 02:04:47PM -0700, Luis R. Rodriguez wrote:
>> Which ones? These two?
>>
>> dcf6d294830d46b0e6901477fb4bf455281d90c8 - drm/i915: quirk away
>> phantom LVDS on Intel's D525MW mainboard
>> e5614f0c2d0f4d7f0b8ef745d34593baf2c5dbf8 - drm/i915: quirk away
>> phantom LVDS on Intel's D510MO mainboard
>
> Yes.

OK, will do.

>> Please let me know if you see any other way.
>
> An alternative ugly hack would be to encode some metadata into the
> search string. I am a bit wary of simply converting the DMI_EXACT_MATCH
> back into DMI_MATCH because that introduces a regression into working
> machines if we blithely backport fixes like the two above. I'd rather
> have the compile failure.

How about then just backporting like this then:

#define DMI_EXACT_MATCH(a, b) DMI_MATCH(DMI_PRODUCT_NAME, "BACKPORT_IGNORE")

It'd mean no #ifdef'ing code and at the same time making the run time
of the code of the mentioned patches skip.

Thoughts?

  Luis
