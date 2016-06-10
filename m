Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:56666 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751440AbcFJQ7d (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 Jun 2016 12:59:33 -0400
Received: from [192.40.95.7] (helo=dubbel.ger.corp.intel.com)
	by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.87)
	(envelope-from <luca@coelho.fi>)
	id 1bBPUU-0004sB-8I
	for backports@vger.kernel.org; Fri, 10 Jun 2016 19:41:03 +0300
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Date: Fri, 10 Jun 2016 19:40:58 +0300
Message-Id: <1465576858-1524-1-git-send-email-luca@coelho.fi> (sfid-20160610_185935_647479_5298058E)
Subject: [PATCH] backport: define nla_put_u64_64bit() for < 4.7 kernels
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The nla_put_u64_64_bit() function was introduced in v4.7.  Define it
in netlink.h if the kernel is < 4.7.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/net/netlink.h | 68 +++++++++++++++++++++++++++++
 backport/compat/backport-4.6.c          | 77 +++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 40160b5..1bc6e0e 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -189,4 +189,72 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
 }
 #endif /* < 4.4 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
+
+int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
+		  const void *data, int padattr);
+
+static inline int nla_put_u64_64bit(struct sk_buff *skb, int attrtype,
+				    u64 value, int padattr)
+{
+	return nla_put_64bit(skb, attrtype, sizeof(u64), &value, padattr);
+}
+
+/**
+ * nla_need_padding_for_64bit - test 64-bit alignment of the next attribute
+ * @skb: socket buffer the message is stored in
+ *
+ * Return true if padding is needed to align the next attribute (nla_data()) to
+ * a 64-bit aligned area.
+ */
+static inline bool nla_need_padding_for_64bit(struct sk_buff *skb)
+{
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	/* The nlattr header is 4 bytes in size, that's why we test
+	 * if the skb->data _is_ aligned.  A NOP attribute, plus
+	 * nlattr header for next attribute, will make nla_data()
+	 * 8-byte aligned.
+	 */
+	if (IS_ALIGNED((unsigned long)skb_tail_pointer(skb), 8))
+		return true;
+#endif
+	return false;
+}
+
+/**
+ * nla_align_64bit - 64-bit align the nla_data() of next attribute
+ * @skb: socket buffer the message is stored in
+ * @padattr: attribute type for the padding
+ *
+ * Conditionally emit a padding netlink attribute in order to make
+ * the next attribute we emit have a 64-bit aligned nla_data() area.
+ * This will only be done in architectures which do not have
+ * CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS defined.
+ *
+ * Returns zero on success or a negative error code.
+ */
+static inline int nla_align_64bit(struct sk_buff *skb, int padattr)
+{
+	if (nla_need_padding_for_64bit(skb) &&
+	    !nla_reserve(skb, padattr, 0))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+/**
+ * nla_total_size_64bit - total length of attribute including padding
+ * @payload: length of payload
+ */
+static inline int nla_total_size_64bit(int payload)
+{
+	return NLA_ALIGN(nla_attr_size(payload))
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+		+ NLA_ALIGN(nla_attr_size(0))
+#endif
+		;
+}
+
+#endif /* < 4.7 */
+
 #endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/backport/compat/backport-4.6.c b/backport/compat/backport-4.6.c
index 54ff669..9572524 100644
--- a/backport/compat/backport-4.6.c
+++ b/backport/compat/backport-4.6.c
@@ -12,6 +12,13 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <net/netlink.h>
+
 /**
  * kstrtobool - convert common user inputs into boolean values
  * @s: input string
@@ -75,3 +82,73 @@ int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
 	return kstrtobool(buf, res);
 }
 EXPORT_SYMBOL_GPL(kstrtobool_from_user);
+
+/**
+ * __nla_reserve_64bit - reserve room for attribute on the skb and align it
+ * @skb: socket buffer to reserve room on
+ * @attrtype: attribute type
+ * @attrlen: length of attribute payload
+ * @padattr: attribute type for the padding
+ *
+ * Adds a netlink attribute header to a socket buffer and reserves
+ * room for the payload but does not copy it. It also ensure that this
+ * attribute will have a 64-bit aligned nla_data() area.
+ *
+ * The caller is responsible to ensure that the skb provides enough
+ * tailroom for the attribute header and payload.
+ */
+struct nlattr *__nla_reserve_64bit(struct sk_buff *skb, int attrtype,
+				   int attrlen, int padattr)
+{
+	if (nla_need_padding_for_64bit(skb))
+		nla_align_64bit(skb, padattr);
+
+	return __nla_reserve(skb, attrtype, attrlen);
+}
+
+/**
+ * __nla_put_64bit - Add a netlink attribute to a socket buffer and align it
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @attrlen: length of attribute payload
+ * @data: head of attribute payload
+ *
+ * The caller is responsible to ensure that the skb provides enough
+ * tailroom for the attribute header and payload.
+ */
+void __nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
+		     const void *data, int padattr)
+{
+	struct nlattr *nla;
+
+	nla = __nla_reserve_64bit(skb, attrtype, attrlen, padattr);
+	memcpy(nla_data(nla), data, attrlen);
+}
+EXPORT_SYMBOL(__nla_put_64bit);
+
+/**
+ * nla_put_64bit - Add a netlink attribute to a socket buffer and align it
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @attrlen: length of attribute payload
+ * @data: head of attribute payload
+ *
+ * Returns -EMSGSIZE if the tailroom of the skb is insufficient to store
+ * the attribute header and payload.
+ */
+int nla_put_64bit(struct sk_buff *skb, int attrtype, int attrlen,
+		  const void *data, int padattr)
+{
+	size_t len;
+
+	if (nla_need_padding_for_64bit(skb))
+		len = nla_total_size_64bit(attrlen);
+	else
+		len = nla_total_size(attrlen);
+	if (unlikely(skb_tailroom(skb) < len))
+		return -EMSGSIZE;
+
+	__nla_put_64bit(skb, attrtype, attrlen, data, padattr);
+	return 0;
+}
+EXPORT_SYMBOL(nla_put_64bit);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
