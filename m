Return-Path: <SRS0=n4Ms=7G=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790B4C433DF
	for <backports@archiver.kernel.org>; Sun, 24 May 2020 15:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E6920787
	for <backports@archiver.kernel.org>; Sun, 24 May 2020 15:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TFwDMn0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEXPjd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 24 May 2020 11:39:33 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:12702
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbgEXPjd (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 24 May 2020 11:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogOSBdVqI4GUk0762IieCalVgXZ9+P+SYeMx3ee7avgiBu4nHsxf1NqZPUUOVSYVbwfREqJYDq7XLvZ4QpiZpjjKv6elj+Yvm/7GE2m3XVKlhq3S/bxBIXxROnd+G0pImUzAwnPwps9ecxiA3UvcUXWOr75dUGVTBQ8NUbpqzMh0l85ciGKwQd/2NT70Zf7pW0ALQHz1ziYOyQ2PPSL5xrLhluVBzUTFc0p9UIESRB6B2I9aW1nVU+fxHUL6X4+P/REsDuN7/LZAdUDulyfd+3WjKVdKWS8AwBagXywk18v9klSyDspomsQU/jfUwp3p0v5XCUKO/WMVKMY/WLHBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVYdZueplfU8DaDpeJycZzhUAw+/fSMCewzo5s7MgBk=;
 b=CyDpLs68KjZBggUMHur7N/nThSxu9E81zqZfiTvs89T74wQ5yutqxoqMO0FAjQhs1Sr8zByH+Ptufo5LpvSOiA9GYZdj8+VkebxHfJCD34fHMNapTo+AAsO1L5L9eozq3uxO5JbhSeX+P4GavZFH4fFP6R4XNYrBAOrFg1Lo3M5D7EPs93yxOl7M1lqsK3NWlupzWzPOxVy3JhglQY6q1S1niejkAzfVVWNqo7KjsR44D3l3YJ1sQA6UD0ielE/iKYh6TEhfLBIJde6yKxAjt0Q9l+qJuwzwDHXiB5aCB1t4SMgZRq8Nt6y+NGD+MaRxz/TZ0hTJvqtwaPZtVLvEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVYdZueplfU8DaDpeJycZzhUAw+/fSMCewzo5s7MgBk=;
 b=TFwDMn0A83Oh7Wfw8Q56B2f0E2P878WGX240WmYNLnI88N3uKJXwd7Vs/OIji0IHvy+fLiGd+jrxC3f9x0uKGi1l00qtzGuijWhyiublPrEJJf33LOq9JrpVOIsI8K4iBreypYEDe1uNfqJ4VJN03TFg/RASI2hfhUDZ54Imkj4=
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com (2603:10a6:208:b7::18)
 by AM0PR05MB4980.eurprd05.prod.outlook.com (2603:10a6:208:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Sun, 24 May
 2020 15:39:30 +0000
Received: from AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::d881:998d:b326:952c]) by AM0PR05MB4738.eurprd05.prod.outlook.com
 ([fe80::d881:998d:b326:952c%5]) with mapi id 15.20.3021.026; Sun, 24 May 2020
 15:39:30 +0000
