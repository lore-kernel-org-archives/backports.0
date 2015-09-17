Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61563 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbIQVri (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 17 Sep 2015 17:47:38 -0400
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: backports@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 1/2] Add required changes for audio packports
Date: Thu, 17 Sep 2015 16:47:16 -0500
Message-Id: <1442526437-22392-2-git-send-email-pierre-louis.bossart@linux.intel.com> (sfid-20150917_234741_112317_5CC135D1)
In-Reply-To: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 backport/Kconfig.sources                           |   2 +
 backport/Makefile.kernel                           |   2 +
 backport/backport-include/linux/firewire.h         |  12 +
 backport/backport-include/linux/genalloc.h         |   9 +
 backport/backport-include/linux/hrtimer.h          |  12 +
 backport/backport-include/linux/skbuff.h           |   2 +
 backport/backport-include/linux/uio.h              | 246 +++++++++++++++++++++
 dependencies                                       |   2 +
 .../sound/0001-pcm-native-fix-v41-changes.patch    | 128 +++++++++++
 patches/collateral-evolutions/sound/README         |   1 +
 10 files changed, 416 insertions(+)
 create mode 100644 backport/backport-include/linux/firewire.h
 create mode 100644 backport/backport-include/linux/genalloc.h
 create mode 100644 backport/backport-include/linux/hrtimer.h
 create mode 100644 backport/backport-include/linux/uio.h
 create mode 100644 patches/collateral-evolutions/sound/0001-pcm-native-fix-v41-changes.patch
 create mode 100644 patches/collateral-evolutions/sound/README

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 5711433..b076648 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -22,3 +22,5 @@ source "$BACKPORT_DIR/net/mac802154/Kconfig"
 source "$BACKPORT_DIR/drivers/net/ieee802154/Kconfig"
 
 source "$BACKPORT_DIR/drivers/usb/class/Kconfig"
+
+source "$BACKPORT_DIR/sound/Kconfig"
\ No newline at end of file
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 42333ad..cbdcd28 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -54,3 +54,5 @@ obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
 
 obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
 obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
+
+obj-$(CPTCFG_SOUND) += sound/
diff --git a/backport/backport-include/linux/firewire.h b/backport/backport-include/linux/firewire.h
new file mode 100644
index 0000000..3306ce8
--- /dev/null
+++ b/backport/backport-include/linux/firewire.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_FIREWIRE_H
+#define __BACKPORT_LINUX_FIREWIRE_H
+#include_next <linux/firewire.h>
+#include <linux/version.h>
+
+#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+
+void fw_schedule_bus_reset(struct fw_card *card, bool delayed,
+			   bool short_reset);
+#endif /* < 3.16 */
+
+#endif /* __BACKPORT_LINUX_FIREWIRE_H */
diff --git a/backport/backport-include/linux/genalloc.h b/backport/backport-include/linux/genalloc.h
new file mode 100644
index 0000000..a7917f3
--- /dev/null
+++ b/backport/backport-include/linux/genalloc.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_LINUX_GENALLOC_H
+#define __BACKPORT_LINUX_GENALLOC_H
+#include_next <linux/genalloc.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#define of_gen_pool_get of_get_named_gen_pool
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4, 2, 0) */
+
+#endif /* __BACKPORT_LINUX_GENALLOC_H */
diff --git a/backport/backport-include/linux/hrtimer.h b/backport/backport-include/linux/hrtimer.h
new file mode 100644
index 0000000..e951315
--- /dev/null
+++ b/backport/backport-include/linux/hrtimer.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_HRTIMER_H
+#define __BACKPORT_LINUX_HRTIMER_H
+#include_next <linux/hrtimer.h>
+#include <linux/version.h>
+
+#if  LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+
+#define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
+
+#endif /* < 4.2 */
+
+#endif /* __BACKPORT_LINUX_HRTIMER_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index a21e6cc..2c56141 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -258,6 +258,8 @@ static inline struct page *dev_alloc_page(void)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+
+#include <linux/uio.h>
 #define skb_copy_datagram_msg LINUX_BACKPORT(skb_copy_datagram_msg)
 static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 					struct msghdr *msg, int size)
