Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39814 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbdBFMkA (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 07:40:00 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] backports: support class_groups
Date: Mon,  6 Feb 2017 13:39:56 +0100
Message-Id: <20170206123956.20082-3-johannes@sipsolutions.net> (sfid-20170206_134002_277997_E7F9D5B6)
In-Reply-To: <20170206123956.20082-1-johannes@sipsolutions.net>
References: <20170206123956.20082-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Add a new semantic patch just like for dev_groups to
support class_groups.

Change-Id: I114e1a6ed8db901b3aa738a5052721d1da45cae4
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../0001-group-attr/0003-class_groups.cocci        | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci

diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci
new file mode 100644
index 000000000000..a4694dd75763
--- /dev/null
+++ b/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci
@@ -0,0 +1,54 @@
+/* see upstream commit ced6473e74867 */
+
+@ attribute_group @
+identifier group;
+declarer name ATTRIBUTE_GROUPS;
+@@
+
+ATTRIBUTE_GROUPS(group);
+
+@script:python attribute_groups_name@
+group << attribute_group.group;
+groups;
+@@
+coccinelle.groups = group + "_groups"
+
+@ class_group @
+identifier group_class;
+identifier attribute_groups_name.groups;
+fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
+@@
+
+struct class group_class = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
+	.class_groups = groups,
++#else
++	.class_attrs = group_dev_attr,
++#endif
+};
+
+@ attribute_group_mod depends on class_group @
+declarer name ATTRIBUTE_GROUPS_BACKPORT;
+identifier attribute_group.group;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
+ATTRIBUTE_GROUPS(group);
++#else
++#define BP_ATTR_GRP_STRUCT class_attribute
++ATTRIBUTE_GROUPS_BACKPORT(group);
++#endif
+
+@ class_registering @
+identifier class_register, ret;
+identifier class_group.group_class;
+fresh identifier group_class_init = "init_" ## attribute_group.group ## "_attrs";
+@@
+
+(
++	group_class_init();
+	return class_register(&group_class);
+|
++	group_class_init();
+	ret = class_register(&group_class);
+)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
