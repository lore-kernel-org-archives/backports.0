Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40734 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3H0Sw3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:52:29 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so5209784pab.12
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:52:28 -0700 (PDT)
Date: Tue, 27 Aug 2013 12:01:49 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 1/2] backports: fix typo in define
Message-ID: <20130827190147.GG7485@garbanzo.do-not-panic.com> (sfid-20130827_205231_351305_599C5693)
References: <1377354539-9202-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
In-Reply-To: <1377354539-9202-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2013 at 04:28:58PM +0200, Hauke Mehrtens wrote:
> This fixes a build error one some non x86 systems.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks, applied and pushed!

  Luis

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPebAAoJEKwtdpJg+MHGKEcQALNa0f5f5C4uYnfo86yQK2zf
5Mua4+RTYVLtX3qYxDQpLXSZS4uh+g4dexHVNP2BRdbU7OKfP0LtU6d0Ubck1fRC
Z3q9aErjr3Gxy5HJkd3y15DgRQ1iBcMrzZ2swNXKcNeNRaewU9fT+eLFbYODSGmM
D6YhCGIaKkkMjy/TJ1GxHGdPbeT4xNl2WzIz1V8sLGZGCz/5in7SGAq8aJks0Y8h
oyfO+/meAeqI5PBFixHModJCoBj8xftpDV56rUe5Vsle0dtFNaGMlYZZx/YrjP2X
my0FWPCrNzZjNxD1ciEx/khfch4gyePCQXJYTaCvwptJiEL9bneW8c+T5ETS0oyZ
7UWMKBMNkuLXQDiOzb9XlnLC508LJ31f6l8GG+AKubqusoRec0WZa+nGDJYPHNxw
ey/5IzBVuI3zZZPbeU3puOwniWLH1Z9GoG7pYK/gskSNsMaypxNa9Ej0R4z0QEXs
0KzoEQjnZoa0BpbxW7x/gExtcjqbc6DseP8PlDocFWdBnDyHXe51ZfGC8D21E0Vu
RTrCoRSah0oAFIajwxo70W3Zf2riwP5sPYCBZhq79QqUZJvNfioE33rdNZjYpi4n
AksKHy0cjgFn3rtayWy0jfyS2BifyvITJ3dvNxqcyg/tztljzhENT+S6BF9rQN8L
bt4JplGWfCgQOK/jCxhi
=TZII
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
