Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51052 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRML (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:12:11 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:41 +0300
Message-Id: <20180920112842.27198-14-luca@coelho.fi> (sfid-20180920_132910_199300_CD3B6546)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 13/14] backport: convert int led activate op to void when needed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

In kernel v4.19-rc1, the activate op in struct led_trigger, changed
from void to int.  To solve this, add a semantic patch to insert a
wrapper function that returns void and calls the function that returns
int.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/led_activate.cocci | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 patches/led_activate.cocci

diff --git a/patches/led_activate.cocci b/patches/led_activate.cocci
new file mode 100644
index 000000000000..df8211d29462
--- /dev/null
+++ b/patches/led_activate.cocci
@@ -0,0 +1,24 @@
+@act@
+identifier activate_fn, p;
+identifier m =~ "rx_led|tx_led|assoc_led|radio_led|tpt_led";
+fresh identifier activate_fn_wrap = "bp_" ## activate_fn;
+@@
+<...
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+p->m.activate = activate_fn;
++#else
++p->m.activate = activate_fn_wrap;
++#endif
+...>
+
+@@
+identifier act.activate_fn;
+identifier act.activate_fn_wrap;
+@@
+int activate_fn(...) {...}
++#if LINUX_VERSION_IS_LESS(4,19,0)
++static void activate_fn_wrap(struct led_classdev *led_cdev)
++{
++	activate_fn(led_cdev);
++}
++#endif
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
