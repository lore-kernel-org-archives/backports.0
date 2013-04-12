Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:38338 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3DLHh3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 03:37:29 -0400
Message-ID: <1365752245.8399.0.camel@jlt4.sipsolutions.net> (sfid-20130412_093730_937546_0A47EBA1)
Subject: Re: [RFC/WIP 14/24] backports: remove vb2_mmap_pfn_range
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 12 Apr 2013 09:37:25 +0200
In-Reply-To: <CAB=NE6XdC2OM_ZcQDMAC84sazZ=+0PnJH_Khky_WtjfyyzWn3w@mail.gmail.com> (sfid-20130412_080716_378046_4302A15A)
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
	 <1365723771-10660-15-git-send-email-johannes@sipsolutions.net>
	 <CAB=NE6XdC2OM_ZcQDMAC84sazZ=+0PnJH_Khky_WtjfyyzWn3w@mail.gmail.com>
	 (sfid-20130412_080716_378046_4302A15A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-04-11 at 23:06 -0700, Luis R. Rodriguez wrote:
> On Thu, Apr 11, 2013 at 4:42 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > This doesn't seem to be used anywhere.
> >
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> I need this for media.

Ok, I'll replace this patch with:


>From 523e3db02047519f879f9b141919eab8a5c4c628 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Thu, 11 Apr 2013 20:48:09 +0200
Subject: [PATCH] backports: move vb2_mmap_pfn_range

The new code uses vb2_common_vm_ops which is in
include/media/videobuf2-memops.h so put this
there as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.9.h       |  7 -------
 backport/backport-include/media/videobuf2-memops.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 backport/backport-include/media/videobuf2-memops.h

diff --git a/backport/backport-include/linux/compat-3.9.h
b/backport/backport-include/linux/compat-3.9.h
index a939e0b..2a1f2da 100644
--- a/backport/backport-include/linux/compat-3.9.h
+++ b/backport/backport-include/linux/compat-3.9.h
@@ -18,13 +18,6 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
-int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
-				unsigned long size,
-				const struct vm_operations_struct *vm_ops,
-				void *priv);
-#endif
-
 /* module_platform_driver_probe() - Helper macro for drivers that don't
do
  * anything special in module init/exit.  This eliminates a lot of
  * boilerplate.  Each module may only use this macro once, and
diff --git a/backport/backport-include/media/videobuf2-memops.h
b/backport/backport-include/media/videobuf2-memops.h
new file mode 100644
index 0000000..78ec8e4
--- /dev/null
+++ b/backport/backport-include/media/videobuf2-memops.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_MEDIA_VB2_MEMOPS_H
+#define __BACKPORT_MEDIA_VB2_MEMOPS_H
+#include_next <media/videobuf2-memops.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
+				unsigned long size,
+				const struct vm_operations_struct *vm_ops,
+				void *priv);
+#endif
+
+#endif /* __BACKPORT_MEDIA_VB2_MEMOPS_H */
-- 
1.8.0