From:   Shetu Ayalew <shetu@mellanox.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: generate backport
Thread-Topic: generate backport
Thread-Index: AdYx4VZgoJaOWJ0HRE+PBDQzPHZcwg==
Date:   Sun, 24 May 2020 15:39:30 +0000
Message-ID: <AM0PR05MB4738C333E2495962C3CEBAADDAB20@AM0PR05MB4738.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
x-originating-ip: [79.180.37.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1bdd3d0-1e82-412e-94ac-08d7fff8a646
x-ms-traffictypediagnostic: AM0PR05MB4980:
x-microsoft-antispam-prvs: <AM0PR05MB49809902BC57AABE000743A3DAB20@AM0PR05MB4980.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0413C9F1ED
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tCDAebBJmcDIqgu2ek+OBWg1MfNBPvaXZwdNQu0XE34tGruwivfDXojHwmzary1KrNtGtIyaP2VTVOHjemAMEoLY832h9LP60oR8lYvMYAOQNQnCsjbmde/atgOih0X8Z7dweIWZB7vlCrXRKHH5nbO5hZj2HUTUrdAef+mvw7ZNauxcjeaU9HKTP15ItGEG8kjtuI41Hsbdqvu7HA4llQvpbd7fVRoH07hmB7fih1HRX6Q6IRBQjtDN2Sgu8OyXL327d41rDYpAj4lFjFuvCoXefqCLYvwsldC7y3QMSoXbBihGu8diaiyJRo9brZonTf4iobrH9qCgxf80OQIjpJ1eQBCXkF3jgQiUSlVMKq1Od8dessPSglNph0imKILufiLI8hIsSN4N9CKo/mHh1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4738.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(76116006)(64756008)(66946007)(66556008)(66476007)(66446008)(478600001)(966005)(52536014)(9686003)(55016002)(86362001)(33656002)(6916009)(3480700007)(7116003)(71200400001)(7696005)(316002)(6506007)(5660300002)(186003)(16799955002)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mR0c/JlXRhL482hajaIUf1gmPq7AX2DYPQVCMzppzv8nS3ZeUNYOcunzuGcRnVOc1dq4ZFZebMvgTnlnYtgN80cnlTxClRnEydVGzvP+pj6iuzgoU3N4Yn2gSbz7Ws3NCalBSv+wJxdkGeYtvcOS4/+2JvjGK7ORcLdNSExErE8le9MXIShLuMn6VYhV7Gls+KS7tGQ/pqKK29dJCR7NF3WNLCmRoTTipkEUcvzmBvrYcKe9jigNcF2k5vTMQev0LxBmhMq9DuUZkVfypK5pS9XvGMBIOYp7hVFmsYgEtC8j0Uli5J1ZdWOQFurwISGSfj4ARTe9MSiZ7UngjU6tVS9Ubde/6qXNTxoRtLBXWODLd0FTmUw1GDfsFtOzxASDuYjQUCKGaQVzcZD26Zx+UdFIWMKdwBkVX169kSZA9A6KRE4YZd52h9pBU9wuXfWaGiuMiTr1rmRJmlDYkTLHau4FrKcX4inJPDQQqIsF0gg6zV4ov0gKm5Pl74B/UfLu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bdd3d0-1e82-412e-94ac-08d7fff8a646
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2020 15:39:30.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AB6K6pxzVOsd7XriIwN8j5WFjup6QDgC+X5g0IZbIDvUkdsA9C/eWq/ddKTH/c63PyV82VKl+/11KtwFhPQCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4980
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi,=20

I'm trying to create backport based on the backport project. I followed the=
 instructions here - https://backports.wiki.kernel.org/index.php/Documentat=
ion/backports/hacking.=20

I'm using the latest versions of linux-next tree and backports tree and I a=
lso installed the latest version of the coccinelle. I did checkout on both =
trees (of linux-next tree and backports) to many different tags (the last I=
 tryed on was v5.3.6-1). Then I run:
./gentree.py --clean --git-revision v5.3.6-1 /path/to/your/linux-next /path=
/to/your/newly/created/release

But in all the cases there was always patches that created parsing error. F=
or example on the last tag I got error in patch 0049-no-pfmemalloc/no-pfmem=
alloc.cocci with the following message:
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
minus: parse error:=20
=A0=A0File "/.autodirect/swgwork/shetu/upstream/backports/patches/0049-no-p=
fmemalloc/no-pfmemalloc.cocci", line 7, column 4, charpos =3D 90
=A0 around =3D 'page_is_pfmemalloc',
=A0 whole content =3D=A0 || page_is_pfmemalloc(page)

which is not much informative, I'm not sure where is the problem. =A0I also=
 checked this file on master branch and other branches
Is it possible you give me two tags (one for the linux-next tree and one fo=
r the backport) where the backport should work so I will be able to try it.

Thanks,=20
Shetu

--
To unsubscribe from this list: send the line "unsubscribe backports" in
