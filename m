Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0261BC4338F
	for <backports@archiver.kernel.org>; Fri, 23 Jul 2021 13:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C777260EB1
	for <backports@archiver.kernel.org>; Fri, 23 Jul 2021 13:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhGWMx3 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:53:29 -0400
Received: from mx0a-00099901.pphosted.com ([148.163.145.250]:18392 "EHLO
        mx0a-00099901.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235005AbhGWMx3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 23 Jul 2021 08:53:29 -0400
X-Greylist: delayed 1841 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 08:53:29 EDT
Received: from pps.filterd (m0160113.ppops.net [127.0.0.1])
        by mx0a-00099901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ND1x8J004291
        for <backports@vger.kernel.org>; Fri, 23 Jul 2021 13:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bah.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=20190219; bh=ppa2Qlpt74wwPyW104qLFwDz1UryR9awEIfvCWtbDwo=;
 b=jb7HSaYCTW5LV+IJsmYuwWJKRFqvMmYKy36Z97BRsdCO0o93Cu+o1lAcSNpiTrhZcb4Y
 gZ2oTEPDMFJJxd2YwHBEHUJZhohQkSWZLLNeTMgHFFLLCiQt56NLz1hq8XKzp2tlbYdy
 44bkya33zeqXiriHjUXh5O8ggXn560tbjAPszZAHeMX0R+z6fI4K7kkMqgQit7bdEED3
 /aQBSM7HtU6m5yx7iLww52hr+kk+3vIBpcIYusHNZrs9TbDv8+V8J7ghQ8kaTDSJDSSV
 78SdwvJW56Zmemtmxx7gd+yjfVov3ytRHbBED/ZDmHTNZ35g17G2cQco/KVsuaHnxUVk qw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00099901.pphosted.com with ESMTP id 39xkf2yc1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <backports@vger.kernel.org>; Fri, 23 Jul 2021 13:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSIgE58Yr7Y5gEKAF+J43WwjsgzC5eDzs5nhWg0d+wwVhsqk7XlxqJUp9+tMOYsBly+3REd1dXx37B5OOPsWM4D5Jy1/onAyxNy94M9bbdK8LUHO0YWbl2o+im2uYrTbbF/d1/ME1/ffs6IUHzwa4oGw2r7lVTTA7uEn0A9a0QLy+F9jJo0YDXIYnjEiOQkeS/+jO5ctOSpGn6Eh+bDhovBXD34Klvi3wC+ntd9m3DcS+jKUrr23UN6ZOnr6BVqTfp9tHSOq0xYN8a9CJFsQnjAAPy11dBTbRhpezRdFmTiEI7JfT8x79g+9rBv1QhKQ2mZDq8BLdHZwT4jpWmEZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppa2Qlpt74wwPyW104qLFwDz1UryR9awEIfvCWtbDwo=;
 b=iI8RTVScyXWtWKWo0A1XNOFNg4CdEisXjlvQI6HaLpjA+xtOrBFQhD7TkLSi0cvMLq8gTEoPAlzivkpb4owsEoTqHtQ+K8aBSTrxxaxUMmn69wLlLqmpO9sl8aGpARuALzucFLihwoAgZrjnuJGRIzyfBVHgvrGSBTXqYghRQeXCsSddwrE0h598SU6JajBmZsZKuuIgOhRxP6Ox1px4xnqIY0uR8tzTq+BUmD00RS4YhX/2022No0kIifNdPtvtSi4qbFbqcFQuOCw46wi0fe0LUNZGx7YNUL/MbRehCP82rhQZs4q39czj4nEIdtoJtjKUGN5KhIj+1sOcjdRmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bah.com; dmarc=pass action=none header.from=bah.com; dkim=pass
 header.d=bah.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=BoozAllen.onmicrosoft.com; s=selector1-BoozAllen-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppa2Qlpt74wwPyW104qLFwDz1UryR9awEIfvCWtbDwo=;
 b=L2BH0yOX/fyvGUiKYsgBuIgIElNcMGM2yQ6UKg0LdJ7YwIMS5whDqxbPveVp4P+Zeo6HC6+O2A0LZ2ts6NudboXpCZW8V23/qYC3q3rGO26BZ8EkCZ80X7KcCiL2wTz9y9sFAkxjfOjBH+FKoSdYyJAK4H7IyMKaRTjzMXG0Yik=
Received: from DM5PR06MB3306.namprd06.prod.outlook.com (2603:10b6:4:45::37) by
 DM6PR06MB4458.namprd06.prod.outlook.com (2603:10b6:5:26::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Fri, 23 Jul 2021 13:03:18 +0000
Received: from DM5PR06MB3306.namprd06.prod.outlook.com
 ([fe80::681e:cc52:613c:f06a]) by DM5PR06MB3306.namprd06.prod.outlook.com
 ([fe80::681e:cc52:613c:f06a%4]) with mapi id 15.20.4331.034; Fri, 23 Jul 2021
 13:03:18 +0000
From:   "Cruz, Petagay [USA]" <cruz_petagay@bah.com>
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: amd-xgbe driver 
Thread-Topic: amd-xgbe driver 
Thread-Index: AQHXf8L46B/M9bXMlkGo73huYf9CHg==
Date:   Fri, 23 Jul 2021 13:03:18 +0000
Message-ID: <DM5PR06MB330601F41EF05DD66B0294D0E0E59@DM5PR06MB3306.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bah.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cde5c09-8a64-4f3f-3ac2-08d94dda3df5
x-ms-traffictypediagnostic: DM6PR06MB4458:
x-microsoft-antispam-prvs: <DM6PR06MB4458C9BBA78490156DEA5180E0E59@DM6PR06MB4458.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TDUQewhc8ZEvfx3SBiMZt/OJXCi6uIu+Z6z0XvefHKd6qvbvG7BQVutTMRbjS0sExTJ/11IOHVE5YXV5ARUIxoZQ/JYK4lCxcuNEOfWxU32JyOKVtr4Y95h5vc+xrSg8qy4T2gU+RdBmPgHxjrBybLjaG6H4QY4/e+R7Jm6EoVwBWNQlaUM2hZ7vwmCWcZkdsp3p25EViF7NYGvyAHIkg/ehip5fOxG1AnsylVLyoj5ms5SkkvKKAQnyzSw6qeRgAF4+HSNId00dFTl7lxSnOyu/WOuFcJQsWwv7Arp3m6hb8iH+T1SfE9L8teKeNhCj/xTZyWhFyRRh/AA9HPT+AzNjLGiDmOfrz6lyrD/MUVFfKUk5qzgbRJCc+V1zQrthkhm+0Hy/g038EWcOsNrTNCp7HeG3eTIu3VbHjuve8MLliL2w4zlPyvarjnZmJtDHnuQ/cGHJgCG1OgdkOWQnfL/PhAUpE0FwFY7oCdUM7VsDUtSA0v9Lej+zel1gPv4HXfQcpMFZmAT83Iu01qAkg5UhRtSU+49DzFieG5Z1VzlaA9HNPB/GhobSakIN0v6HSKQTr2l16JQgTPQLJN567G9u6hzbzMTXY8Y7aO1TWv5fH9DAXxtc6w79YbeApLdrUEpGvsFBIp70yLAMLhagpaEb3SODAWrwH25Ygt9TjXoKM/GFzGZxnYXt/EfyzYcpgddBO5GUv7yX+HLTszxuYoxrVkMa9oNaLXeJHPfRK9TEYb5aXISE1U5DyLhtiaKUmy+5dlSyfbhwpTqUM1WRymbcasf4jHO4YkLv2IlIBQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR06MB3306.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(3480700007)(76116006)(316002)(7696005)(66556008)(64756008)(4743002)(26005)(52536014)(508600001)(9686003)(66476007)(86362001)(55016002)(5660300002)(33656002)(2906002)(91956017)(38100700002)(8676002)(66446008)(6916009)(122000001)(966005)(71200400001)(66946007)(8936002)(6506007)(4744005)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iZYMKKVDbizbJAGkD8sCrF/9xnqGOLIS4WexaQIqc1P2hz9dShupSKLtPz?=
 =?iso-8859-1?Q?80ExW2oqlbyJtLjTRgtu1EeC6UQmmb/+xEZ6NBnp7fIXCE5D6i5Utn0mKF?=
 =?iso-8859-1?Q?IJXZW/EJskPHddyd9Zze+FtcuRtt8uLuhc6zqhNJQddaCb+CuATrVU1hxz?=
 =?iso-8859-1?Q?XDhgJcedBZI5DAgrtYRyaM+XpZey7i4wuI6YufM5mEHZZ6e6zCAAdzsMsa?=
 =?iso-8859-1?Q?FOoFA++IBTZIKiY+XRhF3BmYQToW6HF2ahAlmgKPA0YoUg7fPWq5Ce+7ng?=
 =?iso-8859-1?Q?7y8Oc4kdbx96vQkPGxq+aeCBaBLSottzgKW2qGuMqZBXZVVsqHKrVLhme7?=
 =?iso-8859-1?Q?ZGDmT8NZq8BPGC8mQUnJWHP2MYAdn6x5fzW31CBZ2ftBGqNnqQ5Baqvze6?=
 =?iso-8859-1?Q?0+Yf7ZQxxNJTvz3OE2oNRQXOsAxBfqzqi7Pi2ssLfYUxL/7EeieBK2MgMz?=
 =?iso-8859-1?Q?B77jUVANXb8KvVpyTfi8NfZkO83kUSMAeChNcc21RON0peHa7/EfL4mUuk?=
 =?iso-8859-1?Q?gwHa4nSwYKLa9ACW9USBc4h7ScGY21kY9wC9n44KZmgk2zedYEleX5gHmk?=
 =?iso-8859-1?Q?gcphMpbQ3YBsGMvqVbtQ+bX8IccAI1F4tfs775AFDT40H9e5K7oPxdZK8C?=
 =?iso-8859-1?Q?Vi7dK1QIRd1umDGthMaW68bN/s32Rapm3/P4RuO3Pb3/9r2+mxmPUAAa99?=
 =?iso-8859-1?Q?hkL7ZNYmFpb8gABsMk4ycqvj7qBWLbPltNJNS4/hcomQla9YWvl/ICUVeJ?=
 =?iso-8859-1?Q?NZ7l7s+MXnd2wr79DmOaoCcmGg7H8YvQ+pHxYLe+VBHdKRJn3zDqKRh0Js?=
 =?iso-8859-1?Q?Q5ASHdb6PU+ZFo+57Snd2ufPncz1wgvXbJmRgo0uxr+oGkR0W5ZgiTz69P?=
 =?iso-8859-1?Q?ligfhmg1b0LCgf6OCoM0ejTfdeSwXYkoEJyCRSzIAGvsS/XhdXYVd2ecca?=
 =?iso-8859-1?Q?NMHf51S+DnEokmKIu/QB+L2cxA7XYGxky8EtDMoWjbz9s/q0BDefljFQbL?=
 =?iso-8859-1?Q?gP+skBEt2UbO8m79GSD5S70GX0DL7QkcXimQHAd8Y4Uz2o54gGpGWQYqbq?=
 =?iso-8859-1?Q?JmFVoivScva0+hGgp75+wGZvKJdtxB5hP7Glth1vO3UtS/0F6Ia9pbNWdb?=
 =?iso-8859-1?Q?3DYSwpQOF4WVrCTiErtA3R5R4AcydJs74OPGqkRSkgOdxCwxOQ4O6lqo4F?=
 =?iso-8859-1?Q?USnsoxTldue1OoPjT5Taq4/HDfb31HFq2JM61QB5DmSz5qhWVO1GMXapa/?=
 =?iso-8859-1?Q?UBL7Pyo/eCSQsYone9NAaPl74yGfyygzVnIXIJt1aeQ3Kbh7/D+//0P+Sf?=
 =?iso-8859-1?Q?lx8fFfjlncwMWmrt6JbkOuUiNcUyOrtQVAMhssRv2tP/zulTE9SaALJT8Z?=
 =?iso-8859-1?Q?klzSbiL0Q5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bah.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR06MB3306.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cde5c09-8a64-4f3f-3ac2-08d94dda3df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 13:03:18.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5fe813e-0caa-432a-b2ac-d555aa91bd1c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhA+NtLf7NIIY8aVUmOsu0nmEEwJvkU61HH/0bk3ykPZUPcHxttaMfaDkbAUH1qt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4458
X-Proofpoint-GUID: yHKQN3x9mKn5efMC5ML6GiNE2xSgB-x-
X-Proofpoint-ORIG-GUID: yHKQN3x9mKn5efMC5ML6GiNE2xSgB-x-
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=703 bulkscore=1 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230078
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

I am working on CentOS 7, kernel 3.10.0-1160.31.1.el7.x86_64.   I would lik=
e to update the amd-xgbe driver to at least kernel v5.7-rc2.  I do not see =
this driver mentioned in dependences file for https://git.kernel.org/pub/sc=
m/linux/kernel/git/backports/backports.git/tree/dependencies?h=3Dlinux-5.7.=
y&id=3Da42aa4d474e5859164a00bf451970fb58b676fcf, or anyother really.  Does =
that mean this driver has not been backported?  =0A=
=0A=
I have not been able to build a Package releases, other than v3.10 on 3.10.=
0-1160.31.1.el7.x86_64.  Am I suppose to build package release v5.7-rc2 on =
my v3.10 OS?=0A=
Thank you,=0A=
Maria Cruz=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
