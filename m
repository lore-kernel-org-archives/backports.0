Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/5] compat-drivers: address usage of intel_enable_gtt() for i915
Date: Fri, 28 Sep 2012 23:54:44 -0700
Message-Id: <1348901686-15036-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Kernels older than 3.6 don't have intel_enable_gtt() exported
and most Linux distributions have CONFIG_AGP_INTEL as built-in
(y) and as such we don't bother to make it available as
modular here. The change to export intel_enable_gtt() was
made through commit 8ecd1a66 but previous to this the driver
never called intel_enable_gtt() so we can safely assume we
can do the same for older kernels.

There should be a way to export an intel_enable_gtt() for
kernels with CONFIG_AGP_INTEL as built-in but that itself
is a project.

commit 8ecd1a6615f0d9de6759aafe229bc1cc4ee99c7b
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Jun 7 15:56:03 2012 +0200

    drm/i915: call intel_enable_gtt

    When drm/i915 is in control of the gtt, we need to call
    the enable function at all the relevant places ourselves.

    Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

This now goes with i915 run time tested against 3.2.0-3-amd64
and code extrated from linux-next next-20120926.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/drm/07-intel-gtt.patch |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 patches/drm/07-intel-gtt.patch

diff --git a/patches/drm/07-intel-gtt.patch b/patches/drm/07-intel-gtt.patch
new file mode 100644
index 0000000..6b3fabe
--- /dev/null
+++ b/patches/drm/07-intel-gtt.patch
@@ -0,0 +1,37 @@
+Kernels older than 3.6 don't have intel_enable_gtt() exported
+and most Linux distributions have CONFIG_AGP_INTEL as built-in
+(y) and as such we don't bother to make it available as
+modular here. The change to export intel_enable_gtt() was
+made through commit 8ecd1a66 but previous to this the driver
+never called intel_enable_gtt() so we can safely assume we
+can do the same for older kernels.
+
+There should be a way to export an intel_enable_gtt() for
+kernels with CONFIG_AGP_INTEL as built-in but that itself
+is a project.
+
+commit 8ecd1a6615f0d9de6759aafe229bc1cc4ee99c7b
+Author: Daniel Vetter <daniel.vetter@ffwll.ch>
+Date:   Thu Jun 7 15:56:03 2012 +0200
+
+    drm/i915: call intel_enable_gtt
+    
+    When drm/i915 is in control of the gtt, we need to call
+    the enable function at all the relevant places ourselves.
+    
+    Reviewed-by: Jani Nikula <jani.nikula@linux.intel.com>
+    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
+
+--- a/drivers/gpu/drm/i915/i915_gem.c
++++ b/drivers/gpu/drm/i915/i915_gem.c
+@@ -3914,8 +3914,10 @@ i915_gem_init_hw(struct drm_device *dev)
+ 	drm_i915_private_t *dev_priv = dev->dev_private;
+ 	int ret;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+ 	if (!intel_enable_gtt())
+ 		return -EIO;
++#endif
+ 
+ 	i915_gem_l3_remap(dev);
+ 
-- 
1.7.10.4
