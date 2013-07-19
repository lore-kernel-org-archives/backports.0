Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61568 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3GSMAl (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq12so1012581pab.39
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:41 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, annndddrr@gmail.com,
	chris@chris-wilson.co.uk, cpanceac@gmail.com,
	daniel.vetter@ffwll.ch, greg@kroah.com
Subject: [RFC 6/9] backports: revert DMI_EXACT_MATCH() for older kernels
Date: Fri, 19 Jul 2013 05:00:06 -0700
Message-Id: <1374235209-19782-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140043_110237_7AB28839)
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

struct dmi_strmatch was modified on v3.11 with a
exact_match member. The DMI_EXACT_MATCH() macro was
added as a mod version of DMI_MATCH() to account for
dmi strings that look closely like each other. An
example is D510MO Vs D510MOV.

Since exact_match is is not available on older kernels
we can't use it and must revert to the old DMI_MATCH().
Addressing the desired behaviour will require a separate
change to deal with addressing the difference
in the behaviour.

I welcome alternative ideas.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 5017b285
v3.11-rc1~99^2~254

commit 5017b2851373ee15c7035151853bb1448800cae2
Author: Jani Nikula <jani.nikula@intel.com>
Date:   Wed Jul 3 15:05:02 2013 -0700

    dmi: add support for exact DMI matches in addition to substring matching

    dmi_match() considers a substring match to be a successful match.  This is
    not always sufficient to distinguish between DMI data for different
    systems.  Add support for exact string matching using strcmp() in addition
    to the substring matching using strstr().

    The specific use case in the i915 driver is to allow us to use an exact
    match for D510MO, without also incorrectly matching D510MOV:

      {
        .ident = "Intel D510MO",
        .matches = {
                DMI_MATCH(DMI_BOARD_VENDOR, "Intel"),
                DMI_EXACT_MATCH(DMI_BOARD_NAME, "D510MO"),
        },
      }

    Signed-off-by: Jani Nikula <jani.nikula@intel.com>
    Cc: <annndddrr@gmail.com>
    Cc: Chris Wilson <chris@chris-wilson.co.uk>
    Cc: Cornel Panceac <cpanceac@gmail.com>
    Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Cc: Greg KH <greg@kroah.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Cc: jani.nikula@intel.com
Cc: annndddrr@gmail.com
Cc: chris@chris-wilson.co.uk
Cc: cpanceac@gmail.com
Cc: daniel.vetter@ffwll.ch
Cc: greg@kroah.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/mod_devicetable.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index 1f85ce6..5b63637 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -2,6 +2,10 @@
 #define __BACKPORT_MOD_DEVICETABLE_H
 #include_next <linux/mod_devicetable.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#define DMI_EXACT_MATCH(a, b)  { a, b }
+#endif
+
 #ifndef HID_BUS_ANY
 #define HID_BUS_ANY                            0xffff
 #endif
-- 
1.7.10.4

