Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:56713 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3H0Sbj (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:31:39 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so5264915pdi.28
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:31:39 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:41:00 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Solomon Peachy <pizza@shaftnet.org>, backports@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Enable cw1200 on >=2.6.34
Message-ID: <20130827184058.GA7485@garbanzo.do-not-panic.com> (sfid-20130827_203151_178091_6770E611)
References: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
 <52114ABC.10908@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <52114ABC.10908@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 12:29:16AM +0200, Hauke Mehrtens wrote:
> On 08/17/2013 03:02 PM, Solomon Peachy wrote:
> > This superscedes the earlier patch set I posted when apparently sleep=
=20
> > deprived.  It enables the cw1200_wlan_sdio driver to build cleanly on=
=20
> >> =3D2.6.34 kernels, and the cw1200_wlan_spi driver to build cleanly on=
=20
> >> =3D2.6.35 kernels.
>=20
> Hi Solomon,
>=20
> I compile tested this and haven't found any problems in cw1200 with this
> patches applied.

I've applied these and will push out later. Thanks!

  Luis

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPK5AAoJEKwtdpJg+MHGnQIP+QGUadUPnZAQM0IB1L1TiO18
NZFFohit3O93qgHXz7rvJ55ZgXgWXg/PD2ciuREVPpS0UdU5nfLJVbe5URNkzjJT
4sdsgdBI3aBnCbuROcbi8oJHyx1CYWTlTDdldZ02m47ED59bz7WjorDuX3zwrJWg
PkDdqzMkKmpTcls2+b5ud3k/cVpKW8zG9wuGegvzdvGruBCwX/DvTVwCiEla/ERw
8dLKRSoaFLhZY8noC9+w2Y84YRICAy6cPav0BfxwOuxF2xwU3JI9l7Zcgb1MSjJJ
PnBF+ASbYDW+RMyHO3zdJCkaSvBfLdMD+qYPElRkGmyLc8s1rdS0e9nqT/r5nAQo
JAH356rW8h4ba3WvFan/MGEo9c+YodQ9gKKXsAn4CrAmf8fGNFCwaT7gSyU87srD
3+ZvldO8fiyG2oKtuFOAxtdbD/WsivFdVuMS3560QnlUDMcUEb013VMEZsvd3JUP
LKsh8v9CcCXccxUC0rnBlyB+icbuADzpn+BP3/qbHlwLEEG1LBQFRCnnrvplSQXi
ZcMWqLwtWG89XOM+3SGHQCVda1pYNbU/Gh5qB7bGIZth7v22H69CV9Hz1lodmxpI
qycLXRUUCQBCp5narFqd9C7IzufguWNqqfq7z/uUwbl09O9XxhZLl2//j8f81r1p
FWtjX/5i1f/I4SCI7LO5
=t+U3
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