diff --git a/backport/backport-include/linux/uio.h b/backport/backport-include/linux/uio.h
new file mode 100644
index 0000000..0aa5e87
--- /dev/null
+++ b/backport/backport-include/linux/uio.h
@@ -0,0 +1,246 @@
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#include_next <linux/uio.h>
+
+#ifndef __iter_is_iovec_h_
+#define __iter_is_iovec_h_
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0))
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
+
+/* iov_iter is defined elsewhere */
+#include_next <linux/fs.h>
+static inline bool iter_is_iovec(struct iov_iter *i)
+{
+	return true;
+}
+
+#else
+static inline bool iter_is_iovec(struct iov_iter *i)
+{
+	return !(i->type & (ITER_BVEC | ITER_KVEC));
+}
+#endif
+#endif
+
+#endif /* __iter_is_iovec_h_ */
+
+#else
+
+#ifndef _LINUX_UIO_H
+#define _LINUX_UIO_H
+
+/*
+ * A set of types for the internal kernel types representing uids and gids.
+ *
+ * The types defined in this header allow distinguishing which uids and gids in
+ * the kernel are values used by userspace and which uid and gid values are
+ * the internal kernel values.  With the addition of user namespaces the values
+ * can be different.  Using the type system makes it possible for the compiler
+ * to detect when we overlook these differences.
+ *
+ */
+#include <linux/types.h>
+#include <linux/highuid.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+#ifdef CONFIG_UIO_STRICT_TYPE_CHECKS
+
+typedef struct {
+	uid_t val;
+} kuid_t;
+
+
+typedef struct {
+	gid_t val;
+} kgid_t;
+
+#define KUIDT_INIT(value) (kuid_t){ value }
+#define KGIDT_INIT(value) (kgid_t){ value }
+
+static inline uid_t __kuid_val(kuid_t uid)
+{
+	return uid.val;
+}
+
+static inline gid_t __kgid_val(kgid_t gid)
+{
+	return gid.val;
+}
+
+#else
+
+typedef uid_t kuid_t;
+typedef gid_t kgid_t;
+
+static inline uid_t __kuid_val(kuid_t uid)
+{
+	return uid;
+}
+
+static inline gid_t __kgid_val(kgid_t gid)
+{
+	return gid;
+}
+
+#define KUIDT_INIT(value) ((kuid_t) value )
+#define KGIDT_INIT(value) ((kgid_t) value )
+
+#endif
+
+#define GLOBAL_ROOT_UID KUIDT_INIT(0)
+#define GLOBAL_ROOT_GID KGIDT_INIT(0)
+
+#define INVALID_UID KUIDT_INIT(-1)
+#define INVALID_GID KGIDT_INIT(-1)
+
+static inline bool uid_eq(kuid_t left, kuid_t right)
+{
+	return __kuid_val(left) == __kuid_val(right);
+}
+
+static inline bool gid_eq(kgid_t left, kgid_t right)
+{
+	return __kgid_val(left) == __kgid_val(right);
+}
+
+static inline bool uid_gt(kuid_t left, kuid_t right)
+{
+	return __kuid_val(left) > __kuid_val(right);
+}
+
+static inline bool gid_gt(kgid_t left, kgid_t right)
+{
+	return __kgid_val(left) > __kgid_val(right);
+}
+
+static inline bool uid_gte(kuid_t left, kuid_t right)
+{
+	return __kuid_val(left) >= __kuid_val(right);
+}
+
+static inline bool gid_gte(kgid_t left, kgid_t right)
+{
+	return __kgid_val(left) >= __kgid_val(right);
+}
+
+static inline bool uid_lt(kuid_t left, kuid_t right)
+{
+	return __kuid_val(left) < __kuid_val(right);
+}
+
+static inline bool gid_lt(kgid_t left, kgid_t right)
+{
+	return __kgid_val(left) < __kgid_val(right);
+}
+
+static inline bool uid_lte(kuid_t left, kuid_t right)
+{
+	return __kuid_val(left) <= __kuid_val(right);
+}
+
+static inline bool gid_lte(kgid_t left, kgid_t right)
+{
+	return __kgid_val(left) <= __kgid_val(right);
+}
+
+static inline bool uid_valid(kuid_t uid)
+{
+	return !uid_eq(uid, INVALID_UID);
+}
+
+static inline bool gid_valid(kgid_t gid)
+{
+	return !gid_eq(gid, INVALID_GID);
+}
+
+#ifdef CONFIG_USER_NS
+
+#define make_kuid LINUX_BACKPORT(make_kuid)
+extern kuid_t make_kuid(struct user_namespace *from, uid_t uid);
+#define make_kgid LINUX_BACKPORT(make_kgid)
+extern kgid_t make_kgid(struct user_namespace *from, gid_t gid);
+
+#define from_kuid LINUX_BACKPORT(from_kuid)
+extern uid_t from_kuid(struct user_namespace *to, kuid_t uid);
+#define from_kgid LINUX_BACKPORT(from_kgid)
+extern gid_t from_kgid(struct user_namespace *to, kgid_t gid);
+#define from_kuid_munged LINUX_BACKPORT(from_kuid_munged)
+extern uid_t from_kuid_munged(struct user_namespace *to, kuid_t uid);
+#define from_kgid_munged LINUX_BACKPORT(from_kgid_munged)
+extern gid_t from_kgid_munged(struct user_namespace *to, kgid_t gid);
+
+#define kuid_has_mapping LINUX_BACKPORT(kuid_has_mapping)
+static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
+{
+	return from_kuid(ns, uid) != (uid_t) -1;
+}
+
+#define kgid_has_mapping LINUX_BACKPORT(kgid_has_mapping)
+static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
+{
+	return from_kgid(ns, gid) != (gid_t) -1;
+}
+
+#else
+
+#define make_kuid LINUX_BACKPORT(make_kuid)
+static inline kuid_t make_kuid(struct user_namespace *from, uid_t uid)
+{
+	return KUIDT_INIT(uid);
+}
+
+#define make_kgid LINUX_BACKPORT(make_kgid)
+static inline kgid_t make_kgid(struct user_namespace *from, gid_t gid)
+{
+	return KGIDT_INIT(gid);
+}
+
+#define from_kuid LINUX_BACKPORT(from_kuid)
+static inline uid_t from_kuid(struct user_namespace *to, kuid_t kuid)
+{
+	return __kuid_val(kuid);
+}
+
+#define from_kgid LINUX_BACKPORT(from_kgid)
+static inline gid_t from_kgid(struct user_namespace *to, kgid_t kgid)
+{
+	return __kgid_val(kgid);
+}
+
+#define from_kuid_munged LINUX_BACKPORT(from_kuid_munged)
+static inline uid_t from_kuid_munged(struct user_namespace *to, kuid_t kuid)
+{
+	uid_t uid = from_kuid(to, kuid);
+	if (uid == (uid_t)-1)
+		uid = overflowuid;
+	return uid;
+}
+
+#define from_kgid_munged LINUX_BACKPORT(from_kgid_munged)
+static inline gid_t from_kgid_munged(struct user_namespace *to, kgid_t kgid)
+{
+	gid_t gid = from_kgid(to, kgid);
+	if (gid == (gid_t)-1)
+		gid = overflowgid;
+	return gid;
+}
+
+#define kuid_has_mapping LINUX_BACKPORT(kuid_has_mapping)
+static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
+{
+	return true;
+}
+
+#define kgid_has_mapping LINUX_BACKPORT(kgid_has_mapping)
+static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
+{
+	return true;
+}
+
+#endif /* CONFIG_USER_NS */
+
+#endif /* _LINUX_UIO_H */
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/dependencies b/dependencies
index ba78004..bd84a6e 100644
--- a/dependencies
+++ b/dependencies
@@ -178,3 +178,5 @@ IGB 3.5
 
 # This driver needs mmc_hw_reset() which was added in kernel version 3.2
 MWIFIEX_SDIO 3.2
