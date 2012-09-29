Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Serge Hallyn <serge.hallyn@canonical.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/3] compat: backport uidgid.h kuid_t and kgid_t addition
Date: Fri, 28 Sep 2012 23:38:23 -0700
Message-Id: <1348900705-12431-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains \
	7a4e7408c5cadb240e068a662251754a562355e3
v3.5-rc1~107^2~33

This backports:

commit 7a4e7408c5cadb240e068a662251754a562355e3
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Mon Nov 14 14:29:51 2011 -0800

    userns: Add kuid_t and kgid_t and associated infrastructure in uidgid.h

    Start distinguishing between internal kernel uids and gids and
    values that userspace can use.  This is done by introducing two
    new types: kuid_t and kgid_t.  These types and their associated
    functions are infrastructure are declared in the new header
    uidgid.h.

    Ultimately there will be a different implementation of the mapping
    functions for use with user namespaces.  But to keep it simple
    we introduce the mapping functions first to separate the meat
    from the mechanical code conversions.

    Export overflowuid and overflowgid so we can use from_kuid_munged
    and from_kgid_munged in modular code.

    Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

The uidgid.h header file is provided for older kernels and for
newer kernels we use include_next trick. The only difference
here is that compat-3.5.c now exports overflowuid and
overflowgid in the case that CONFIG_UID16 was not defined
given that on older kernels these were not exported although
linux/highuid.h always has historically provided the extern
declaration for them.

Apart from all this we also force inclusion of uidgid.h
within the compat framework now given that in newer
kernels its expected to be included by many header files
and modules without them having included it in upstream
code already.

mcgrof@garbanzo ~/compat (git::master)$ time ckmake
Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real	1m0.411s
user	3m18.060s
sys	0m30.686s

Cc: Serge Hallyn <serge.hallyn@canonical.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 compat/Makefile            |    3 +
 compat/compat-3.5.c        |   30 +++++++
 compat/user_namespace.c    |   68 +++++++++++++++
 include/linux/compat-2.6.h |    1 +
 include/linux/uidgid.h     |  205 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 compat/compat-3.5.c
 create mode 100644 compat/user_namespace.c
 create mode 100644 include/linux/uidgid.h

diff --git a/compat/Makefile b/compat/Makefile
index a44b345..e9c6e1f 100644
--- a/compat/Makefile
+++ b/compat/Makefile
@@ -45,6 +45,9 @@ compat-$(CONFIG_COMPAT_KERNEL_3_2) += compat-3.2.o
 compat-$(CONFIG_COMPAT_KERNEL_3_3) += \
 	compat-3.3.o
 compat-$(CONFIG_COMPAT_KERNEL_3_4) += compat-3.4.o
+compat-$(CONFIG_COMPAT_KERNEL_3_5) += \
+	compat-3.5.o \
+	user_namespace.o
 compat-$(CONFIG_COMPAT_KERNEL_3_7) += compat-3.7.o
 
 compat-$(CONFIG_COMPAT_CORDIC) += cordic.o
