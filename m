Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35373 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdLEQ3N (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 5 Dec 2017 11:29:13 -0500
Received: by mail-ua0-f194.google.com with SMTP id l2so646088uak.2
        for <backports@vger.kernel.org>; Tue, 05 Dec 2017 08:29:13 -0800 (PST)
MIME-Version: 1.0
From: Michael McElroy <mikem388@gmail.com>
Date: Tue, 5 Dec 2017 11:29:12 -0500
Message-ID: <CAJt7DwwqoJMWk1=-BO5O+cfutLfTwE04oYo46GqcMhb9zgGwPA@mail.gmail.com> (sfid-20171205_172916_304793_B93BEC9D)
Subject: Errors backporting to 3.4
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I have been following the thread on the genl-const.cocci parse error. I
had the same problem and found the information very helpful. I had been
killing the gentree build because I thought it was hung applying SmPL patch
0079-netdev-destructor.cocci. On my system, a 4 processor  Intel(R)
Core(TM) i7-3740QM CPU @ 2.70GHz machine, that patch takes about an hour
and 20 minutes with the system at 100% for about an hour. After reading
your discussion, I stopped killing it and it ran successfully.  I am
backporting to 3.4 and ran into a couple of other problems. There were 2
problems building the output against a 3.4 kernel. I wasn't sure that my
kernel was the problem, so I built against the 3.4 branch of linux-stable.

The first problem was caused by commit 8cdd85766293018fea01512959320a
05269e97b4.

Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Oct 13 10:48:42 2017 +0200

    backports: add netdev_upper_dev_link() extack argument

    But make it optional (using magic.h) to let this still work
    on kernels that didn't change the argument.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

In file included from /home/mike/linux-backport/compat/compat-3.8.c:18:
/home/mike/linux-backport/backport-include/linux/netdevice.h:341: error:
implicit declaration of function 'netdev_upper_dev_link'

/home/mike/linux-backport/backport-include/linux/netdevice.h: In function
'_bp_netdev_upper_dev_

+#if LINUX_VERSION_IS_LESS(4,14,0)
+static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
+                                           struct net_device *upper_dev)
+{
+       return netdev_upper_dev_link(dev, upper_dev);
+}
+#define netdev_upper_dev_link3(dev, upper, extack) \
+       netdev_upper_dev_link(dev, upper)
+#define netdev_upper_dev_link2(dev, upper) \
+       netdev_upper_dev_link(dev, upper)
+#define netdev_upper_dev_link(...) \
+       macro_dispatcher(netdev_upper_dev_link, __VA_ARGS__)(__VA_ARGS__)
+#endif
+

I tried building against various kernels and didn't find
netdev_upper_dev_link' defined until 3, so anything less that that probably
has this error.  I didn't know exactly what to use here so I just did an
#if 0 around that section and resolved the problem for me.


The second problem is in commit 2ebca7b7d087be04e25b1fc50cf08137d423af3d.

Author: Luca Coelho <luciano.coelho@intel.com>
Date:   Tue Apr 19 22:13:11 2016 +0300

    backport: add pm_runtime_active() implementation for < 3.9 kernels

    The pm_runtime_active() helper function was introduced in kernel 3.9.
    In order to use it in earlier kernels, we need to add its
    implementation to the backports.

    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
    [add LINUX_BACKPORT() protection]
    Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

diff --git a/backport/backport-include/linux/pm_runtime.h
b/backport/backport-include/linu
new file mode 100644
index 0000000..16d2a80
--- /dev/null
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_PM_RUNTIME_H
+#define __BACKPORT_PM_RUNTIME_H
+#include_next <linux/pm_runtime.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define pm_runtime_active LINUX_BACKPORT(pm_runtime_active)
+#ifdef CONFIG_PM
+static inline bool pm_runtime_active(struct device *dev)
+{
+       return dev->power.runtime_status == RPM_ACTIVE
+               || dev->power.disable_depth;
+}
+#else
+static inline bool pm_runtime_active(struct device *dev) { return true; }
+#endif /* CONFIG_PM */
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
+#endif /* __BACKPORT_PM_RUNTIME_H */


/home/mike/linux-backport/backport-include/linux/pm_runtime.h: In function
'backport_pm_runtime_active':
/home/mike/linux-backport/backport-include/linux/pm_runtime.h:10: error:
'struct dev_pm_info' has no member named 'runtime_status'
/home/mike/linux-backport/backport-include/linux/pm_runtime.h:11: error:
'struct dev_pm_info' has no member named 'disable_depth'
make[6]: *** [/home/mike/linux-backport/compat/backport-4.8.o] Error 1

In linux/pm.h, those members addition to the struct are controlled by
CONFIG_PM_RUNTIME, not CONFIG_PM. I changed pm_runtime.h to
use CONFIG_PM_RUNTIME and that resolved the problem.

Thanks for this amazing product,
Mike McElroy
--
To unsubscribe from this list: send the line "unsubscribe backports" in
