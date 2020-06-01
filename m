Return-Path: <SRS0=+NTX=7O=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B5C433DF
	for <backports@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4E3206E2
	for <backports@archiver.kernel.org>; Mon,  1 Jun 2020 09:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pxkd9Guw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFAJTu (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:19:50 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:24006
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbgFAJTt (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD1dyFWCksTEzHIS6pBaNEQGedB3Y2XBT98AwvjssnkSDadJXmxxDH0JaL4MZ/YQITbjMBrwp61JqEkvMLhzaujYB66GoGsjrt6JfmcljAPBC3OS2YdqyRvRWxW4kb684G7bmnsCMp4KRnzwj5HMf3VcePpYuLv0hS+xjjLYX4p2fODgx0DR0KEt8neDg1K5b/zcQeGOPh9DEkrRfmBaRm+kP0A8JC2rmPcDOoPNt+SFI86wsqjy2xiqsSP22dhbuPKa1kvAQZcLRyFW917ssYm6OKmBhDY0lYNfQAtNMvs/GWoOTMlTb3EynG53YiFIr9FNhhC2FN7727pu3MWJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+SHlEusme8ze+Trs9Yy9iH0WqrSxyltGslMdCPZzvQ=;
 b=G3SF3HZJYLr4YgN6pIxRrUVEYHFd9NVSfrq76TQR2KYJ1+T8LMQyQhaDKNocItWIcolG88ZA32G84yPAHAXOhcgnWFvFom6HzVlopOUjOhLjlmDv73dn7coKWwNEHf+d+PPG6kh97jrT1WP3bGPZ52xVabx0IEjxvhVDovkgyLk3Ngl7e3AppIVZ2djKXhW9jzgtbiXnrKCz1o2CcdXnvJUox5GTlFXqtzqnaXLgG4HrJcMYA39G0piAPjoMFTDfFjfzeaVCp+boq+JwN+GlQXR8jKiU3Bt7Zwsy8C4ugIVtB0rHlq8fQmhBFXQqm1nUpChDhTLrnGDqbdKJ6vbIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+SHlEusme8ze+Trs9Yy9iH0WqrSxyltGslMdCPZzvQ=;
 b=pxkd9GuwaK/Soi4l9u3NJGIItb9u2LwXMM1jHeZfL1yyXpBHJfhU8iv8HDWrzevuXVRdMUaMkxGQKr9kfAQPPuz7iUGnn22JQdmYrfgEDe/bE3PKU0yk3NxcF7PI/buEg0NfqPPmKd1H/ohWmN5M4pF1Iyq8B6kLXpuhXCC/EmU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com (2603:10a6:208:b7::18)
 by AM0PR05MB6562.eurprd05.prod.outlook.com (2603:10a6:208:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 09:19:46 +0000
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::c94d:7197:8290:bbb9]) by AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::c94d:7197:8290:bbb9%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 09:19:46 +0000
To:     backports@vger.kernel.org
From:   Shetu Ayalew <shetu@mellanox.com>
Subject: generate backport error
Message-ID: <7318c1e5-fbe0-b941-f10e-ed00151a835f@mellanox.com>
Date:   Mon, 1 Jun 2020 12:19:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::29) To AM0PR05MB4738.eurprd05.prod.outlook.com
 (2603:10a6:208:b7::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.11] (79.180.37.161) by AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 09:19:46 +0000
