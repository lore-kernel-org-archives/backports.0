Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBDC388F7
	for <backports@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFCC20797
	for <backports@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=celeno.com header.i=@celeno.com header.b="vCjajaWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgKJOEG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:04:06 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:39665
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbgKJOEF (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 10 Nov 2020 09:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf6rxKaRyMqrQCIhTpgmkgDHVjffdcK1fsYOXMU3UwVJaRkqzykxyIRdWS2E2HCCUbhFStXwxr80+5p//WPskBv5w1gA9BdRiqvqCRy8xqXTOrp1apoBNaxTGi2zm5vovWcqTc2WQfKhVz+DL115gVhwiRwPgSR3gel7+pOQJQGtMdzJ5bn3dIK6DWCYv/WYWsi/cmmIyel6C6DY9D1KIH/uXU7D3zFfJtjb7X00AE2bVoeJJ+u567iYZQ9WgsCAQP6t1eH1EJ1R+x9wxoCAgsBGZKh3OQHE8PTgZLoRoV6IfWb83Htj1mQEPCHHzZafqLbj7qbIu50TwAMZpsyrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtbR7G5Aim6/+sOhuDaF+zicZbhrJ3o/J7kFtLPrC/I=;
 b=Dv8OFmvb4DOlaTcUSHvHzHI+Yy7kWYiDsLbxKIS4alFIR3mCk6M8BT6Q8oHTefXpa73NN+x5twJoZ7GP98dwBuyvD7YOy+3bjjlOcVyWZKTBypAgkU60nQilI/K9A5r1d1Sma7cREe4Zo1G916/SSNHz2MDxqBQCtTB+2zgsss048e9PIRG7bd6kyoyqpbcHyHQIv8PMH3MKYRzntbuy/TJIMUnxX+6S2Y779XNcOZbz6DbhKvFMpKPwpWSatRFW3nS9EfwOHOb7RaYAQkMh5Gj6egrDGiJtVlsUIrrv5YGCUjZ86crCaF1k4S5jXEBGf5V/voRqy97SOf6pYqsY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtbR7G5Aim6/+sOhuDaF+zicZbhrJ3o/J7kFtLPrC/I=;
 b=vCjajaWwACNgnlmLxv/p5Gpyi21HX8pPh/SU/y207dUE4SliNyMSRHSJD1GBqTzGFbmeG5HrDrM9cGbpbkEZyNV8SG7wloX6hgMCM085bTgh3+E3d6/xUBg5L6Vvc7c3OyciJvg/QS1OxXj18OblPzGABZA5/RuyhDgRL01GZhc=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 14:03:59 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543%5]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 14:03:59 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, eliav.farber@celeno.com
