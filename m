Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82612C433EF
	for <backports@archiver.kernel.org>; Thu,  9 Dec 2021 16:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhLIQ3D (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:29:03 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:44526
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233101AbhLIQ3C (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 9 Dec 2021 11:29:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acRuG5qWqsjCNEkLzKPsQJDOmywhT+gHvAI7Ifsyq1bby9XrMerxxnmU+La2BtT3VWjioh6Ll+lBQ6pAK0rqSrK820K+6QbnK7V+dfr6csI4GM3FZq642h9vItOIJ89wZ3AT61b9gGGCIdExskDIY0WOqxz8lwqXYS1BcqlaL/gGK/Hy7T35JHLMNWdKmudYQ9adZ2dFryxPd3hwGQmRVCi5zN8O688++J+Es0G+KD1jM+SE1AWxyP+sBVdS1GYV2QfbWenKQED8vRNt6GsAfos8HDL9EBbpPyOJ01o8NHMeZ1lqb9IBZexv22ybkCXrpUWHIvhomLr30qqUugS2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfH9T6ha2iKOa1cogofj6XfXsuQdslaoGOLxRZMWp7A=;
 b=nDt9nRtnbPpV+8Sn1uu8scxjvgbld2QhsoNR5l0yodNl7F4P+5cpOy3nzv2d9CVHhCme949clAd2w9l6/PJJBZq4+hiO2IDuvwNwsf+1s51xFvDVYTHpFU8vLJF5LnKn7rPjNcMKYQ+oVowOQV/chG702h/yIPsA4peaBnOI2i5f0D48dco+iw2ERm+nA8zLTKN0WQa1SH2I20puNkRBuTr5pCIX9X/UFXQomFuzp0OvCaT2mfRJWXBWFHxvcKja5Py+Buf4GWGfGL2waC3Z+OqmwmDSBy/fNUv40Jhd77ahDW//GoNewZSUlfGmR6dpfvaeyz9hLddSN/kqN2QPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfH9T6ha2iKOa1cogofj6XfXsuQdslaoGOLxRZMWp7A=;
 b=YsJFS1qg7BCjbC5BzqRY4X7fYpAw6uc19q+hOmZiDZsZqhsp15K/2jVy3+Go7H3rT1JqLktk7kRjdbRDGxPZR72KDdq/TdiowL+Xg1F233mJiBNUxlQUsamn/iqLx2+WD6I6TnO8Q5yTuhts1pEp6g1hA8IdLDrfwL8D7ixjOFupn+B99XoiTXM8tj7es01mqfk/3WocJdgDO/8hNimBGs+D/13Vyu+Ara5cpCQix3ZfP9K7JJ+YWB67KhksqNFsuyUoksQnJq+FgSRdkhkWiEYGIVSwTKXdNrga8GTe8ZCBssHTeIturYivPt+1RbIGgMk3NWColQgEVZfZYhEaoA==
Received: from AS9PR06CA0330.eurprd06.prod.outlook.com (2603:10a6:20b:45b::9)
 by AM6PR10MB2887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 16:25:27 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45b:cafe::1) by AS9PR06CA0330.outlook.office365.com
 (2603:10a6:20b:45b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 16:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 16:25:26 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Thu, 9 Dec
 2021 17:25:23 +0100
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:23 +0100
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:23 +0100
Received: from FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:22 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4D.bsh.corp.bshg.com (10.49.78.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.17; Thu, 9 Dec 2021 17:25:22 +0100
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::81ac:4f34:2616:9bad%6]) with mapi id
 15.01.2375.017; Thu, 9 Dec 2021 17:25:22 +0100
From:   "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
CC:     "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Subject: [PATCH 0/1] backports: fix build on recent v4.14 kernels 
Thread-Topic: [PATCH 0/1] backports: fix build on recent v4.14 kernels 
Thread-Index: AQHX7RldU0QYmAkX5kqKjUie3Pwk4g==
Date:   Thu, 9 Dec 2021 16:25:22 +0000
Message-ID: <20211209162516.25022-1-sven.dembianny@bshg.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b2a0fdf-ed51-405b-f65b-08d9bb308267
X-MS-TrafficTypeDiagnostic: AM6PR10MB2887:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB28875B6CED27D551983AA5F4F4709@AM6PR10MB2887.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCjegrct9PZRXI38ug39hTQUtNmqglc2fxJmQImdsNBmabTuCkL6l6iNar6uECc7Zu+BQLO+5uRjV5anU6c1Xte/ahizCxaPTDg+fALVeO9CYsNr9FrvdMYusb8adU+wp9H37N1pl0UUodZiUPAEMbVqC/cjSIqk2EjcuBBLkzD2cIYSRyTCLjAUWp5lrxUhD38OlplopkSSSpGMD4S8AInORbB8mEyj6GykKtqlD8bxaLdxMVuXpppQRQZ2RuwPUdFIj8YQ2LxaOo5ocTwSzBiE9vALGUBF/Cwxr4wC7m+mzxG+b9nbd1p3N8F58gWzVTtqJ1nSt4lN7gJYaoBh1lfd3Ty7Hrel+XpUFuZq3qLFaul0SohLawdAxaGBAj23Op3spdnerX1yNndn8MMyFV+R1V/VPw15e6qxaY/3xXtoUtTHjriA+K6ySUEKRXumyzRfm/sl6i3DyMUQvn5mn7xkTVfx3oyUXmdIRT1ZOscSTCkCQv/hRFmi+54gm8C1inFrvQKjIFJzv9HwbNUEi8gP5BDf7Hmj+PYu3NCfgsAcGsCaIy4MBiQM5IUkDfgIoWM+szoS7xLX0jHbWCK5pclGdZs2xDsqbrRpXDSFEwFwb/9RP8fB7DgtVvKNklvw02csWXoLCn1a78wOklV5oOfWIuWSjxBssFS3dYLs4BEkxAGlNck62PQkPiJQXgrCtHzYH+UzrtDkupvcshPcmJfSs7YByO9UMP7EteYPwRR7B5iKzNQdmtyvuqvSO5pjeg4j9+tzWUT9totiKE2I8HdTNLZMPFe4r/OShGRjSjA=
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(426003)(70206006)(36860700001)(186003)(82960400001)(508600001)(6916009)(4326008)(316002)(8676002)(4744005)(107886003)(336012)(86362001)(8936002)(4743002)(47076005)(2906002)(1076003)(356005)(81166007)(82310400004)(36756003)(40460700001)(7696005)(83380400001)(5660300002)(2616005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:25:26.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a0fdf-ed51-405b-f65b-08d9bb308267
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2887
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: "Dembianny, Sven" <sven.dembianny@bshg.com>

This was found while backporting kernel driver from v5.10.9.
skb_mark_not_on_list is defined from v4.14.217, backports would do a
redefinition.
Had a look on recent v4.13-v4.9 kernels, seems no adaption is needed there.

Best regards, Sven

Dembianny, Sven (1):
  backports: fix build on recent v4.14 kernels

 backport/backport-include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--=20
2.17.1
--
To unsubscribe from this list: send the line "unsubscribe backports" in
