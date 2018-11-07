Return-Path: <SRS0=VT+k=NS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2BC0044C
	for <backports@archiver.kernel.org>; Wed,  7 Nov 2018 09:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152532081D
	for <backports@archiver.kernel.org>; Wed,  7 Nov 2018 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cypress.com header.i=@cypress.com header.b="RbpFKS2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152532081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cypress.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeKGTHR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:07:17 -0500
Received: from mail-co1nam03on0105.outbound.protection.outlook.com ([104.47.40.105]:52848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeKGTHQ (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 7 Nov 2018 14:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hKK2bJgvue1UtulQn0cTiyAmMD7zFEKb96p7V/uK4E=;
 b=RbpFKS2JplWXURocpvGpdgOf1pGOxcRFt/dKzRqKnK/AY+x53K0lEs7LoWmYJ1Dsvmh8DgPQLkbjLMmm+HFpZvJ2Kno9w4vG1b05BkSt4MHmSrZTk6yBY0eIA3lIzSsX+E4GtmTHzRMZRQG5Ap7CPQjz+CxFEx/ffsk7bVB9bL8=
Received: from BY1PR0601MB1436.namprd06.prod.outlook.com (10.162.111.23) by
 BY1PR0601MB1388.namprd06.prod.outlook.com (10.162.111.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 09:37:41 +0000
Received: from BY1PR0601MB1436.namprd06.prod.outlook.com
 ([fe80::199f:c63e:1449:1979]) by BY1PR0601MB1436.namprd06.prod.outlook.com
 ([fe80::199f:c63e:1449:1979%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 09:37:41 +0000
From:   Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Winnie Chang <Winnie.Chang@cypress.com>,
        Winnie Chang <Winnie.Chang@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH] backports: wrap pci_alloc_irq_vectors() in PCI defines
Thread-Topic: [PATCH] backports: wrap pci_alloc_irq_vectors() in PCI defines
Thread-Index: AQHUdn2H6Oir7q/M5E6UCuT/OuAkWA==
Date:   Wed, 7 Nov 2018 09:37:41 +0000
Message-ID: <1541583418-196225-1-git-send-email-chi-hsien.lin@cypress.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [12.110.209.245]
x-clientproxiedby: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To BY1PR0601MB1436.namprd06.prod.outlook.com
 (2a01:111:e400:522c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR0601MB1388;6:xMTnlRHytIbIkOcH/p6tQQPHAtv3Y2FUXCyrW7y+qBQZyYHqIwIO/btnNkpDNSS72mx67Ih9A67k8OWjxFMs5i+Af3JhzYRJZYOIQ9F0Ie5PX1qBXfTY5kpIRz1FgMSqb3NHojdtdscuLINeFBEx4px84Dsf7W1c/pLWJ/Pnps/WTLcEEy9uCf07PB6p2o/Ib7r2M+IHUqxu0K6Dk/yGWC3vX6Kzg+rRjxZ828g1LiZH8JFv96YrKkIZb2HZDnK5cdyflgC6OFVmygO92khASy8il/VDE/ax2d/y69D9G/sezjNdfqKscXpBMtED8UJe9tzZbUiIp4ZJeG3zeeaD0OpRJKn+wpfP0WLqPSFROOFAgcLx3yFJv6NpiMGvYHey96r1Vtqyt5ALI4l1A5vOpBKgqQ/8+lR3AtaNISHZALMHq1nYQONfSuJGdmM8lr8GN6SwRNr0OHSquhhQ3YaW7w==;5:3MA/OcnGqquQXYrveXhnJ/Pz1LWI4hPo+W7oxdL+i1gJ7sTrvpNR/3UfVDeQNrXh/yv1Zk1NX3UM2KrKrzst2T3WvqxRovK7gst7RuTFsGfKFrBVVauveF0PyXK+EiKK0ZYUkvtf4stf8ujMUIKH+P8WzLpaV7HEh5rOlLMrDb0=;7:7hVcWbV+R9PGISiOSn8ilrMuaR+n490ycaaliG3RRg1uenDmTLLn3oMRlujsNn8m33ghYlIU0Ay76ivVZDwkHGKwljkgYT8lUy/xS4+mRcf6TFCpJpa3DZKsH96yT5fQCSyL4ul622LQVfWRt+9nrQ==
x-ms-office365-filtering-correlation-id: 102ea62c-326f-4294-a906-08d64494a983
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY1PR0601MB1388;
x-ms-traffictypediagnostic: BY1PR0601MB1388:
x-microsoft-antispam-prvs: <BY1PR0601MB13887B71F17A6A1CF4956FB2BBC40@BY1PR0601MB1388.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258095267146985);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY1PR0601MB1388;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0601MB1388;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(2501003)(4326008)(25786009)(71200400001)(71190400001)(8936002)(97736004)(53936002)(102836004)(478600001)(99286004)(186003)(6512007)(26005)(8676002)(81166006)(3846002)(14454004)(6116002)(81156014)(68736007)(2900100001)(256004)(54906003)(2616005)(5660300001)(86362001)(7736002)(110136005)(476003)(305945005)(6436002)(6486002)(316002)(36756003)(72206003)(486006)(2906002)(105586002)(106356001)(1857600001)(107886003)(6506007)(386003)(52116002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR0601MB1388;H:BY1PR0601MB1436.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rPoqPdJZMAqL8MaWATc4OIKw7Fj91U+THC/+5G4sJVVVwiXYglDX0dzM2FpUjz27MxyO2QnV8mp3kQ7BzW7NJYEPBC5YLgierkBTzO3ZEEp7QjDxrP9lAjBZAr6Vg4NBVGRdTgRbTj75kEgIHBta4LowehO6wSjtUEmIVdAEjyqrj/6M9Vj7lYB25yhJCHzx8UYFjp5zqbBGg2DropKeWQZGVUalXGmX6cnkTAElFT7/Phxy3OHjvqndzOfK6u50g+er1zM8W+JGPtqQBxXwL9HT7ISZNI1mVocD6kCueENbj5fMoZcmBXd2Doipubp3x4AftvK1yWF1B3q5aJocbMvA96ujL5iaiRNICytzHVI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102ea62c-326f-4294-a906-08d64494a983
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 09:37:41.5025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0601MB1388
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Winnie Chang <Winnie.Chang@cypress.com>

pci_alloc_irq_vectors() needs to be wrapped in CONFIG_PCI and
CONFIG_PCI_MSI definition to avoid a function redefinition compiler
error.

Fixes: 162a6b312f1b ("add support for pci_alloc_irq_vectors")
Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 backport/compat/backport-4.8.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-4.8.=
c
index e583c1eca01e..a53e39c96dab 100644
--- a/backport/compat/backport-4.8.c
+++ b/backport/compat/backport-4.8.c
@@ -146,6 +146,8 @@ next_desc:
 }
 EXPORT_SYMBOL_GPL(cdc_parse_cdc_header);
=20
+#ifdef CONFIG_PCI
+#ifdef CONFIG_PCI_MSI
 int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags)
 {
@@ -167,3 +169,5 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned=
 int min_vecs,
 	return -ENOSPC;
 }
 EXPORT_SYMBOL_GPL(pci_alloc_irq_vectors);
+#endif /* CONFIG_PCI_MSI */
+#endif /* CONFIG_PCI */
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
