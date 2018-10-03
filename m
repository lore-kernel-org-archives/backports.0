Return-Path: <SRS0=TTIH=MP=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1168AC00449
	for <backports@archiver.kernel.org>; Wed,  3 Oct 2018 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9120684
	for <backports@archiver.kernel.org>; Wed,  3 Oct 2018 09:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tandemg.com header.i=@tandemg.com header.b="yC2uPK5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tandemg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJCQFs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:05:48 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com ([40.107.0.105]:29216
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbeJCQFs (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 3 Oct 2018 12:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m8qrNvkNlH2RCm3Tx/hMSXFTG4altrUA3XjLH0jr7w=;
 b=yC2uPK5H2NSu4IQZM8Z2u0qgVVinYMMnzAxCEXiEvZCFlQhVs53qwj+KGF5Vzn6W6tEQRzYLGMp+mRpKyt8p6xXQDblAVGSU5l8mE/QgBtteinnqkj6RWuayAuLKRpPwY2PfyuxBqxMGlIpmu+88laOygMfnmxEjOmyyHGsjfdM=
Received: from AM0PR02MB3650.eurprd02.prod.outlook.com (52.133.63.27) by
 AM0PR02MB3649.eurprd02.prod.outlook.com (52.133.63.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Wed, 3 Oct 2018 09:18:09 +0000
Received: from AM0PR02MB3650.eurprd02.prod.outlook.com
 ([fe80::e0b5:1e22:6b63:e7fc]) by AM0PR02MB3650.eurprd02.prod.outlook.com
 ([fe80::e0b5:1e22:6b63:e7fc%4]) with mapi id 15.20.1207.018; Wed, 3 Oct 2018
 09:18:09 +0000
From:   Omer Dagan <omer.dagan@tandemg.com>
To:     "hauke@hauke-m.de" <hauke@hauke-m.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "backports@vger.kernel.org" <backports@vger.kernel.org>,
        Omer Dagan <omer.dagan@tandemg.com>
Subject: [PATCH] add support for pci_alloc_irq_vectors
Thread-Topic: [PATCH] add support for pci_alloc_irq_vectors
Thread-Index: AQHUWvoA56ildz6zPE66wqD7bP+nNQ==
Date:   Wed, 3 Oct 2018 09:18:09 +0000
Message-ID: <20181003091746.28511-1-omer.dagan@tandemg.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0016.eurprd07.prod.outlook.com
 (2603:10a6:203:51::26) To AM0PR02MB3650.eurprd02.prod.outlook.com
 (2603:10a6:208:3f::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=omer.dagan@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.120.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3649;6:5liiR+yBopG/ei3mU5/tkYYlzsq9rCGBnBbQUJBUdrdLX4q09VupIpmWrPmfyXrlEium3dlirmriOOBk3iP9tFAOWt6MNIMz0PI2Zz3FFzNOAjAki4wyvlitbczAVTnHF/Lf9rmCZJsEq9ZRL/Yt2XjsDJZipso4v1HDIZpWz+1ZtEwS7jsUBGfMU4f1unFWU7qVyzuPtWQNXpNN/N8aY5PSccX8GZWFsvl0uuD+f5+lnvyaPV3xxBl24NEogmyp5mHG5NE8jJRaIIsJ+eZmz2xPjhKUq2/0+JAcS5uYQlGSAOqQ3F4lG8yc9dn3y308sV+t7dpOvKyLHQUtthAwH+d7oZJDpivW3OVMyrQNTEP5C8aXvLINw61L2resQiX4t82GdyMpNtRr4O54VOj8skedDRSE3krKhqQCzPUZRVXhLp/0LJpZqeUN1BUXdU8gLjTliMO2AeF0hsdl4Hd49A==;5:GQbvphsp7l+QouW9Xk01iTEGazj/utrT5mkBIc7kFGnWudSQXVgbqncGFdQQKIFR6aIdHrwk1LRUb28naF/HRcH9XnL87LL1b2CqvqkdBlogOmsCb129ZEIy9IVDQOmrzKuiq9aeV4uLfpt5FHAPsROI9EOzm9/PoyfKRsx5wkw=;7:+0UFOF67XZtaNL251sAxMxADQ+P3f3KbhQRXKPdZYS7jsLPrECXhzweLnph4QzlJqndsuR/iNg3BKMbUBUipSFUVi48YoDBtlL1N0x22zvkz//EuNC4krRmPT9VmwetcEOS6VKWpm40PBJ8UstwuUcnm7Z6WNPUqFOU7y3oP8qfBJ/WKLa1jSrcTABsdL9i8lCdfv5mRxIMfGX4MHly/w3jICBfGsoOCvTkGyWwkJQaYRmAOUU+ad1oXVzt1rLsB
x-ms-office365-filtering-correlation-id: 7a51698d-9d6d-4804-e3ae-08d6291122a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3649;
x-ms-traffictypediagnostic: AM0PR02MB3649:
x-microsoft-antispam-prvs: <AM0PR02MB3649AD69B16439FE8F9A15A893E90@AM0PR02MB3649.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051);SRVR:AM0PR02MB3649;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3649;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39840400004)(366004)(136003)(189003)(199004)(107886003)(5660300001)(6436002)(6486002)(3846002)(53936002)(86362001)(66066001)(1076002)(25786009)(102836004)(68736007)(105586002)(6512007)(4326008)(6116002)(106356001)(6506007)(36756003)(7736002)(97736004)(2501003)(305945005)(5250100002)(99286004)(71200400001)(71190400001)(81156014)(8936002)(110136005)(316002)(2906002)(52116002)(8676002)(54906003)(386003)(2900100001)(81166006)(14454004)(486006)(26005)(1857600001)(476003)(186003)(2616005)(508600001)(256004)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3649;H:AM0PR02MB3650.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iUBQ8UdrA3MqbItF9bWb2glJ30po5TYxkogMmseIfSFWTj/+tJCzncDh8Ntt106aQEPbyaqvPiDI8L46YjsmF92wI6AX2DDi6uwyfofkhK7DlZPYSWcjAmF3WBZiw8Q8wmgcxbR4Jo7HtcbKmda6O0s2SZG5NdbA1zpSo/REIHcsJ58euxQzGpHOvNF4oFcapSSrPvI2y8TT9+EGlTTyO+FgTE0GY4Zr2YYVcFSgiyi4yiGijlz5QgwN5EgakzbBmvSw2aepZu+bvLVH6PLnvAZDddd2aqfOVezpJSu6ZkD3MM/24xzRGys7v5Kk8RCEzIXtQDJHuZB8Rkmg/nV1RCgRpR7o8Omh68EZAbRVKcg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a51698d-9d6d-4804-e3ae-08d6291122a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 09:18:09.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3649
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Omer Dagan <omer.dagan@tandemg.com>

    add support for function in kernels under 4.8
    function is a wrapper around 'pci_enable_msi_block' or
    'pci_enable_msi_range' depending on the kernel version
    the min\max number of interrupts was overridden to always use the
    max number of interrupts which seems correct since it was not
    supported in the old APIs

Signed-off-by: Omer Dagan <omer.dagan@tandemg.com>
---
 backport/backport-include/linux/pci.h | 19 +++++++++++++++++++
 backport/compat/backport-4.8.c        | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/backport/backport-include/linux/pci.h b/backport/backport-incl=
ude/linux/pci.h
index 67ac40fc..531f5a47 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -134,6 +134,25 @@ static inline int pci_vfs_assigned(struct pci_dev *dev=
)
=20
 #endif /* LINUX_VERSION_IS_LESS(3,10,0) */
=20
+#if LINUX_VERSION_IS_LESS(4,8,0)
+#define pci_alloc_irq_vectors LINUX_BACKPORT(pci_alloc_irq_vectors)
+#ifdef CONFIG_PCI_MSI
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags);
+#else
+static inline int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int =
min_vecs,
+		unsigned int max_vecs, unsigned int flags)
+{ return -ENOSYS; }
+#endif
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,8,0)
+#define pci_free_irq_vectors LINUX_BACKPORT(pci_free_irq_vectors)
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(3,14,0)
 #define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
 #ifdef CONFIG_PCI_MSI
diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-4.8.=
c
index 7d056444..706bd067 100644
--- a/backport/compat/backport-4.8.c
+++ b/backport/compat/backport-4.8.c
@@ -9,6 +9,7 @@
  */
 #include <linux/usb.h>
 #include <linux/usb/cdc.h>
+#include <linux/pci.h>
=20
 int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
 			 struct usb_interface *intf,
@@ -144,3 +145,27 @@ next_desc:
 	return cnt;
 }
 EXPORT_SYMBOL_GPL(cdc_parse_cdc_header);
+
+#if LINUX_VERSION_IS_LESS(4,8,0)
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags)
+{
+	int res;
+	int msi_nvect =3D max_vecs;
+
+	if (max_vecs < min_vecs)
+		return -ERANGE;
+
+#if LINUX_VERSION_IS_LESS(3,15,0)
+	res =3D pci_enable_msi_block(dev, msi_nvect);
+	if (res =3D=3D 0) {
+		return msi_nvect;
+	}
+#else
+	res =3D pci_enable_msi_range(dev, msi_nvect, msi_nvect);
+	return msi_nvect;
+#endif /*LINUX_VERSION_IS_LESS(3,15,0)*/
+	return -ENOSPC;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+#endif /*LINUX_VERSION_IS_LESS(4,8,0)*/
--=20
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
