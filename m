Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8021A2FD5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532132; cv=none; b=BRewEydg/2yuiwS1XKXp5A2vfFsoA9/dts7V+PTi8pWprgTkGSsX9uryvNEr56v1fSynwerGzxo57Yrv6NvoStdCl40/gLLwQvqe1FghXi4EtkAqbnxLXPyvwmQxrAN81RknVhAVSB/PMu7nDQ/l5HdLNjpM9dpsTPy4w6i3yT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532132; c=relaxed/simple;
	bh=JOBrN/tfwlDUCnC7LD8c/je8nHyUD6OgXFJnj8FKGyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOV+If765JRqnMbTwUvJDcs7niof+5j1QK7WxM2XL1FHE1TNmQlKgoFBd2WHqEiBXe/osE7n2fb8OQoc61QWlmFIhiX+RPDIoN3E7nqZHqOq22w7RC9tLyHLNrynyTNJCKlGPdERHZpG/pJiyAvCNqZQ76wqBw7ZT4TKWFOaBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=vN0jn50d; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="vN0jn50d"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdW0Q4Lz9spj;
	Fri, 28 Jun 2024 01:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JTtvsUzSN/mZM6L08rscFUx7zq6CNJB29+PSc5/pF0=;
	b=vN0jn50dTXqZqnVO6XoWwQpGoYJFgCNPaXY4siyCAIhs7RB2qBmzu6YMG4GgXYkgZsfpU7
	LdR35vuIGCxM6CkWcePedmlxgKr3aGfwjnnCDABO8gVBmuR91ucwzgOlMnzTzTUVY6cKzQ
	LItLiyj2f1jPqBVGiZWnsOy5yrgSuKgslnwLhjbJlxPqfpFA7mizJEuSqKomuztiY89zWA
	U2jruC2D378MqaxXyXvA+Ryyw+NEekONxDWiHl0EQKjgPhmp0liGE3SBPWLCx+9WsfDnNK
	D9VWtfqwCaGH2ibrw3ee8XVBYXPgTiKtb0/0bzdZJrvSSgSjKP2cf/FOCvSLlQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/75] backports: add NLA_POLICY_MIN_LEN()
Date: Fri, 28 Jun 2024 01:47:13 +0200
Message-ID: <20240627234808.1253337-28-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdW0Q4Lz9spj

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 7192153b..61c266d5 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -264,6 +264,8 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 	return __nla_validate_nested(start, maxtype, policy,
 				     NL_VALIDATE_LIBERAL, extack);
 }
+
+#define NLA_POLICY_MIN_LEN(_len)	{ .type = NLA_MIN_LEN, .len = _len }
 #endif /* < 5.2 */
 
 #if LINUX_VERSION_IS_LESS(5,6,0)
-- 
2.45.2

