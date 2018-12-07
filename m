Return-Path: <SRS0=K4sR=OQ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_TVD_MIME_EPI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256EDC07E85
	for <backports@archiver.kernel.org>; Fri,  7 Dec 2018 20:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7B820868
	for <backports@archiver.kernel.org>; Fri,  7 Dec 2018 20:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7B820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLGUBJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:01:09 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:59324 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGUBJ (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 7 Dec 2018 15:01:09 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 86A3848BEC;
        Fri,  7 Dec 2018 21:01:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id rrmUlZdVDdNH; Fri,  7 Dec 2018 21:01:05 +0100 (CET)
Subject: Re: [PATCH 00/12] backports: Multiple fixes for kernel 4.20
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org
References: <20181202115226.3594-1-hauke@hauke-m.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hauke@hauke-m.de; prefer-encrypt=mutual; keydata=
 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
 U9K2P2+nz7is4sF1hNVarw==
Message-ID: <0e648032-a788-5449-013c-a708e75cfa40@hauke-m.de>
Date:   Fri, 7 Dec 2018 21:01:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ClL0OOrpkTg6YgKAFGXFu5QUcxs2H0rZI"
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ClL0OOrpkTg6YgKAFGXFu5QUcxs2H0rZI
Content-Type: multipart/mixed; boundary="CWHBxJ5qxhOTdrzeZTD27WrSkZEnZtSzY";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org
Message-ID: <0e648032-a788-5449-013c-a708e75cfa40@hauke-m.de>
Subject: Re: [PATCH 00/12] backports: Multiple fixes for kernel 4.20
References: <20181202115226.3594-1-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>

--CWHBxJ5qxhOTdrzeZTD27WrSkZEnZtSzY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/2/18 12:52 PM, Hauke Mehrtens wrote:
> This fixes multiple problems in backport when using it with kernel 4.20=
-rc4.
>=20
> "ckmake --allyesconfig" results with kernel 4.20-rc4:
>=20
> 1   3.10.108            [  LINK  ]
> 2   3.11.10             [  LINK  ]
> 3   3.12.74             [  OK  ]
> 4   3.13.11             [  LINK  ]
> 5   3.14.79             [  LINK  ]
> 6   3.15.10             [  LINK  ]
> 7   3.16.61             [  OK  ]
> 8   3.17.8              [  LINK  ]
> 9   3.18.128            [  OK  ]
> 10  3.19.8              [  LINK  ]
> 11  4.0.9               [  LINK  ]
> 12  4.1.52              [  OK  ]
> 13  4.2.8               [  LINK  ]
> 14  4.3.6               [  LINK  ]
> 15  4.4.166             [  OK  ]
> 16  4.5.7               [  OK  ]
> 17  4.6.7               [  OK  ]
> 18  4.7.10              [  OK  ]
> 19  4.8.17              [  OK  ]
> 20  4.9.142             [  OK  ]
> 21  4.10.17             [  OK  ]
> 22  4.11.12             [  OK  ]
> 23  4.12.14             [  OK  ]
> 24  4.13.16             [  OK  ]
> 25  4.14.85             [  OK  ]
> 26  4.15.18             [  OK  ]
> 27  4.16.18             [  OK  ]
> 28  4.17.19             [  OK  ]
> 29  4.18.20             [  OK  ]
> 30  4.19.6              [  OK  ]
>=20
>=20
> Hauke Mehrtens (12):
>   backports: Refresh patches on kernel 4.20-rc4
>   backports: Add page_ref_count() and page_ref_sub_and_test()
>   backports: Add page_frag_alloc() and __page_frag_cache_drain()
>   backports: Add missing include for mt76
>   backports: Add device_get_mac_address()
>   backports: Remove BPAUTO_CRYPTO_SKCIPHER
>   backports: Fix pci_alloc_irq_vectors() backport
>   backports: Revert "dependencies: Make WIL6210 depend on kernel >=3D 4=
=2E8"
>   backports: Make TI WLCORE depend on kernel >=3D 4.2
>   backports: Remove unused code from backport-public_key.h
>   backports: Remove unused default configurations
>   backports: Update wifi default configuration
>=20
Applied in a little bit different order.

Hauke


--CWHBxJ5qxhOTdrzeZTD27WrSkZEnZtSzY--

--ClL0OOrpkTg6YgKAFGXFu5QUcxs2H0rZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlwK0YAACgkQ8bdnhZyy
68fA4QgA4g7BcF+cl/IPsptoaWKvSmFZMxlG+efVVQcYrGImbDaqfp8B+IX7Izgh
4GVvx6BzbM0RjZiOwHP4TBfRSNUB5Yx9ZrTw5CVVsGPCHSo6DWrhpI/xMElVvzzV
QEiZ7iEhBZmc/6AZg6AAg385QW90eFGHgTQJuM+bv0uuxonfQR7pNE/wnANY6SYz
hQLLBd89+N28g5L+8PNy8LrRduEgpEaCGS7BoEH62PkKHTzgR1zlx2NwGT9V8YRc
z+LkhaYy1OJETyo1r4m4sj1Jkj1OGMMvs88cEQluAnP16UoMYzYyXcZ8muq+79gQ
vLQhaUO0sVxnWoCP4QQ8JxqSAqupFw==
=rJ3I
-----END PGP SIGNATURE-----

--ClL0OOrpkTg6YgKAFGXFu5QUcxs2H0rZI--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
