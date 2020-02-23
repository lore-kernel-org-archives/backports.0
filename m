Return-Path: <SRS0=W20+=4L=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_EPI,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CEC35673
	for <backports@archiver.kernel.org>; Sun, 23 Feb 2020 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22263206ED
	for <backports@archiver.kernel.org>; Sun, 23 Feb 2020 22:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgBWW06 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 23 Feb 2020 17:26:58 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:42284 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWW06 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Feb 2020 17:26:58 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48Qfv32MY5zQlJr;
        Sun, 23 Feb 2020 23:26:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id vkBS9XmBzZ92; Sun, 23 Feb 2020 23:26:49 +0100 (CET)
Subject: Re: [PATCH 02/15] backports: update x509.asn1.[ch]
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
 <20200221095437.fcc31f62d6cf.I268b63a7ca56b448e4a0ae8e2f4293561342648d@changeid>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Autocrypt: addr=hauke@hauke-m.de; keydata=
 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
Message-ID: <55f3752b-b334-a2af-75f3-4dc90cae9a4e@hauke-m.de>
Date:   Sun, 23 Feb 2020 23:26:44 +0100
MIME-Version: 1.0
In-Reply-To: <20200221095437.fcc31f62d6cf.I268b63a7ca56b448e4a0ae8e2f4293561342648d@changeid>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eMTkuwtJ82ukinojUleFtPaOYIpDQMLXF"
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eMTkuwtJ82ukinojUleFtPaOYIpDQMLXF
Content-Type: multipart/mixed; boundary="LI1y1Yb6BTAeoQ8jGigPuwsufAlAyZT9Q"

--LI1y1Yb6BTAeoQ8jGigPuwsufAlAyZT9Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/21/20 9:56 AM, Johannes Berg wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> In v5.2, x509_cert_parser.c implemented a new function,
> x509_note_params().  So we need the new generated asn1 files.  Update
> these files from the ones generated with v5.2

Should we generate these files automatically?
Sine this commit flex and bison are anyway needed for building:
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/c=
ommit/?id=3D4ec72687181df4b786152747c008a688c9b9b9de

Why did you use kernel 5.2 and nothing more recent?

> type=3Dmaint
> ticket=3Djira:WIFI-25529
>=20
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/compat/verification/x509.asn1.c | 105 ++++++++++++-----------=

