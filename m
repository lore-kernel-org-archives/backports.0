Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64129 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3EPFsg (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 01:48:36 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj3so2191110pad.15
        for <backports@vger.kernel.org>; Wed, 15 May 2013 22:48:35 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: revert remove_proc_subtree() for backport
Date: Wed, 15 May 2013 22:48:24 -0700
Message-Id: <1368683306-21463-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_074837_821663_440D7856)
In-Reply-To: <1368683306-21463-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368683306-21463-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Intorduced in next-20130429 and Linus has merged it
onto v3.10-rc1. We cannot backport remove_proc_subtree()
modularly [0] so just go ahead and revert this change.

The alternative is to go and review each procfs usage
for each driver we have issues and see if it makes
sense to replace procs with debugfs upstream.

commit 8ce584c7416d8a85a6f3edc17d1cddefe331e87e
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Mar 30 20:13:46 2013 -0400

    procfs: add proc_remove_subtree()

    just what it sounds like; do that only to procfs subtrees you've
    created - doing that to something shared with another driver is
    not only antisocial, but might cause interesting races with
    proc_create() and its ilk.

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[0] http://marc.info/?t=136841961600002&r=1&w=2

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drm/12-revert-remove_proc_subtree/INFO         |   25 ++++++++
 .../drivers_gpu_drm_drm_proc.patch                 |   64 ++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch

diff --git a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
new file mode 100644
index 0000000..8dbcf8a
--- /dev/null
+++ b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
@@ -0,0 +1,25 @@
+We cannot backport remove_proc_subtree() modularly so the
+only thing we can do is revert its usage. This patch reverts
+all of its usage and the commits that added them are listed
+below.
+
+Another thing we could do is look at each driver's usage of
+proc and see if its reasonable to instead covert it to use
+debugfs. This needs to be dealt with on a case by case basis.
+
+From 8bc742e13fb2c9cd64988816749295e9ddf53101 Mon Sep 17 00:00:00 2001
+From: David Howells <dhowells@redhat.com>
+Date: Fri, 12 Apr 2013 16:15:07 +0100
+Subject: [PATCH] drm: proc: Use remove_proc_subtree()
+
+Use remove_proc_subtree() rather than remove_proc_entry() to remove a
+minor-specific drm proc directory and all its children.
+
+Things could theoretically be improved by storing the drm_minor pointer in the
+minor-specific dir proc_dir_entry struct data and then scrapping the list of
+proc files - but that's shared with the debugfs interface where you can't do
+that, so I don't see an easy way of doing it.
+
+Signed-off-by: David Howells <dhowells@redhat.com>
+cc: dri-devel@lists.freedesktop.org
+Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
diff --git a/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
new file mode 100644
index 0000000..bd9652d
--- /dev/null
+++ b/patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch
@@ -0,0 +1,64 @@
+diff --git a/drivers/gpu/drm/drm_proc.c b/drivers/gpu/drm/drm_proc.c
+index d7f2324..0646a46 100644
+--- a/drivers/gpu/drm/drm_proc.c
++++ b/drivers/gpu/drm/drm_proc.c
+@@ -95,7 +95,7 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+ 	struct drm_device *dev = minor->dev;
+ 	struct proc_dir_entry *ent;
+ 	struct drm_info_node *tmp;
+-	int i;
++	int i, ret;
+ 
+ 	for (i = 0; i < count; i++) {
+ 		u32 features = files[i].driver_features;
+@@ -105,9 +105,10 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+ 			continue;
+ 
+ 		tmp = kmalloc(sizeof(struct drm_info_node), GFP_KERNEL);
+-		if (!tmp)
+-			return -1;
+-
++		if (tmp == NULL) {
++			ret = -1;
++			goto fail;
++		}
+ 		tmp->minor = minor;
+ 		tmp->info_ent = &files[i];
+ 		list_add(&tmp->list, &minor->proc_nodes.list);
+@@ -119,10 +120,16 @@ static int drm_proc_create_files(const struct drm_info_list *files, int count,
+ 				  minor->index, files[i].name);
+ 			list_del(&tmp->list);
+ 			kfree(tmp);
+-			return -1;
++			ret = -1;
++			goto fail;
+ 		}
+ 	}
+ 	return 0;
++
++fail:
++	for (i = 0; i < count; i++)
++		remove_proc_entry(drm_proc_list[i].name, minor->proc_root);
++	return ret;
+ }
+ 
+ /**
+@@ -153,7 +160,7 @@ int drm_proc_init(struct drm_minor *minor, struct proc_dir_entry *root)
+ 	ret = drm_proc_create_files(drm_proc_list, DRM_PROC_ENTRIES,
+ 				    minor->proc_root, minor);
+ 	if (ret) {
+-		remove_proc_subtree(name, root);
++		remove_proc_entry(name, root);
+ 		minor->proc_root = NULL;
+ 		DRM_ERROR("Failed to create core drm proc files\n");
+ 		return ret;
+@@ -203,7 +210,8 @@ int drm_proc_cleanup(struct drm_minor *minor, struct proc_dir_entry *root)
+ 	drm_proc_remove_files(drm_proc_list, DRM_PROC_ENTRIES, minor);
+ 
+ 	sprintf(name, "%d", minor->index);
+-	remove_proc_subtree(name, root);
++	remove_proc_entry(name, root);
++
+ 	return 0;
+ }
+ 
-- 
1.7.10.4

