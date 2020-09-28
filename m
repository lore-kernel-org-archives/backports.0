Return-Path: <SRS0=boiZ=DF=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C2C2D0A8
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB43822204
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C2aafztR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgI1KJA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:09:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:38730 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgI1KJA (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 28 Sep 2020 06:09:00 -0400
IronPort-SDR: FuRLGBMWyvqHF05in4l/ses22yM//AogNurnHnXTch19GFGZCVaasM5ShKUNblZBSmzjkFB+XN
 UmmHv5EJ2YGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141979488"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="141979488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 02:12:45 -0700
IronPort-SDR: zrYTWZA5SKYRuIn/25hAJPKCT7aOI/kiMGtB6p0PVblovw0V1ECuEpjZlx2AiRhP+ohD5l0N9C
 C+gluy5YoV1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="307264717"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2020 02:12:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 02:12:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 02:12:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 02:12:44 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 02:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHetyOsubmEND0EC0VyhpxbTa2DmIm6kZ/1RuQooqCjPM54JNE3qkWf5KF5vkLQyXYYZGeb81bjjVkjFPKRooVJ0BLVQ8MNBXLYfom2D87K+WDyugJmnEH48F/V8274Z74UEDgoEKtYiwu5yqyHf10dS1+cRNlanpr/fB4weq/1ge6n6jD2qrUbJq3owlXE4wbzw7twSGkEgwEYD719ESD3bSYnFt/ZQ3/E21M6ZH4bC2g+iV1vTlsxIpRxeebRqctK0hRPNRGauZgIUBKopYHtise/5oJBSnKnm9zFZYQMDsVpytGzGuEcAnKo8U5xm/OlUbT6+q3SgzpFgVHGZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79uPSde5rWDcHeGAUE7LMFw46BwSFk1MVOl2Pf9Y9Pw=;
 b=gT/MRwO+eltO7g5+yUp/nXZuyIWTewxlDdbRq0l8cIHWk/ncU2dDRGIBhGJmbRSB6KgCRqI9uI88TpP2kL3wvJFN4daR9MqZkCdMhf5ba0GPQRf/x4yAMwZ1v7mAYg4+oOY3VlxU6iinUFaGzkAPqA8zA+lvnUbni1RsvHIf0q1b1JKkgdQnClLNfI+NXW4qQz+8B7cGiFd6X3G83Zd0seg0bJbjtw+g8LV8ZGA+a9ESynN62+dUvSnpr1L/XKh7oRrI/tFoWbqr4P8Lp69DxQoJEmdAJwEpa8BeROzjM62i6hBEeGZsjKJkstYiXZ4YhSLk/VwiFZV1apSAi5g8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79uPSde5rWDcHeGAUE7LMFw46BwSFk1MVOl2Pf9Y9Pw=;
 b=C2aafztRs3YQx+BDNl5yPFso4MILhYqcipFwPM9f6hm8PV5+oyA9Zxj/9GM3pCM2OF4j7SxUlFRyrQLOW/pO//Q4kGM3SWE8ZujmWp4QE58osuSTbWZrB5sdZm9lY6132/Cbjiqb7ah2iGchgk5nmNHzbPo1RFrqwfz3XGQNgdU=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2872.namprd11.prod.outlook.com (2603:10b6:a02:c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 09:12:40 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::718c:ac63:d72e:f3c9]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::718c:ac63:d72e:f3c9%4]) with mapi id 15.20.3412.028; Mon, 28 Sep 2020
 09:12:40 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "hauke@hauke-m.de" <hauke@hauke-m.de>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] backports: add skb_list_del_init
Thread-Topic: [PATCH v2 2/2] backports: add skb_list_del_init
Thread-Index: AQHWlWfxgHggrflCnkKfHo4T9Ox7Vql9xDaA
Date:   Mon, 28 Sep 2020 09:12:40 +0000
Message-ID: <761d13bdc1b162ed574c6b3c3bb9b6635ad696f7.camel@intel.com>
References: <20200814142958.7773-1-nbd@nbd.name>
         <20200814142958.7773-2-nbd@nbd.name>
         <8e1d9f3d-4128-4030-97fd-3e541bb9c7e6@hauke-m.de>
         <e7a00f96-41e4-6513-5962-b80fbfa37613@nbd.name>
         (sfid-20200928_085509_032248_C1749EAB)
 <1923f0e6540d422d41f5817caeae412c49de973a.camel@sipsolutions.net>
In-Reply-To: <1923f0e6540d422d41f5817caeae412c49de973a.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nbd.name; dkim=none (message not signed)
 header.d=none;nbd.name; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa971eb5-717e-45eb-f487-08d8638ea699
