Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A2C433F5
	for <backports@archiver.kernel.org>; Tue, 22 Mar 2022 18:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiCVSXc (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiCVSXb (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 22 Mar 2022 14:23:31 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F28D6B0
        for <backports@vger.kernel.org>; Tue, 22 Mar 2022 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647973322; x=1679509322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sXzcv426M/YfAmIpQYty05d0EyhHtyIb3XZtS/DmAQY=;
  b=Pr0OmF7pUgFHZYmFAM7zeDae1P3UmeAsJqthHwVoCYmHdFoQ71+q6ooI
   a9Ft9RjiXiO5Nze7QBHTYEiQIpxuw23+vTPBcrR37jvLdQuVqiCMXF5vl
   9dP7L2uaQatY6pUxqb9KrbuqgCKWAN4CjoR8B6A5S6tAmRJGvUSJOaRlh
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 11:22:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 11:22:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 11:22:01 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 11:22:00 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <hauke@hauke-m.de>
CC:     <backports@vger.kernel.org>, Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] patches: Add missing definition for NL80211_FILS_DISCOVERY_ATTR_TMPL
Date:   Tue, 22 Mar 2022 11:21:48 -0700
Message-ID: <20220322182148.27727-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add definition for the attribute NL80211_FILS_DISCOVERY_ATTR_TMPL
which is missing for kernels older than 5.10.0.

Fixes: 51258137c228 ("patches: Avoid using NLA_POLICY_RANGE(...)")
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 patches/0099-netlink-range/mac80211.patch | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index e1037a58e1f1..168265ce50a9 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,8 @@
+diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
+index 578bff9c378b..18145767193a 100644
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -412,10 +412,12 @@ static const struct nla_policy
+@@ -412,10 +412,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -9,11 +11,14 @@
  			NLA_POLICY_RANGE(NLA_BINARY,
  					 NL80211_FILS_DISCOVERY_TMPL_MIN_LEN,
  					 IEEE80211_MAX_DATA_LEN),
++#else
++	[NL80211_FILS_DISCOVERY_ATTR_TMPL] = { .type = NLA_BINARY,
++					       .len = IEEE80211_MAX_DATA_LEN },
 +#endif
  };
  
  static const struct nla_policy
-@@ -655,16 +657,26 @@ static const struct nla_policy nl80211_p
+@@ -665,16 +670,26 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -40,7 +45,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -719,10 +731,15 @@ static const struct nla_policy nl80211_p
+@@ -729,10 +744,15 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
-- 
2.31.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
