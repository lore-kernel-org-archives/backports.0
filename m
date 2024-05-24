Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B2376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570579; cv=none; b=B/heApZSrjR4vKa8qpHSgqdFb6ulPnEmQS2xpKEQXNc8WMQG5l9efs1x/h9hsi693etBccYeOPAPYFbMJ+ijYUXKXpkbX4DQEc0SRHlv5O4WMo+bqtp8UhiLl3Jmqt/9LUFhFkLKfbuzxiKnUphn/moqMNseHTXBg2amqRs3Lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570579; c=relaxed/simple;
	bh=h09jWKcVN3dWbABQhSbfl7xb2B0G9Yb0YhmKaBCW0hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O53ZoHT2dvR7G109XMMjG/kumFris287X0HM1jBqeXKJohl+ZfKiSLDnLoE77ZuXe80I3U+mX6qwo2FBH2RrfyHKTz5ZSEurxjcNivQQO8PsAEBFe3a1bBFus0jsKYXrNnxa2+hqyudjX9w3giiiax3K49Z3vSs0wWGG5NDms/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p6ZGfmxS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p6ZGfmxS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yWh15hV6/j2NYpUJnMMJ5USIDwOMLCnXUP1C08io57U=;
	t=1716570577; x=1717780177; b=p6ZGfmxSbXk/cxY6laHE+ZVab9TGde1QVrfGgsYympNceOh
	4zbYUuTarANrStORAJmdwyMmk98ifsmgvb+5t65kzVKjlwspXRjk0+1DTAADPBrX7/XoAI1OpuxH0
	J4xWMLKwbZ1hsKApoJVvi1pfhFn2SuQOlwpClzuswEQsMDC1r4g88Gdcz9hrCkrTWKImzr4/okgGZ
	6+nD2OUlIGS9C8HbAK/7oMJfwyqth0plMbO0Ms3j6MWi/kd4kDXCXBgY74UNcsHu2S2Mk4xFQFJdw
	Yi5FKoyCxAkpPPEjYOXSl3nc22T6S9ZFGn59VfTS8jI4I6dMRb4S1xlX2rjjj0Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQB-00000008Xuw-0sJZ;
	Fri, 24 May 2024 19:09:35 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 28/74] backports: add get_random_u16()
Date: Fri, 24 May 2024 19:07:40 +0200
Message-ID: <20240524190907.0ee01bdbffe9.Iac1c83457034d19878457df15d9f93a8c4781308@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/random.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index 0a247321785a..89e9ce022505 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -3,6 +3,13 @@
 #include_next <linux/random.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(6,1,0)
+static inline u16 get_random_u16(void)
+{
+	return get_random_int() & 0xffff;
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(6,2,0)
 static inline u32 get_random_u32_below(u32 ceil)
 {
-- 
2.45.1

