Return-Path: <SRS0=7wC2=AR=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA0C433E0
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5BC2053B
	for <backports@archiver.kernel.org>; Mon,  6 Jul 2020 08:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="qfEHQDLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGFIUZ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:20:25 -0400
Received: from mail-am5eur03hn2231.outbound.protection.outlook.com ([52.100.11.231]:22242
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbgGFIUY (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Jul 2020 04:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZS0BcfV5TU+uC0iWVaGQSmpyUJpsQ7TnEdqkWFfipJw3zbTy56tbCL55hA7RRfMOZGY9i+n9h7WDhxkg+26Vuz8YIrp9y279ZxecRDMTQgK+HOz276gVLLCgYYLbY6q2x3mDuS+HbqwECIMGkp6A8DWN3DFHk8TqfpDQTrU0cs/5GuLOYyw4sgtySCqeWp052EB0ZCScO/sCyRmyWFU/BT2uehJUOYpLORMlw53ZhqiCCu2IssFBDU6vekvIr6aKewI9J0tSxiOUbmFxlgFkDWaDqdn8T5A05ccPz4MZQn9X78BQSzsjgHb9AvvuEfNANkPyQ9rJURxoLDBD1+a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rulT3IAjcVKpRkUpjWrYi3aGVlqPI+q1yDXoPHZoqT4=;
 b=XrxWIEe7UnlSmBOKedYrJnR9jnhubg1EHMUK1Uf1p25ir2p1IhSsjkjTNFem2onqtqZluU1tT85VZnd2RwFo1bvuTUAYWtjiwnhRNekcfkyyqGKxcINnf4cAZ1+KHq2zc/2BULs1aMm8yse3l3d1ApAIHKvA8Sr8KcxTIePy6c2RZZYrxwPY0t7lmylW2arfKD4TaVyLLLmuZLIPahodMK8xVHQCGKLLUZTbvTTAC177Go8BbkcJ30M9qCptZk5ZUwK8gwMfaTNaAJ0CW5vyajDapi6dGRoLQkdf7rjM2x4aECDTqEU0RxxtFfLqM/Ci/sFLsP9O/i2iiVL/qSSsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rulT3IAjcVKpRkUpjWrYi3aGVlqPI+q1yDXoPHZoqT4=;
 b=qfEHQDLlkfhWinr7Gh4FoCGPspI4b+wazgjtp1Eavp+KNW1IRCx/yFpbuT9z62MPJIVXbqQzfcAtGK4466FJQkLPS3rLnYRjOYq3Asm2XjaXhh95OZtY5VfEb1idQbkUL7Yg38qbTCOidXEjxzLMv8gfPLg+xzPDsTzep0lqoxw=
Authentication-Results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM0PR05MB6754.eurprd05.prod.outlook.com (2603:10a6:20b:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 08:20:12 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::cc9b:ebb6:bc86:23d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:20:12 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH] backports: add missed dependency
Date:   Mon,  6 Jul 2020 11:14:33 +0300
Message-Id: <20200706081433.509052-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 08:20:12 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f88184d8-67f0-4714-a8cb-08d821856778
X-MS-TrafficTypeDiagnostic: AM0PR05MB6754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6754620D16DEC1243E0F1ECDF9690@AM0PR05MB6754.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(4636009)(39840400004)(346002)(376002)(366004)(396003)(136003)(86362001)(1076003)(4326008)(5660300002)(478600001)(316002)(8936002)(83380400001)(107886003)(36756003)(16526019)(186003)(8676002)(2906002)(55236004)(26005)(6666004)(6486002)(52116002)(44832011)(66556008)(66946007)(66476007)(956004)(6496006)(2616005)(23200700001);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iAjhrAZGx2YmNAb31aWcJ3/juZzx5Y6RLgLJEVRzbYo94BOB+0PgVWYsWYqP+FzXOqAGsZwAAw1Rey2jRgmmvXWc9t3h5E5p+Y9d7KvCaOzbmBpPQCWsBfKTE2akdshfwJtktxgv015P9S/RDjIu7/uEwWZ3CPWJLQD+1BG5SSs0sfZnH6kKzHDzvAFv+rU8MNJ5sHFWKKeTrjzm/BVv9nCgz2M63c3kW3RL3pkwKcjZp2kloZmf0Pn68qbuAy4hh4Yo9xBFw/rxoXBsCD5YK2gFKLz/vkEZ43br1PGVJWV8CX0q+vDPFTuG4qVKxCufDVJHsso0UipyyS5NSjNRIpKlH7SbPlCMIoTbGozZOde4fYSGgGRvexeOeeuA4Ga7OC1V8GhTgnpGveeXqIVgoZsr/M1uGHbFbxgls8e0lzsVIodJ3Efonf6dd3zLxo928HeIqk9qGpUtuqwZoEp3ueYNOmx7TFPtAZM1Jy5APj5jMI8PO1heHV44zR7/jVrHr0aYosEE3AUb9AiUTrNlCOxophSv37Ou7VseVYMftwbwZ/3NmeFGgKLwABmSYCr62t7G2f5J+m6F+P8mhCTB1MZLwEBROfRBb2WujN99GCU2fdg3pQ9Eu9ptrlgrT1NXvBMJwjVpOhhYRrzsfOCy4EeZrIH/ohnJUhUskSx38MgqTn2Hked5hs48ET6yFd/
X-MS-Exchange-AntiSpam-MessageData: kTGSZU8H0ySn9TyS6wXxGu9J0ExIsPDQPOgK4En+5SZgxKCs4ylhaCTsRPTXUtIhDNhZPd4+P+wrCmXNvTxuuYMk4nkc1MYcdLAej9JLJjo2U194SkLqDVcJfBXUjg+1/w+VNUU1AqBnSPMv3kuniOodm3tkOZmiN5knEh0fWbVssWgNU/BZs/6cap86sInhSP5w7eGWnfqbXLek2dJNB3ABVaBF/HBCZCbse9oSyUhJapK0cNDAniAIEJ+mjU0o3fyya0vinxrYsxX8J3YMqkOBmjsf1Mlr8k2y+YzlT9QeI5VyUJIxAP6wIccTJV4In6CZmyDzBUZBADaqSPZbH3BWKWmKhXXvEMry1FSf36YA1/vRrYd9WElDHmTeD0hHNoVbxs8UVZZn7pZtKWB5Scs9IErwyfr8WAwnZBfmyzneON2xRB3bULEbtfVSn2fvWLFg1A/ogH66dHgHIQd1YIQYvaqr5fVX+JaU43ll1Zw=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88184d8-67f0-4714-a8cb-08d821856778
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 08:20:12.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7/q7TJeWRD95Y+D4OlEQIDnhF2rB4ER0wm+pss6XNVfglBHmsuIXBoovHOb0bXS0U9tixNibSOrHeaGDUALpnRB5oHA9atglVG1dB96aIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6754
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

verification/pkcs7_verify.c uses the hash_algo_name array that
is available in kernel exported names only if CRYPTO_HASH_INFO config
option enabled. Add this dependency to avoid getting late error
on loading compat.ko module [1].

[1]
---------------------------------
[   12.645547] compat: Unknown symbol hash_algo_name (err 0)
---------------------------------

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 backport/compat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 3af729a3..c9b311f5 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -149,7 +149,7 @@ config BPAUTO_SYSTEM_DATA_VERIFICATION
 config BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
 	bool
 	default y if BPAUTO_SYSTEM_DATA_VERIFICATION
-	depends on KERNEL_4_7 || !SYSTEM_DATA_VERIFICATION
+	depends on (KERNEL_4_7 || !SYSTEM_DATA_VERIFICATION) && CRYPTO_HASH_INFO
 	select BPAUTO_ASN1_DECODER
 	select BPAUTO_PUBLIC_KEY
 	select BPAUTO_PKCS7
-- 
2.25.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
