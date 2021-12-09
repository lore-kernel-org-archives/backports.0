Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC769C433F5
	for <backports@archiver.kernel.org>; Thu,  9 Dec 2021 16:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhLIQ3E (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:29:04 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:61767
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233101AbhLIQ3E (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 9 Dec 2021 11:29:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtx0CP9iFLHqQFWFWzICr5mKG86dqpOMHSs0UHTSfeKKP3xHy8/4Q+uIlAmBFwYbVDDbq4g68oekO73ovqCyZDM63eCIy34eUZ2SMuqKwagf/g82syk0q6JnDOpcKWbD5+gVw8j02a3Z12jIKkjZ5UY6MKCH2GaDMIIFuGsEy4HusvrqJvYnM4ENDUcMy8dCPIWwwrFvIQkcBP25qcTVzhA2OdFsQIaqjKKs3qDNPAVBKYB7uKNFITUdhF7uk7LyKeulgnt/e8iiVCxws9YzZEiNknQxNC4V/L2oxmVQNHy+N1p1r/B+0Tn5I0ZkriVuNxySrplHil3vC68fxxWh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2v52TqgCI5iZzIoACDfHXsyUtj6dSXA2Bst1l0GYf4=;
 b=V5MKW5A8x1sHUXslzwnrwGXPZcp8fDscEheCPS75JSaoMmrWFVl9C6Q70pKkFLG9QL0nb2pL2ixLcMC9ll/TZRcZa8ntRaBV9IJuNebAQrwp7NVP8yROz+S+/tt9MruH3vs8jxZ4BmhHHG9RKYvFlrsWl1LUjw6nzbbI1IdAFd5VGiIlrFipeoNzGPqGPJOaep0RyljaB4mLt/julTJOa+yksvq5MIDLUpJrVYdIru20uG7kvaSUbkkTHHDxTtlp4BR5dxSdK+P1nDPfzh95Mohy2OkXWemjc0pTy/XdomxaWeIufAEbwEIpZaVmH5YBriM9kc6j2yW0a5a8o8NQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2v52TqgCI5iZzIoACDfHXsyUtj6dSXA2Bst1l0GYf4=;
 b=ZUFinpDW95VXIIpQlzbVQwYIJwyCmPEtQnP19whfDZOKNpCvJt9gTdZeWvUA2iHWiLLBeIP1AJvbuyTs9x2dzkXirMgrTO+uOmAXHD4yBgs1Eek20tGA9OhDFjIFsG0cHygw8BT9x/wBoSvKnB4DJOjb0VzzPutKd4S3eYrGD+7ASsOjdWaaLayYWaOT2o0OvK3jFm5i9oGpSD7CYqlMoCd4QjR4BucZjblDKJn7Y6RSA/tstXn4u454nDw3i0JzTTZuaWo6n5XvtZa2eS/L/+csF4mjxInadww64FGzaazKcqNkXhVjHFkhayDS+4glYZWIswC/Rh+5Xa1B5nFa2A==
Received: from DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) by VI1PR10MB2734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 16:25:28 +0000
Received: from DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::c7) by DB9PR01CA0029.outlook.office365.com
 (2603:10a6:10:1d8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 9 Dec 2021 16:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 DB5EUR03FT035.mail.protection.outlook.com (10.152.20.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 16:25:27 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Thu, 9 Dec
 2021 17:25:27 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:27 +0100
Received: from SI0SWIEXHC02.bsh.corp.bshg.com (10.49.76.142) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:27 +0100
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) by
 SI0SWIEXHC02.bsh.corp.bshg.com (10.49.76.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:26 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:26 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad%6]) with mapi id
 15.01.2375.017; Thu, 9 Dec 2021 17:25:26 +0100
From:   "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
CC:     "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Subject: [PATCH 1/1] backports: fix build on recent v4.14 kernels
Thread-Topic: [PATCH 1/1] backports: fix build on recent v4.14 kernels
Thread-Index: AQHX7RlfrSTvNb6OekyFkQtwQz+dlw==
Date:   Thu, 9 Dec 2021 16:25:26 +0000
Message-ID: <20211209162516.25022-2-sven.dembianny@bshg.com>
References: <20211209162516.25022-1-sven.dembianny@bshg.com>
In-Reply-To: <20211209162516.25022-1-sven.dembianny@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [10.49.85.187]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c56b80-5ad5-4274-3311-08d9bb308308
X-MS-TrafficTypeDiagnostic: VI1PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2734D54DDAE26362A857A60AF4709@VI1PR10MB2734.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtLEg8hhAUME6O7QZ4007jBbbbFh2WD76keJilyuhZ9COOwdPtt80oAyi2SRtgnGjNNDHaEumSSitWeUG7YiWewrlTw2/9ODsZsCEDPmub+qzaNzouzUZR7fonNvoW+d//f/OfkoSh1zouutoPtwHQsz4hsJyWyCCYfa1Y5uoC48vcSw42vNKYHJaW3LFuUyyARebojJi4NNT6juoTgBjm9CP1TJKGlRIPzDwq16JlVE8MIwO0fGLWIJiKDucVmvU5oUtPaC5dLMqVag5jU7DbUd8w/6xwhnqx8jPi/mQeuqvsNZoY9r95zZtIJk3VtdzEcRqOXPg6FbnSkNBvOmUJMfXHgR5lYk/xKrDq+KLx4x9sef4earW2tAExaGCzWWqiV8/2wPRE+yB8+UxBjJSIpU7UbnNX4ykDC4AbpXFOmq4kClKR3BTEUv3wXbhzChEFORPfcbYnKy8slbtM2TuD+DO/zjAv0cGLoBY8X0O6mTmCRhdHPKDa0uWOHCiwcIwzOVxwx4vFOtJMYEfXj4C/XKwFrfzVh3PbzjDmkPStAiiDOlYl4pr5vUp2fC6FI9blAyCm/D6HK3S1ysXEhWbtr2ZEd0NB+iSRrJindMNbYfI6lJ5/yVG3Sh/LQm9QEuVjcI4YX4mj8Jxe9mnSNPJRSdf21GxG78Lob5W9fRg5S2KEC676YZmLTglny9zmSxI6Jx/ZZbOjnOG2cFR0GALJDnV33dRd/lKn+xSIX9AZq09JS5f685CX7wXG5zrGQlY9987F4AeCwzzAdc4XkR2cwKuJBZ4jcSmQnDBEdCEpQ=
X-Forefront-Antispam-Report: CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36756003)(70206006)(6916009)(70586007)(8676002)(336012)(86362001)(36860700001)(2906002)(316002)(426003)(107886003)(356005)(81166007)(82310400004)(4744005)(40460700001)(5660300002)(2616005)(186003)(26005)(8936002)(508600001)(1076003)(4326008)(82960400001)(83380400001)(7696005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:25:27.9714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c56b80-5ad5-4274-3311-08d9bb308308
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2734
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: "Dembianny, Sven" <sven.dembianny@bshg.com>

---
 backport/backport-include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-i=
nclude/linux/skbuff.h
index 1fd25fcd..c5015e9d 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -62,7 +62,8 @@ static inline struct sk_buff *__skb_peek(const struct sk_=
buff_head *list_)
 	return list_->next;
 }
=20
-#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0)
+#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0) && \
+    !LINUX_VERSION_IN_RANGE(4,14,217, 4,15,0)
 static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next =3D NULL;
--=20
2.17.1
--
To unsubscribe from this list: send the line "unsubscribe backports" in