Subject: [PATCH] backports: Add time64_to_tm and ipv6_mc_check_mld
Date:   Tue, 10 Nov 2020 16:03:44 +0200
Message-Id: <20201110140344.17330-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [87.70.23.140]
X-ClientProxiedBy: LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::6) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (87.70.23.140) by LO4P123CA0001.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:150::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:03:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4969492f-a98c-4425-7f4f-08d885817844
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09660B76ACE95596A5DEFB57E7E90@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHQ3eSEIA4jmBSJhCuRmIl66LmoXWVtMgv7JxXQwYU1Mlj27no2UQT5cjLH7A4QGHvKaxrK9V1IBWT0cK7fEDY1FFq2iI4FWSR6rtPUE9V9KYYSBX5LReQxcpQJuF84lVUjcouaJ+7A/8YEUbICHFlDbqHjb7+ubqueIiIO1POJK93mcGFBXrztGT5FMAt8sxbv6SJ0rTXnj4cSbB/JPUqXxLlLwLwxYbY7COE+67R2ghu2b70eaUFZ/NZpU1sVUcRZ9/YouanwGXTaRnzMCxfzrz51y9AwbomfqQdEqGiKFIMOFkv4eOy/oZuG2PtjgOkmDJKF2HvHPCAjWDwSQpHn6strfp3UeD9GmuTkrVkHnDZCfRSsY/HvW6fT0+4BI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(69590400008)(4326008)(66946007)(1076003)(66476007)(66556008)(8676002)(8936002)(86362001)(26005)(6506007)(52116002)(5660300002)(2616005)(956004)(107886003)(6666004)(498600001)(16526019)(186003)(44832011)(2906002)(6486002)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rh1mR16C7hSdhr9nIdKlfnD2eXTePVAzmQ8I/83g2FIzrcPy42+YOQAVQkl2FYZtP36wgAjzWC9ZrQR8L4zspkCpykK/nHDMUNYkqGml2TCwWrRqcahlc3tOWRGtEw8IF+iSxsrdgkOSHN7LkGSSSkuurl1RattHoZnBLbT6ZkwaakkxpwcdZnF0pgCxucnsc/2XNwJCvwyEzbO9X4hm06eH3SfgJFWkjRLpi56+gqhSNz11YF3ha18bNhGtLlQ+FpGxINWR8uQUrP6oBfEBCvc6OsAXwQV2d3g2w3e7e73HXlwj56ENnByU5v171QA1MV28tzuWAafaVuZ1uDS/8i8mfvPx1Jgx+WbBbHtb9WditXMJRzVIn+OYs3ZFrXHiq3wopCl6P1wTLDLHOkBAi59ir+8S9Zz/b8a6b56Sta3y1usUiOdk5KZTY4o+d0Q8y44IDTSl7jTQeI5fdbPv6oPlNE6/eymwpdEBf0cXNeMXHqXjJx3EVaRTxbQFAUaFOw6maqzdZtSiayJTbYFeyv9WybcSMxsoQo0X6dCAO62Q8QkmbCyNH+o0PZpJbwtu9fF6A7CSjt8MNifOuni+D5qYbKsdcskiX8o4tZB/jFprX83cFzZHbjCLRtaqSZysdWMmaQRczngbQPCdrjGB1Q==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4969492f-a98c-4425-7f4f-08d885817844
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:03:59.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of9Vi5uGBz+CE/HAtimn2Ev8fibzlre9HIT2HiIKANaUXGZcx5gy9ilUfZDbdYu1+L0ZxdUyVUnOftMmICQ9Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

ipv6_mc_check_mld() was added in kernel version 4.2.0.
The 2nd parameter was removed in kernel version 5.1.0.

time64_to_tm() was added in kernel version 4.8.0.

Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 backport/backport-include/linux/time.h   |  8 ++++++++
 backport/backport-include/net/addrconf.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index 3191047d..ce8a1b03 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -4,4 +4,12 @@
 
 #include <linux/time64.h>
 
+#if LINUX_VERSION_IS_LESS(4,8,0)
+static inline void time64_to_tm(time64_t totalsecs, int offset,
+				struct tm *result)
+{
+	time_to_tm((time_t)totalsecs, 0, result);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_TIME_H */
diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
index f1e8e627..67d44e19 100644
--- a/backport/backport-include/net/addrconf.h
+++ b/backport/backport-include/net/addrconf.h
@@ -22,4 +22,19 @@ static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
 }
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
+#if LINUX_VERSION_IS_LESS(4,2,0)
+static inline int ipv6_mc_check_mld(struct sk_buff *skb)
+{
+	WARN_ON(1);
+
+	return -1;
+}
+#elif LINUX_VERSION_IS_LESS(5,1,0)
+static inline int backport_ipv6_mc_check_mld(struct sk_buff *skb)
+{
+	return ipv6_mc_check_mld(skb, NULL);
+}
+#define ipv6_mc_check_mld LINUX_BACKPORT(ipv6_mc_check_mld)
+#endif
+
 #endif	/* _BACKPORT_NET_ADDRCONF_H */
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
