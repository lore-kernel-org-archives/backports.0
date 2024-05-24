Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C512FB29
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570573; cv=none; b=Ow4SN0RnQb+/4oNxQ0sgh51HMqBbW0qdWtEorj0/MhxhLJd+txLJ5pUkgHi0sNaX7nLJOT4+bnQYN+gA5ftYWeZ81DNfSL+qMRj1S5tKW5kJgSJLGOjsyAX4uGBJ3RIVY5GnLaLJaF9MG1Y/PgDlD9Oy5s5R97UOiw1wYd2bCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570573; c=relaxed/simple;
	bh=oMiW8Uu5/Ay4bTFWq/lAthy9GnMs97gBwgvKJGEF1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNACbxf/JwEz719Q9pelKCJEElyhfwgc6vlXaJa/G4yexhOan0De4AEwToDwokHiKxmnVlJe7618awID9TzQc1PVSuogDdjqSXB1bB7WkR1xfCsatpdFI8Tlh3HhlbWlZrSaS+m5EOAzMZ2YXNzW1xHiu+P1RUpRhOtRbbkCqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VTmy102A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VTmy102A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d2OB7FFADNjvHBzZLV6uVgELoi9+JgRm6q38Pbag5Ng=;
	t=1716570571; x=1717780171; b=VTmy102AsCUOqpDff/U0NXxu1rEBVCsbyXyme8r9ltZwj2F
	lR3vfEaAP6qXRYTS9vM8qUJP9L/+XsVEH11P5B+4qAyH5D5E9YpizgqV7VVyRK/ApOzX4WW5OV7CO
	Qole1bPh7DK/63iZ6GRKop9zHG3wTaDpIrOTC5u252tROg1bkvtJKRY3gTWJwdyTmg85SVIEuZ+h3
	mTYXgQAJA8Q32KNkaK8z6xW6CAA+mCVZhsc0vadHyHiqfL75ZqSDbenjrpwWRaoHKUsJc4JgOFZvh
	VR4fuhnwCEp/LrYolRMvOrw6Tm/3mzh+oZ9bQVy/RKL9sQvGGy/6Hqi/5I2ld/hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ5-00000008Xuw-2xJ7;
	Fri, 24 May 2024 19:09:30 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 22/74] backports: add support for kvmemdup
Date: Fri, 24 May 2024 19:07:34 +0200
Message-ID: <20240524190907.896ca9334310.I1558b8083444d6bb053501b489091ab1ac077ae3@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This was added in 6.3.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/mm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 46c7ecafce76..83b495a1bd02 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -10,5 +10,18 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 }
 #endif /* < 4.18 */
+#if LINUX_VERSION_IS_LESS(6,3,0)
+
+#define kvmemdup LINUX_BACKPORT(kvmemdup)
+static inline void *kvmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = kvmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+	return p;
+}
+#endif
 
 #endif /* __BACKPORT_MM_H */
-- 
2.45.1

