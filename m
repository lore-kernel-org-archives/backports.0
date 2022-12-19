Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07979C4332F
	for <backports@archiver.kernel.org>; Mon, 19 Dec 2022 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLSTHm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLSTHl (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 19 Dec 2022 14:07:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4965EE
        for <backports@vger.kernel.org>; Mon, 19 Dec 2022 11:07:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJFY9wO018398;
        Mon, 19 Dec 2022 19:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=iYL0b1T4Pniw9ZTEyBB//GBORRd7dLlW0JGVAXBqNAo=;
 b=FNulaBpnNrj+tG3XEDVBS6rtFpROCexKFOR8hKOpM2E84+Htos2iv2dkVvX5kG8c6tN2
 eHnT/hRlJwgU+u2FUTKV862xJ1c4g9fdiq2cWwpxfSKnYyNFBb8f8EZSQDB0rd1DCf4P
 FCuQy0/WNva9kv0OddEamafpVTmCJDf/AFGyXudKqnKX3dFhLzOFPn7NKPAWQzzUXVMl
 wWG/XHxPEpS+51V4jT/Cpgr/jwih+bzT8bqeijuW8sNqE0adN+srnOy4id6LlCAz7Pq0
 Akx61zy6WA+fUArfvJ7zIlYRhmpKWB8N62P3W345SDer/kOqGhFjmOvlVpt1CcI/GLks Fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mh7havp0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:07:29 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BJJ7SDv030457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 19:07:28 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 19 Dec 2022 11:07:27 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <hauke@hauke-m.de>, <mcgrof@kernel.org>
CC:     <backports@vger.kernel.org>, Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH] patches: Avoid NLA_POLICY_RANGE() for NL80211_ATTR_EHT_CAPABILITY
Date:   Mon, 19 Dec 2022 11:07:18 -0800
Message-ID: <20221219190718.27547-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dg-6jCxaojZkT1a_cMjaPmxb0kloFxLa
X-Proofpoint-ORIG-GUID: Dg-6jCxaojZkT1a_cMjaPmxb0kloFxLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190170
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

NLA_POLICY_RANGE(NLA_BINARY, ...) is not supported on kernels < 5.10.
Avoid its use in older kernels for NL80211_ATTR_EHT_CAPABILITY
which was added in following commit,
commit ea05fd3581d3 ("cfg80211: Support configuration of station EHT
capabilities")
Author: Ilan Peer <ilan.peer@intel.com>
Date: Mon Feb 14 17:29:58 2022 +0100

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 patches/0099-netlink-range/mac80211.patch | 32 ++++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index bc55cc2f15bd..3e9333032728 100644
--- a/patches/0099-netlink-range/mac80211.patch
+++ b/patches/0099-netlink-range/mac80211.patch
@@ -1,6 +1,8 @@
+diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
+index 33a82ecab9d5..fecb5500dcf4 100644
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -412,10 +412,15 @@ static const struct nla_policy
+@@ -421,10 +421,15 @@ static const struct nla_policy
  nl80211_fils_discovery_policy[NL80211_FILS_DISCOVERY_ATTR_MAX + 1] = {
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MIN] = NLA_POLICY_MAX(NLA_U32, 10000),
  	[NL80211_FILS_DISCOVERY_ATTR_INT_MAX] = NLA_POLICY_MAX(NLA_U32, 10000),
@@ -16,7 +18,7 @@
  };
  
  static const struct nla_policy
-@@ -510,7 +515,11 @@ static const struct nla_policy nl80211_p
+@@ -535,7 +540,11 @@ static const struct nla_policy nl80211_p
  	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR_COMPAT,
  
  	/* allow 3 for NUL-termination, we used to declare this NLA_STRING */
@@ -28,7 +30,7 @@
  	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
  
  	[NL80211_ATTR_BSS_CTS_PROT] = { .type = NLA_U8 },
-@@ -656,16 +665,26 @@ static const struct nla_policy nl80211_p
+@@ -681,16 +690,26 @@ static const struct nla_policy nl80211_p
  	 * The value of the Length field of the Supported Operating
  	 * Classes element is between 2 and 253.
  	 */
@@ -55,15 +57,14 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -720,10 +739,15 @@ static const struct nla_policy nl80211_p
+@@ -745,9 +764,14 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
 +#if LINUX_VERSION_IS_GEQ(5,10,0)
  	[NL80211_ATTR_HE_CAPABILITY] =
- 		NLA_POLICY_RANGE(NLA_BINARY,
- 				 NL80211_HE_MIN_CAPABILITY_LEN,
- 				 NL80211_HE_MAX_CAPABILITY_LEN),
+ 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
+ 				       NL80211_HE_MAX_CAPABILITY_LEN),
 +#else
 +	[NL80211_ATTR_HE_CAPABILITY] = { .type = NLA_BINARY,
 +					 .len = NL80211_HE_MAX_CAPABILITY_LEN },
@@ -71,3 +72,20 @@
  	[NL80211_ATTR_FTM_RESPONDER] =
  		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
  	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
+@@ -793,10 +817,16 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
+ 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
+ 	[NL80211_ATTR_RADAR_BACKGROUND] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_AP_SETTINGS_FLAGS] = { .type = NLA_U32 },
++#if LINUX_VERSION_IS_GEQ(5,10,0)
+ 	[NL80211_ATTR_EHT_CAPABILITY] =
+ 		NLA_POLICY_RANGE(NLA_BINARY,
+ 				 NL80211_EHT_MIN_CAPABILITY_LEN,
+ 				 NL80211_EHT_MAX_CAPABILITY_LEN),
++#else
++	[NL80211_ATTR_EHT_CAPABILITY] =
++			{ .type = NLA_BINARY,
++			  .len = NL80211_EHT_MAX_CAPABILITY_LEN },
++#endif
+ 	[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
+ 	[NL80211_ATTR_MLO_LINKS] =
+ 		NLA_POLICY_NESTED_ARRAY(nl80211_policy),

base-commit: e1867d552f108f403725067c72ad2dc87535b935
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