X-Originating-IP: [79.180.37.161]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ce164e2-05a9-4f06-1f17-08d8060ced4e
X-MS-TrafficTypeDiagnostic: AM0PR05MB6562:
X-Microsoft-Antispam-PRVS: <AM0PR05MB656236D99677A4BD06BE7E74DA8A0@AM0PR05MB6562.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YcM0E6slr4vlhx4HoZKwH+VjKYzV46jRgKp2w7HAcm2BuReXt6Y8sGfPBV2/cCJL38dXi8nBpzp2vUibIa1jPOMGDDGSUQLgRNNL4bqbmtX+Rqb+8czjyXu+zbWJ0/wbf29+/bYjuGacpAM+IMPXn+jeecGJUOJS7ANbcUVLL+i30BmHvce3A/UYoe+KCCuYUDiTYwOiugfO3DeMdeC3LXS8/fXUs+PHG47hpV7kwHjCgi4ApE5AgOVyo6T6ouQ4rjeaIzqLIG0S3dSygLISnpl4TmUkSf1oSOYEV3a6G6gQRuZGWNA6bW5kpm7UoFQH6jJ4uQzYrobq/tvlLOynA15jEYQqN8/boXkGD5O1j6oq5cFo1yTx1G6aYDhOq+L7o5u/gH3RlFBxytTqgIYA4KVwLT3B3HROzQ8bYpSmD3AWSJQERGDiZd455WC+g4lTbmsbDIw6yaCTFrWyW/1uZIpV4JoUQ/rSgxOj4Ndzi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4738.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(6916009)(36756003)(5660300002)(8936002)(52116002)(3480700007)(86362001)(66476007)(186003)(66946007)(26005)(16526019)(31696002)(66556008)(7116003)(2616005)(8676002)(956004)(31686004)(478600001)(966005)(2906002)(83380400001)(316002)(16576012)(6486002)(133083001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9uSsMxMFgiq+84Ae8J/NwLCVLmNYnzYbAUZ5Ro+SLbC3Wo9aTxvzm3iD7qM50k5X7R8RexiQ62qH+k4tulh2NKpuSSALyraqcUJYHRGFARgBLlAdF36tFigmDcw7N+rn8ywHHh55QN5XhYvc+rkNM2MNe4gFfUZu2tpCpxI3s/feovZv9R7RVCaUrWjX1CpaUGgzyw9Bcvlzkc1CsARzVIcUxem8iMmNb/+Rtm7pwIFGBA5kANs5AbN1Ebdn+cSpRVQxwt8W2CgnirK2ioOEmA7SqxltjLdMXnG7bkTGFPFBFkZxuXNgYcIXWTwXdhqoDv2EXLMHW8evzqY1JSxj198hpolns2VSTYUL3dhlrW96eYwyEO0YycdJRWwnihreG5zsSCnJthCuMTL553T/7XCG/1jlmaX1gVKJWliHq3jfyImR3AfVR8WIU3PCeaTX8gKL9nQoMopc3bGGiU4X/jzP7y2A2/BZXwxDN0QatdQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce164e2-05a9-4f06-1f17-08d8060ced4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 09:19:46.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTUxPJT+oq8Vb75klC+eACR8g4uW2ZzoI/kzL52NvglQRVBZQisqiQgpPbO88rgbZEzHbcfeBSjdVNdHD3wfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6562
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi,

I'm trying to run the the gentree.py.
I use coccinelle 1.0.7 and the following tree - 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

with few different tags the last one was v5.7-rc3-1 (for backports 
tree)  and v5.7-rc3 (for the Linux tree).

and I get error:

Traceback (most recent call last):
   File "./gentree.py", line 1107, in <module>
     ret = _main()
   File "./gentree.py", line 724, in _main
     logwrite=logwrite)
   File "./gentree.py", line 914, in process
     kver = gen_version.kernelversion(bpid.project_dir)
   File 
"/.autodirect/swgwork/shetu/upstream/backports/lib/bpversion.py", line 
40, in kernelversion
     _check(process)
   File 
"/.autodirect/swgwork/shetu/upstream/backports/lib/bpversion.py", line 
11, in _check
     raise ExecutionError(process.returncode)
lib.bpversion.ExecutionError


To my understanding the source of the above error is the fail of the run 
of the following command that the script executes:

"make --no-print-directory -C  /swgwork/shetu/upstream/backport_vr 
kernelversion"

The error I get is "you shouldn't run make in the backports tree, but 
only in the generated output ...".

But the directory backport_vr is not under the backports tree. Moreover 
I tried running make kernelversion

from backport_vr and I got the same error message. Do you familiar with 
this probelm, any idea how to solve it ?


Thanks,

Shetu.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
