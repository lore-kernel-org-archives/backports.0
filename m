Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0C12E1EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570588; cv=none; b=VV07pxX6xczHB6A3n26vh1YGewjop9blYFZv7zECPgBW4aS/L7JDpAIhehT37HNmhbaCWWSN+orK6t3Io/LJh6YTlp6UkEG2ozEdo3bdPfwhc4TBuMzEmWC/TYZ7lBi6NEy8Hi9KYPef2EOxr8mUwewrcnefo6U3ET5m9Mly1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570588; c=relaxed/simple;
	bh=L7PP/uog8GWZiEftPzgMGj1eOn/56mCRFJ+e4aIa78A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnTycaE9vMZHBfAA2XeIX1uzf5AX+/ez99V4vLwSm6a6JEn/cqnFQcbOOgoA/DWyMoo4zUeT7u0OCoUF/wnXkLZEuCKko9kueb7iGKmMTP7TRxslKAne8VWKqXPb7XkPY5toZLdurPtL529TYYkgmH/uzoYvObDuZvl3PXL4F/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d5Z+pOw6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d5Z+pOw6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+j09dzoHGoGC5bHoJSqCfNBk/nKJs3Onwkg/uo/YcUs=;
	t=1716570587; x=1717780187; b=d5Z+pOw6ILQNy6RXDfU7jWoTu+qVawvv3PHnnf6AuYrLTSu
	zThXjPp1vzAVgauvjeaIncwvEG8nYKUcRhi/0TiOK9rio+thypEoSRmYJysPY4RZyOzWefhl2vJ5D
	hXjmiRL/MQidzoX9le8Wmcq8Iiqc9hGDkbD+31Kh7V6gOZcX84nJhk6M+6Le2L5D4bzPPQmFWND37
	Ks2/ELCwWacCZpoqurx2hnRf2qnsjVo9y9HXBGHxHeLq/QrWKMPh4e260nE9G6EElk7PGWeYnybqg
	UBohhny0qMKpuIclKw5ihYYQXOtXx2/TsCNwbJEqjVAHYvlrEhyaQKO0TE5UpFbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQK-00000008Xuw-43D2;
	Fri, 24 May 2024 19:09:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 37/74] headers: add skb_tcp_all_headers
Date: Fri, 24 May 2024 19:07:49 +0200
Message-ID: <20240524190907.2429e3545959.Ia864c56f1dd70716e29a2f97f07f57932923ebb6@changeid>
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

From: Felix Fietkau <nbd@nbd.name>

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/tcp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/tcp.h

diff --git a/backport/backport-include/linux/tcp.h b/backport/backport-include/linux/tcp.h
new file mode 100644
index 000000000000..2483cbebf66c
--- /dev/null
+++ b/backport/backport-include/linux/tcp.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_TCP_H
+#define __BACKPORT_LINUX_TCP_H
+
+#include_next <linux/tcp.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+static inline int skb_tcp_all_headers(const struct sk_buff *skb)
+{
+	return skb_transport_offset(skb) + tcp_hdrlen(skb);
+}
+#endif
+
+#endif
-- 
2.45.1

