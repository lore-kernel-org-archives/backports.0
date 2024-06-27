Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F71A2FC6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=XYtJUtYkKLRixSzlFRA9skLruc1ubHZRUrbw7Uc0a0iN67J4/BjeEh0ad1eMA21rKadCH9z7UKoE/X2p4i3mijUe8E4sejeBYyE7JYDfwoKUXYt3wlc6OPhyAfl1drRkWC4BivZljwUto3H5yTOHU0fdhcCFtKE2PYp1LRey7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=Hgw6Ttczf/TF7ja2hnbGzcU5J7Ops8GWwz6oh3XXS5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX3eBYxS+CqOQVTkJ/g5w5/7tlFB33yIPxdd5O/TWHKPKzgr61oj252zAUcBpjFkaOPbeXibCQfpdLz1lmqCgD1UjzRIL4XXr9E7hCLaMxZOwtlGCPsYouLPE/mDh9c3YEWvQ7ot+OtjeABwiig/ZeyQA2U5Y8EyUKmvWBNSZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Fj5H6jE0; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Fj5H6jE0"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdV2WhSz9sWB;
	Fri, 28 Jun 2024 01:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=juSZpjwOdjjTipFcVU+AKVL/tD7eA9xE6aUr5Y8/DfU=;
	b=Fj5H6jE0OWgYsjF+v4ZuEUOuMi2avLEEL9X9HnQ5QjNHBBxsHZOS182rcJnUTkT7AtNfBg
	SdFWfrwj+StbKrk1L09/IZtlvH6+S78gkRKdQcROZO8lrOgivKpVTHcqSNw+wPa3/WqmCb
	guB3XNXM7w/0gcN/oSYFUEyUv8YcWYuOWMKBEAxL5B1MJQ09jlGan7ryi7Px99vxbuYlmQ
	TudIUnXdptN5o2a7MorFl7F1HXSNIVO8VS8o9H1F3JP/c6zX36n01l1TIGDXS5gz65g0w3
	GsRk/fSMISbXnmG43lnjjy2AQbKgwPkmE84Aeahh+1D9IFSQ+g5w4iHlGDR25w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 24/75] backports: add rfkill_soft_blocked()
Date: Fri, 28 Jun 2024 01:47:10 +0200
Message-ID: <20240627234808.1253337-25-hauke@hauke-m.de>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/rfkill.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index c0b99d58..d130c9b7 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -21,4 +21,13 @@ static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 
 #endif /* 5.11 */
 
+#if LINUX_VERSION_IS_LESS(5,17,0) && !defined(CONFIG_WLAN_VENDOR_INTEL_MEI)
+
+static inline bool rfkill_soft_blocked(struct rfkill *rfkill)
+{
+	return rfkill_blocked(rfkill);
+}
+
+#endif /* 5.17 */
+
 #endif /* __BACKPORT_UAPI__RFKILL_H */
-- 
2.45.2

