Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24812EBD4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570582; cv=none; b=podiy+4dumXHjxsk/6rasJSslIuO3U4Lll7Dm2ZW77B5rOoGM0C9KOBauWd80Y62vHhOsG2G4UfKZSrj8Q/hR+fkZofTNboE75tONjhLezSCJgTmoSCoo8/mxG3GQR4MjdlL3j8s3U3vH3Y7z9fmz7aadGnba8csEPlgfi8D7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570582; c=relaxed/simple;
	bh=MXQZcvaqYjFYEhbNo19Yj738wartpqZmZyHHjrqtsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOdXF3XKDq7gQhWBcLRqrmhmxXaWVbOTGRlQkgfiIjugFt8cAzDJouj7+QFLKTixzvLKxzp0qqwfEfW99zigqqg/bsRmpKLkjgiIG+EgRaiTTS0kwCP65u1cc7ITzs5eJXgSKW5rlXgsLSxFrROjP8dPM5neBaO7wG2ytAwtlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KhJfTinE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KhJfTinE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GxiNTZvpt4asoHHhcOYDpXPI8ndRgjF0DMcUHPSnR8Q=;
	t=1716570580; x=1717780180; b=KhJfTinEGO9cWoR+IYtTBdlxkMWL74GF5vnopqi121TSLty
	ovzCElLUyK2JpeOg64bVhjV8zJcNnDDUZsNzWxix5LuGKUBH8ZZGn2XFIEEi+3BdXxbOi4IW63n8i
	KRkQUH+IAuWmKkY7frryxW6ANlqnePqvatBpmuhkGlvmIrpOmG5g3d1Dxxsp6SOdCRHE29rS3YV1+
	jbou+GJwjdSg+rcXjZFUSSNcqVGLNjDH3AjagkdspU6bvtptnUoG/+2Tbj9ybUQSfi2NUvzO3SIQh
	lDvkSf9VfOWdpBZYmF38b3ox286Uf75agTDVyqNkUHZ5HY66Od8Cs+/kPJ9b4seA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQE-00000008Xuw-1uJO;
	Fri, 24 May 2024 19:09:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 31/74] backports: handle kfree_skb_reason for older kernels
Date: Fri, 24 May 2024 19:07:43 +0200
Message-ID: <20240524190907.ca531b72b1df.Ibba0f29bbf9e340a7b04d26c2e99f596233e6e89@changeid>
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

kfree_skb_reason() was added in 5.17, handle it for kernels
older than that.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2daf06012864..909f0a9d63c0 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -76,4 +76,11 @@ static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void kfree_skb_reason(struct sk_buff *skb, u32 reason)
+{
+	dev_kfree_skb(skb);
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
2.45.1