x-ms-traffictypediagnostic: BYAPR11MB2872:
x-microsoft-antispam-prvs: <BYAPR11MB2872F83C175BBD40AF756A2A90350@BYAPR11MB2872.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjLAZLFB1XUuENa4nIrR2veNq5NqMOnfnjmLU6YLli2G/bxSM/5mlzawdesasWxa8c5QoP/9Iub36GrOd1b5klckgkdUiNVvbKo+XpnBTYDGZK1gpbalI6nkE5+P+8RgHXj3qwTqFB2eb5R1GXMr1EhOhvSrTi2DbF4Pd93c5XuQWpyQeVtNAwaTyaD8/mab9atAG30M/1QmfdW2lDR4AyaH51ENcRrNqBeEk/sqDZ7OK++/9fkQeq7C/UIcKQDTwul8F3NXALAPVcKvf+8Wp9GihhkIXG86j94QFqFWmSC+1iK8olIV9JsSLOnWYbts4d67dV92/5eSj3nFylZxTL/FUup+qY96d/1FB/yPghtrq4aBtWSm1QfjODUaPZsHK15KMo+Z4QrbdcZsf62iLi48xSiMj9BvuJGFlYk1Kf6zVGwSMHyQTmeRBWU0l8MC0FWTN9AWU4GVhHcwmBHYow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(2616005)(71200400001)(8676002)(478600001)(8936002)(6486002)(66476007)(5660300002)(76116006)(91956017)(66946007)(966005)(66446008)(64756008)(66556008)(6512007)(36756003)(2906002)(26005)(186003)(110136005)(6506007)(316002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: skc3aF9rmd+I6ATanAk1NEreu2P5bZPAywliwbGz1HhnBrNba1QudK6sOzKNC/fw02eH2hcY57UEfkp0a4UV2vzBIHVYFrReptPA3R24QgJIOnM753EiEXfOW8IH6jrM9fNu84AZ3ubJ25BcUJc91URSojGsFrvPojthOVlKhZ0m0qny+tvNvHLFanwHFEf3b4ZjMnTnOpMiN7Fs3oEPeDAi8/WgzmS6Jq+G5D0CSnMsXoHatlNjHi5uEkoucnJkd99IH24+KW2gOmlin7zHV7DT0x349iA3D88xNrd/sPdgW0XRkFE1wGVuZaTQyQDq+WflKGoMTc094cbci6JTQh12yX1hzn68UOTyOwe1aArlsWcq3F4MPjfpMEQw4nm0yipDX8XGDEiL2CWvh1BKP6gR2Vim3mIkYH2LbbSrrgVA43nU6btkrsO7AmvMEsmYHx/Cf/Rl/1fr1FYf+HDdx8WVqqNIgZB1Y4Hssx/Tj59JCc7xz7fbXZ9hU9afz/QDY452LzZhN1UIVWfuUKr1xfd3A4hMK08Qj/jrJ0BWJHBCYL5oKXJPcUiVL8pzATyT7/8DzWZINyeTj9GEwma3qd0QgyxAyXqydRkf5VQZnKPP26pZmP0ereisAN+0nq38PywoI3PBBvWQxSvCcPHNTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45A7ABCEC5F2F74094653F47D28514C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa971eb5-717e-45eb-f487-08d8638ea699
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 09:12:40.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHJobLLogupCHmCkIPn892FtkHIIGBqRo3NWMg8ywS5RWuSN+48jKhuNZqz+Tbmkno9Q2WDMJL/iZ4HpGDwHu90oSEJ6jDgVZ3Cr3CATQbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2872
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTI4IGF0IDA5OjIwICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjAtMDktMjggYXQgMDg6MzEgKzAyMDAsIEZlbGl4IEZpZXRrYXUgd3JvdGU6
DQo+ID4gPiBUaGUgbGlzdCBtZW1iZXIgd2FzIG9ubHkgYWRkZWQgaW4ga2VybmVsIDQuMTkgdG8g
dGhlIHNrX2J1ZmYgc3RydWN0dXJlLA0KPiA+ID4gc2VlIGhlcmU6DQo+ID4gPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL2xpbnVzL2Q0NTQ2YzI1MDliMWU5Y2QwODJlMzY4MmRjZWM5ODQ3MmUzN2Vl
NWENCj4gPiBJIGd1ZXNzIGl0IHdhcyB3b3JraW5nIGZvciBtZSBvbiA0LjE0IGJlY2F1c2UgdGhl
IGxpc3QgbWVtYmVyIHdhcw0KPiA+IGJhY2twb3J0ZWQgaW4gNC4xNC43MS4NCj4gPiBTbyBpdCB3
b3JrcyBmb3Iga2VybmVscyB3aXRoIHRoYXQgYmFja3BvcnQsIGFuZCBJIGd1ZXNzIG90aGVyIHZl
cnNpb25zDQo+ID4gd2hpY2ggZG9uJ3QgaGF2ZSB0aGF0IHdpbGwgbmVlZCBhIG1vcmUgaW50cnVz
aXZlIGJhY2twb3J0IHRoYXQgcGF0Y2hlcw0KPiA+IG1hYzgwMjExIGFueXdheS4NCj4gDQo+IEkg
dGhpbmsgTHVjYSAoKykganVzdCBtYWRlIHNvbWUgaW50ZXJuYWxseSAtIHdlIHNob3VsZCBwdXNo
IHRoYXQgb3V0Lg0KDQpUaGlzIGlzIHdoYXQgSSBoYXZlIChJJ20gcGxhbm5pbmcgdG8gc2VuZCBt
eSB1cGRhdGVzIGxhdGVyIHRoaXMgd2Vlayk6DQoNCmRpZmYgLS1jYyBiYWNrcG9ydC1pbmNsdWRl
L2xpbnV4L3NrYnVmZi5oDQppbmRleCAwODQzNDQ2YmQyZDUsYmUyZjk1NWNjMjRlLi5hZTUwNGYw
NzAzZTENCi0tLSBhL2JhY2twb3J0LWluY2x1ZGUvbGludXgvc2tidWZmLmgNCisrKyBiL2JhY2tw
b3J0LWluY2x1ZGUvbGludXgvc2tidWZmLmgNCkBAQCAtMzgzLDE5IC0zNzUsMTkgKzM4MywyNSBA
QEAgc3RhdGljIGlubGluZSB2b2lkIHNrYl9wdXRfdTgoc3RydWN0IHNrDQogIH0NCiAgI2VuZGlm
DQogIA0KKysjaWYgTElOVVhfVkVSU0lPTl9JU19MRVNTKDQsMjAsMCkgJiYgIUxJTlVYX1ZFUlNJ
T05fSU5fUkFOR0UoNCwxOSwxMCwgNCwyMCwwKQ0KKytzdGF0aWMgaW5saW5lIHZvaWQgc2tiX21h
cmtfbm90X29uX2xpc3Qoc3RydWN0IHNrX2J1ZmYgKnNrYikNCisrew0KKysgICAgICBza2ItPm5l
eHQgPSBOVUxMOw0KKyt9DQorKyNlbmRpZiAvKiA8IDQuMjAgfHwgNC4xOS4xMCA8PSB4IDwgNC4y
MCAqLw0KKysNCiAgI2lmIExJTlVYX1ZFUlNJT05fSVNfTEVTUyg0LDIwLDApDQogIHN0YXRpYyBp
bmxpbmUgc3RydWN0IHNrX2J1ZmYgKl9fc2tiX3BlZWsoY29uc3Qgc3RydWN0IHNrX2J1ZmZfaGVh
ZCAqbGlzdF8pDQogIHsNCiAgICAgICAgcmV0dXJuIGxpc3RfLT5uZXh0Ow0KICB9DQotICNlbmRp
Zg0KICANCi0gI2lmIExJTlVYX1ZFUlNJT05fSVNfTEVTUyg0LDIwLDApICYmICFMSU5VWF9WRVJT
SU9OX0lOX1JBTkdFKDQsMTksMTAsIDQsMjAsMCkNCiAtI2lmICFMSU5VWF9WRVJTSU9OX0lOX1JB
TkdFKDQsMTksMTAsIDQsMjAsMCkNCi0tc3RhdGljIGlubGluZSB2b2lkIHNrYl9tYXJrX25vdF9v
bl9saXN0KHN0cnVjdCBza19idWZmICpza2IpDQorK3N0YXRpYyBpbmxpbmUgdm9pZCBza2JfbGlz
dF9kZWxfaW5pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KICB7DQotLSAgICAgIHNrYi0+bmV4dCA9
IE5VTEw7DQorKyAgICAgIF9fbGlzdF9kZWxfZW50cnkoKHN0cnVjdCBsaXN0X2hlYWQgKikmc2ti
LT5uZXh0KTsNCisrICAgICAgc2tiX21hcmtfbm90X29uX2xpc3Qoc2tiKTsNCiAgfQ0KLSAjZW5k
aWYgLyogPCA0LjIwIHx8IDQuMTkuMTAgPD0geCA8IDQuMjAgKi8NCiAtI2VuZGlmIC8qIDQuMTku
MTAgPD0geCA8IDQuMjAgKi8NCisgI2VuZGlmDQogIA0KICAjaWYgTElOVVhfVkVSU0lPTl9JU19M
RVNTKDQsMTEsMCkNCiAgI2RlZmluZSBza2JfbWFjX29mZnNldCBMSU5VWF9CQUNLUE9SVChza2Jf
bWFjX29mZnNldCkNCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
