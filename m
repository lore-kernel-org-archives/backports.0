Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AB22616
	for <backports@vger.kernel.org>; Fri, 24 May 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574280; cv=none; b=Miu05GijnU2+zd1s+MxpchhEuzwMtaN12huRJTsM0Ra6JwGbGPNQHOml5YsZnQTm+agOsCt/J9MVNmiDqOJKaOECBTUqOKc9Zqw3WAiysA858zuzPgbul5+oYZJgn7MmvVhEP/0LqmB2g1aCmDkPfvAUtycKlwJJ580ZDjtYXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574280; c=relaxed/simple;
	bh=JAKhAedT4DF61A7nsOqed5CQj7plAA+O/I6WOANUEfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQou8HeDlHAsgp7SxencDMyTH+z2fwhFkYurpRYrGuEmUDYF2g/sK7tcU9wwAhZty2PueMKdojWUkS+B3DLNK+b/kjJSX2AYe2qZsm4TjD1BWmEZYnFGF91/XJxgAGw/PEBxtpbeFFkwYSS0hY3T3T1YkTc40joDJXdRyZS8QwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uLKc+iVm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uLKc+iVm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=sk3bnx+Wc9v0tyUjFDQMqxrvWzr0mHq0KUfkbAf3Vnc=; t=1716574279; x=1717783879; 
	b=uLKc+iVm4ytjmCafKMrS+3R5DLG1P5ddTQVPHdl/J2HdnAnyKyZYcGogpFeuoFl4TMdeUlLPANQ
	A3l6/12jTXLsRVENnbqkXZa4EtORsUaLPn4SLfWwFtYuny/8f4kPoffH0OJQFD2faZrmhQPs9HJi7
	2MgDFLuK8a7pzAqExya63MOIM4GS0apOhJa17hanDa6hoOPeiJMpwPvpEcAHClEjRUwwSaINlO+6u
	UCPr+f0bMd822YW9Eu17X+EkmOkhdkoiHkxMB+TN+e5fH23Suxd/7/wAqfiQUU+xyFkH/OTc6c6+g
	V/1oUwrz8kgV4tX2P74rjMGXKRa3i+hOVUjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZNr-00000008bYt-32TZ;
	Fri, 24 May 2024 20:11:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/3] backports: add BITS_TO_BYTES()
Date: Fri, 24 May 2024 20:11:11 +0200
Message-ID: <20240524201112.bfc1a1eeddfa.I6ae09dfd2061693745358ecdac5f703f96b07e00@changeid>
X-Mailer: git-send-email 2.45.1
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
 backport/backport-include/linux/bitops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
index 17bd8138ecd6..20890e198ee5 100644
--- a/backport/backport-include/linux/bitops.h
+++ b/backport/backport-include/linux/bitops.h
@@ -24,4 +24,8 @@
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #endif
 
+#ifndef BITS_TO_BYTES
+#define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
+#endif
+
 #endif /* __BACKPORT_BITOPS_H */
-- 
2.45.1

