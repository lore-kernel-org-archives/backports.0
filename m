Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53970 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762769Ab3DHUYJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:24:09 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: allow using backported drivers w/o LEDs
Date: Mon,  8 Apr 2013 22:24:01 +0200
Message-Id: <1365452641-30374-1-git-send-email-johannes@sipsolutions.net> (sfid-20130408_222413_628476_F6C25146)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

When the base kernel has LED support (partially) disabled,
currently many drivers cannot be built. Since LED support
is hardy critical, work around this by providing API stubs
for the LED support code to still compile (but not work.)

This passes allyesconfig (except for some stupid rtlwifi
issue) with next-20130405 against a 3.8 kernel that has
all the LED options disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig                |  16 ++++
 backport/compat/compat-2.6.37.c        |   2 +-
 backport/include/linux/compat-2.6.37.h |   3 +-
 backport/include/linux/leds.h          | 153 +++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 backport/include/linux/leds.h

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index df58dcc..a416cc8 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -156,6 +156,22 @@ config BACKPORT_BUILD_HDMI
 config BACKPORT_HDMI
 	bool
 
+config BACKPORT_BUILD_LEDS
+	bool
+	depends on !NEW_LEDS || !LEDS_CLASS || !LEDS_TRIGGERS
+	default y if BACKPORT_NEW_LEDS
+	default y if BACKPORT_LEDS_CLASS
+	default y if BACKPORT_LEDS_TRIGGERS
+
+config BACKPORT_NEW_LEDS
+	bool
+
+config BACKPORT_LEDS_CLASS
+	bool
+
+config BACKPORT_LEDS_TRIGGERS
+	bool
+
 config BACKPORT_USERSEL_BUILD_ALL
 	bool "Build all compat code"
 	help
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index 9f722a6..04ff7af 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -153,7 +153,7 @@ int compat_genl_unregister_family(struct genl_family *family)
 }
 EXPORT_SYMBOL_GPL(compat_genl_unregister_family);
 
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS) && !defined(CPTCFG_BACKPORT_BUILD_LEDS)
 
 #undef led_brightness_set
 #undef led_classdev_unregister
diff --git a/backport/include/linux/compat-2.6.37.h b/backport/include/linux/compat-2.6.37.h
index 317ae6f..35e992b 100644
--- a/backport/include/linux/compat-2.6.37.h
+++ b/backport/include/linux/compat-2.6.37.h
@@ -129,7 +129,7 @@ int genl_unregister_family(struct genl_family *family);
 #define genl_register_mc_group(_fam, _grp) genl_register_mc_group(&(_fam)->family, _grp)
 #define genl_unregister_mc_group(_fam, _grp) genl_unregister_mc_group(&(_fam)->family, _grp)
 
-
+#ifndef CPTCFG_BACKPORT_BUILD_LEDS
 extern void led_blink_set(struct led_classdev *led_cdev,
 			  unsigned long *delay_on,
 			  unsigned long *delay_off);
@@ -140,6 +140,7 @@ extern void compat_led_classdev_unregister(struct led_classdev *led_cdev);
 #define led_brightness_set compat_led_brightness_set
 extern void compat_led_brightness_set(struct led_classdev *led_cdev,
 				      enum led_brightness brightness);
+#endif
 
 #define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
 
