Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCBC2D0E4
	for <backports@archiver.kernel.org>; Sun, 15 Nov 2020 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D1622447
	for <backports@archiver.kernel.org>; Sun, 15 Nov 2020 14:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=celeno.com header.i=@celeno.com header.b="rmfCDwYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKOOHi (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 15 Nov 2020 09:07:38 -0500
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:61667
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbgKOOHh (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 15 Nov 2020 09:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT7zrThGZU7k5aYLImu6fRbwGy2nLhHwWCBmc8gREjwFIu3zHySN2G7uID7NG9B9AKKtiCD6NebF6cG+dhUgbbVZPzdHUggdtZ5vVOCLlG7Frs0/LCSVSI2BFeVbl+2InZE5Xq33tHjCg/LQ4DLCKjgPnireM9X6m9a7W6Avkn1d17dsMmQ5rsz5G6amx7vwxaGHYMgIQ2V27TgtkbofbtaLZ6u7xebtbAtuHuJycBr37oZWbLt+aSisl6in5l4G5/W14CXGTzSkXPQXd/BCo6FKSW+6eIyHXGpke1bei6uOJ+fWhE3b1f90J8fjJ1EY+tfTun56NwLXBg3Nd6pOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2kv+t5vBGHOFW45H9kSbU3hI1XKSf/5oaViKOG88h0=;
 b=YXthg6jo+Kh4cuOIUR9vOUur8vjWf32R+NI+rzQ59j4SFBrjuDpf6Ts608UPYN/bdigI/unsTKDiLaOZl/cMh5tOBd5icFw00Sl/8f0PM+JL0rTqohR/3YM9d3HMq5KF2BwttE40vOoOH2QO7A5RWddTi2wCl3pCDMG7AsngbnwEfbT/JmRR3+QPooNs8TqnjksnlpYDRjCoI0UvayrPd9Y/NDUhl98pniL1rPY35s1fkmU7/y/EYiOZlQQ/8580WZdE+mD5lNqLc4ywR7PY2fGWCGdiKa7bmKL6nqeWhBeMttTmPh7zJh/aEmodkYtcC4ijiaQ2rvAxKOwp15abKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2kv+t5vBGHOFW45H9kSbU3hI1XKSf/5oaViKOG88h0=;
 b=rmfCDwYnEs1LZXHLmPOGKW/liPtvkTffllcxRxC1MAw8+XVqWSXQ23DfWU9lvHlzaju3s5uuvlCL4LTi/TvNcadfZYeDHvOdEIXcKKZIsI2i92YBKtLN4zVqtugBTJjYjVKgQPkUWbA4BJmoc52sB2gVfN5o19fNHcvV+BvaXdI=
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM9P192MB0870.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 15 Nov
 2020 14:07:34 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543%5]) with mapi id 15.20.3564.028; Sun, 15 Nov 2020
 14:07:34 +0000
From:   Shay Bar <Shay.Bar@celeno.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "backports@vger.kernel.org" <backports@vger.kernel.org>,
        Eliav Farber <Eliav.Farber@celeno.com>
Subject: RE: [PATCH] backports: Add time64_to_tm and ipv6_mc_check_mld
Thread-Topic: [PATCH] backports: Add time64_to_tm and ipv6_mc_check_mld
Thread-Index: AQHWt2pVuPzpmqNoiEOor5MSAl0rj6nJPK8AgAAFs7A=
Date:   Sun, 15 Nov 2020 14:07:34 +0000
Message-ID: <AM0P192MB04684FF2B814EF6A61549381E7E40@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20201110140344.17330-1-shay.bar@celeno.com>
 <29b92ce7-9dc1-0456-34b0-6391ef628005@hauke-m.de>
In-Reply-To: <29b92ce7-9dc1-0456-34b0-6391ef628005@hauke-m.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hauke-m.de; dkim=none (message not signed)
 header.d=none;hauke-m.de; dmarc=none action=none header.from=celeno.com;
