Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:63805 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab3LBOkx (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 2 Dec 2013 09:40:53 -0500
Received: by mail-wg0-f51.google.com with SMTP id b13so9007479wgh.6
        for <backports@vger.kernel.org>; Mon, 02 Dec 2013 06:40:52 -0800 (PST)
Date: Mon, 2 Dec 2013 15:40:47 +0100
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 1/5] backports: check for define in module_driver and not
 kernel version
Message-ID: <20131202144047.GA4884@cerro.do-not-panic.com> (sfid-20131202_154105_511576_5E68EC38)
References: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 08:54:39PM +0100, Hauke Mehrtens wrote:
> In some places backports checked for the kernel version on weather to
> add a own define for module_driver or not. This patch makes it check if
> there is already one or not.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks! Applied and pushed all patches!

  Luis

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSnJvvAAoJELt3oFG5aZ5Ld9YP/1BLpW8FmBaCtGrCgL7parua
VJ60W210635FGKhEe2WxYaYT5y7+0AWabJ7zqy5gGKmB4PhvuRKTJZoag4uQX2nd
+D85LH78D3BA2/hU/aabS5mwb44ygrMuuyJ6g+3mpn/oNw9Y/+5TJSbV0T3CrTow
AEd/T2u5pVP+cTBuzlmvIeHIb5RgNfiRvntmBRCaw8lZPePNSicqGdpYYJFDIMkW
oKbu8//8C+a90NrEwJYdVjMpGWOuVNp2PvobeaTjWuac2Qx6JknEoUxUoUMlKt3/
sAarDoY6vQU7T+PI/zR0VtudbGA6DdTylln9nxTbZc7Uk5cFzUeP9LZ5R5UPoIGY
QGe5gRBioCsrW2GgKryyL1rObVHbQT4LhkwRG+C52bhpxbS94riyjAlAyhZ/2+Sh
v1YUzdeV7a2scCDNQsIO35jnYPZggNpKRLITztcz2PjI9l9x9OqOuyoo7BDRT8hF
VTiRiAojLk2tr4QaZxN0yWOP5YwZ0rorES2+DGbR04h2Ya967TL8YIv53dC347G/
E6ye3obNVJod0oeMW8rYKUkC0eplU1Cmts87z7ehJ+QWwZG5tl/6+gdBXhs9WjYx
PqZk3QhYOvNtZfJscMOieNX0T9mb21i7HHoJe88hsEKcC7jIYG2Ib7IRgdxDUtWn
0GWjnQkHCQS42aCA6qdW
=CANH
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
