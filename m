Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED4C433EF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A14260EDF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhJKWZG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413CC061762
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:58 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HStbN5ZgSzQl0w;
        Tue, 12 Oct 2021 00:22:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQcZb0If0xQ/mtm//zAYvGp4ojbFWo76fAnrv3+vD9E=;
        b=W5RRPYiQ1Fnq3RAyIvS6/mDQZjYI5FXRb47MwBX7ZOxyJh8Z/zlmXWobSfXSsyONbNVVt1
        WPKQ/mkVv77wdFNUpEu9r1mCg+DYIyHbVyw+fWmwVLwSy8yU8+7I8RJ/q5hmD+UqjU66RN
        2QyHcmBzTrIAK2gtaQv5BzCptulHmOi/QwKnpqDVMnNWle2gAHUXGT/UTKmxu8LnezMOxL
        ZYuIcGbPLfgE8qC2NaCMEkMBdYqf7xPifZ1zvScszVJLcG4hXV4Gy2bB+3Wo1FIck+sOUT
        FLt/OghWAU/1fE0R1QKQsdDfpKTv99g0/svd6kuIZ1LoNzLPrYcTcgc/BVJorw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/14] backports: Remove led subsystem backport
Date:   Tue, 12 Oct 2021 00:22:20 +0200
Message-Id: <20211011222227.1189850-8-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E792118B7
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is not needed on kernel 4.0 and later. These kernel versions
already ship a compatible LED system.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../backport-include/backport/leds-disabled.h | 198 ------------------
 backport/backport-include/linux/leds.h        |   2 -
 backport/compat/Kconfig                       |  16 --
 3 files changed, 216 deletions(-)
 delete mode 100644 backport/backport-include/backport/leds-disabled.h

