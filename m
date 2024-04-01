Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BC55C3A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009040; cv=none; b=jwf9KpNRwbrZc6sEtBP6OkviFvYol/i4GaoylmrSlud/K8oy6X9JMRzqVxmUwm0mUCCWyiQXhuCeU/xPwbaMEjUHyJ3K8brR+9lii8T5tGqq+fvYspl9HIXVg9AgzU3ekAlo7mnNLAy0/bmUN82Ogwrh9bsurnPIDLFvJWvuw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009040; c=relaxed/simple;
	bh=Cp9yww4Rsteh6MJ3XhUCeAjDtm8U7/u9/MGMwL06dRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM6s5LLUwLUMnpjl6JSlD4uPPorf4dPaCxNAouiZrrAChyR5xHZsVFiiJhC1imsV+ec9cCyjA8iLZcp52YFxgaVEaQEC3vAp0/eO2AiOgcTdpEKCi0WkFAFeMAce1bTf6v6+4ycuhnknjAIa35EwYlQwzBX3/T9VMFS42i5Fa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ETHoA/Je; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ETHoA/Je"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V7lQY6b1Pz9spX;
	Tue,  2 Apr 2024 00:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ovfT1CJYrU0uPY+Tq847/qnysd6uQ+yYOqwS7sXHRk=;
	b=ETHoA/JeZYTnFXCSAikARLXeSxexw/T4cFGdpLeTmWrEkiuezS4rJF9OZvjFQ71ONa+854
	go5uyQ8GqfFJT8Ncb/tbRh+W0ILOlwZe1/QntIQ2NddQd0QQlfAXYnCh6NvifwmS/gxwl0
	nVh0t4lM6PU6GJ7rZykQyYerqQ+khkRfLikfBMLfT/c09VzujV5L8fcJ2SE+hHBZSkvEPa
	tNJoIgMVJ5ldFkHO/jOvmgosSKPqCJflteN1bp0JnuA1usbjfFSpsx4xTcXnRfg1W/J2+g
	cgCe9D4cZapgpsmwCSKTCwJz1rHagBQ7/FACOxSiDaYg926iM7qagrsSmJ7R9w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] backports: Remove support for kernel smaller than 4.13
Date: Tue,  2 Apr 2024 00:03:13 +0200
Message-ID: <20240401220314.2434455-10-hauke@hauke-m.de>
In-Reply-To: <20240401220314.2434455-1-hauke@hauke-m.de>
References: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQY6b1Pz9spX

