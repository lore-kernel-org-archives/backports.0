Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE712EBC9
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570604; cv=none; b=cBSl/TeMoDyX9cDsYuWLJsVOx4Mgoc5d+ap20ad06HgQBhVqglJAd26NX5IDOA7qrFSfsRakAvFMY/39hzjHO84PTdMwfIO6ndwrRMuoShZHWbILksMwT8Cb6AQGApCijiXxyMsi7vw4DUKF+vPbh4drB2JPdmdWsPOpqlmqXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570604; c=relaxed/simple;
	bh=eNAlsFtBLJN8GIYFIKAlUeJFbibgfaM2jxkwVu9btRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHQOygcWZErPCq+eKIDCNcujg7AzlbPU1Ju/emaEh0oa93AXQS4CeJTJzq9WeOXkqB+wSLJvsx7fM+FT3PYd8g3pFbyol0gJ2IbFH9BAN8MPXU06i8dXXCnWLE6LPssAn9OWXzkruxt9BzbIr1FFaGIEmMflpNWNDuAbWegX038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aHv/1cli; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aHv/1cli"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BvaDh8vgujN2svh5YgrX2cn9r9LXYktqKNnmJQneUZ4=;
	t=1716570603; x=1717780203; b=aHv/1cliCXLrjVkqc3NntpVHjVNZsz64M8fhBKRgrLXtw9t
	BPtZzYHSuPqItBvDeYESbdd3NWFOSeRcR1fUmBAn1dn7nMID9fHxIq7gukVgSTLWT7OawG8UClqHE
	oZs3Laqh3I6xh3EtS/vn/6g8SlFrUC9x7+qm47vxAw3+Gaac+rM6hnOOrM09Qj7hT71GM8j1YuTtv
	kWdAU9/lky5wsV1GgKMqZlqQcBDNOrq6uFr+K4D+agKYXyy0cfWwh8XM2qohiCFtzZPCrtZtdtpY9
	i7HxXQRgoSFgxmAYvEBa8/a+Zdum5eyCKPB31xhuuWvQfOl6wIZt7/ht1FYWNZ8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQZ-00000008Xuw-2jLn;
	Fri, 24 May 2024 19:10:00 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 47/74] backport: implement NLA_POLICY_RANGE for NLA_BINARY
Date: Fri, 24 May 2024 19:07:59 +0200
Message-ID: <20240524190907.84d051bc3c68.Ife595e2dc94955bda3d7d3089ec6a219fde272c1@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Coelho <luciano.coelho@intel.com>

The range checks for NLA_BINARY are supported since v5.10.  Unwrap the
macros and introduce a new function to test type.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h    | 31 +++++++++++++++++++---
 patches/0097-nla_policy_binary_range.cocci |  5 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 patches/0097-nla_policy_binary_range.cocci

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index ad5882347440..7192153b860c 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -346,10 +346,33 @@ enum nla_policy_validation {
 }
 #endif /* < 4.20 */
 
-#ifndef NLA_POLICY_MIN_LEN
-#define NLA_POLICY_MIN_LEN(_len) {		\
-	.type = NLA_BINARY			\
+#if LINUX_VERSION_IS_LESS(5,10,0)
+// pre-declare all the minimum lengths in use
+#define MIN_LEN_VALIDATION(n)						\
+static inline								\
+int nla_validate_min_len_##n(const struct nlattr *attr,			\
+			     struct netlink_ext_ack *extack)		\
+{									\
+	if (nla_len(attr) < n)						\
+		return -EINVAL;						\
+	return 0;							\
 }
-#endif
+
+MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(16)
+MIN_LEN_VALIDATION(42)
+
+// double-expansion to expand _min to the actual value
+#define NLA_POLICY_BINARY_RANGE(_min, _max) _NLA_POLICY_BINARY_RANGE(_min, _max)
+#define _NLA_POLICY_BINARY_RANGE(_min, _max)		\
+{							\
+	.type = NLA_BINARY,				\
+	.len = _max,					\
+	.validation_type = NLA_VALIDATE_FUNCTION,	\
+	.validate = nla_validate_min_len_ ## _min,	\
+}
+#else
+#define NLA_POLICY_BINARY_RANGE(_min, _max) NLA_POLICY_RANGE(NLA_BINARY, _min, _max)
+#endif /* < 5.10 */
 
 #endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/patches/0097-nla_policy_binary_range.cocci b/patches/0097-nla_policy_binary_range.cocci
new file mode 100644
index 000000000000..cb3b8be52b51
--- /dev/null
+++ b/patches/0097-nla_policy_binary_range.cocci
@@ -0,0 +1,5 @@
+@@
+expression MIN, MAX;
+@@
+-NLA_POLICY_RANGE(NLA_BINARY, MIN, MAX)
++NLA_POLICY_BINARY_RANGE(MIN, MAX)
-- 
2.45.1

