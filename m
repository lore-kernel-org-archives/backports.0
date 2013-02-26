Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 5/6] compat-drivers: refresh patches
Date: Tue, 26 Feb 2013 21:46:59 +0100
Message-Id: <1361911620-29333-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
References: <1361911620-29333-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

refreshes patches based on linux 3.7.9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/drm/04-revert-prime-support.patch |    4 ++--
 patches/network/04-netns.patch            |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/drm/04-revert-prime-support.patch b/patches/drm/04-revert-prime-support.patch
index 66f7ec0..7e41388 100644
--- a/patches/drm/04-revert-prime-support.patch
+++ b/patches/drm/04-revert-prime-support.patch
@@ -236,7 +236,7 @@ not < 3.3.0.
  	dev = drm->dev;
 --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
 +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
-@@ -590,7 +590,10 @@ driver = {
+@@ -593,7 +593,10 @@ driver = {
  	.driver_features =
  		DRIVER_USE_AGP | DRIVER_PCI_DMA | DRIVER_SG |
  		DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
@@ -248,7 +248,7 @@ not < 3.3.0.
  
  	.load = nouveau_drm_load,
  	.unload = nouveau_drm_unload,
-@@ -611,10 +614,12 @@ driver = {
+@@ -614,10 +617,12 @@ driver = {
  	.ioctls = nouveau_ioctls,
  	.fops = &nouveau_driver_fops,
  
diff --git a/patches/network/04-netns.patch b/patches/network/04-netns.patch
index 777ced3..38d4249 100644
--- a/patches/network/04-netns.patch
+++ b/patches/network/04-netns.patch
@@ -55,7 +55,7 @@ files...
  
  		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
  				      "phy80211")) {
-@@ -1026,6 +1032,7 @@ static struct notifier_block cfg80211_ne
+@@ -1025,6 +1031,7 @@ static struct notifier_block cfg80211_ne
  	.notifier_call = cfg80211_netdev_notifier_call,
  };
  
@@ -63,7 +63,7 @@ files...
  static void __net_exit cfg80211_pernet_exit(struct net *net)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -1043,14 +1050,17 @@ static void __net_exit cfg80211_pernet_e
+@@ -1042,14 +1049,17 @@ static void __net_exit cfg80211_pernet_e
  static struct pernet_operations cfg80211_pernet_ops = {
  	.exit = cfg80211_pernet_exit,
  };
@@ -81,7 +81,7 @@ files...
  
  	err = wiphy_sysfs_init();
  	if (err)
-@@ -1085,8 +1095,10 @@ out_fail_nl80211:
+@@ -1084,8 +1094,10 @@ out_fail_nl80211:
  out_fail_notifier:
  	wiphy_sysfs_exit();
  out_fail_sysfs:
@@ -92,7 +92,7 @@ files...
  	return err;
  }
  subsys_initcall(cfg80211_init);
-@@ -1098,7 +1110,9 @@ static void __exit cfg80211_exit(void)
+@@ -1097,7 +1109,9 @@ static void __exit cfg80211_exit(void)
  	unregister_netdevice_notifier(&cfg80211_netdev_notifier);
  	wiphy_sysfs_exit();
  	regulatory_exit();
-- 
1.7.10.4
