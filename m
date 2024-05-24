Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333E376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570581; cv=none; b=baY5xuank3yDUeaQT9hexrYrbZ4ngFRY163YX9IrAQJrF8IBmiDz0R9h2YpxScoHJwO+GjXcThic7CXxXNi2W1jdUN5Cq9GHenqj2zLh6h5VPG+x0yBQVX/l9GLRsFTvOmPmDaadI1al8WZ9LU3Cq8tenhQHMuWThoTYq9vsT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570581; c=relaxed/simple;
	bh=aY7j4nteNeRGstMxjTe9oh0bbfXAr3FIHYJPTefDQ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY39I8BNQchO3am5TiZtfJJsUU2IJXKkwz4D6hjtIMPFDY5aVrocGTyk48oioQEPgrSK045gEEzY+I5/m91x1/tGE7UTEmy0sS8tmvfUAyRGIaa8L8v0gMohowdZe9gHCRJJEduIYR+dmN2zgsNvw4oPuAjwrJA3+yz535swCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EMBPQRpo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EMBPQRpo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QGJl6o0AQ9mXupVYP+mBozTjvMRwI6Yh6zB7U2x6gYQ=;
	t=1716570579; x=1717780179; b=EMBPQRpoWVB57hZTV7pcJFp9H8UQVlEgqryfWVfO+fToyfu
	QU1diIgf6cRdmOrDCAzUtnSnVjn38uRga1z/2TEEPGRVUM8H0ZZRIF3esLkS3ek2ssEipT9rQO9b/
	Nt5KTuxRdeRp7mYIbpaXoCQ4+SbPu2NmW6Aeqcse+Ctl/jGZc7oBBa/HZVnXQLpqlm5ZgWQlJNNzZ
	YKTPaunHQT/lO/bfi12pXsd1U3ormExyohHTnZspO0y+HaXNezY492fl1xiZtLbyaY4smDkZJuggj
	LI5BkI7lW1gT8xSbwhIW8Xs8wWfRCaGz4/EGc5nxo3uAp3Eo53aVGS/1JHkM4ENQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQD-00000008Xuw-0xOD;
	Fri, 24 May 2024 19:09:37 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 30/74] backports: add skb_list_del_init()
Date: Fri, 24 May 2024 19:07:42 +0200
Message-ID: <20240524190907.033807850b36.I5a46230bc9c575b716597267e0b7b455600e05b6@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This got backported to 4.19.10, but we use it for >= 4.19.0,
so provide a backported version for < 4.19.10.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2bcd10364f9c..2daf06012864 100644
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
2.45.1