This removes all the code which is needed to support kernel 4.12.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml                |  1 -
 README                                      |  2 +-
 backport/backport-include/acpi/acpi_bus.h   | 15 ------
 backport/backport-include/linux/acpi.h      | 15 ------
 backport/backport-include/linux/build_bug.h |  4 --
 backport/backport-include/linux/kernel.h    |  7 ---
 backport/backport-include/linux/skbuff.h    | 54 ---------------------
 backport/backport-include/linux/uuid.h      | 34 -------------
 backport/backport-include/linux/wait.h      | 25 ----------
 patches/0082-pci_error_handlers.cocci       | 32 ------------
 10 files changed, 1 insertion(+), 188 deletions(-)
 delete mode 100644 backport/backport-include/acpi/acpi_bus.h
 delete mode 100644 backport/backport-include/linux/acpi.h
 delete mode 100644 backport/backport-include/linux/kernel.h
 delete mode 100644 backport/backport-include/linux/uuid.h
 delete mode 100644 backport/backport-include/linux/wait.h
 delete mode 100644 patches/0082-pci_error_handlers.cocci

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index f99cdf88..7850b8f0 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -55,7 +55,6 @@ jobs:
     strategy:
       matrix:
         kernel: [
-           "4.12",
            "4.13",
            "4.14",
            "4.15",
diff --git a/README b/README
index 1b76bcee..2eb53ab1 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 4.12 and above.
+for kernels 4.13 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/acpi/acpi_bus.h b/backport/backport-include/acpi/acpi_bus.h
deleted file mode 100644
index fbd68a16..00000000
--- a/backport/backport-include/acpi/acpi_bus.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef _BACKPORTS_ACPI_BUS_H__
-#define _BACKPORTS_ACPI_BUS_H__ 1
-
-#include_next <acpi/acpi_bus.h>
-
-#if LINUX_VERSION_IS_LESS(4,13,0)
-static inline union acpi_object *
-backport_acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func, union acpi_object *argv4)
-{
-	return acpi_evaluate_dsm(handle, guid->b, rev, func, argv4);
-}
-#define acpi_evaluate_dsm LINUX_BACKPORT(acpi_evaluate_dsm)
-#endif /* x < 4.13.0 */
-
-#endif /* _BACKPORTS_ACPI_BUS_H__ */
diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
deleted file mode 100644
index bee7ae17..00000000
--- a/backport/backport-include/linux/acpi.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __BACKPORT_LINUX_ACPI_H
-#define __BACKPORT_LINUX_ACPI_H
-#include_next <linux/acpi.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_IS_LESS(4,13,0)
-#define devm_acpi_dev_add_driver_gpios LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
-static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
-			      const struct acpi_gpio_mapping *gpios)
-{
-	return -ENXIO;
-}
-#endif /* LINUX_VERSION_IS_LESS(4,13,0) */
-
-#endif /* __BACKPORT_LINUX_ACPI_H */
diff --git a/backport/backport-include/linux/build_bug.h b/backport/backport-include/linux/build_bug.h
index c883e525..356ac044 100644
--- a/backport/backport-include/linux/build_bug.h
+++ b/backport/backport-include/linux/build_bug.h
@@ -1,11 +1,7 @@
 #ifndef __BP_BUILD_BUG_H
 #define __BP_BUILD_BUG_H
 
-#if LINUX_VERSION_IS_GEQ(4,13,0)
 #include_next <linux/build_bug.h>
-#else /* LINUX_VERSION_IS_GEQ(4,13,0) */
-#include <linux/bug.h>
-#endif /* LINUX_VERSION_IS_GEQ(4,13,0) */
 
 #ifndef static_assert
 /**
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
deleted file mode 100644
index ae73f8db..00000000
--- a/backport/backport-include/linux/kernel.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __BACKPORT_KERNEL_H
-#define __BACKPORT_KERNEL_H
-#include_next <linux/kernel.h>
-/* needed to include BUILD_BUG_ON_ZERO on <= 4.12 */
-#include <linux/bug.h>
-
-#endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index d0466daa..2bcd1036 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -3,60 +3,6 @@
 #include_next <linux/skbuff.h>
 #include <linux/version.h>
 
