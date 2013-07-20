Return-path: <backports-owner@vger.kernel.org>
Received: from s16502780.onlinehome-server.info ([87.106.93.118]:50227 "EHLO
	fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754341Ab3GTQ1j (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 20 Jul 2013 12:27:39 -0400
Date: Sat, 20 Jul 2013 17:27:18 +0100
From: Chris Wilson <chris@chris-wilson.co.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>, annndddrr@gmail.com,
	cpanceac@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
Message-ID: <20130720162718.GA4376@cantiga.alporthouse.com> (sfid-20130720_182747_205824_8234C585)
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
 <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com>
 <20130719123146.GC9288@cantiga.alporthouse.com>
 <CAB=NE6UEHomQAoQb3cV0Bdtpb5SEGTr0_TaPWTbvF6OHe2bguA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB=NE6UEHomQAoQb3cV0Bdtpb5SEGTr0_TaPWTbvF6OHe2bguA@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jul 19, 2013 at 02:04:47PM -0700, Luis R. Rodriguez wrote:
> On Fri, Jul 19, 2013 at 5:31 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > On Fri, Jul 19, 2013 at 05:00:06AM -0700, Luis R. Rodriguez wrote:
> >> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> >>
> >> struct dmi_strmatch was modified on v3.11 with a
> >> exact_match member. The DMI_EXACT_MATCH() macro was
> >> added as a mod version of DMI_MATCH() to account for
> >> dmi strings that look closely like each other. An
> >> example is D510MO Vs D510MOV.
> >>
> >> Since exact_match is is not available on older kernels
> >> we can't use it and must revert to the old DMI_MATCH().
> >> Addressing the desired behaviour will require a separate
> >> change to deal with addressing the difference
> >> in the behaviour.
> >
> > If you choose not to backport DMI_EXACT_MATCH, then don't backport the
> > two fixes that depend upon it.
> 
> Which ones? These two?
> 
> dcf6d294830d46b0e6901477fb4bf455281d90c8 - drm/i915: quirk away
> phantom LVDS on Intel's D525MW mainboard
> e5614f0c2d0f4d7f0b8ef745d34593baf2c5dbf8 - drm/i915: quirk away
> phantom LVDS on Intel's D510MO mainboard

Yes.
 
> Just #ifdef over these for older kernels ifndef DMI_EXACT_MATCH ?
> 
> > Is there a blocker for not backporting the DMI_EXACT_MATCH feature?
> 
> I'm so glad you asked. DMI_EXACT_MATCH uses struct dmi_strmatch's new
> member exact_match:
> 
> @@ -456,7 +456,8 @@ enum dmi_field {
>  };
> 
>  struct dmi_strmatch {
> -       unsigned char slot;
> +       unsigned char slot:7;
> +       unsigned char exact_match:1;
>         char substr[79];
>  };
> 
> Prior to 5017b285 we only had slot so to use DMI_EXACT_MATCH with its
> intent we'd have to do something like slot |= 1 if its called. This
> however assumes though that older code has the sanity check as changed
> in 5017b285 on drivers/firmware/dmi_scan.c. dmi_scan.o gets linked
> with CONFIG_DMI. At least for x86 that gets objects sprinkled on
> arch/x86/, but more importantly CONFIG_DMI is bool. I've argued how I
> envision us being able to backport core components before (see
> 0935deab for the hint) but as it is right now we can't. We only
> backport things we can throw in as modular.
> 
> Please let me know if you see any other way.

An alternative ugly hack would be to encode some metadata into the
search string. I am a bit wary of simply converting the DMI_EXACT_MATCH
back into DMI_MATCH because that introduces a regression into working
machines if we blithely backport fixes like the two above. I'd rather
have the compile failure.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