diff --git a/backport/include/linux/leds.h b/backport/include/linux/leds.h
new file mode 100644
index 0000000..f9f88ea
--- /dev/null
+++ b/backport/include/linux/leds.h
@@ -0,0 +1,153 @@
+#ifndef __BACKPORT_LED_SUPPORT
+#define __BACKPORT_LED_SUPPORT
+
+/*
+ * LED support is strange, with the NEW_LEDS, LEDS_CLASS and LEDS_TRIGGERS
+ * Kconfig symbols ... If any of them are not defined, we build our
+ * "compatibility" code that really just makes it all non-working but
+ * allows compilation.
+ */
+
+#include_next <linux/leds.h>
+#ifdef CPTCFG_BACKPORT_BUILD_LEDS
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/rwsem.h>
+
+#define led_classdev LINUX_BACKPORT(led_classdev)
+#define led_trigger LINUX_BACKPORT(led_trigger)
+
+struct led_classdev {
+	const char		*name;
+	int			 brightness;
+	int			 max_brightness;
+	int			 flags;
+
+	/* Lower 16 bits reflect status */
+#ifndef LED_SUSPENDED
+#define LED_SUSPENDED		(1 << 0)
+	/* Upper 16 bits reflect control information */
+#define LED_CORE_SUSPENDRESUME	(1 << 16)
+#define LED_BLINK_ONESHOT	(1 << 17)
+#define LED_BLINK_ONESHOT_STOP	(1 << 18)
+#define LED_BLINK_INVERT	(1 << 19)
+#endif
+
+	/* Set LED brightness level */
+	/* Must not sleep, use a workqueue if needed */
+	void		(*brightness_set)(struct led_classdev *led_cdev,
+					  enum led_brightness brightness);
+	/* Get LED brightness level */
+	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
+
+	/*
+	 * Activate hardware accelerated blink, delays are in milliseconds
+	 * and if both are zero then a sensible default should be chosen.
+	 * The call should adjust the timings in that case and if it can't
+	 * match the values specified exactly.
+	 * Deactivate blinking again when the brightness is set to a fixed
+	 * value via the brightness_set() callback.
+	 */
+	int		(*blink_set)(struct led_classdev *led_cdev,
+				     unsigned long *delay_on,
+				     unsigned long *delay_off);
+
+	struct device		*dev;
+	struct list_head	 node;			/* LED Device list */
+	const char		*default_trigger;	/* Trigger to use */
+
+	unsigned long		 blink_delay_on, blink_delay_off;
+	struct timer_list	 blink_timer;
+	int			 blink_brightness;
+
+	struct work_struct	set_brightness_work;
+	int			delayed_set_value;
+
+	/* Protects the trigger data below */
+	struct rw_semaphore	 trigger_lock;
+
+	struct led_trigger	*trigger;
+	struct list_head	 trig_list;
+	void			*trigger_data;
+	/* true if activated - deactivate routine uses it to do cleanup */
+	bool			activated;
+};
+
+struct led_trigger {
+	const char *name;
+	rwlock_t leddev_list_lock;
+	struct list_head led_cdevs;
+	struct list_head next_trig;
+};
+
+#undef led_classdev_register
+#define led_classdev_register LINUX_BACKPORT(led_classdev_register)
+#undef led_classdev_unregister
+#define led_classdev_unregister LINUX_BACKPORT(led_classdev_unregister)
+#undef led_blink_set
+#define led_blink_set LINUX_BACKPORT(led_blink_set)
+#undef led_set_brightness
+#define led_set_brightness LINUX_BACKPORT(led_set_brightness)
+#undef led_classdev_suspend
+#define led_classdev_suspend LINUX_BACKPORT(led_classdev_suspend)
+#undef led_classdev_resume
+#define led_classdev_resume LINUX_BACKPORT(led_classdev_resume)
+
+#undef led_trigger_register
+#define led_trigger_register LINUX_BACKPORT(led_trigger_register)
+#undef led_trigger_unregister
+#define led_trigger_unregister LINUX_BACKPORT(led_trigger_unregister)
+#undef led_trigger_event
+#define led_trigger_event LINUX_BACKPORT(led_trigger_event)
+
+#undef DEFINE_LED_TRIGGER
+#define DEFINE_LED_TRIGGER(x) static struct led_trigger *x;
+
+static inline int led_classdev_register(struct device *parent,
+					struct led_classdev *led_cdev)
+{
+	return 0;
+}
+
+static inline void led_classdev_unregister(struct led_classdev *led_cdev)
+{
+}
+
+static inline void led_blink_set(struct led_classdev *led_cdev,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+}
+
+static inline void led_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
+{
+}
+
+static inline void led_classdev_suspend(struct led_classdev *led_cdev)
+{
+}
+
+static inline void led_classdev_resume(struct led_classdev *led_cdev)
+{
+}
+
+static inline int led_trigger_register(struct led_trigger *trigger)
+{
+	INIT_LIST_HEAD(&trigger->led_cdevs);
+	INIT_LIST_HEAD(&trigger->next_trig);
+	rwlock_init(&trigger->leddev_list_lock);
+	return 0;
+}
+
+static inline void led_trigger_unregister(struct led_trigger *trigger)
+{
+}
+
+static inline void led_trigger_event(struct led_trigger *trigger,
+				     enum led_brightness event)
+{
+}
+#endif
+
+#endif /* __BACKPORT_LED_SUPPORT */
-- 
1.8.0

