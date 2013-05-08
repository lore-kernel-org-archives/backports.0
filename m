Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54991 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3EHABU (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 20:01:20 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so793044pdj.27
        for <backports@vger.kernel.org>; Tue, 07 May 2013 17:01:20 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] backports: add pm patch for rtl8188ee
Date: Tue,  7 May 2013 17:01:09 -0700
Message-Id: <1367971269-25440-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130508_020122_199655_84C24B54)
In-Reply-To: <1367971269-25440-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367971269-25440-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Some day we will use SmPL for this...

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  FAIL  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m33.959s
user    809m11.262s
sys     126m15.477s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 ...drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
new file mode 100644
index 0000000..c377e12
--- /dev/null
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
@@ -0,0 +1,25 @@
+--- a/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
++++ b/drivers/net/wireless/rtlwifi/rtl8188ee/sw.c
+@@ -387,6 +387,9 @@ MODULE_PARM_DESC(swlps, "Set to 1 to use
+ MODULE_PARM_DESC(fwlps, "Set to 1 to use FW control power save (default 1)\n");
+ MODULE_PARM_DESC(debug, "Set debug level (0-5) (default 0)");
+ 
++compat_pci_suspend(rtl_pci_suspend);
++compat_pci_resume(rtl_pci_resume);
++
+ static SIMPLE_DEV_PM_OPS(rtlwifi_pm_ops, rtl_pci_suspend, rtl_pci_resume);
+ 
+ static struct pci_driver rtl88ee_driver = {
+@@ -394,7 +397,12 @@ static struct pci_driver rtl88ee_driver
+ 	.id_table = rtl88ee_pci_ids,
+ 	.probe = rtl_pci_probe,
+ 	.remove = rtl_pci_disconnect,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
+ 	.driver.pm = &rtlwifi_pm_ops,
++#elif defined(CONFIG_PM_SLEEP)
++	.suspend = rtl_pci_suspend,
++	.resume = rtl_pci_resume,
++#endif
+ };
+ 
+ module_pci_driver(rtl88ee_driver);
-- 
1.7.10.4