>  backport/compat/verification/x509.asn1.h |   1 +
>  2 files changed, 55 insertions(+), 51 deletions(-)
>=20
> diff --git a/backport/compat/verification/x509.asn1.c b/backport/compat=
/verification/x509.asn1.c
> index 316c10e3267f..e68864b6a1f5 100644
> --- a/backport/compat/verification/x509.asn1.c
> +++ b/backport/compat/verification/x509.asn1.c
> @@ -13,13 +13,14 @@ enum x509_actions {
>  	ACT_x509_note_issuer =3D 3,
>  	ACT_x509_note_not_after =3D 4,
>  	ACT_x509_note_not_before =3D 5,
> -	ACT_x509_note_pkey_algo =3D 6,
> -	ACT_x509_note_serial =3D 7,
> -	ACT_x509_note_signature =3D 8,
> -	ACT_x509_note_subject =3D 9,
> -	ACT_x509_note_tbs_certificate =3D 10,
> -	ACT_x509_process_extension =3D 11,
> -	NR__x509_actions =3D 12
> +	ACT_x509_note_params =3D 6,
> +	ACT_x509_note_pkey_algo =3D 7,
> +	ACT_x509_note_serial =3D 8,
> +	ACT_x509_note_signature =3D 9,
> +	ACT_x509_note_subject =3D 10,
> +	ACT_x509_note_tbs_certificate =3D 11,
> +	ACT_x509_process_extension =3D 12,
> +	NR__x509_actions =3D 13
>  };
> =20
>  static const asn1_action_t x509_action_table[NR__x509_actions] =3D {
> @@ -29,12 +30,13 @@ static const asn1_action_t x509_action_table[NR__x5=
09_actions] =3D {
>  	[   3] =3D x509_note_issuer,
>  	[   4] =3D x509_note_not_after,
>  	[   5] =3D x509_note_not_before,
> -	[   6] =3D x509_note_pkey_algo,
> -	[   7] =3D x509_note_serial,
> -	[   8] =3D x509_note_signature,
> -	[   9] =3D x509_note_subject,
> -	[  10] =3D x509_note_tbs_certificate,
> -	[  11] =3D x509_process_extension,
> +	[   6] =3D x509_note_params,
> +	[   7] =3D x509_note_pkey_algo,
> +	[   8] =3D x509_note_serial,
> +	[   9] =3D x509_note_signature,
> +	[  10] =3D x509_note_subject,
> +	[  11] =3D x509_note_tbs_certificate,
> +	[  12] =3D x509_process_extension,
>  };
> =20
>  static const unsigned char x509_machine[] =3D {
> @@ -61,7 +63,7 @@ static const unsigned char x509_machine[] =3D {
>  	// Name
>  	[  16] =3D   ASN1_OP_MATCH_JUMP,
>  	[  17] =3D   _tag(UNIV, CONS, SEQ),
> -	[  18] =3D   _jump_target(80),		// --> Name
> +	[  18] =3D   _jump_target(81),		// --> Name
>  	[  19] =3D   ASN1_OP_ACT,
>  	[  20] =3D   _action(ACT_x509_note_issuer),
>  	// Validity
> @@ -87,7 +89,7 @@ static const unsigned char x509_machine[] =3D {
>  	// Name
>  	[  38] =3D   ASN1_OP_MATCH_JUMP,
>  	[  39] =3D   _tag(UNIV, CONS, SEQ),
> -	[  40] =3D   _jump_target(80),		// --> Name
> +	[  40] =3D   _jump_target(81),		// --> Name
>  	[  41] =3D   ASN1_OP_ACT,
>  	[  42] =3D   _action(ACT_x509_note_subject),
>  	// SubjectPublicKeyInfo
> @@ -109,7 +111,7 @@ static const unsigned char x509_machine[] =3D {
>  	[  55] =3D   _tagn(CONT, PRIM,  2),
>  	[  56] =3D   ASN1_OP_MATCH_JUMP_OR_SKIP,		// extensions
>  	[  57] =3D   _tagn(CONT, CONS,  3),
> -	[  58] =3D   _jump_target(95),
> +	[  58] =3D   _jump_target(96),
>  	[  59] =3D  ASN1_OP_END_SEQ,
>  	[  60] =3D  ASN1_OP_ACT,
>  	[  61] =3D  _action(ACT_x509_note_tbs_certificate),
> @@ -132,47 +134,48 @@ static const unsigned char x509_machine[] =3D {
>  	[  74] =3D  ASN1_OP_MATCH_ACT,		// algorithm
>  	[  75] =3D  _tag(UNIV, PRIM, OID),
>  	[  76] =3D  _action(ACT_x509_note_OID),
> -	[  77] =3D  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
> -	[  78] =3D ASN1_OP_END_SEQ,
> -	[  79] =3D ASN1_OP_RETURN,
> +	[  77] =3D  ASN1_OP_MATCH_ANY_ACT_OR_SKIP,		// parameters
> +	[  78] =3D  _action(ACT_x509_note_params),
> +	[  79] =3D ASN1_OP_END_SEQ,
> +	[  80] =3D ASN1_OP_RETURN,
> =20
>  	// RelativeDistinguishedName
> -	[  80] =3D  ASN1_OP_MATCH,
> -	[  81] =3D  _tag(UNIV, CONS, SET),
> +	[  81] =3D  ASN1_OP_MATCH,
> +	[  82] =3D  _tag(UNIV, CONS, SET),
>  	// AttributeValueAssertion
> -	[  82] =3D   ASN1_OP_MATCH,
> -	[  83] =3D   _tag(UNIV, CONS, SEQ),
> -	[  84] =3D    ASN1_OP_MATCH_ACT,		// attributeType
> -	[  85] =3D    _tag(UNIV, PRIM, OID),
> -	[  86] =3D    _action(ACT_x509_note_OID),
> -	[  87] =3D    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
> -	[  88] =3D    _action(ACT_x509_extract_name_segment),
> -	[  89] =3D   ASN1_OP_END_SEQ,
> -	[  90] =3D  ASN1_OP_END_SET_OF,
> -	[  91] =3D  _jump_target(82),
> -	[  92] =3D ASN1_OP_END_SEQ_OF,
> -	[  93] =3D _jump_target(80),
> -	[  94] =3D ASN1_OP_RETURN,
> +	[  83] =3D   ASN1_OP_MATCH,
> +	[  84] =3D   _tag(UNIV, CONS, SEQ),
> +	[  85] =3D    ASN1_OP_MATCH_ACT,		// attributeType
> +	[  86] =3D    _tag(UNIV, PRIM, OID),
> +	[  87] =3D    _action(ACT_x509_note_OID),
> +	[  88] =3D    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
> +	[  89] =3D    _action(ACT_x509_extract_name_segment),
> +	[  90] =3D   ASN1_OP_END_SEQ,
> +	[  91] =3D  ASN1_OP_END_SET_OF,
> +	[  92] =3D  _jump_target(83),
> +	[  93] =3D ASN1_OP_END_SEQ_OF,
> +	[  94] =3D _jump_target(81),
> +	[  95] =3D ASN1_OP_RETURN,
> =20
>  	// Extensions
> -	[  95] =3D  ASN1_OP_MATCH,
> -	[  96] =3D  _tag(UNIV, CONS, SEQ),
> +	[  96] =3D  ASN1_OP_MATCH,
> +	[  97] =3D  _tag(UNIV, CONS, SEQ),
>  	// Extension
> -	[  97] =3D   ASN1_OP_MATCH,
> -	[  98] =3D   _tag(UNIV, CONS, SEQ),
> -	[  99] =3D    ASN1_OP_MATCH_ACT,		// extnid
> -	[ 100] =3D    _tag(UNIV, PRIM, OID),
> -	[ 101] =3D    _action(ACT_x509_note_OID),
> -	[ 102] =3D    ASN1_OP_MATCH_OR_SKIP,		// critical
> -	[ 103] =3D    _tag(UNIV, PRIM, BOOL),
> -	[ 104] =3D    ASN1_OP_MATCH_ACT,		// extnValue
> -	[ 105] =3D    _tag(UNIV, PRIM, OTS),
> -	[ 106] =3D    _action(ACT_x509_process_extension),
> -	[ 107] =3D   ASN1_OP_END_SEQ,
> -	[ 108] =3D  ASN1_OP_END_SEQ_OF,
> -	[ 109] =3D  _jump_target(97),
> -	[ 110] =3D ASN1_OP_END_SEQ,
> -	[ 111] =3D ASN1_OP_RETURN,
> +	[  98] =3D   ASN1_OP_MATCH,
> +	[  99] =3D   _tag(UNIV, CONS, SEQ),
> +	[ 100] =3D    ASN1_OP_MATCH_ACT,		// extnid
> +	[ 101] =3D    _tag(UNIV, PRIM, OID),
> +	[ 102] =3D    _action(ACT_x509_note_OID),
> +	[ 103] =3D    ASN1_OP_MATCH_OR_SKIP,		// critical
> +	[ 104] =3D    _tag(UNIV, PRIM, BOOL),
> +	[ 105] =3D    ASN1_OP_MATCH_ACT,		// extnValue
> +	[ 106] =3D    _tag(UNIV, PRIM, OTS),
> +	[ 107] =3D    _action(ACT_x509_process_extension),
> +	[ 108] =3D   ASN1_OP_END_SEQ,
> +	[ 109] =3D  ASN1_OP_END_SEQ_OF,
> +	[ 110] =3D  _jump_target(98),
> +	[ 111] =3D ASN1_OP_END_SEQ,
> +	[ 112] =3D ASN1_OP_RETURN,
>  };
> =20
>  const struct asn1_decoder x509_decoder =3D {
> diff --git a/backport/compat/verification/x509.asn1.h b/backport/compat=
/verification/x509.asn1.h
> index 4f32a25d6660..77ec6085ae75 100644
> --- a/backport/compat/verification/x509.asn1.h
> +++ b/backport/compat/verification/x509.asn1.h
> @@ -13,6 +13,7 @@ extern int x509_note_OID(void *, size_t, unsigned cha=
r, const void *, size_t);
>  extern int x509_note_issuer(void *, size_t, unsigned char, const void =
*, size_t);
>  extern int x509_note_not_after(void *, size_t, unsigned char, const vo=
id *, size_t);
>  extern int x509_note_not_before(void *, size_t, unsigned char, const v=
oid *, size_t);
> +extern int x509_note_params(void *, size_t, unsigned char, const void =
*, size_t);
>  extern int x509_note_pkey_algo(void *, size_t, unsigned char, const vo=
id *, size_t);
>  extern int x509_note_serial(void *, size_t, unsigned char, const void =
*, size_t);
>  extern int x509_note_signature(void *, size_t, unsigned char, const vo=
id *, size_t);
>=20



--LI1y1Yb6BTAeoQ8jGigPuwsufAlAyZT9Q--

--eMTkuwtJ82ukinojUleFtPaOYIpDQMLXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl5S/CQACgkQ8bdnhZyy
68cFNwgA0O6u6LfQO/BpgHMIZEvnKIJNcgwtPC13yvOry04feHOvMVYQgZIOC4tz
i7rEtI28bWnCBJQYTsho+I06tmcU2kh89CMsNRp9szi4L+WOmfuSaYRWH3n3elpG
KQfCxSPKlqCGIS1C4NOIYFJ9wRLfh7/XWkdCIu8Lc+HijOmud4aQMQX4pRbY19yz
XVdWjwFYV/F4qJjV8cJcaLVmTrhudvpFIQ7nmWusZJg9+VSzruk1UgxRy6Pw5CZv
m60utGFFr/lXFsBo8So/Lj6yzGGacnB8L+dbfzpZqjAvsZ8l5Sz+B7cUG/XyOMvh
RJnrqcylbDhNIQdcKSlqDySQw5DCYA==
=gXN1
-----END PGP SIGNATURE-----

--eMTkuwtJ82ukinojUleFtPaOYIpDQMLXF--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
