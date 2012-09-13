Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] compat: backport netlink pid to portid rename
Date: Thu, 13 Sep 2012 15:36:00 -0700
Message-Id: <1347575760-15749-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The patch:

commit 15e473046cb6e5d18a4d0057e61d76315230382b
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Fri Sep 7 20:12:54 2012 +0000

    netlink: Rename pid to portid to avoid confusion

    It is a frequent mistake to confuse the netlink port identifier with a
    process identifier.  Try to reduce this confusion by renaming fields
    that hold port identifiers portid instead of pid.

    I have carefully avoided changing the structures exported to
    userspace to avoid changing the userspace API.

    I have successfully built an allyesconfig kernel with this change.

    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Changed the struct members:

struct netlink_notify->pid    to
struct netlink_notify->portid

struct genl_info->snd_pid     to
struct genl_info->snd_portid

This adds helpers to help reduce the overhead cost to backport
this collateral evolution.

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

real    1m0.017s
user    3m12.748s
sys     0m30.274s

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/compat-3.7.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 6cee787..e4e126c 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -10,6 +10,10 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 
+#define netlink_notify_portid(__notify) (__notify->pid)
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).pid
+
 bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay);
 
@@ -55,6 +59,10 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 
 #define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
 
+#else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
+#define netlink_notify_portid(__notify) (__notify->portid)
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).portid
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
 
 #endif /* LINUX_3_7_COMPAT_H */
-- 
1.7.10.4
