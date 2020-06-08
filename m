Return-Path: <SRS0=WoTc=7V=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9749EC433E0
	for <backports@archiver.kernel.org>; Mon,  8 Jun 2020 08:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D4820656
	for <backports@archiver.kernel.org>; Mon,  8 Jun 2020 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lVOABnW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgFHIPU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:15:20 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:22070
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729060AbgFHIPT (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 8 Jun 2020 04:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIS87gOsam/I/9+MiMRThASfIxT+GPqG0NZiojB23cN0jpxqhoKR92o9NQzU6kZ5kMe5W0aY/vpBjFc34JFVb1yQh6pggx36XahwnAfxknVySqVAjrc3fmLhweWNJxEThePJSOUcs4V2feIugLVWgIgfuyiynEIjvSzYEIP30mv2+GEJ9EVceqz+hpATiwfTYGf4TJb3FcKE6ptge8stqb+59+BLSQl+MR5VvD5v/6x123pNZKk5R/vF6Jmrk1c9Oc5BJlxsRajwFwr3BXzVIewRChO4jDLyXvvYJWl8gxzhxroPWAeFz54iF+dEmNUO6kH/aaXv6m4c6IM+DwND3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYvjhK1fUxCQ/elLzDfKHQRZZPkxMmWgJ8+6I3HSZC0=;
 b=I3bDbrvdcX/x1YT5tuXYTC+52orqogr9bc7O7/6RUqpqbgz+/9S3E4IKep/Jz1C+EkMDNbLKRb0883PBrBvjEHUQo9IQsPgZTrXRgWuAqrQj8kwcbcyiK7Jeo9u6kd9biszXdTuofrQ0Aq3x4+si5jeAQZIiA2BrGvpUz/dYmoh3pyvsh5qFCfDGliNHLCg0D5Rzr47gctfUrgznKrDRVscsPl3Z7ibO9uvAn0mId9LcsdHWBPL3up/O4jK4IPfkXujeJacdpDYeHJUSV2wcoM9u/YxHU4pFkkx5SL9bEe+g8/OpdKQ4eoTcl0L8EHzKGtJV/+rbZ3/YELm/XAG9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYvjhK1fUxCQ/elLzDfKHQRZZPkxMmWgJ8+6I3HSZC0=;
 b=lVOABnW1ZZx8BuZFvFD550DgqqK4Xki1ajkv+a0ldbQOClgPmVMjph7DLP3OA5G4KHXT98CXstSmtFft4vooFoYcnkLtRbMfcXqNbajXM+q2/CmvQIS9jHvrrfYl1wNhQU7SSaQlNqN60HZ/3ps4nsnPRAYkNZdDDbXjs6ayMXU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com (2603:10a6:208:b7::18)
 by AM0PR05MB6817.eurprd05.prod.outlook.com (2603:10a6:20b:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 08:15:16 +0000
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::c94d:7197:8290:bbb9]) by AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::c94d:7197:8290:bbb9%4]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 08:15:16 +0000
Subject: Re: generate backport error
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
References: <7318c1e5-fbe0-b941-f10e-ed00151a835f@mellanox.com>
 <9661a158-829d-e053-9ae7-5e3114c4f9f6@hauke-m.de>
From:   Shetu Ayalew <shetu@mellanox.com>
Message-ID: <ea4eaf08-d135-69c0-0fa1-f8ad4499edd1@mellanox.com>
Date:   Mon, 8 Jun 2020 11:15:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <9661a158-829d-e053-9ae7-5e3114c4f9f6@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:208:122::38) To AM0PR05MB4738.eurprd05.prod.outlook.com
 (2603:10a6:208:b7::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.25] (109.67.81.162) by AM0PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:208:122::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 08:15:15 +0000
