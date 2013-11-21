Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:51338 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab3KUTva (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 21 Nov 2013 14:51:30 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: support new generic netlink APIs
Date: Thu, 21 Nov 2013 20:51:23 +0100
Message-Id: <1385063483-29198-1-git-send-email-johannes@sipsolutions.net> (sfid-20131121_205133_037126_3ED085D4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

I recently changed the generic netlink registration and multicast
group APIs to be safer. Backport these changes by implementing all
the new APIs in terms of what was in the kernel before.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Apply this patch once the base kernel gets the netlink changes, obviously :)
---
 backport/backport-include/net/genetlink.h          | 192 ++++++++++++++++-----
 backport/compat/backport-3.13.c                    | 140 ++++++++++++++-
 backport/compat/compat-2.6.37.c                    | 115 ------------
 .../network/81-genl-const/INFO                     |   3 +
 .../network/81-genl-const/hwsim.patch              |  11 ++
 .../network/81-genl-const/ieee802154.patch         |  20 +++
 .../network/81-genl-const/nfc.patch                |  20 +++
 .../network/81-genl-const/nl80211.patch            |  50 ++++++
 8 files changed, 394 insertions(+), 157 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/81-genl-const/INFO
 create mode 100644 patches/collateral-evolutions/network/81-genl-const/hwsim.patch
 create mode 100644 patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
 create mode 100644 patches/collateral-evolutions/network/81-genl-const/nfc.patch
 create mode 100644 patches/collateral-evolutions/network/81-genl-const/nl80211.patch

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 4458a10..d1ae143 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -13,12 +13,8 @@
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
-#define genl_dump_check_consistent(cb, user_hdr, family)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-struct compat_genl_info {
+struct backport_genl_info {
 	struct genl_info *info;
 
 	u32 snd_seq;
@@ -27,9 +23,13 @@ struct compat_genl_info {
 	struct nlattr **attrs;
 	void *user_ptr[2];
 };
-#define genl_info compat_genl_info
+#define genl_info LINUX_BACKPORT(genl_info)
 
-struct compat_genl_ops {
+/* if info gets overridden, so will family below */
+#define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
+	genlmsg_put_reply(_skb, (_info)->info, &(_fam)->family, _flags, _cmd)
+
+struct backport_genl_ops {
 	struct genl_ops ops;
 
 	u8 cmd;
@@ -41,16 +41,50 @@ struct compat_genl_ops {
 	int (*dumpit)(struct sk_buff *skb, struct netlink_callback *cb);
 	int (*done)(struct netlink_callback *cb);
 };
-#define genl_ops compat_genl_ops
+#define genl_ops LINUX_BACKPORT(genl_ops)
+
+#define genlmsg_reply(_msg, _info) genlmsg_reply(_msg, (_info)->info)
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
+#define genl_info_net(_info) genl_info_net((_info)->info)
+#endif
+#endif /* 2.6.37 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+/*
+ * struct genl_multicast_group was made netns aware through
+ * patch "genetlink: make netns aware" by johannes, we just
+ * force this to always use the default init_net
+ */
+#define genl_info_net(x) &init_net
+/* Just use init_net for older kernels */
+#define get_net_ns_by_pid(x) &init_net
+/* net namespace is lost */
+#define genlmsg_unicast(net, skb, pid) genlmsg_unicast(skb, pid)
+#endif
 
-struct compat_genl_family {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define genl_dump_check_consistent(cb, user_hdr, family)
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+static inline int __real_genl_register_family(struct genl_family *family)
+{
+	return genl_register_family(family);
+}
+
+/* Needed for the mcgrps pointer */
+struct backport_genl_family {
 	struct genl_family family;
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
 	struct list_head list;
+#endif
 
 	unsigned int id, hdrsize, version, maxattr;
-	const char *name;
+	char name[GENL_NAMSIZ];
 	bool netnsok;
+	bool parallel_ops;
 
 	struct nlattr **attrbuf;
 
@@ -59,43 +93,119 @@ struct compat_genl_family {
 
 	void (*post_doit)(struct genl_ops *ops, struct sk_buff *skb,
 			  struct genl_info *info);
-};
-
-#define genl_family compat_genl_family
-
-#define genl_register_family_with_ops compat_genl_register_family_with_ops
-
-int genl_register_family_with_ops(struct genl_family *family,
-				  struct genl_ops *ops, size_t n_ops);
 
-#define genl_unregister_family compat_genl_unregister_family
+	struct genl_multicast_group *mcgrps;
+	struct genl_ops *ops;
+	unsigned int n_mcgrps, n_ops;
 
+	struct module *module;
+};
+#define genl_family LINUX_BACKPORT(genl_family)
+
+int __backport_genl_register_family(struct genl_family *family);
+
+#define genl_register_family LINUX_BACKPORT(genl_register_family)
+static inline int
+genl_register_family(struct genl_family *family)
+{
+	family->module = THIS_MODULE;
+	return __backport_genl_register_family(family);
+}
+
+#define _genl_register_family_with_ops_grps \
+	_backport_genl_register_family_with_ops_grps
+static inline int
+_genl_register_family_with_ops_grps(struct genl_family *family,
+				    struct genl_ops *ops, size_t n_ops,
+				    struct genl_multicast_group *mcgrps,
+				    size_t n_mcgrps)
+{
+	family->ops = ops;
+	family->n_ops = n_ops;
+	family->mcgrps = mcgrps;
+	family->n_mcgrps = n_mcgrps;
+	return genl_register_family(family);
+}
+
+#define genl_register_family_with_ops(family, ops)			\
+	_genl_register_family_with_ops_grps((family),			\
+					    (ops), ARRAY_SIZE(ops),	\
+					    NULL, 0)
+#define genl_register_family_with_ops_groups(family, ops, grps)		\
+	_genl_register_family_with_ops_grps((family),			\
+					    (ops), ARRAY_SIZE(ops),	\
+					    (grps), ARRAY_SIZE(grps))
+
+#define genl_unregister_family backport_genl_unregister_family
 int genl_unregister_family(struct genl_family *family);
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#define genl_info_net(_info) genl_info_net((_info)->info)
+#define genl_notify(_fam, _skb, _net, _portid, _group, _nlh, _flags)	\
+	genl_notify(_skb, _net, _portid, (_fam)->mcgrps[_group].id,	\
+		    _nlh, _flags)
+#define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd)		\
+	genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
+#define genlmsg_nlhdr(_hdr, _fam)					\
+	genlmsg_nlhdr(_hdr, &(_fam)->family)
+#ifndef genl_dump_check_consistent
+#define genl_dump_check_consistent(_cb, _hdr, _fam)			\
+	genl_dump_check_consistent(_cb, _hdr, &(_fam)->family)
 #endif
-
-#define genlmsg_reply(_msg, _info) genlmsg_reply(_msg, (_info)->info)
-#define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd) genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
-#define genl_register_mc_group(_fam, _grp) genl_register_mc_group(&(_fam)->family, _grp)
-#define genl_unregister_mc_group(_fam, _grp) genl_unregister_mc_group(&(_fam)->family, _grp)
-#endif /* < 2.6.37 */
-
+#ifndef genlmsg_put_reply /* might already be there from _info override above */
+#define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
+	genlmsg_put_reply(_skb, _info, &(_fam)->family, _flags, _cmd)
+#endif
+#define genlmsg_multicast_netns LINUX_BACKPORT(genlmsg_multicast_netns)
+static inline int genlmsg_multicast_netns(struct genl_family *family,
+					  struct net *net, struct sk_buff *skb,
+					  u32 portid, unsigned int group,
+					  gfp_t flags)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return -EINVAL;
+	group = family->mcgrps[group].id;
+	return nlmsg_multicast(
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-/*
- * struct genl_multicast_group was made netns aware through
- * patch "genetlink: make netns aware" by johannes, we just
- * force this to always use the default init_net
- */
-#define genl_info_net(x) &init_net
-/* Just use init_net for older kernels */
-#define get_net_ns_by_pid(x) &init_net
-
-/* net namespace is lost */
-#define genlmsg_multicast_netns(a, b, c, d, e)	genlmsg_multicast(b, c, d, e)
-#define genlmsg_multicast_allns(a, b, c, d)	genlmsg_multicast(a, b, c, d)
-#define genlmsg_unicast(net, skb, pid)	genlmsg_unicast(skb, pid)
+		genl_sock,
+#else
+		net->genl_sock,
 #endif
+		skb, portid, group, flags);
+}
+#define genlmsg_multicast LINUX_BACKPORT(genlmsg_multicast)
+static inline int genlmsg_multicast(struct genl_family *family,
+				    struct sk_buff *skb, u32 portid,
+				    unsigned int group, gfp_t flags)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return -EINVAL;
+	group = family->mcgrps[group].id;
+	return nlmsg_multicast(
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+		genl_sock,
+#else
+		init_net.genl_sock,
+#endif
+		skb, portid, group, flags);
+}
+static inline int
+backport_genlmsg_multicast_allns(struct genl_family *family,
+				 struct sk_buff *skb, u32 portid,
+				 unsigned int group, gfp_t flags)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return -EINVAL;
+	group = family->mcgrps[group].id;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
+	return nlmsg_multicast(genl_sock, skb, portid, group, flags);
+#else
+	return genlmsg_multicast_allns(skb, portid, group, flags);
+#endif
+}
+#define genlmsg_multicast_allns LINUX_BACKPORT(genlmsg_multicast_allns)
+
+#define __genl_const
+#else /* < 3.13 */
+#define __genl_const const
+#endif /* < 3.13 */
 
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 91fb480..77eefef 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -8,10 +8,11 @@
  * published by the Free Software Foundation.
  */
 #include <linux/version.h>
+#include <linux/kernel.h>
+#include <net/genetlink.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 #ifdef CONFIG_REGULATOR
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/driver.h>
 #include <linux/device.h>
@@ -83,3 +84,140 @@ void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
 EXPORT_SYMBOL_GPL(devm_regulator_unregister);
 #endif /* CONFIG_REGULATOR */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
+
+/************* generic netlink backport *****************/
+
+#undef genl_register_family
+#undef genl_unregister_family
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#undef genl_info
+static LIST_HEAD(backport_nl_fam);
+
+static struct genl_ops *genl_get_cmd(u8 cmd, struct genl_family *family)
+{
+	struct genl_ops *ops;
+
+	list_for_each_entry(ops, &family->family.ops_list, ops.ops_list)
+		if (ops->cmd == cmd)
+			return ops;
+
+	return NULL;
+}
+
+static int nl_doit_wrapper(struct sk_buff *skb, struct genl_info *info)
+{
+	struct backport_genl_info backport_info;
+	struct genl_family *family;
+	struct genl_ops *ops;
+	int err;
+
+	list_for_each_entry(family, &backport_nl_fam, list) {
+		if (family->id == info->nlhdr->nlmsg_type)
+			goto found;
+	}
+	return -ENOENT;
+
+found:
+	ops = genl_get_cmd(info->genlhdr->cmd, family);
+	if (!ops)
+		return -ENOENT;
+
+	memset(&backport_info.user_ptr, 0, sizeof(backport_info.user_ptr));
+	backport_info.info = info;
+#define __copy(_field) backport_info._field = info->_field
+	__copy(snd_seq);
+	__copy(snd_pid);
+	__copy(genlhdr);
+	__copy(attrs);
+#undef __copy
+	if (family->pre_doit) {
+		err = family->pre_doit(ops, skb, &backport_info);
+		if (err)
+			return err;
+	}
+
+	err = ops->doit(skb, &backport_info);
+
+	if (family->post_doit)
+		family->post_doit(ops, skb, &backport_info);
+
+	return err;
+}
+#endif /* < 2.6.37 */
+
+int __backport_genl_register_family(struct genl_family *family)
+{
+	int i, ret;
+
+#define __copy(_field) family->family._field = family->_field
+	__copy(id);
+	__copy(hdrsize);
+	__copy(version);
+	__copy(maxattr);
+	strncpy(family->family.name, family->name, sizeof(family->family.name));
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32)
+	__copy(netnsok);
+#endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+	__copy(parallel_ops);
+#endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+	__copy(module);
+#endif
+#undef __copy
+
+	ret = genl_register_family(&family->family);
+	if (ret < 0)
+		return ret;
+
+	family->attrbuf = family->family.attrbuf;
+	family->id = family->family.id;
+
+	for (i = 0; i < family->n_ops; i++) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+#define __copy(_field) family->ops[i].ops._field = family->ops[i]._field
+		__copy(cmd);
+		__copy(flags);
+		__copy(policy);
+		__copy(dumpit);
+		__copy(done);
+#undef __copy
+		if (family->ops[i].doit)
+			family->ops[i].ops.doit = nl_doit_wrapper;
+		ret = genl_register_ops(&family->family, &family->ops[i].ops);
+#else
+		ret = genl_register_ops(&family->family, &family->ops[i]);
+#endif
+		if (ret < 0)
+			goto error;
+	}
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+	list_add(&family->list, &backport_nl_fam);
+#endif
+
+	for (i = 0; i < family->n_mcgrps; i++) {
+		ret = genl_register_mc_group(&family->family,
+					     &family->mcgrps[i]);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+ error:
+	backport_genl_unregister_family(family);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__backport_genl_register_family);
+
+int backport_genl_unregister_family(struct genl_family *family)
+{
+	int err;
+	err = genl_unregister_family(&family->family);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+	list_del(&family->list);
+#endif
+	return err;
+}
+EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
index 078912a..8d401e1 100644
--- a/backport/compat/compat-2.6.37.c
+++ b/backport/compat/compat-2.6.37.c
@@ -13,7 +13,6 @@
 #include <net/sock.h>
 #include <linux/nsproxy.h>
 #include <linux/vmalloc.h>
-#include <net/genetlink.h>
 #include <linux/leds.h>
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)
@@ -39,122 +38,8 @@ struct kobj_ns_type_operations net_ns_type_operations = {
 	.initial_ns = net_initial_ns,
 };
 EXPORT_SYMBOL_GPL(net_ns_type_operations);