x-originating-ip: [87.71.36.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35b4a96f-6a36-4982-c090-08d8896fcccc
x-ms-traffictypediagnostic: AM9P192MB0870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9P192MB0870522B19913AA13B4DB012E7E40@AM9P192MB0870.EURP192.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEi4RBRV8VUw8eTGDLhJyaGd3bCT/0yk4X//UsuK6rEjU/cIG9hYhpD63JU/jgS6WbVKEXHwondP3IwcoKMHgENoYyqwk4hsCaFb1myyhTMZQP8XaSZUZ0PhwF1+y7nLvgU16pmaErl1d+D1EvBRjNlwJgJzRTn2fh0DLVMeI0wfFu2XoHBMI4LWPb+3gk1QwXEN1+zZSPAjpqHE6fJylrDBhUorECpkxDtba2V3uaaxPU7i9Pa9qrYyTWzJMrRUJxwkz5jvbSHvO+WvpOgyBwZk49HyiO/IxmmeBHR3IZsCYF2XfOYDKuwgrjxJFJfv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39840400004)(136003)(8936002)(71200400001)(66446008)(54906003)(64756008)(4326008)(86362001)(66946007)(66476007)(2906002)(55016002)(478600001)(66556008)(26005)(110136005)(558084003)(316002)(33656002)(8676002)(52536014)(5660300002)(6506007)(107886003)(76116006)(7696005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PgKTduholnTi+7iCHsvLjEGVUjgI+e5dzKH5rHuZGwmxOWr94c2TSWnPMPqAf2rzsyzHpZfa+ENx5u7Z/zGA7U7HYqNLYylM2P+98fC+07bv/dje7xbRdEHJEBvVMFNRR3OmoI/RWl2MNL0N0cSwygBVbsY/UNb2TPobdCamZubsC8l/UrWI43Qui9ohovv+S+V7f4iG8LHkzG7VvS8sefxjfdWWQY0qx5sdwDDaWUz8GiQD783xUY9Lmj+bX/XOASCfHz44z3gDtPZ+qC0MjLctqBGkcBSRHcfRa2ZmrsrwzXXbGVcbtALA5eCGj2izvH3JNxEVKw6OEdHoQ0MpHOZuGyCgVKMC246UFNRNQfC791ybISaw6H+XqtasrtpmDhW3KwHOmrYBYV8sp9mq4MVElL6MUxaNzYkPolDFXL+DgQAwZf4pEEi7JgAR2PXL3pQiswnad/kXHw2YUPJ5CZ5OJi6YAxgfnqoRw5ACVvEW6KAEjVcB5o3WfjhhpM7gOqTD4DOZzIIkSAvqKBAXRbWgM2NbSwHm1M6ZevFY4lamu2vo7o6tcnj5pi6CxWbntzWbs9jP/WGHI2beemuJ3jvHd7ZAcaSqSQ7XhVlpPzdklP0o7KsQak8+H0WwkvBmU5jWQpBJDvUlkPSblO20LOaT7nb2zvN5d0AFlxTtWzlNCuISfAi3QjfBHlyng7r04HdavmnLAhj2KiX5sW8ML2bbaN3o7jhs4gYtKTF+SMbAQUEg0+xW6vjMxTi72MtYdijkU5AOG74Y1ut2KzxOasZGOV7eIqchfL9Vvgw3Ckl4OGgGqAWkOejtx9DkGSpfNxhAi9hCYmHHY2Ei5Dk0MjvKLumtsEiw3xgSl9MGLAjQTO7ug5zIBzbr9OiVrxzdEaG1DIoCgfRvtcn2sVNfyA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b4a96f-6a36-4982-c090-08d8896fcccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 14:07:34.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4oWmlRcW4LMoSLQ/ThhV67xRtwO26evvdUp970PlGA9nzcgsaj3IWRyHVyLN3gaeQeWcwX9a80zM1tvF+oAPuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0870
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Hauke,

Indeed, no wifi driver is currently using them, but we plan to
commit our new driver (that uses it) to the kernel.

Should I ping this patch again once we upstream or can you
already accept it now ?

Thanks,
Shay.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