X-Originating-IP: [109.67.81.162]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e944a9fa-3713-418f-672d-08d80b841385
X-MS-TrafficTypeDiagnostic: AM0PR05MB6817:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6817B07172A34A3C5DAA131EDA850@AM0PR05MB6817.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6zKkc8Ty+hbZcX6acGqsEE2sZNahvsM2JWZ33BUoQHWjPZSVI9PlAg4KepSU26zQOXQMgVeI0OvSCWintftlCwT3AGnwFn1crNC4ouj//zy1Y9/B6Tts8wP7MrvmGOLb6kgrTOKvbU74qfIsz+61bkosaXfiB42ufmsmqdoIKkntw18gxCPzhjWFQbTVGqVJ5lbdCjn1ra/20E8FjDX9QkIfcndHHQSLJkcmEbNKe7vEPww+XQq8x9h/ycOqU1JyzI3LNVLF5rmXl06HZVHxPpC1KOowG7gY6uNnr4pkAQ9jHcLUJZ2DGpnL/tf5YTEbio67qR6DSQxgwIiARQgecEwYah2bhEoE3W3Kjet2H3JpWaadhYnAcanSAB3zmNgFLLYRxU+Rw2V+R/RvMb259TS1jo5Y78WFpB3iwXfHzVZjob8GpWi3twrTfFdWVq3JJGg2u77FEPlBwW9q0Qq7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4738.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(16576012)(3480700007)(316002)(53546011)(16526019)(7116003)(52116002)(6666004)(26005)(5660300002)(186003)(6486002)(2616005)(86362001)(956004)(8936002)(8676002)(478600001)(36756003)(66476007)(66556008)(83380400001)(31696002)(31686004)(966005)(2906002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k6iUHF8CL7DsQOgPwyx4rCJp9lUdAk1buFVU3JR7y+5ILUu1ZfSFNuOHFbC49XIRmWcGKha0bcv3IjJgHERIU/wdz2+L8drlYYiwQWz3ZLKB/teit8g5yk0ENOZ0n+xAHsF1k8Xgfv+7tiMe0L+KuqUiT50fVvizM/9KvNY4ASalWbwbkNR8I2+N244y8VXgaZ+XQUoisrV0LKXTtCasJeuuX3BiukDHm6T7caT3GOvwVbUaU1zNGv1/MFiDnDtGlP8XMAdigvDOCXUhCik1HEPz7BCEe6scsxnuArZf8W0klZrgHO9zCspt8VR/ZcBkhHiCl7tbaI0VJ+sEeDs8CKKUfrrCN2tuCCN4zxm9WbMwn5W8KRbfhyXlTiiN4jndZcHa3hQxe8U4qNyUxgYypmJoGSaE6PVXHiHP5yO2Gdb71aH43cx1LKOaVBxbVUVaLvrVqAMfUAkunkZtEG8i9wK12Wqs3x8yWOJehV5VCHc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e944a9fa-3713-418f-672d-08d80b841385
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 08:15:16.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuHazNWEF6+Xj0TIzgBeVjxmyqu//MeZCjKzCW5UXqK1oS8eScnc3BMHcIh4NurzZMWOJW4q4H16kJs3YkrhQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6817
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 6/7/2020 5:46 PM, Hauke Mehrtens wrote:
> On 6/1/20 11:19 AM, Shetu Ayalew wrote:
>> Hi,
>>
>> I'm trying to run the the gentree.py.
>> I use coccinelle 1.0.7 and the following tree -
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>>
>> with few different tags the last one was v5.7-rc3-1 (for backports
>> tree)  and v5.7-rc3 (for the Linux tree).
>>
>> and I get error:
>>
>> Traceback (most recent call last):
>>    File "./gentree.py", line 1107, in <module>
>>      ret = _main()
>>    File "./gentree.py", line 724, in _main
>>      logwrite=logwrite)
>>    File "./gentree.py", line 914, in process
>>      kver = gen_version.kernelversion(bpid.project_dir)
>>    File "/.autodirect/swgwork/shetu/upstream/backports/lib/bpversion.py",
>> line 40, in kernelversion
>>      _check(process)
>>    File "/.autodirect/swgwork/shetu/upstream/backports/lib/bpversion.py",
>> line 11, in _check
>>      raise ExecutionError(process.returncode)
>> lib.bpversion.ExecutionError
>>
>>
>> To my understanding the source of the above error is the fail of the run
>> of the following command that the script executes:
>>
>> "make --no-print-directory -C  /swgwork/shetu/upstream/backport_vr
>> kernelversion"
>>
>> The error I get is "you shouldn't run make in the backports tree, but
>> only in the generated output ...".
>>
>> But the directory backport_vr is not under the backports tree. Moreover
>> I tried running make kernelversion
>>
>> from backport_vr and I got the same error message. Do you familiar with
>> this probelm, any idea how to solve it ?
>>
>>
>> Thanks,
>>
>> Shetu.
> Hi Shetu,
>
> The script tries to get the kernel version of the kernel you want to
> create a backports release for and this somehow fails.
>
> Could you please run this manually like I did here:
>
> $ make --no-print-directory -C ~/linux/linux-next kernelversion
> 5.7.0-rc3
> $ echo $?
> 0
>
> Please keep the mailing list in CC.
>
> Hauke
>
Hi,

I did  and got the same output as you. But it seems like the script is 
not using the source tree path as in you asked me to do, rather it uses 
the output tree (after backport) path.
Looking into the Makefile is looks like the it checks if file named 
local-symbols exits (which not) and thus fails.

Thanks

Shetu.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