-
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)*/ 
 
-#undef genl_info
-#undef genl_unregister_family
-
-static LIST_HEAD(compat_nl_fam);
-
-static struct genl_ops *genl_get_cmd(u8 cmd, struct genl_family *family)
-{
-	struct genl_ops *ops;
-
-	list_for_each_entry(ops, &family->family.ops_list, ops.ops_list)
-		if (ops->cmd == cmd)
-			return ops;
-
-	return NULL;
-}
-
-
-static int nl_doit_wrapper(struct sk_buff *skb, struct genl_info *info)
-{
-	struct compat_genl_info compat_info;
-	struct genl_family *family;
-	struct genl_ops *ops;
-	int err;
-
-	list_for_each_entry(family, &compat_nl_fam, list) {
-		if (family->id == info->nlhdr->nlmsg_type)
-			goto found;
-	}
-	return -ENOENT;
-
-found:
-	ops = genl_get_cmd(info->genlhdr->cmd, family);
-	if (!ops)
-		return -ENOENT;
-
-	memset(&compat_info.user_ptr, 0, sizeof(compat_info.user_ptr));
-	compat_info.info = info;
-#define __copy(_field) compat_info._field = info->_field
-	__copy(snd_seq);
-	__copy(snd_pid);
-	__copy(genlhdr);
-	__copy(attrs);
-#undef __copy
-	if (family->pre_doit) {
-		err = family->pre_doit(ops, skb, &compat_info);
-		if (err)
-			return err;
-	}
-
-	err = ops->doit(skb, &compat_info);
-
-	if (family->post_doit)
-		family->post_doit(ops, skb, &compat_info);
-
-	return err;
-}
-
-int compat_genl_register_family_with_ops(struct genl_family *family,
-					 struct genl_ops *ops, size_t n_ops)
-{
-	int i, ret;
-
-#define __copy(_field) family->family._field = family->_field
-	__copy(id);
-	__copy(hdrsize);
-	__copy(version);
-	__copy(maxattr);
-	strncpy(family->family.name, family->name, sizeof(family->family.name));
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-	__copy(netnsok);
-#endif
-#undef __copy
-
-	ret = genl_register_family(&family->family);
-	if (ret < 0)
-		return ret;
-
-	family->attrbuf = family->family.attrbuf;
-	family->id = family->family.id;
-
-	for (i = 0; i < n_ops; i++) {
-#define __copy(_field) ops[i].ops._field = ops[i]._field
-		__copy(cmd);
-		__copy(flags);
-		__copy(policy);
-		__copy(dumpit);
-		__copy(done);
-#undef __copy
-		if (ops[i].doit)
-			ops[i].ops.doit = nl_doit_wrapper;
-		ret = genl_register_ops(&family->family, &ops[i].ops);
-		if (ret < 0)
-			goto error_ops;
-	}
-	list_add(&family->list, &compat_nl_fam);
-
-	return ret;
-
-error_ops:
-	compat_genl_unregister_family(family);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(compat_genl_register_family_with_ops);
-
-int compat_genl_unregister_family(struct genl_family *family)
-{
-	int err;
-	err = genl_unregister_family(&family->family);
-	list_del(&family->list);
-	return err;
-}
-EXPORT_SYMBOL_GPL(compat_genl_unregister_family);
-
 #if IS_ENABLED(CONFIG_LEDS_CLASS) && !defined(CPTCFG_BACKPORT_BUILD_LEDS)
 
 #undef led_brightness_set
diff --git a/patches/collateral-evolutions/network/81-genl-const/INFO b/patches/collateral-evolutions/network/81-genl-const/INFO
new file mode 100644
index 0000000..242f9f8
--- /dev/null
+++ b/patches/collateral-evolutions/network/81-genl-const/INFO
@@ -0,0 +1,3 @@
+Newer kernels make generic netlink ops and multicast groups
+const, but older can't have that. We therefore introduce
+__genl_const, which can be defined depending on the kernel.
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
new file mode 100644
index 0000000..de938ed
--- /dev/null
+++ b/patches/collateral-evolutions/network/81-genl-const/hwsim.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/mac80211_hwsim.c
++++ b/drivers/net/wireless/mac80211_hwsim.c
+@@ -2098,7 +2098,7 @@ out:
+ }
+ 
+ /* Generic Netlink operations array */
+-static const struct genl_ops hwsim_ops[] = {
++static __genl_const struct genl_ops hwsim_ops[] = {
+ 	{
+ 		.cmd = HWSIM_CMD_REGISTER,
+ 		.policy = hwsim_genl_policy,
diff --git a/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
new file mode 100644
index 0000000..6efcd60
--- /dev/null
+++ b/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
@@ -0,0 +1,20 @@
+--- a/net/ieee802154/netlink.c
++++ b/net/ieee802154/netlink.c
+@@ -109,7 +109,7 @@ out:
+ 	return -ENOBUFS;
+ }
+ 
+-static const struct genl_ops ieee8021154_ops[] = {
++static __genl_const struct genl_ops ieee8021154_ops[] = {
+ 	/* see nl-phy.c */
+ 	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
+ 			ieee802154_dump_phy),
+@@ -125,7 +125,7 @@ static const struct genl_ops ieee8021154_ops[] = {
+ 			ieee802154_dump_iface),
+ };
+ 
+-static const struct genl_multicast_group ieee802154_mcgrps[] = {
++static __genl_const struct genl_multicast_group ieee802154_mcgrps[] = {
+ 	[IEEE802154_COORD_MCGRP] = { .name = IEEE802154_MCAST_COORD_NAME, },
+ 	[IEEE802154_BEACON_MCGRP] = { .name = IEEE802154_MCAST_BEACON_NAME, },
+ };
diff --git a/patches/collateral-evolutions/network/81-genl-const/nfc.patch b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
new file mode 100644
index 0000000..d39f892
--- /dev/null
+++ b/patches/collateral-evolutions/network/81-genl-const/nfc.patch
@@ -0,0 +1,20 @@
+--- a/net/nfc/netlink.c
++++ b/net/nfc/netlink.c
+@@ -30,7 +30,7 @@
+ #include "nfc.h"
+ #include "llcp.h"
+ 
+-static const struct genl_multicast_group nfc_genl_mcgrps[] = {
++static __genl_const struct genl_multicast_group nfc_genl_mcgrps[] = {
+ 	{ .name = NFC_GENL_MCAST_EVENT_NAME, },
+ };
+ 
+@@ -1365,7 +1365,7 @@ static int nfc_genl_se_io(struct sk_buff *skb, struct genl_info *info)
+ 	return dev->ops->se_io(dev, se_idx, apdu, apdu_len, se_io_cb, ctx);
+ }
+ 
+-static const struct genl_ops nfc_genl_ops[] = {
++static __genl_const struct genl_ops nfc_genl_ops[] = {
+ 	{
+ 		.cmd = NFC_CMD_GET_DEVICE,
+ 		.doit = nfc_genl_get_device,
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
new file mode 100644
index 0000000..2dfbad0
--- /dev/null
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -0,0 +1,50 @@
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -30,9 +30,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
+ 				   struct cfg80211_crypto_settings *settings,
+ 				   int cipher_limit);
+ 
+-static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
++static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
+ 			    struct genl_info *info);
+-static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
++static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
+ 			      struct genl_info *info);
+ 
+ /* the netlink family */
+@@ -56,7 +56,7 @@ enum nl80211_multicast_groups {
+ 	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
+ };
+ 
+-static const struct genl_multicast_group nl80211_mcgrps[] = {
++static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
+ 	[NL80211_MCGRP_CONFIG] = { .name = "config", },
+ 	[NL80211_MCGRP_SCAN] = { .name = "scan", },
+ 	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
+@@ -8871,7 +8871,7 @@ static int nl80211_crit_protocol_stop(struct sk_buff *skb,
+ #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
+ 					 NL80211_FLAG_CHECK_NETDEV_UP)
+ 
+-static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
++static int nl80211_pre_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
+ 			    struct genl_info *info)
+ {
+ 	struct cfg80211_registered_device *rdev;
+@@ -8940,7 +8940,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+ 	return 0;
+ }
+ 
+-static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
++static void nl80211_post_doit(__genl_const struct genl_ops *ops, struct sk_buff *skb,
+ 			      struct genl_info *info)
+ {
+ 	if (info->user_ptr[1]) {
+@@ -8957,7 +8957,7 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+ 		rtnl_unlock();
+ }
+ 
+-static const struct genl_ops nl80211_ops[] = {
++static __genl_const struct genl_ops nl80211_ops[] = {
+ 	{
+ 		.cmd = NL80211_CMD_GET_WIPHY,
+ 		.doit = nl80211_get_wiphy,
-- 
1.8.4.rc3

