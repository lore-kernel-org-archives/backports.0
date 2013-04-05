Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:42050 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507Ab3DEKMe (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 06:12:34 -0400
Message-ID: <1365156746.8515.22.camel@jlt4.sipsolutions.net> (sfid-20130405_121249_783924_CFDD248C)
Subject: Re: [ANN] new backports project
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Andy Gospodarek <andy@greyhouse.net>,
	Phil Perry <phil@pendre.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 05 Apr 2013 12:12:26 +0200
In-Reply-To: <CAB=NE6VOZpEYC=OLJ7KsMq3xwXdEqVeKxvLCOZTOCuEOUwijMQ@mail.gmail.com> (sfid-20130405_043012_934520_0A2CB82F)
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
	 <1364923241.8204.15.camel@jlt4.sipsolutions.net>
	 <515B4994.3030309@pendre.co.uk>
	 <1364937780.8204.18.camel@jlt4.sipsolutions.net>
	 <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com>
	 <20130405021259.GM27415@gospo.rdu.redhat.com>
	 <CAB=NE6VOZpEYC=OLJ7KsMq3xwXdEqVeKxvLCOZTOCuEOUwijMQ@mail.gmail.com>
	 (sfid-20130405_043012_934520_0A2CB82F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-04-04 at 19:29 -0700, Luis R. Rodriguez wrote:

> > Of course that seems extremely tedious, but is there a compelling reason
> > why something like this should not be done -- other than possibly doing
> > as Luis suggests and finding a way to resurrect Andi Kleen's proposal
> > for module symbol namespaces -- then I think the option to begin a more
> > liberal use of the LINUX_BACKPORT macro is worth considering.
> 
> Johannes some idea to help with the tedious work of doing this moving
> forward for new code. I'll let him dive in when he awakens.

Well my idea here was more related to the fact that right now we copy a
lot of code into compat, and it seems a bit tedious to maintain this
manually. Also, if using the 'partial backport' where you only put a
single driver into the copy-list file, we still carry everything needed
to backport any driver etc.

My idea revolves around a few observations I made:
 a) we typically copy an entire subsystem (usually a C and H file) from
the
    kernel and then add LINUX_BACKPORT() to the symbols
 b) we already need to add some configuration for this, in Kconfig (in
the new
    system anyway)

So take for example the recent addition of HDMI. Luis did basically
three things:

 1) add it to Makefile/Kconfig
 2) copy kernel/drivers/video/hdmi.c to backport/compat/hdmi.c
    and kernel/include/linux/hdmi.h to backport/include/linux/hdmi.h
 3) modify the hdmi.h file like this:

+#ifndef CPTCFG_BACKPORT_BUILD_HDMI
+#include_next <linux/hdmi.h>
+#else
...
+#define hdmi_spd_infoframe_init LINUX_BACKPORT(hdmi_spd_infoframe_init)
...
+#define hdmi_audio_infoframe_init
LINUX_BACKPORT(hdmi_audio_infoframe_init)
(etc)
#endif

I'll note that he forgot to add LINUX_BACKPORT() to
hdmi_spd_infoframe_init and hdmi_spd_infoframe_pack :-)


So with these observations, why not do the following instead:

 1) add it to Makefile/Kconfig (manually), and include the information
about the
    C/H file(s) into e.g. the Kconfig file, or a separate configuration
file. I
    wouldn't use the copy-list since we need to do some transformation
steps.

 2) At backport generation time, use that information to copy the C/H
files just
    as Luis did manually for HDMI, however, copy
kernel/include/linux/hdmi.h to
    backport/include/linux/backport_hdmi.h instead.

 3) At backport generation time, create include/linux/hdmi.h like this:

#ifndef CPTCFG_BACKPORT_BUILD_HDMI
#include_next <linux/hdmi.h>
#else
#ifndef __BACKPORT_HDMI
#define __BACKPORT_HDMI
#define hdmi_avi_infoframe_init LINUX_BACKPORT(hdmi_avi_infoframe_init)
#define hdmi_avi_infoframe_pack LINUX_BACKPORT(hdmi_avi_infoframe_pack)
...
#include <linux/backport_hdmi.h>
#endif /* __BACKPORT_HDMI */
#endif /* CPTCFG_BACKPORT_BUILD_HDMI */

The biggest 'issue' here is how to find the symbols. Luis even missed
some, as I noticed, because there's an easy algorithm for this:

sed 's/^EXPORT_SYMBOL\(_GPL\|\)(\([^)]*\)/#define \2 LINUX_BACKPORT(\2)/;t;d' < C file(s)


Basically that was my idea. Maybe we should attempt to do this instead
of backporting HDMI? It seems for HDMI this would yield a more correct
version that Luis's current patch :-D

If there are subsystems with multiple header files (not counting uapi/,
those don't declare symbols and can probably just copied as is) then we
might want to stick #undef in there before each #define.


Extending it a bit further, we could do this _after_ we did
Makefile/Kconfig "impossible" analysis. This way, HDMI would only be
copied if the copy-list included a driver that requires it, otherwise it
would be left out.

One way to configure it would be to put this into the Kconfig (as
structured comments), maybe like this:

config BACKPORT_BUILD_HDMI
	...
	#backport-C-file drivers/video/hdmi.c
	#backport-H-file include/linux/hdmi.h

That'd be easy to read and easy to see almost everything (except the
Makefile snippet) at once. Heck, we could even generate the Makefile
line automatically by just writing
	obj-$(CPTCFG_BACKPORT_BUILD_HDMI) += hdmi.o
to the end of backport/compat/Makefile ...

Thoughts?

johannes

