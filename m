Return-path: <backports-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27366 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184Ab3GVKPr (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 22 Jul 2013 06:15:47 -0400
From: Jani Nikula <jani.nikula@intel.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, annndddrr@gmail.com,
	chris@chris-wilson.co.uk, cpanceac@gmail.com,
	daniel.vetter@ffwll.ch, greg@kroah.com
Subject: Re: [PATCH v2 07/10] backports: revert DMI_EXACT_MATCH() for older kernels
In-Reply-To: <1374272009-26152-8-git-send-email-mcgrof@do-not-panic.com>
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com> <1374272009-26152-8-git-send-email-mcgrof@do-not-panic.com>
Date: Mon, 22 Jul 2013 13:17:10 +0300
Message-ID: <8738r62921.fsf@intel.com> (sfid-20130722_121550_001228_6EF66920)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


Hi Luis -

On Sat, 20 Jul 2013, "Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> struct dmi_strmatch was modified on v3.11 with a
> exact_match member. The DMI_EXACT_MATCH() macro was
> added as a mod version of DMI_MATCH() to account for
> dmi strings that look closely like each other. An
> example is D510MO Vs D510MOV.
>
> Since exact_match is is not available on older kernels
> we can't use it and must revert to the old DMI_MATCH().
> Addressing the desired behaviour will require a separate
> change to deal with addressing the difference
> in the behaviour.
>
> Chris Wilson recommends that if we can't use this we should
> also rever the DMI related fixes. I believe these are:
>
> dcf6d294830d46b0e6901477fb4bf455281d90c8 - drm/i915: quirk away phantom LVDS on Intel's D525MW mainboard
> e5614f0c2d0f4d7f0b8ef745d34593baf2c5dbf8 - drm/i915: quirk away phantom LVDS on Intel's D510MO mainboard
>
> Once we get confirmation we can do that.

I agree with Chris about dropping the above two instead of carrying this
patch, if you can't backport DMI_EXACT_MATCH implementation. As is, this
would regress the longer named variants of D525MW and D510MO.

If more users for DMI_EXACT_MATCH start showing up, you may need to
figure out a better way if you want to backport the quirks.

BR,
Jani.

>
> Proof of why we can't backport DMI_EXACT_MATCH():
>
> DMI_EXACT_MATCH uses struct dmi_strmatch's new
> member exact_match:
>
> 	@@ -456,7 +456,8 @@ enum dmi_field {
> 	 };
>
> 	 struct dmi_strmatch {
> 	-       unsigned char slot;
> 	+       unsigned char slot:7;
> 	+       unsigned char exact_match:1;
> 		char substr[79];
> 	 };
>
> Prior to 5017b285 we only had slot member so to use
> DMI_EXACT_MATCH() with its intent we'd have to do something
> like:
> 	slot |= 1
>
> if its called. This however assumes though that older code has
> the sanity check as changed in 5017b285 on drivers/firmware/dmi_scan.c.
> dmi_scan.o gets linked with CONFIG_DMI. At least for x86 that gets
> objects sprinkled on arch/x86/, but more importantly CONFIG_DMI is
> bool. I've argued how I envision us being able to backport core
> components before (see 0935deab for the hint) but as it is right
> now we can't. We only backport things we can throw in as modular.
>
> mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 5017b285
> v3.11-rc1~99^2~254
>
> commit 5017b2851373ee15c7035151853bb1448800cae2
> Author: Jani Nikula <jani.nikula@intel.com>
> Date:   Wed Jul 3 15:05:02 2013 -0700
>
>     dmi: add support for exact DMI matches in addition to substring matching
>
>     dmi_match() considers a substring match to be a successful match.  This is
>     not always sufficient to distinguish between DMI data for different
>     systems.  Add support for exact string matching using strcmp() in addition
>     to the substring matching using strstr().
>
>     The specific use case in the i915 driver is to allow us to use an exact
>     match for D510MO, without also incorrectly matching D510MOV:
>
>       {
>         .ident = "Intel D510MO",
>         .matches = {
>                 DMI_MATCH(DMI_BOARD_VENDOR, "Intel"),
>                 DMI_EXACT_MATCH(DMI_BOARD_NAME, "D510MO"),
>         },
>       }
>
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Cc: <annndddrr@gmail.com>
>     Cc: Chris Wilson <chris@chris-wilson.co.uk>
>     Cc: Cornel Panceac <cpanceac@gmail.com>
>     Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>     Cc: Greg KH <greg@kroah.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Cc: jani.nikula@intel.com
> Cc: annndddrr@gmail.com
> Cc: chris@chris-wilson.co.uk
> Cc: cpanceac@gmail.com
> Cc: daniel.vetter@ffwll.ch
> Cc: greg@kroah.com
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  backport/backport-include/linux/mod_devicetable.h |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
> index 1f85ce6..5b63637 100644
> --- a/backport/backport-include/linux/mod_devicetable.h
> +++ b/backport/backport-include/linux/mod_devicetable.h
> @@ -2,6 +2,10 @@
>  #define __BACKPORT_MOD_DEVICETABLE_H
>  #include_next <linux/mod_devicetable.h>
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
> +#define DMI_EXACT_MATCH(a, b)  { a, b }
> +#endif
> +
>  #ifndef HID_BUS_ANY
>  #define HID_BUS_ANY                            0xffff
>  #endif
> -- 
> 1.7.10.4
>

-- 
Jani Nikula, Intel Open Source Technology Center
