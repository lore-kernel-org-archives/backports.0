Return-Path: <SRS0=7wC2=AR=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13656C433E0
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49F02074F
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SuP8cOFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGFIvD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:51:03 -0400
Received: from mail-am6eur05hn2239.outbound.protection.outlook.com ([52.100.174.239]:24511
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbgGFIvD (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Jul 2020 04:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdthIF59Y/TxeBgTWB60AtNDoRYxRe8Chu3Nxr5S4EsSfNPbAx/VEzMYUUbDAI6NCAv6ugIpxBE1ibztZp3wuGERNu32J/JHQsLT0+y3q34qlCn3Mgy9cqszziBQ8067emnSHLABixq1GvjNdhL7SWxbCPC1NhP2qf0wjewSQ0YeG7ij6SpWLR0NXsg1RClMLywlmcv4qHW5Bl7CW8KERsog1j630v4JXpFZRUv+zhl0+374txZbhQ9X106llNpyKmHtomGUf+eVULxG4BhBY9A/8Oo6QCtmicVs5rqTzcXns1yUldjw92KTz0bmWJ//5++mMmQ0ShU3hRMldd4zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd3YzCtCfzHbBgLkGXF1kfyCgUaBmgVpiYfXrcjC0h4=;
 b=kHoym3NgGwrgJECoGSx5qLeVC7aDRSYvec18yJWOMOwAdp+lTyCIebrt1vUKbsGTUqdr+0DmKy3ARzGox7iUHu7jXEaVjEZbWOCQZ0DLaY7mLMMX60nVnCS3DPBlhrSrJvYgcYfkqYCp374Ytugwgx0dQ89t39bHbGdT+q44YqJLwQIRQrVRkqupWGNbRIm8jnWMWdmbhPXXXbWWgdJJgcVFaBh4iqJXAn69LaxzymSeY+zG5HR5CXc4XZkHOMP8GV4197VUsXKu2e+blhUoO47vnAY6EU1FZ6ChkiYNiI37JtaGeIapNULOQC52R/CzVLhTGkRb0Q+z8Y7OPkOPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd3YzCtCfzHbBgLkGXF1kfyCgUaBmgVpiYfXrcjC0h4=;
 b=SuP8cOFxNn1RT1moEXxuzMLTW9N7sIvAb34o/Yn0HkmUAP53PAZ7ymcs8oxju3hhWYRr0ObqGKNrtLRFiLIaUaNBKMIJgu60G3QJLZkq1jn8ID9ubbcsq0qrveM177bzFX/6h1Ob6MizMM5uyUfSvKK+vBHo+FFfkUuxLP7aKjw=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM0PR05MB6145.eurprd05.prod.outlook.com (2603:10a6:208:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 08:50:54 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:50:54 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH] backports: add lock_acquire_exclusive
Date:   Mon,  6 Jul 2020 11:34:00 +0300
Message-Id: <20200706083400.511726-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::42) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 08:50:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb64ffd-f2b3-4597-d0a0-08d82189b149
X-MS-TrafficTypeDiagnostic: AM0PR05MB6145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6145B01132F8310B0F7A4E2CF9690@AM0PR05MB6145.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(4636009)(136003)(346002)(366004)(39840400004)(396003)(376002)(478600001)(44832011)(66946007)(6486002)(2906002)(36756003)(66476007)(4744005)(66556008)(16526019)(6666004)(6496006)(1076003)(107886003)(52116002)(4326008)(186003)(8936002)(86362001)(8676002)(316002)(55236004)(2616005)(83380400001)(956004)(5660300002)(26005)(23200700001);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsiPfv1msJ5jNAnp7trPsKHqjo1QuZVWCnvT02WvhhQqFSs1Qz2Ge8/N6XxEAYX7HAE6YZnAeMKYFpI4FLxKKNtmWhASX3i0GVEu8w/iFcOngOq5OibOXjmkJto3O+M/pxEs+GJTxCFhuhEcIHt7Lsg3NU+Kx6kMdYWRXTRa92jo97aCjYdDib/Q2lg4nMC3Oeg/1O5fLRJbZxBfZaOKsKcAHWBCtl9jqB2V3JjRwxNPy0kwmhndQsKRXfdh+yaon46bIqkaja4LzskjkNhx68MTNi+5rEF9SZBGo6AKe+VQF5XUX8E/0xeBkrU0SbvjpmCXnuhQn82TX2rI4gSOVFH1KiTI0VZGhmeFFpji/uRo0p8dSzaCC2volp9jBV1th9AOTwynwDfezZp3EUI3Y55dA9h3lor4APbkaw7qXCP8C6N+WPh0MnYPu6HUVB8j1hpZe/qaWEvhT8j1ELMWg/i5gDs3TcDikXmd8YkwczidehSJGszsxlITMTS8/nR7p3wdpSMCBvCjhYRyJmYHKnooolGJl4DfbUSg3I5MbEaD0vo9PsToJii1rInbSYdZ/RSzUk6vtf9TtEkGYtUexHyiHSiVuka4EdgntyTe0zqZZsbzuN4QFc+BNIOaHqhABaUT9cnSYKZOYq3UUHg8M2bKEmN7u9cAWcO6EJlnmOFFfzZYhKmil70FPBnEZL3s
X-MS-Exchange-AntiSpam-MessageData: VyiX65bwHmnrMRUFY5m1Yu/Z8WkC0/8FsagT6NHtHhxlHqXm/Kn2WcEa9RikrVG7iOb7H6K+shlhkq1At/L4RnVGgvZNFM17sEMm5ofyFjFnl0WzTzF0RTeRrRxtiHDkg26ElY4YA8ZvfeiZ1rUqCHN7sv8i6YsrH6rHlotuT5+1uFUcTLKSCK8Gg50CJ9honbxBAV8/53H3CSYLjB+gWyEujYLQunP2hAAByCv1O3Bi+SyfuTTAK6I0QuL4oHuwOOFR/Vf3l0ZT73vSwtKRE5ecwfcF5rvbNN3U8+mQT87U5VhaKXcnavhR6WT1UlgrTlqt5/3WCST7taGdJ6wnF/FUmNQs6gIlprm7TUkJ71xYKO/rEDwu4xpa0VCtAqtN6CtlYA5RK/OtXd43hTdGSpa/AiHOXRqm6uiUJU3bXr/rEEOwgG70aXClGBqyLetVRAVheAG7Qpxn+E5Nslxei54dfLa+CTicctDPEdvq9V4=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb64ffd-f2b3-4597-d0a0-08d82189b149
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 08:50:54.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSr6W0vvZqd9tu1C/x+Uaj2w+29RlXH6GAwgQAtrvYJCeHO7wjFIcJn2t6zCVosDBTcdbPORtWjT2789gKpt67uBufj0DOItqE98+qoDQAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6145
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Define lock_acquire_exclusive() macro that doesn't exist
before version 3.14.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 backport/backport-include/linux/lockdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 12b91b4f..17c8ea16 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -3,6 +3,10 @@
 #include_next <linux/lockdep.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(3,14,0)
+#define lock_acquire_exclusive(l, s, t, n, i)          lock_acquire(l, s, t, 0, 1, n, i)
+#endif
+
 #if LINUX_VERSION_IS_LESS(3,9,0)
 #undef lockdep_assert_held
 #ifdef CONFIG_LOCKDEP
-- 
2.25.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