-
-#if LINUX_VERSION_IS_LESS(4,13,0) && \
-	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
-static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
-{
-	return skb_put(skb, len);
-}
-#define skb_put LINUX_BACKPORT(skb_put)
-
-static inline void *backport_skb_push(struct sk_buff *skb, unsigned int len)
-{
-	return skb_push(skb, len);
-}
-#define skb_push LINUX_BACKPORT(skb_push)
-
-static inline void *backport___skb_push(struct sk_buff *skb, unsigned int len)
-{
-	return __skb_push(skb, len);
-}
-#define __skb_push LINUX_BACKPORT(__skb_push)
-
-static inline void *__skb_put_zero(struct sk_buff *skb, unsigned int len)
-{
-	void *tmp = __skb_put(skb, len);
-
-	memset(tmp, 0, len);
-	return tmp;
-}
-
-static inline void *skb_put_zero(struct sk_buff *skb, unsigned int len)
-{
-	void *tmp = skb_put(skb, len);
-
-	memset(tmp, 0, len);
-
-	return tmp;
-}
-
-static inline void *skb_put_data(struct sk_buff *skb, const void *data,
-				 unsigned int len)
-{
-	void *tmp = skb_put(skb, len);
-
-	memcpy(tmp, data, len);
-
-	return tmp;
-}
-
-static inline void skb_put_u8(struct sk_buff *skb, u8 val)
-{
-	*(u8 *)skb_put(skb, 1) = val;
-}
-#endif
-
 #if LINUX_VERSION_IS_LESS(4,20,0)
 static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
 {
diff --git a/backport/backport-include/linux/uuid.h b/backport/backport-include/linux/uuid.h
deleted file mode 100644
index 90352f1b..00000000
--- a/backport/backport-include/linux/uuid.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef __BACKPORT_LINUX_UUID_H_
-#define __BACKPORT_LINUX_UUID_H_
-#include <linux/version.h>
-#include_next <linux/uuid.h>
-
-#ifndef UUID_STRING_LEN
-/*
- * The length of a UUID string ("aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee")
- * not including trailing NUL.
- */
-#define	UUID_STRING_LEN		36
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,13,0)
-#define guid_t uuid_le
-#define uuid_t uuid_be
-#define GUID_INIT UUID_LE
-
-static inline void guid_gen(guid_t *u)
-{
-	return uuid_le_gen(u);
-}
-static inline void uuid_gen(uuid_t *u)
-{
-	return uuid_be_gen(u);
-}
-
-static inline void guid_copy(guid_t *dst, const guid_t *src)
-{
-	memcpy(dst, src, sizeof(guid_t));
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_UUID_H_ */
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
deleted file mode 100644
index f07f6099..00000000
--- a/backport/backport-include/linux/wait.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __BACKPORT_LINUX_WAIT_H
-#define __BACKPORT_LINUX_WAIT_H
-#include_next <linux/wait.h>
-
-
-#if LINUX_VERSION_IS_LESS(4,13,0)
-#define wait_queue_entry_t wait_queue_t
-
-#define wait_event_killable_timeout(wq_head, condition, timeout)	\
-({									\
-	long __ret = timeout;						\
-	might_sleep();							\
-	if (!___wait_cond_timeout(condition))				\
-		__ret = __wait_event_killable_timeout(wq_head,		\
-						condition, timeout);	\
-	__ret;								\
-})
-
-#define __wait_event_killable_timeout(wq_head, condition, timeout)	\
-	___wait_event(wq_head, ___wait_cond_timeout(condition),		\
-		      TASK_KILLABLE, 0, timeout,			\
-		      __ret = schedule_timeout(__ret))
-#endif
-
-#endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/patches/0082-pci_error_handlers.cocci b/patches/0082-pci_error_handlers.cocci
deleted file mode 100644
index 9b5573d4..00000000
--- a/patches/0082-pci_error_handlers.cocci
+++ /dev/null
@@ -1,32 +0,0 @@
-@r@
-identifier OPS;
-identifier pcie_reset_prepare_fn;
-identifier pcie_reset_done_fn;
-fresh identifier pcie_reset_notify_fn = pcie_reset_prepare_fn ## "_notify";
-position p;
-@@
-struct pci_error_handlers OPS@p = {
-+#if LINUX_VERSION_IS_GEQ(4,13,0)
-	.reset_prepare = pcie_reset_prepare_fn,
-	.reset_done = pcie_reset_done_fn,
-+#else
-+	.reset_notify = pcie_reset_notify_fn,
-+#endif
-};
-
-
-@@
-identifier r.pcie_reset_prepare_fn;
-identifier r.pcie_reset_done_fn;
-identifier r.pcie_reset_notify_fn;
-@@
-void pcie_reset_done_fn(...) {...}
-+#if LINUX_VERSION_IS_LESS(4,13,0)
-+static void pcie_reset_notify_fn(struct pci_dev *dev, bool prepare)
-+{
-+	if (prepare)
-+		pcie_reset_prepare_fn(dev);
-+	else
-+		pcie_reset_done_fn(dev);
-+}
-+#endif
-- 
2.44.0

