Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:56085 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3GSVFI (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 17:05:08 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so2350862lbi.15
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 14:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130719123146.GC9288@cantiga.alporthouse.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
 <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com> <20130719123146.GC9288@cantiga.alporthouse.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 19 Jul 2013 14:04:47 -0700
Message-ID: <CAB=NE6UEHomQAoQb3cV0Bdtpb5SEGTr0_TaPWTbvF6OHe2bguA@mail.gmail.com> (sfid-20130719_230511_808521_E6B91D03)
Subject: Re: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"jani.nikula" <jani.nikula@intel.com>, annndddrr@gmail.com,
	cpanceac@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jul 19, 2013 at 5:31 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Fri, Jul 19, 2013 at 05:00:06AM -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> struct dmi_strmatch was modified on v3.11 with a
>> exact_match member. The DMI_EXACT_MATCH() macro was
>> added as a mod version of DMI_MATCH() to account for
>> dmi strings that look closely like each other. An
>> example is D510MO Vs D510MOV.
>>
>> Since exact_match is is not available on older kernels
>> we can't use it and must revert to the old DMI_MATCH().
>> Addressing the desired behaviour will require a separate
>> change to deal with addressing the difference
>> in the behaviour.
>
> If you choose not to backport DMI_EXACT_MATCH, then don't backport the
> two fixes that depend upon it.

Which ones? These two?

dcf6d294830d46b0e6901477fb4bf455281d90c8 - drm/i915: quirk away
phantom LVDS on Intel's D525MW mainboard
e5614f0c2d0f4d7f0b8ef745d34593baf2c5dbf8 - drm/i915: quirk away
phantom LVDS on Intel's D510MO mainboard

Just #ifdef over these for older kernels ifndef DMI_EXACT_MATCH ?

> Is there a blocker for not backporting the DMI_EXACT_MATCH feature?

I'm so glad you asked. DMI_EXACT_MATCH uses struct dmi_strmatch's new
member exact_match:

@@ -456,7 +456,8 @@ enum dmi_field {
 };

 struct dmi_strmatch {
-       unsigned char slot;
+       unsigned char slot:7;
+       unsigned char exact_match:1;
        char substr[79];
 };

Prior to 5017b285 we only had slot so to use DMI_EXACT_MATCH with its
intent we'd have to do something like slot |= 1 if its called. This
however assumes though that older code has the sanity check as changed
in 5017b285 on drivers/firmware/dmi_scan.c. dmi_scan.o gets linked
with CONFIG_DMI. At least for x86 that gets objects sprinkled on
arch/x86/, but more importantly CONFIG_DMI is bool. I've argued how I
envision us being able to backport core components before (see
0935deab for the hint) but as it is right now we can't. We only
backport things we can throw in as modular.

Please let me know if you see any other way.

  Luis
