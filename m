Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DF481CD
	for <backports@vger.kernel.org>; Mon, 22 Jan 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959203; cv=none; b=jZg7vhKAEO834NgBsLJQESEPx/tYjBrgqPPCrVtSI7s0JWhQSgYsTQu39lxyGUVDuFduP8yZDwgpIpQfM+NzNTKh3oq0hhWFcNskzpckCuSaUoy9iuhOR8427Xs2RqBEvhskCczHkv1SmOlnpgqfZTGTwlBW8opU0uTv5mJ9hfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959203; c=relaxed/simple;
	bh=L+I1aEPT+ovTDrOyQzAsvvmGiqebsKrjvkRue/lUN5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqkYGzTG2hVxSlrge/XKUyKKQFaGQlPXf5gIcSKxEDoSOu+8AKmpBM2bEpIvywd46vkFa30DZV7PNneqGizj4J/iy0xFEN/oEyDUXz40ODTsn+1PCH/jO+GSLTTix6/4H7aejSdDMS1XruEm6Oa2ROw/ALAnR4v7XCVBOmbT2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=FFvTpn3A; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="FFvTpn3A"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TJk3f1Lvjz9sSN;
	Mon, 22 Jan 2024 22:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1705959198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lf7vaTHssm0qJ/BYbSws7+2iKOg1pPmuZKPsvRNHvFg=;
	b=FFvTpn3AHDp6myLb+LgSv609bbKE5+IuW2agVzEw0s9GyR7hmOK3+xyMdKGr50VYia0z+8
	tZuAKrn+aHWxHex90ddXcIijZ9G0UPAiQtNoc0jvH7JAUmAaOA/6xKmyqUJMaY3k+A8KOl
	tyL3XK71W37WghQaBVn5m5311zrPzV1XaPnONk7Bgu9aqQ6jvILe1PYe7DPBpXPetGaqF1
	nZq/QDz/w6c6XXfUNxT3VNLWrj5+FzWcSnFCJ+kTxZ5z62YE7ehVyvQ/pD9SJbyixvbGpT
	n1UE4haQTDBdBDxG3/FpYi4mBP9BbBlTPXC82hbgwooi2N/LLu720dIe5kpSDg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] headers: stddef.h: Add struct_group
Date: Mon, 22 Jan 2024 22:33:08 +0100
Message-ID: <20240122213308.149303-3-hauke@hauke-m.de>
In-Reply-To: <20240122213308.149303-1-hauke@hauke-m.de>
References: <20240122213308.149303-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the struct_group from Linux.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/stddef.h | 77 ++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/backport/backport-include/linux/stddef.h b/backport/backport-include/linux/stddef.h
index a0765ef3..5a73ec71 100644
--- a/backport/backport-include/linux/stddef.h
+++ b/backport/backport-include/linux/stddef.h
@@ -56,4 +56,81 @@
 	__DECLARE_FLEX_ARRAY(TYPE, NAME)
 #endif
 
+#ifndef __struct_group
+/**
+ * __struct_group() - Create a mirrored named and anonyomous struct
+ *
+ * @TAG: The tag name for the named sub-struct (usually empty)
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @ATTRS: Any struct attributes (usually empty)
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical layout
+ * and size: one anonymous and one named. The former's members can be used
+ * normally without sub-struct naming, and the latter can be used to
+ * reason about the start, end, and size of the group of struct members.
+ * The named struct can also be explicitly tagged for layer reuse, as well
+ * as both having struct attributes appended.
+ */
+#define __struct_group(TAG, NAME, ATTRS, MEMBERS...) \
+	union { \
+		struct { MEMBERS } ATTRS; \
+		struct TAG { MEMBERS } ATTRS NAME; \
+	}
+#endif
+
+#ifndef struct_group
+/**
+ * struct_group() - Wrap a set of declarations in a mirrored struct
+ *
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical
+ * layout and size: one anonymous and one named. The former can be
+ * used normally without sub-struct naming, and the latter can be
+ * used to reason about the start, end, and size of the group of
+ * struct members.
+ */
+#define struct_group(NAME, MEMBERS...)	\
+	__struct_group(/* no tag */, NAME, /* no attrs */, MEMBERS)
+#endif /* struct_group */
+
+#ifndef struct_group_attr
+/**
+ * struct_group_attr() - Create a struct_group() with trailing attributes
+ *
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @ATTRS: Any struct attributes to apply
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical
+ * layout and size: one anonymous and one named. The former can be
+ * used normally without sub-struct naming, and the latter can be
+ * used to reason about the start, end, and size of the group of
+ * struct members. Includes structure attributes argument.
+ */
+#define struct_group_attr(NAME, ATTRS, MEMBERS...) \
+	__struct_group(/* no tag */, NAME, ATTRS, MEMBERS)
+#endif /* struct_group_attr */
+
+#ifndef struct_group_tagged
+/**
+ * struct_group_tagged() - Create a struct_group with a reusable tag
+ *
+ * @TAG: The tag name for the named sub-struct
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical
+ * layout and size: one anonymous and one named. The former can be
+ * used normally without sub-struct naming, and the latter can be
+ * used to reason about the start, end, and size of the group of
+ * struct members. Includes struct tag argument for the named copy,
+ * so the specified layout can be reused later.
+ */
+#define struct_group_tagged(TAG, NAME, MEMBERS...) \
+	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
+#endif /* struct_group_tagged */
+
 #endif /* __BACKPORT_LINUX_STDDEF_H */
-- 
2.43.0

