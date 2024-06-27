Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EC1A2FB5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=UTtu5eUXcIUqjAoBiGMW9cBoxqDb1gmEkfOeNldloTqJVVHHTSd7JLrmmBs1vJDJGTp29PqfqHl5G9cxLoQYomapoyWCy9jVk97B5SLccI7ZVaCpX59WBcslpyWYe/quicj1r1ObxK/LdKwWGrcl2Q4T9QTNy5LqqW5ubtKxeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=nN/mRf2+bHQRpyLdmqd2N4jNzLHawra7K3nTU9sVi+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpgMpY70qTOVFjWYWOj5UEtQaXqzpeZSMmqj2ZRwJZNJM6mj16JTndsSM0p7zHupNinsqEYKIVB0uYVa8F5oWC1LwMZTJZw9SJiMH9oUxsmUJnYqm+W6EKyCq3D1XGwmJJGqAdAWkR03MzfXFRFSLS3D/00MB5Q1GvgVDii7uLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Qnki+b1T; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Qnki+b1T"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdV416Pz9sqv;
	Fri, 28 Jun 2024 01:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joKA9tv9QBe40KjRQcehVNP4sdZBkzAW1hOgbmWQGQg=;
	b=Qnki+b1TsVY7Xev+uc8ptVvzbbtASHU95jp9/XA9jfa3TSDY4KV/97VYhw3dQ1+tygfFty
	5qAWvQvqqbhBrxc4nPfmQJl1nutETwcXIRxUp47cxIADD9NhH8reyrbtrcp9Vk3ycJr94w
	9Z+iGH+9OlQfsGNlk9JfS1FEd8qNEwhf1lyLSXAasYOtu0nH9CL91fmy3BS5xRchdnQz8T
	rHkWzJ7R/H35xakzcRgkZX8C6g1XWPeYsgL55VU4aIZRAA+2HiW467riQ6LCKTNWpRewOq
	3Kg8sHQ+/OWH7pKJfT0sVOdY/YkeVnWAg7Zp4lojaSKexFQWzWV9/3ryMw3BFA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/75] backports: add skb_list_del_init()
Date: Fri, 28 Jun 2024 01:47:11 +0200
Message-ID: <20240627234808.1253337-26-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This got backported to 4.19.10, but we use it for >= 4.19.0,
so provide a backported version for < 4.19.10.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2bcd1036..2daf0601 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -15,8 +15,16 @@ static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
 }
+#endif /* 4.19.10 <= x < 4.20 || 4.14.217 <= x < 4.15 */
+
+#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0)
+static inline void skb_list_del_init(struct sk_buff *skb)
+{
+	__list_del_entry((struct list_head *)&skb->next);
+	skb_mark_not_on_list(skb);
+}
 #endif /* 4.19.10 <= x < 4.20 */
-#endif
+#endif /* < 4.20 */
 
 #if LINUX_VERSION_IS_LESS(5,4,0)
 /**
-- 
2.45.2