diff --git a/backport/backport-include/backport/leds-disabled.h b/backport/backport-include/backport/leds-disabled.h
deleted file mode 100644
index 5ab82e5b..00000000
--- a/backport/backport-include/backport/leds-disabled.h
+++ /dev/null
@@ -1,198 +0,0 @@
-#ifndef __BACKPORT_LED_DISABLED_SUPPORT
-#define __BACKPORT_LED_DISABLED_SUPPORT
-
-/*
- * LED support is strange, with the NEW_LEDS, LEDS_CLASS and LEDS_TRIGGERS
- * Kconfig symbols ... If any of them are not defined, we build our
- * "compatibility" code that really just makes it all non-working but
- * allows compilation.
- */
-
-#ifdef CPTCFG_BPAUTO_BUILD_LEDS
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/rwsem.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
-
-#define led_classdev LINUX_BACKPORT(led_classdev)
-#define led_trigger LINUX_BACKPORT(led_trigger)
-
-struct led_classdev {
-	const char		*name;
-	enum led_brightness	 brightness;
-	enum led_brightness	 max_brightness;
-	int			 flags;
-
-	/* Lower 16 bits reflect status */
-#ifndef LED_SUSPENDED
-#define LED_SUSPENDED		(1 << 0)
-	/* Upper 16 bits reflect control information */
-#define LED_CORE_SUSPENDRESUME	(1 << 16)
-#define LED_BLINK_ONESHOT	(1 << 17)
-#define LED_BLINK_ONESHOT_STOP	(1 << 18)
-#define LED_BLINK_INVERT	(1 << 19)
-#define LED_SYSFS_DISABLE	(1 << 20)
-#define SET_BRIGHTNESS_ASYNC	(1 << 21)
-#define SET_BRIGHTNESS_SYNC	(1 << 22)
-#define LED_DEV_CAP_FLASH	(1 << 23)
-#endif
-
-	/* Set LED brightness level */
-	/* Must not sleep, use a workqueue if needed */
-	void		(*brightness_set)(struct led_classdev *led_cdev,
-					  enum led_brightness brightness);
-	/*
-	 * Set LED brightness level immediately - it can block the caller for
-	 * the time required for accessing a LED device register.
-	 */
-	int		(*brightness_set_sync)(struct led_classdev *led_cdev,
-					enum led_brightness brightness);
-	/* Get LED brightness level */
-	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
-
-	/*
-	 * Activate hardware accelerated blink, delays are in milliseconds
-	 * and if both are zero then a sensible default should be chosen.
-	 * The call should adjust the timings in that case and if it can't
-	 * match the values specified exactly.
-	 * Deactivate blinking again when the brightness is set to a fixed
-	 * value via the brightness_set() callback.
-	 */
-	int		(*blink_set)(struct led_classdev *led_cdev,
-				     unsigned long *delay_on,
-				     unsigned long *delay_off);
-
-	struct device		*dev;
-	const struct attribute_group	**groups;
-
-	struct list_head	 node;			/* LED Device list */
-	const char		*default_trigger;	/* Trigger to use */
-
-	unsigned long		 blink_delay_on, blink_delay_off;
-	struct timer_list	 blink_timer;
-	int			 blink_brightness;
-	void			(*flash_resume)(struct led_classdev *led_cdev);
-
-	struct work_struct	set_brightness_work;
-	int			delayed_set_value;
-
-	/* Protects the trigger data below */
-	struct rw_semaphore	 trigger_lock;
-
-	struct led_trigger	*trigger;
-	struct list_head	 trig_list;
-	void			*trigger_data;
-	/* true if activated - deactivate routine uses it to do cleanup */
-	bool			activated;
-
-	/* Ensures consistent access to the LED Flash Class device */
-	struct mutex		led_access;
-};
-
-struct led_trigger {
-	const char *name;
-	void (*activate)(struct led_classdev *led_cdev);
-	void (*deactivate)(struct led_classdev *led_cdev);
-	rwlock_t leddev_list_lock;
-	struct list_head led_cdevs;
-	struct list_head next_trig;
-};
-
-#undef led_classdev_register
-#define led_classdev_register LINUX_BACKPORT(led_classdev_register)
-#undef led_classdev_unregister
-#define led_classdev_unregister LINUX_BACKPORT(led_classdev_unregister)
-#undef led_blink_set
-#define led_blink_set LINUX_BACKPORT(led_blink_set)
-#undef led_set_brightness
-#define led_set_brightness LINUX_BACKPORT(led_set_brightness)
-#undef led_classdev_suspend
-#define led_classdev_suspend LINUX_BACKPORT(led_classdev_suspend)
-#undef led_classdev_resume
-#define led_classdev_resume LINUX_BACKPORT(led_classdev_resume)
-
-#undef led_trigger_register
-#define led_trigger_register LINUX_BACKPORT(led_trigger_register)
-#undef led_trigger_unregister
-#define led_trigger_unregister LINUX_BACKPORT(led_trigger_unregister)
-#undef led_trigger_register_simple
-#define led_trigger_register_simple LINUX_BACKPORT(led_trigger_register_simple)
-#undef led_trigger_unregister_simple
-#define led_trigger_unregister_simple LINUX_BACKPORT(led_trigger_unregister_simple)
-#undef led_trigger_event
-#define led_trigger_event LINUX_BACKPORT(led_trigger_event)
-
-#undef DEFINE_LED_TRIGGER
-#define DEFINE_LED_TRIGGER(x) static struct led_trigger *x;
-
-static inline int led_classdev_register(struct device *parent,
-					struct led_classdev *led_cdev)
-{
-	return 0;
-}
-
-static inline void led_classdev_unregister(struct led_classdev *led_cdev)
-{
-}
-
-static inline void led_trigger_register_simple(const char *name,
-					       struct led_trigger **trigger)
-{
-}
-
-static inline void led_trigger_unregister_simple(struct led_trigger *trigger)
-{
-}
-
-static inline void led_blink_set(struct led_classdev *led_cdev,
-				 unsigned long *delay_on,
-				 unsigned long *delay_off)
-{
-}
-
-static inline void led_set_brightness(struct led_classdev *led_cdev,
-				      enum led_brightness brightness)
-{
-}
-
-static inline void led_classdev_suspend(struct led_classdev *led_cdev)
-{
-}
-
-static inline void led_classdev_resume(struct led_classdev *led_cdev)
-{
-}
-
-static inline int led_trigger_register(struct led_trigger *trigger)
-{
-	INIT_LIST_HEAD(&trigger->led_cdevs);
-	INIT_LIST_HEAD(&trigger->next_trig);
-	rwlock_init(&trigger->leddev_list_lock);
-	return 0;
-}
-
-static inline void led_trigger_unregister(struct led_trigger *trigger)
-{
-}
-
-static inline void led_trigger_event(struct led_trigger *trigger,
-				     enum led_brightness event)
-{
-}
-
-static inline void led_trigger_blink(struct led_trigger *trigger,
-				     unsigned long *delay_on,
-				     unsigned long *delay_off)
-{
-}
-
-static inline void led_trigger_blink_oneshot(struct led_trigger *trigger,
-					     unsigned long *delay_on,
-					     unsigned long *delay_off,
-					     int invert)
-{
-}
-#endif
-
-#endif /* __BACKPORT_LED_DISABLED_SUPPORT */
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index ce2e7d1d..afd6c550 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -3,8 +3,6 @@
 #include_next <linux/leds.h>
 #include <linux/version.h>
 
-#include <backport/leds-disabled.h>
-
 #if LINUX_VERSION_IS_LESS(4,2,0)
 /*
  * There is no LINUX_BACKPORT() guard here because we want it to point to
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f8256af8..d992ba82 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -70,22 +70,6 @@ config BPAUTO_BUILD_NLATTR
 config BPAUTO_MII
 	bool
 
-config BPAUTO_BUILD_LEDS
-	bool
-	depends on !NEW_LEDS || LEDS_CLASS=n || !LEDS_TRIGGERS
-	default y if BPAUTO_NEW_LEDS
-	default y if BPAUTO_LEDS_CLASS
-	default y if BPAUTO_LEDS_TRIGGERS
-
-config BPAUTO_NEW_LEDS
-	bool
-
-config BPAUTO_LEDS_CLASS
-	bool
-
-config BPAUTO_LEDS_TRIGGERS
-	bool
-
 config BPAUTO_USERSEL_BUILD_ALL
 	bool "Build all compat code"
 	help
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
