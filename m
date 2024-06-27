Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9021A38D1
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532134; cv=none; b=NDcpJVgHt+poFhd4q5fbAMdKOc5yHySX1JHV45+M/hQBSwU8NSVQnkQRVnoaAFWMF/8TlAIBrYajrp+AlcLc7aSGkPc3+zJJkjB2A28eeXk5B0PjZi/dDQTJz6VHBU/wrFI5tMUAC9qOR4Q4nJmUwN/OgMRbmadnWOWYMOU1zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532134; c=relaxed/simple;
	bh=QAirqKkLdSatj9qQID3i6m6ud6XPfskJOSEJdmZ4cV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUFV2HpReAnNgyIIUGWjQrfla0sEZuytZCtmxexVNETUsYuXlnGlS/Fa1lJI8GeMmmhyDzrhvXDhkqrPLdn2KKkK4UCRQNxRl/N/IGBzWL1dcWM9jrj+R3jabI3XHO6kBbM+lTMIM0jVxXzSSz0ELZyR0WuXL8Rp4EVQ9u8GyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ONtzZynx; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ONtzZynx"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdS1n0vz9sps;
	Fri, 28 Jun 2024 01:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WHg220e/2fGtYDPP9DjuxNEVazOA04HF+ThmswipGY=;
	b=ONtzZynxTGPWafnr5lSXFm+aL7Nzoe/mWvtZ0zcZL5FShBml5WP4vSYG1A/dZ9CUUDMTJC
	F/zJew2TRvPIgBPxPHLdNsa6igsf9ALL9iR3bNkjIVWHDjk4hFTiFNhVoRoIRleaJ+56W9
	m7mnP9ObwjNtueGW1FyaMvjrRdqfuoZ79lvJaHVVU2/L2FbXMYJbnXdLUEIaELj5ibKHNa
	bpeCIJC4ad3R/IQydNUcqavDdRGjg55hhCjVAUsu0IJh5ePdtx6NUTq9ICPi93OnF3Nx9C
	G6+yETnh9ueJq8+aEUidC2cD2VPxDsdoyYl7XfL9lDjJvjqxGuro8dit1f3nYQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/75] backport: update 0099-netlink-range patch to apply on v5.18-rc1
Date: Fri, 28 Jun 2024 01:47:02 +0200
Message-ID: <20240627234808.1253337-17-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdS1n0vz9sps

From: Gregory Greenman <gregory.greenman@intel.com>

For NL80211_ATTR_HE_CAPABILITY we now use NLA_POLICY_VALIDATE_FN(),
so the patch doesn't apply. Fix it.

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 patches/0099-netlink-range/mac80211.patch | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 662b73e9..9289b442 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -55,19 +55,3 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -721,10 +740,15 @@ static const struct nla_policy nl80211_p
- 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
-+#if LINUX_VERSION_IS_GEQ(5,10,0)
- 	[NL80211_ATTR_HE_CAPABILITY] =
- 		NLA_POLICY_RANGE(NLA_BINARY,
- 				 NL80211_HE_MIN_CAPABILITY_LEN,
- 				 NL80211_HE_MAX_CAPABILITY_LEN),
-+#else
-+	[NL80211_ATTR_HE_CAPABILITY] = { .type = NLA_BINARY,
-+					 .len = NL80211_HE_MAX_CAPABILITY_LEN },
-+#endif
- 	[NL80211_ATTR_FTM_RESPONDER] =
- 		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
- 	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.45.2

