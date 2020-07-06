Return-Path: <SRS0=7wC2=AR=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F05C433DF
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A16B206DF
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="muikYcA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgGFI5w (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:57:52 -0400
Received: from mail-db3eur04hn0211.outbound.protection.outlook.com ([52.100.17.211]:62894
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbgGFI5v (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Jul 2020 04:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTDRPLgLRfvl2PPKsS/9743Ivf/FW7AVz2hNmQCbbcd0Zp4oMJ73FkYsNLXQ1YjpjmYVHPbX98k8XxggMQBLc/P8kIh6LCAa9x9YHhosXC06EijCbXmVu8WkOTmsGxHIepuqttWggIX+l6BtUHHW0aJN0FENZzGGEhH5TpEooQKpf9Gf6heGpN+DObndGKuFGynhZvP93De618C6+vWMLToA61UqDKzNiBn6oTRdCExpjYsZoPDc2xj8dyz704eXaReci9FKtEeekKmiJSJmM75W1k4eM92ecCUGofxGTRiQOZCabGt1vCLplHRYxxmHkDuQknaHWvi+kLusaHjDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/GVCNTluhGCPq+tL/mek1lTniIr57tceDq/32bJ2ao=;
 b=lx4pNr/W0Bgi+2ULI+ODaoNTWVkvyD6cYGrB1zcB/BmvvdzyEpy2HfPHKdzjDNwe9zRL9TH+5Yr54f/1EzjTmMA6tygKHtR7/k5gy83iUjtjXdOhwE+wrQHQXh5A+ZgkcVnXjMtsHHNuCD46hIk1z4Ew4d6V9hYj4KBpzaEkmv7z/FeQkOTprCeQZVuvCbXf12Ost6snfKjukS3KtHt52+vu/3WGt92urZ0rUTb2JfFUSJEgzYOjhvuRY5QxmyThFJJ/BUqqi28fKJzfdlM26GKylCmFYbtENuT/uDy279HEflbg26ABUzeoolqluApG7flbtNE+2cIi9WWoLHt7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/GVCNTluhGCPq+tL/mek1lTniIr57tceDq/32bJ2ao=;
 b=muikYcA56Xe+czrOe74N5vzpMuSj2aneTOGF2lPCiynyKgMkNoQEPHRUUuRVA0k2J+1N//ir5my19mbEn1V/FmiESaCjDkkmVomhY6IHhwWUe+HPJ77q4Shp1GjJF0Tk4m11ckgAl3V84xtKAsgRjjBce24DM1Cy7JPjzHl8eCw=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM0PR05MB6818.eurprd05.prod.outlook.com (2603:10a6:20b:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 08:57:40 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:57:40 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH] backports: make backports-4.18 compatible with kernel < 3.19
Date:   Mon,  6 Jul 2020 11:56:24 +0300
Message-Id: <20200706085624.515714-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Mon, 6 Jul 2020 08:57:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17a88414-2aa0-44b4-468e-08d8218aa385
X-MS-TrafficTypeDiagnostic: AM0PR05MB6818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB68180B00242921C3FB80BBBCF9690@AM0PR05MB6818.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(8936002)(2616005)(956004)(6486002)(2906002)(83380400001)(26005)(186003)(478600001)(52116002)(86362001)(36756003)(4326008)(6666004)(16526019)(8676002)(44832011)(316002)(66946007)(1076003)(5660300002)(6496006)(55236004)(107886003)(66556008)(66476007)(23200700001);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZKxmf+vx6aPrl4eDdVXlvwBv3s9StDmXQjpkN2TeUVZH1KEYabJXrfN8KZqMzUlpH77FPsvkl2kWjxEKpcexAPYEIptIMxLRBKr6LgzTm3lbifTQcHO4XAifftjk2ZH7tPm3mS3sNmi2YCL7ICA5/KPg6jUgnIT/Krhu6/kol8ov0pYHBOpuq4uq+JrJQ8rfQvEv6RXMIwNo0hph0PL/0p5Oca8Z/57BE1n4pjPXtC3WCfOXwxO3l9X9G5ELafHfdvfbWV60GFqq5vNoSTPg64+P9+3fcGa/bEA+Bc3pMe7LqkAMrkAUdzLoBQ/sm7rrIwOW8s6SEBFX17KEDQdwySr6KyEQ0HfN7zH5iy0UGXJ7QgYyXbTmbbKTp2S4Ga2Qt8Nuq8ceHoOF5Ax7VGSp4vzVt7mRI0pfObMMGZVoFmBndFKxUAbmp4RU3rjrrEeMeDu7HQa+c6zyqySwW//Zgi1ibzCHWSgID/N+JF8D2DMqTDXH6kLZ8DGxx/wYWAjNquxYN9+E+muzw1QagWXK81eZ3Cxq96kg06u7LtmSPiR1XRUOZNUh1RnGm2wowBabjB0IhGSjNLsHTQNiuAEA3k9KtCa6ZbDCxcJrUK0S264fxPFp1XacB5O0Sl1HJn8UrLFJJDTvXX9L4AOEZqTP+RTMsbngnbi+My73zLHhuiLGRSPGBbEKJbnXnfpbT5p
X-MS-Exchange-AntiSpam-MessageData: q0uq1deotqice/Fhhw5CmwXx+yywTU9h7t7Od4BCLeawMe0Ee2agWTuegVMGVCcCazosqw/H4RU9mF/ClGXX8ycVVYLbH4+c1hwsogVQoWVX8/j8GjreEft9EYfc3je+d5/Mun8ivA9Dve6Q4BdTyHiAkguUPKd3EGfWOaToZtYtzRLZoAol593eolSolQfRkNJOxWDbtPfwmgF2+6YN4/oiYbgnEeaMWBTs49G05ukJzRbR4wmsj83O55Aea3t0E7sOQMK+3w+m9vXKjfrg/YS6euRVnCdJceb0/gur6qLoyNECKVgks+gFXhnqcAb1lekZwRvZZuK+g0ntHIrCuup7q4fRNuLl98AxJweGKb1KPoO7yUNlWGwwrvwvhuJfpf7gOjr5JEzlNCGzQ+QdBU+b9HZX+EhqbsdxtQTZQZEpl/6vIW0+zRqec8zl1bLXEhFqaATndY+d22I9wKTTnQw/mJUfptlitt6JvoUYm3g=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a88414-2aa0-44b4-468e-08d8218aa385
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 08:57:40.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSh7CTK1gIOnfKPbku0HtXxUXnhdK1y0MKvn6/z2ZG1BgOTzzXn6mO2XYgJf6xEwJmjlXXJl8AEIrghGbeMVr312A/h99XKEIIC61dgXfN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6818
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

backports-4.18.c uses ktime_divns() function.
As ktime_divns() is not exported in kernel < 3.19, this symbol
will not be resolved on compat.ko loading.
This commit fixes the linking issue [1].

[1]
-------------------------------
WARNING: "ktime_divns" [compat/compat.ko] undefined!
-------------------------------

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 backport/compat/backport-4.18.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/backport/compat/backport-4.18.c b/backport/compat/backport-4.18.c
index c47fabe5..40551c76 100644
--- a/backport/compat/backport-4.18.c
+++ b/backport/compat/backport-4.18.c
@@ -1,11 +1,47 @@
 /*
  * Copyright (C) 2018 Intel Corporation
+ * Copyright (c) 2020 Toradex
  */
 
 #include <linux/hrtimer.h>
 
+/*
+ * Before the commit 8b618628b2b the ktime_divns was non-exported function.
+ * Add the simple implementation of ktime_divns() to use in
+ * ktime_get_boottime_seconds().
+ */
+#if LINUX_VERSION_IS_LESS(3,19,0)
+
+#include <linux/ktime.h>
+
+#if BITS_PER_LONG < 64
+/*
+ * Divide a ktime value by a nanosecond value
+ */
+u64 ktime_divns(const ktime_t kt, s64 div)
+{
+	int sft = 0;
+	s64 dclc;
+	u64 tmp;
+
+	dclc = ktime_to_ns(kt);
+	tmp = dclc < 0 ? -dclc : dclc;
+
+	/* Make sure the divisor is less than 2^32: */
+	while (div >> 32) {
+		sft++;
+		div >>= 1;
+	}
+	tmp >>= sft;
+	do_div(tmp, (unsigned long) div);
+	return dclc < 0 ? -tmp : tmp;
+}
+#endif /* BITS_PER_LONG >= 64 */
+#endif /* < 3.19 */
+
 time64_t ktime_get_boottime_seconds(void)
 {
 	return ktime_divns(ktime_get_boottime(), NSEC_PER_SEC);
 }
 EXPORT_SYMBOL_GPL(ktime_get_boottime_seconds);
+
-- 
2.25.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
