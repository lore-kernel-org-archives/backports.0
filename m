Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47027 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab3EPWaS (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 18:30:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so224334pde.23
        for <backports@vger.kernel.org>; Thu, 16 May 2013 15:30:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] backports: refresh patches for next-20130429
Date: Thu, 16 May 2013 15:30:04 -0700
Message-Id: <1368743404-30324-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_003020_075743_DDD4C4F6)
In-Reply-To: <1368743404-30324-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368743404-30324-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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
15  2.6.38              [  OK  ]
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

real    30m48.875s
user    815m54.307s
sys     127m12.229s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_drm_proc.patch                           |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
index b250474..6a578e5 100644
--- a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
+++ b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/drm_proc.c
 +++ b/drivers/gpu/drm/drm_proc.c
-@@ -95,7 +95,7 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+@@ -95,7 +95,7 @@ static int drm_proc_create_files(const s
  	struct drm_device *dev = minor->dev;
  	struct proc_dir_entry *ent;
  	struct drm_info_node *tmp;
@@ -9,7 +9,7 @@
  
  	for (i = 0; i < count; i++) {
  		u32 features = files[i].driver_features;
-@@ -105,9 +105,10 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+@@ -105,9 +105,10 @@ static int drm_proc_create_files(const s
  			continue;
  
  		tmp = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
@@ -23,7 +23,7 @@
  		tmp->minor = minor;
  		tmp->info_ent = &files[i];
  		list_add(&tmp->list, &minor->proc_nodes.list);
-@@ -119,10 +120,16 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+@@ -119,10 +120,16 @@ static int drm_proc_create_files(const s
  				  minor->index, files[i].name);
  			list_del(&tmp->list);
  			kfree(tmp);
@@ -41,7 +41,7 @@
  }
  
  /**
-@@ -153,7 +160,7 @@ int drm_proc_init(struct drm_minor *minor, struct proc_dir_entry *root)
+@@ -153,7 +160,7 @@ int drm_proc_init(struct drm_minor *mino
  	ret = drm_proc_create_files(drm_proc_list, DRM_PROC_ENTRIES,
  				    minor->proc_root, minor);
  	if (ret) {
@@ -50,7 +50,7 @@
  		minor->proc_root = NULL;
  		DRM_ERROR("Failed to create core drm proc files\n");
  		return ret;
-@@ -203,7 +210,8 @@ int drm_proc_cleanup(struct drm_minor *minor, struct proc_dir_entry *root)
+@@ -203,7 +210,8 @@ int drm_proc_cleanup(struct drm_minor *m
  	drm_proc_remove_files(drm_proc_list, DRM_PROC_ENTRIES, minor);
  
  	sprintf(name, "%d", minor->index);
-- 
1.7.10.4

