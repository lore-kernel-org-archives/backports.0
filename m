Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFEFC433F5
	for <backports@archiver.kernel.org>; Mon, 13 Dec 2021 10:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbhLMKj1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:39:27 -0500
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:39985
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239737AbhLMKjO (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 13 Dec 2021 05:39:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3UawKlidZy7dYonDt6sTTQHwZdulmTGEh/Hl3vcQFGIo7dmLWG/9PSgSy0ikldLDDejYyVY5AF2vvQeE7iESoPPFv3IzYDgwuRhLqkR82ieXEfPo61Sbvat1B1XqvNpjvYvUbsnUrchvLLiK9/iC9CYWhMzUnt7OEuhQLjp3djSt0bFQhnOk4mQSGgleWuFhk+IPjXn405d3evGiQH+r60PIB29s16w9CTlOpiFjMmNn84T5HE84JUO9+BkEnILpgnX6GLt5TAhoXMWgJIzHveVAYrV9WxxjcQnSUHmiqAcOfXKaCyV7yHxRm7DasTm0+9Qq7mydvQhMgifhBNRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkn8lO7tjBkYZdXrgWvLynqcsPngtVr6Zx12axEWmmo=;
 b=FZNxy33yKzXfNJgBhJdDKaqbiJf5BT0yboPmllj+tes+RaTdoOk3vctqaWGl4harowfQuUJRNInlArrPckJJPMui5Xdq2X7J9hqhltLutGuLnxbH3/eyyN+tWrPiNmteMNGrsifFC9pSd+OB/iOEb7kbfjrfs75vv0go0g5FfhdWki9TvoHzbJC4m/kITCv5LoQ+7zIXUZtPk4RXACXaDI2nCLYmxRb32Xy5JvRySiuw08QOSxM+FUQmmmJsgYG1qQdWKSisBN2zCmv3jEws+culc4B1fmGFtsIn/K0NNfwZykY4I5g3ki4i0gCs43ZTyKN5zPNasmIjl/v+gGLkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkn8lO7tjBkYZdXrgWvLynqcsPngtVr6Zx12axEWmmo=;
 b=SSVKYqZ0iir8SeJhgkyDw4nrSF8nwao71CykLo0tnHrUV9kMykMx/q2m+W8HGUsMM1+vzj4oDnpLiLBIdtbh1Kvtn8awByeBCa6+utwXMs/9ZwMT/Q30fxQmq4vR5YrXOJUa29sxGNges4fSP1G92xlfe99TK7pgQWe1l4Kex7wllBb1t5VgTGfJCkT9VOdY9EuXCf4TS9r29RUGbPPPdj5F2PsMhcA34efWHNhLCYEc+1aie9HD84v1ziu2uS/NqmIVkhAR4QG07jYw8bQWvYVn4F7YJJ/yT0ILQSvhffIn34uVsKyDBSGhqG51bnruZptYoXqXWv0O08Pi+DKpmQ==
Received: from AS8PR04CA0182.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::7)
 by DB8PR10MB2937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 10:39:12 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::3a) by AS8PR04CA0182.outlook.office365.com
 (2603:10a6:20b:2f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Mon, 13 Dec 2021 10:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 10:39:12 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Dec
 2021 11:39:07 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Mon, 13 Dec 2021 11:39:07 +0100
Received: from FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 11:39:07 +0100
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Mon, 13 Dec 2021 11:37:37 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Mon, 13 Dec 2021 11:37:36 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad%6]) with mapi id
 15.01.2375.017; Mon, 13 Dec 2021 11:37:36 +0100
From:   "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
CC:     "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Subject: [PATCH 1/1] backports: fix build on recent v4.14 kernels
Thread-Topic: [PATCH 1/1] backports: fix build on recent v4.14 kernels
Thread-Index: AQHX8A1yazH2vhvI5kCxkGOnKALA0g==
Date:   Mon, 13 Dec 2021 10:37:36 +0000
Message-ID: <20211213103700.14935-1-sven.dembianny@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [10.49.85.188]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4db668b2-2844-4fd8-cf94-08d9be24cd5b
X-MS-TrafficTypeDiagnostic: DB8PR10MB2937:EE_
X-Microsoft-Antispam-PRVS: <DB8PR10MB29371302B4C441B34D3158A0F4749@DB8PR10MB2937.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAVzGnBfcRbAKIi+3mlcH3z/bif3cKEhemxETkAzCvfeJZJsNzw0yPsQHyZobicYKAcBJdCt5sw43DofeFLBBd6ukmQgAg7IZdlbVtXXFpxw7JmuYTc5VMkVJqvzKrpnTZAAwNWTJXHlxa+jWtEJ+mFwGYxigxQuK3b84jLzBefcSOAGYrPRHSVAd38AF9wETNRgNzAgXCvJDiFu5EgnDnnY0mV9vb+pyhKmdHdVdQW+xciVBW1uFW2fRkMsLhCSNg0OUYDSfIkjZjkgIFvnk+pZr50OKnD1Y6f2ec1B7khnAWH9A9CBqt3m40k70CS+YAdIPrn8wMGhQI4vNRVlZTQ2eVS00afpy7YRNgJUhELdcKv9B0rjK6049/505Nz9k5Xo2uexuUcwPOMZotAobQJTqLya3QaPYgerT9GABMq/WXXIICocNtinTJt8koBQLhVZJL8iqLryuEXSgkpdRggFuL6xkdWyZ6SlpWoeE1tf5TKw/Aa64+WGwq8r4Kf2YhWekixWlNmBbJ5cJtpjlzdXCDa/uzuWM0rQDeFiLUQLJzi5Vnvb5uwmIsv8x3Zbi3GcNtnRVeVxE54VszQ0OInl1gAvnuOkHQwd8WDCpKd7thW88dGrVfJZu7ZZzwYvXoWKWP/kzsFjyfQW7/wHgY+6g+M78hEP4OuaNsqlK0c787ZdHN6GpSjcePQh9VI/KOLuH2yd/zuixsD0ioirUbnSOJswX7pGhxGKc2bgbKbOAWiJDrBVx0FjJSv6YlrPrNGBSouw1GFlZugQMHiKS6UT4kp6jQ5vC9DjeN/JMCg=
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(36756003)(2616005)(5660300002)(107886003)(40460700001)(26005)(1076003)(186003)(86362001)(508600001)(426003)(81166007)(4744005)(6916009)(70206006)(2906002)(82310400004)(70586007)(36860700001)(82960400001)(83380400001)(356005)(7696005)(8676002)(47076005)(4326008)(8936002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 10:39:12.2300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db668b2-2844-4fd8-cf94-08d9be24cd5b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2937
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
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
