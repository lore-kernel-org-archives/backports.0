Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/24] compat-drivers: use backport for second workqueue
Date: Tue, 26 Feb 2013 21:37:59 +0100
Message-Id: <1361911096-29117-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

bluetooth hci_core uses a second workqueue.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/46-use_other_workqueue.patch                 |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue.patch b/patches/collateral-evolutions/network/46-use_other_workqueue.patch
index 765fc4e..b342ddd 100644
--- a/patches/collateral-evolutions/network/46-use_other_workqueue.patch
+++ b/patches/collateral-evolutions/network/46-use_other_workqueue.patch
@@ -4,7 +4,7 @@ position before.
 
 --- a/net/bluetooth/hci_core.c
 +++ b/net/bluetooth/hci_core.c
-@@ -1793,8 +1793,12 @@ int hci_register_dev(struct hci_dev *hde
+@@ -1793,16 +1793,24 @@ int hci_register_dev(struct hci_dev *hde
  	list_add(&hdev->list, &hci_dev_list);
  	write_unlock(&hci_dev_list_lock);
  
@@ -17,3 +17,15 @@ position before.
  	if (!hdev->workqueue) {
  		error = -ENOMEM;
  		goto err;
+ 	}
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
+ 	hdev->req_workqueue = alloc_workqueue(hdev->name,
+ 					      WQ_HIGHPRI | WQ_UNBOUND |
+ 					      WQ_MEM_RECLAIM, 1);
++#else
++	hdev->req_workqueue = create_singlethread_workqueue(hdev->name);
++#endif
+ 	if (!hdev->req_workqueue) {
+ 		destroy_workqueue(hdev->workqueue);
+ 		error = -ENOMEM;
-- 
1.7.10.4
