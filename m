Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39245 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbaKTVQr (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Nov 2014 16:16:47 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so3827438pdb.1
        for <backports@vger.kernel.org>; Thu, 20 Nov 2014 13:16:47 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, oblinger@gmail.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4/5] backports: backport netdev_rss_key_fill()
Date: Thu, 20 Nov 2014 13:16:22 -0800
Message-Id: <1416518183-7347-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20141120_221649_276989_72E33EAB)
In-Reply-To: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
References: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

netdev_rss_key_fill() uses net_get_random_once() and since
this depends on static keys and we've decided to only backport
that only down to 3.5 as that is when static key stuff settled we
only backport netdev_rss_key_fill() down to 3.5 as well. For details
on the net_get_random_once() / static key stuff refer to backports
commit 8cb8816d.

Backporting netdev_rss_key_fill requires us to throw in the
netdev_rss_key within our own backports module. We don't backport
the ability to query this *yet though*, but if we really wanted to
we can provide an interface for that:

For *packaging* [0] we have no other option but to currently provide
our own querying interface, that's silly though, in the future
if we extend sysctl interfaces to allow dynamic extensions we
could just peg what we need also within the backports module to
allow seemless integration. With shiny new *kernel integration*
support [1] though we can enable cherry picking the sysctl components,
and apply it to the older kernel -- however this would pose a change
in compartamentalized backporting strategy as currently used. It would
seem a allowing dynamic extensions to an existing sysctl interface
would be more efficient and would allow packaging to also take
advantage of this effort.

[0] https://backports.wiki.kernel.org/index.php/Documentation/packaging
[1] https://backports.wiki.kernel.org/index.php/Documentation/integration

commit 960fb622f85180f36d3aff82af53e2be3db2f888
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Nov 16 06:23:05 2014 -0800

    net: provide a per host RSS key generic infrastructure

    RSS (Receive Side Scaling) typically uses Toeplitz hash and a 40 or 52 bytes
    RSS key.

    Some drivers use a constant (and well known key), some drivers use a random
    key per port, making bonding setups hard to tune. Well known keys increase
    attack surface, considering that number of queues is usually a power of two.

    This patch provides infrastructure to help drivers doing the right thing.

    netdev_rss_key_fill() should be used by drivers to initialize their RSS key,
    even if they provide ethtool -X support to let user redefine the key later.

    A new /proc/sys/net/core/netdev_rss_key file can be used to get the host
    RSS key even for drivers not providing ethtool -x support, in case some
    applications want to precisely setup flows to match some RX queues.

    Tested:

    myhost:~# cat /proc/sys/net/core/netdev_rss_key
    11:63:99:bb:79:fb:a5:a7:07:45:b2:20:bf:02:42:2d:08:1a:dd:19:2b:6b:23:ac:56:28:9d:70:c3:ac:e8:16:4b:b7:c1:10:53:a4:78:41:36:40:74:b6:15:ca:27:44:aa:b3:4d:72

    myhost:~# ethtool -x eth0
    RX flow hash indirection table for eth0 with 8 RX ring(s):
        0:      0     1     2     3     4     5     6     7
    RSS hash key:
    11:63:99:bb:79:fb:a5:a7:07:45:b2:20:bf:02:42:2d:08:1a:dd:19:2b:6b:23:ac:56:28:9d:70:c3:ac:e8:16:4b:b7:c1:10:53:a4:78:41

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py \
	/home/mcgrof/linux-next /home/mcgrof/build/backports-20141117
Copy original source files ...
Applying patches from patches to /home/mcgrof/build/backports-20141117
...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m28.499s
user    13m25.112s
sys     0m47.804s

mcgrof@drvbp1 ~/build/backports-20141117 $ time \
	/home/mcgrof/backports/devel/ckmake --allyesconfig
1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.104             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.58             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.31             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.22             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.6              [  OK  ]
18  3.17.1              [  OK  ]
19  3.18-rc1            [  OK  ]

real    42m18.874s
user    1179m40.500s
sys     138m54.452s

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 backport/backport-include/linux/netdevice.h | 25 +++++++++++++++++++++++++
 backport/compat/backport-3.19.c             | 15 ++++++++++++++-
 dependencies                                |  6 ++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index b453280..0469fdd 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -200,4 +200,29 @@ static inline void backport_unregister_netdevice_many(struct list_head *head)
 #define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
 #endif
 
+/*
+ * Complicated way of saying: We only backport netdev_rss_key stuff on kernels
+ * that either already have net_get_random_once() (>= 3.13) or where we've been
+ * brave enough to backport it due to static keys, refer to backports commit
+ * 8cb8816d for details on difficulty to backport that further down.
+ */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
+#define __BACKPORT_NETDEV_RSS_KEY_FILL 1
+#else
+#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
+#define __BACKPORT_NETDEV_RSS_KEY_FILL 1
+#endif
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
+#ifdef __BACKPORT_NETDEV_RSS_KEY_FILL
+/* RSS keys are 40 or 52 bytes long */
+#define NETDEV_RSS_KEY_LEN 52
+#define netdev_rss_key LINUX_BACKPORT(netdev_rss_key)
+extern u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
+#define netdev_rss_key_fill LINUX_BACKPORT(netdev_rss_key_fill)
+void netdev_rss_key_fill(void *buffer, size_t len);
+#endif /* __BACKPORT_NETDEV_RSS_KEY_FILL */
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index 18cba4d..fd13400 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -11,7 +11,8 @@
 #include <linux/sched.h>
 #include <linux/kthread.h>
 #include <linux/export.h>
-
+#include <linux/net.h>
+#include <linux/netdevice.h>
 
 static inline bool is_kthread_should_stop(void)
 {
@@ -77,3 +78,15 @@ int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
 	return default_wake_function(wait, mode, sync, key);
 }
 EXPORT_SYMBOL(woken_wake_function);
+
+#ifdef __BACKPORT_NETDEV_RSS_KEY_FILL
+u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
+
+void netdev_rss_key_fill(void *buffer, size_t len)
+{
+	BUG_ON(len > sizeof(netdev_rss_key));
+	net_get_random_once(netdev_rss_key, sizeof(netdev_rss_key));
+	memcpy(buffer, netdev_rss_key, len);
+}
+EXPORT_SYMBOL_GPL(netdev_rss_key_fill);
+#endif /* __BACKPORT_NETDEV_RSS_KEY_FILL */
diff --git a/dependencies b/dependencies
index 8e11497..9f7166c 100644
--- a/dependencies
+++ b/dependencies
@@ -130,3 +130,9 @@ IR_HIX5HD2 kconfig: CONFIG_MFD_SYSCON
 # tracing results in compile errors
 ATH10K_TRACING 3.4
 ATH_TRACEPOINTS 3.1
+
+# depends on netdev_rss_key_fill() which uses net_get_random_once()
+# and since net_get_random_once() depends on static keys we've decided
+# to backport that only down to 3.5. For full details refer to backports
+# commit 8cb8816d
+IGB 3.5
-- 
2.1.1