+
+SOUND 3.13
\ No newline at end of file
diff --git a/patches/collateral-evolutions/sound/0001-pcm-native-fix-v41-changes.patch b/patches/collateral-evolutions/sound/0001-pcm-native-fix-v41-changes.patch
new file mode 100644
index 0000000..12a57c5
--- /dev/null
+++ b/patches/collateral-evolutions/sound/0001-pcm-native-fix-v41-changes.patch
@@ -0,0 +1,128 @@
+diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
+index 75888dd..2b4a149 100644
+--- a/sound/core/pcm_native.c
++++ b/sound/core/pcm_native.c
+@@ -3068,6 +3068,91 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
+ 	return result;
+ }
+ 
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++
++/*
++ * FIXME: this structure is in aio.h or linux/include.h,
++ * include it here for now to avoid compilation issues
++ */
++
++struct kiocb {
++	struct file		*ki_filp;
++	loff_t			ki_pos;
++	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
++	void			*private;
++	int			ki_flags;
++};
++
++static ssize_t snd_pcm_aio_read(struct kiocb *iocb, const struct iovec *iov,
++			     unsigned long nr_segs, loff_t pos)
++
++{
++	struct snd_pcm_file *pcm_file;
++	struct snd_pcm_substream *substream;
++	struct snd_pcm_runtime *runtime;
++	snd_pcm_sframes_t result;
++	unsigned long i;
++	void __user **bufs;
++	snd_pcm_uframes_t frames;
++
++	pcm_file = iocb->ki_filp->private_data;
++	substream = pcm_file->substream;
++	if (PCM_RUNTIME_CHECK(substream))
++		return -ENXIO;
++	runtime = substream->runtime;
++	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
++		return -EBADFD;
++	if (nr_segs > 1024 || nr_segs != runtime->channels)
++		return -EINVAL;
++	if (!frame_aligned(runtime, iov->iov_len))
++		return -EINVAL;
++	frames = bytes_to_samples(runtime, iov->iov_len);
++	bufs = kmalloc(sizeof(void *) * nr_segs, GFP_KERNEL);
++	if (bufs == NULL)
++		return -ENOMEM;
++	for (i = 0; i < nr_segs; ++i)
++		bufs[i] = iov[i].iov_base;
++	result = snd_pcm_lib_readv(substream, bufs, frames);
++	if (result > 0)
++		result = frames_to_bytes(runtime, result);
++	kfree(bufs);
++	return result;
++}
++
++static ssize_t snd_pcm_aio_write(struct kiocb *iocb, const struct iovec *iov,
++			      unsigned long nr_segs, loff_t pos)
++{
++	struct snd_pcm_file *pcm_file;
++	struct snd_pcm_substream *substream;
++	struct snd_pcm_runtime *runtime;
++	snd_pcm_sframes_t result;
++	unsigned long i;
++	void __user **bufs;
++	snd_pcm_uframes_t frames;
++
++	pcm_file = iocb->ki_filp->private_data;
++	substream = pcm_file->substream;
++	if (PCM_RUNTIME_CHECK(substream))
++		return -ENXIO;
++	runtime = substream->runtime;
++	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
++		return -EBADFD;
++	if (nr_segs > 128 || nr_segs != runtime->channels ||
++	    !frame_aligned(runtime, iov->iov_len))
++		return -EINVAL;
++	frames = bytes_to_samples(runtime, iov->iov_len);
++	bufs = kmalloc(sizeof(void *) * nr_segs, GFP_KERNEL);
++	if (bufs == NULL)
++		return -ENOMEM;
++	for (i = 0; i < nr_segs; ++i)
++		bufs[i] = iov[i].iov_base;
++	result = snd_pcm_lib_writev(substream, bufs, frames);
++	if (result > 0)
++		result = frames_to_bytes(runtime, result);
++	kfree(bufs);
++	return result;
++}
++#else
+ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
+ {
+ 	struct snd_pcm_file *pcm_file;
+@@ -3138,6 +3223,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
+ 	kfree(bufs);
+ 	return result;
+ }
++#endif
+ 
+ static unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
+ {
+@@ -3669,7 +3755,11 @@ const struct file_operations snd_pcm_f_ops[2] = {
+ 	{
+ 		.owner =		THIS_MODULE,
+ 		.write =		snd_pcm_write,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++		.aio_write =             snd_pcm_aio_write,
++#else
+ 		.write_iter =		snd_pcm_writev,
++#endif
+ 		.open =			snd_pcm_playback_open,
+ 		.release =		snd_pcm_release,
+ 		.llseek =		no_llseek,
+@@ -3683,7 +3773,11 @@ const struct file_operations snd_pcm_f_ops[2] = {
+ 	{
+ 		.owner =		THIS_MODULE,
+ 		.read =			snd_pcm_read,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++		.aio_read =             snd_pcm_aio_read,
++#else
+ 		.read_iter =		snd_pcm_readv,
++#endif
+ 		.open =			snd_pcm_capture_open,
+ 		.release =		snd_pcm_release,
+ 		.llseek =		no_llseek,
diff --git a/patches/collateral-evolutions/sound/README b/patches/collateral-evolutions/sound/README
new file mode 100644
index 0000000..4797e65
--- /dev/null
+++ b/patches/collateral-evolutions/sound/README
@@ -0,0 +1 @@
+This holds collateral evolutions that apply to any driver we backport
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