diff --git a/compat/compat-3.5.c b/compat/compat-3.5.c
new file mode 100644
index 0000000..a6b174d
--- /dev/null
+++ b/compat/compat-3.5.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Compatibility file for Linux wireless for kernels 3.5.
+ */
+
+#include <linux/module.h>
+#include <linux/highuid.h>
+
+/*
+ * Commit 7a4e7408c5cadb240e068a662251754a562355e3
+ * exported overflowuid and overflowgid for all
+ * kernel configurations, prior to that we only
+ * had it exported when CONFIG_UID16 was enabled.
+ * We are technically redefining it here but
+ * nothing seems to be changing it, except
+ * kernel/ code does epose it via sysctl and
+ * proc... if required later we can add that here.
+ */
+#ifndef CONFIG_UID16
+int overflowuid = DEFAULT_OVERFLOWUID;
+int overflowgid = DEFAULT_OVERFLOWGID;
+
+EXPORT_SYMBOL(overflowuid);
+EXPORT_SYMBOL(overflowgid);
+#endif
diff --git a/compat/user_namespace.c b/compat/user_namespace.c
new file mode 100644
index 0000000..a7cebd5
--- /dev/null
+++ b/compat/user_namespace.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2012  Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Compatibility file for Linux wireless for kernels backporting
+ * user_namespace.c
+ */
+
+#include <linux/module.h>
+#include <linux/highuid.h>
+#include <linux/user_namespace.h>
+
+#ifdef CONFIG_USER_NS
+
+kuid_t make_kuid(struct user_namespace *ns, uid_t uid)
+{
+	/* Map the uid to a global kernel uid */
+	return KUIDT_INIT(uid);
+}
+EXPORT_SYMBOL(make_kuid);
+
+uid_t from_kuid(struct user_namespace *targ, kuid_t kuid)
+{
+	/* Map the uid from a global kernel uid */
+	return __kuid_val(kuid);
+}
+EXPORT_SYMBOL(from_kuid);
+
+uid_t from_kuid_munged(struct user_namespace *targ, kuid_t kuid)
+{
+	uid_t uid;
+	uid = from_kuid(targ, kuid);
+
+	if (uid == (uid_t) -1)
+		uid = overflowuid;
+	return uid;
+}
+EXPORT_SYMBOL(from_kuid_munged);
+
+kgid_t make_kgid(struct user_namespace *ns, gid_t gid)
+{
+	/* Map the gid to a global kernel gid */
+	return KGIDT_INIT(gid);
+}
+EXPORT_SYMBOL(make_kgid);
+
+gid_t from_kgid(struct user_namespace *targ, kgid_t kgid)
+{
+	/* Map the gid from a global kernel gid */
+	return __kgid_val(kgid);
+}
+EXPORT_SYMBOL(from_kgid);
+
+gid_t from_kgid_munged(struct user_namespace *targ, kgid_t kgid)
+{
+	gid_t gid;
+	gid = from_kgid(targ, kgid);
+
+	if (gid == (gid_t) -1)
+		gid = overflowgid;
+	return gid;
+}
+EXPORT_SYMBOL(from_kgid_munged);
+
+#endif /* CONFIG_USER_NS */
diff --git a/include/linux/compat-2.6.h b/include/linux/compat-2.6.h
index 46ae654..f26489c 100644
--- a/include/linux/compat-2.6.h
+++ b/include/linux/compat-2.6.h
@@ -11,6 +11,7 @@
 #endif
 #include <linux/compat_autoconf.h>
 #include <linux/init.h>
+#include <linux/uidgid.h>
 
 /*
  * The define overwriting module_init is based on the original module_init
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
new file mode 100644
index 0000000..d9e4224
--- /dev/null
+++ b/include/linux/uidgid.h
@@ -0,0 +1,205 @@
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#include_next <linux/uidgid.h>
+#else
+
+#ifndef _LINUX_UIDGID_H
+#define _LINUX_UIDGID_H
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
+#ifdef CONFIG_UIDGID_STRICT_TYPE_CHECKS
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
+extern kuid_t make_kuid(struct user_namespace *from, uid_t uid);
+extern kgid_t make_kgid(struct user_namespace *from, gid_t gid);
+
+extern uid_t from_kuid(struct user_namespace *to, kuid_t uid);
+extern gid_t from_kgid(struct user_namespace *to, kgid_t gid);
+extern uid_t from_kuid_munged(struct user_namespace *to, kuid_t uid);
+extern gid_t from_kgid_munged(struct user_namespace *to, kgid_t gid);
+
+static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
+{
+	return from_kuid(ns, uid) != (uid_t) -1;
+}
+
+static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
+{
+	return from_kgid(ns, gid) != (gid_t) -1;
+}
+
+#else
+
+static inline kuid_t make_kuid(struct user_namespace *from, uid_t uid)
+{
+	return KUIDT_INIT(uid);
+}
+
+static inline kgid_t make_kgid(struct user_namespace *from, gid_t gid)
+{
+	return KGIDT_INIT(gid);
+}
+
+static inline uid_t from_kuid(struct user_namespace *to, kuid_t kuid)
+{
+	return __kuid_val(kuid);
+}
+
+static inline gid_t from_kgid(struct user_namespace *to, kgid_t kgid)
+{
+	return __kgid_val(kgid);
+}
+
+static inline uid_t from_kuid_munged(struct user_namespace *to, kuid_t kuid)
+{
+	uid_t uid = from_kuid(to, kuid);
+	if (uid == (uid_t)-1)
+		uid = overflowuid;
+	return uid;
+}
+
+static inline gid_t from_kgid_munged(struct user_namespace *to, kgid_t kgid)
+{
+	gid_t gid = from_kgid(to, kgid);
+	if (gid == (gid_t)-1)
+		gid = overflowgid;
+	return gid;
+}
+
+static inline bool kuid_has_mapping(struct user_namespace *ns, kuid_t uid)
+{
+	return true;
+}
+
+static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
+{
+	return true;
+}
+
+#endif /* CONFIG_USER_NS */
+
+#endif /* _LINUX_UIDGID_H */
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
-- 
1.7.10.4
