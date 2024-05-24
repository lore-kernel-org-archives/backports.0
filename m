Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9612C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570628; cv=none; b=jhOie+g9V/bpHZHaRt1NHQWAxhvLViMr/J8uV0lnKFHzKfP7TQUyXg9O/19hDg/YzpmZ4NScNQvhl9aD35DUNn5YZvtFnQokI/EtvFn30UOpYoGWfDp9LVLAnmmkOhGvG+ALOdEHqNK/OWxleQ46W1x2hJkNo2SNH6s4udWXIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570628; c=relaxed/simple;
	bh=PqvWaNcO5cnNdid/0PBZ3MwQV/M54l7NNRaYEYT8DuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifMcV9rQzGd3jAvoEmHYWOEUMhi4Edcqs0ngeNbkqiRIYSq4oqOjtvpdZLOBIP4779JFPbOY4V88u5RuD6ZzqeT57bzF+kiAxpu7ZVROmTUFRV2e3ohyVr7kQu7JS6pq8eJal4azgQbemDE5Xhz2DoBMFd2MxY/6l/5K6cfugNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J1Ekg52p; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J1Ekg52p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nGQ9JmEjEkhCjSBebDRM7JV/FW5nO2B5mrT8hhMiJ08=;
	t=1716570626; x=1717780226; b=J1Ekg52p4pY21Bzfl7AM4szg2Jdqd2xghXLozveUTlIG/dd
	g8SclJVWiZ0euGG3Pc15ApAdMLpD6t5n+56Q35Lwan/cmJW0k9K/NKic9ZPPpv6JR1YmFwfGSQpAh
	A4pbwogPb1FWH7iCH5XVpcPUma1warqGIx8Tp2I7CcUoFsBbVFe7QJPHMfthDqoMUnjdJWr6U8dqw
	yEYCFUaQ7tp4sf9zsN4sNHt8H7gyfu4pubCtL0fny+PdpGjzbSobykP13ytR/t8hSX3GdDglZkLVo
	s+TVnpF6Lust3V9OeiASoJJWe4tITJ9N0mvpWnI+wwSfaXcaXLRmtuarYFjb2FCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQy-00000008Xuw-07d2;
	Fri, 24 May 2024 19:10:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 69/74] rediff patches against 6.9
Date: Fri, 24 May 2024 19:08:21 +0200
Message-ID: <20240524190907.6646341eadf7.I6d0cc1bc85b62b898615611fad198edd3e252afc@changeid>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0099-netlink-range/mac80211.patch    | 52 ++++++++++++++------
 patches/0100-revert-small_ops/mac80211.patch | 11 +++--
 patches/verify.patch                         | 15 ++++--
 3 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index 662b73e91c8d..cf6d0b200b4a 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,8 @@
+diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
+index 569234bc2be6..c713f47c2302 100644
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -413,10 +413,15 @@ static const struct nla_policy
+@@ -422,10 +422,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -16,7 +18,27 @@
  };
  
  static const struct nla_policy
-@@ -511,7 +516,11 @@ static const struct nla_policy nl80211_p
+@@ -463,10 +468,19 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
+ 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
+ };
+ 
++#if LINUX_VERSION_IS_GEQ(5,10,0)
++#if LINUX_VERSION_IS_GEQ(6,7,0)
+ static const struct netlink_range_validation nl80211_punct_bitmap_range = {
+ 	.min = 0,
+ 	.max = 0xffff,
+ };
++#else
++static struct netlink_range_validation nl80211_punct_bitmap_range = {
++	.min = 0,
++	.max = 0xffff,
++};
++#endif
++#endif
+ 
+ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
+ 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
+@@ -541,7 +555,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
  
  	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
@@ -28,7 +50,7 @@
  	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
  
  	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
-@@ -657,16 +666,26 @@ static const struct nla_policy nl80211_p
+@@ -687,16 +705,26 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -55,19 +77,17 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -721,10 +740,15 @@ static const struct nla_policy nl80211_p
- 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
- 	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
+@@ -811,8 +839,13 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
+ 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
+ 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
- 	[NL80211_ATTR_HE_CAPABILITY] =
- 		NLA_POLICY_RANGE(NLA_BINARY,
- 				 NL80211_HE_MIN_CAPABILITY_LEN,
- 				 NL80211_HE_MAX_CAPABILITY_LEN),
+ 	[NL80211_ATTR_PUNCT_BITMAP] =
+ 		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 +#else
-+	[NL80211_ATTR_HE_CAPABILITY] = { .type = NLA_BINARY,
-+					 .len = NL80211_HE_MAX_CAPABILITY_LEN },
++	[NL80211_ATTR_PUNCT_BITMAP] =
++		NLA_POLICY_RANGE(NLA_U32, 0, 0xffff),
 +#endif
- 	[NL80211_ATTR_FTM_RESPONDER] =
- 		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
- 	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
+ 
+ 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
+ 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index d25e785cf57b..80d6dd5240bb 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,8 +1,10 @@
+diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
+index 33a82ecab9d5..b0c05fbf3560 100644
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15188,9 +15188,11 @@ static const struct genl_ops nl80211_ops
+@@ -16403,9 +16403,11 @@ static const struct genl_ops nl80211_ops[] = {
  		/* can be retrieved by unprivileged users */
- 		.internal_flags = NL80211_FLAG_NEED_WIPHY,
+ 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WIPHY),
  	},
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
  };
@@ -12,13 +14,16 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15980,8 +15982,10 @@ static struct genl_family nl80211_fam __
+@@ -17243,9 +17245,13 @@ static struct genl_family nl80211_fam __ro_after_init = {
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
  	.small_ops = nl80211_small_ops,
  	.n_small_ops = ARRAY_SIZE(nl80211_small_ops),
++#endif
++#if LINUX_VERSION_IS_GEQ(6,1,0)
+ 	.resv_start_op = NL80211_CMD_REMOVE_LINK_STA + 1,
 +#endif
  	.mcgrps = nl80211_mcgrps,
  	.n_mcgrps = ARRAY_SIZE(nl80211_mcgrps),
diff --git a/patches/verify.patch b/patches/verify.patch
index 85318b3f26ea..b1fd2c895429 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -67,7 +67,7 @@
  	struct x509_certificate *signer;	/* Certificate that signed this one */
 --- a/include/crypto/backport-public_key.h
 +++ b/include/crypto/backport-public_key.h
-@@ -52,34 +52,6 @@ extern void public_key_signature_free(st
+@@ -56,25 +56,6 @@ extern void public_key_signature_free(struct public_key_signature *sig);
  
  extern struct asymmetric_key_subtype public_key_subtype;
  
@@ -90,15 +90,20 @@
 -						 const union key_payload *payload,
 -						 struct key *trusted);
 -
--extern int query_asymmetric_key(const struct kernel_pkey_params *,
--				struct kernel_pkey_query *);
--
+ #if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+ extern int restrict_link_by_ca(struct key *dest_keyring,
+ 			       const struct key_type *type,
+@@ -93,12 +74,6 @@ static inline int restrict_link_by_ca(struct key *dest_keyring,
+ extern int query_asymmetric_key(const struct kernel_pkey_params *,
+ 				struct kernel_pkey_query *);
+ 
 -extern int encrypt_blob(struct kernel_pkey_params *, const void *, void *);
 -extern int decrypt_blob(struct kernel_pkey_params *, const void *, void *);
 -extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 -extern int verify_signature(const struct key *,
 -			    const struct public_key_signature *);
 -
+ #if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
  int public_key_verify_signature(const struct public_key *pkey,
  				const struct public_key_signature *sig);
- 
+
-- 
2.45.1

