Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Serge Hallyn <serge.hallyn@canonical.com>
Subject: [PATCH 3/3] compat: backport seq_file's user namespace addition
Date: Fri, 28 Sep 2012 23:38:25 -0700
Message-Id: <1348900705-12431-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit adb37c4, which as per linux-next may get to
v3.7-rc1, introduced adding a user namespace to a
struct seq_file. For older kernels with CONFIG_USER_NS
support just access the user_name space via the struct
file. For kernels without CONFIG_USER_NS pass the
init_user_ns. There is a special case to handle for
kernels with CONFIG_USER_NS prior to v2.6.38 --
see commit 47a150ed which added a struct user_namespace
to struct cred.

This backports:

commit adb37c4c67f807f16beb222028fb3ce9a354dc2b
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Wed May 23 18:01:20 2012 -0600

    userns: Make seq_file's user namespace accessible

    struct file already has a user namespace associated with it
    in file->f_cred->user_ns, unfortunately because struct
    seq_file has no struct file backpointer associated with
    it, it is difficult to get at the user namespace in seq_file
    context.  Therefore add a helper function seq_user_ns to return
    the associated user namespace and a user_ns field to struct
    seq_file to be used in implementing seq_user_ns.

    Cc: Al Viro <viro@ZenIV.linux.org.uk>
    Cc: Eric Dumazet <eric.dumazet@gmail.com>
    Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
    Cc: Alexey Dobriyan <adobriyan@gmail.com>
    Acked-by: David S. Miller <davem@davemloft.net>
    Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

And for kernels older than v2.6.38 this is relevant to
review:

commit 47a150edc2ae734c0f4bf50aa19499e23b9a46f8
Author: Serge E. Hallyn <serge.hallyn@canonical.com>
Date:   Fri May 13 04:27:54 2011 +0100

    Cache user_ns in struct cred

    If !CONFIG_USERNS, have current_user_ns() defined to (&init_user_ns).

    Get rid of _current_user_ns.  This requires nsown_capable() to be
    defined in capability.c rather than as static inline in capability.h,
    so do that.

    Request_key needs init_user_ns defined at current_user_ns if
    !CONFIG_USERNS, so forward-declare that in cred.h if !CONFIG_USERNS
    at current_user_ns() define.

    Compile-tested with and without CONFIG_USERNS.

    Signed-off-by: Serge E. Hallyn <serge.hallyn@canonical.com>
    [ This makes a huge performance difference for acl_permission_check(),
      up to 30%.  And that is one of the hottest kernel functions for loads
      that are pathname-lookup heavy.  ]
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

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

real	1m1.219s
user	3m19.912s
sys	0m31.102s

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Serge Hallyn <serge.hallyn@canonical.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/compat-3.7.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 80c2aad..2d7b6dd 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -10,9 +10,36 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/mm.h>
+#include <linux/user_namespace.h>
+#include <linux/file.h>
+#include <linux/seq_file.h>
 
 #define VM_DONTDUMP    VM_NODUMP
 
+#ifdef CONFIG_USER_NS
+
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	struct file *f = container_of((void *) seq, struct file, private_data);
+
+	return f->f_cred->user_ns;
+}
+#else
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	return current_user_ns();
+}
+#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
+
+#else
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	extern struct user_namespace init_user_ns;
+	return &init_user_ns;
+}
+#endif /* CONFIG_USER_NS */
+
 #define netlink_notify_portid(__notify) (__notify->pid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
 #define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).pid
-- 
1.7.10.4
