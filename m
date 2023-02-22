Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61881C64EC4
	for <backports@archiver.kernel.org>; Wed, 22 Feb 2023 05:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBVFCL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 22 Feb 2023 00:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBVFCL (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Feb 2023 00:02:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A4311FD
        for <backports@vger.kernel.org>; Tue, 21 Feb 2023 21:02:09 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M2gM5U006211;
        Wed, 22 Feb 2023 05:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ArY2IWBDgmHqB4I2yUdQzRtPCBodS5iy7A9qU4fGJCg=;
 b=maEZnoXgPL9XBuWBc2+zbo0Ifbva1rStF6/xXRnUMUXUldxDdzfFdcJOF/5g2Wg/3VY+
 AbZ1SS90jHQmeRG2rVBIJ2ELZUwmYgWfFULw1bN2HDgdM8CIM2pFKXg0K3wXUhv4vWfl
 lvKk0VYse/aGfwddBrDanJ5u4JGS07qLRQ4NjoSdsCy07IbodNSNrfWF32XoVKkey/1t
 FMMr62Ob1SilrCgHMRz5Df99JkveY+lKZA+kbpmVybctZBquwd3nRfGrF+IvxfJrWm7a
 /GVjEXVSztlMJOCAj2TQIxr3CDE7f+ICKKzqDg2fogakwQorB3o4nKK4ofyDr15vCveO 7g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvtmm2k1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 05:01:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31M51omh022928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 05:01:50 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Feb 2023 21:01:49 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <hauke@hauke-m.de>, <mcgrof@kernel.org>
CC:     <backports@vger.kernel.org>, Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2] patches: Avoid NLA_POLICY_RANGE() for NL80211_ATTR_EHT_CAPABILITY
Date:   Tue, 21 Feb 2023 21:01:38 -0800
Message-ID: <20230222050138.11819-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2N_2qDjk5X9ZwwbKMT7JMLAHSn2GHmRG
X-Proofpoint-ORIG-GUID: 2N_2qDjk5X9ZwwbKMT7JMLAHSn2GHmRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_02,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220040
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
v2: Removed the modification of NL80211_ATTR_HE_CAPABILITY which was
a rebasing error and not related to this commit.

 patches/0099-netlink-range/mac80211.patch | 27 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/patches/0099-netlink-range/mac80211.patch b/patches/0099-netlink-range/mac80211.patch
index bc55cc2f15bd..ec4d1b9a08ca 100644
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
@@ -55,7 +57,7 @@
  	[NL80211_ATTR_MAC_HINT] = NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN),
  	[NL80211_ATTR_WIPHY_FREQ_HINT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TDLS_PEER_CAPABILITY] = { .type = NLA_U32 },
-@@ -720,10 +739,15 @@ static const struct nla_policy nl80211_p
+@@ -745,9 +764,14 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
  	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
  	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
@@ -71,3 +73,20 @@
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

base-commit: dfe0f60ca8a1065e63b4db703b3bd2708ee23a0e
-- 
2.39.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
