Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:32845 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3H0Sqf (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:46:35 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so5173341pbc.23
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:46:35 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:55:32 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH v2 00/19] backports: add support up to next-20130802
Message-ID: <20130827185531.GB7485@garbanzo.do-not-panic.com> (sfid-20130827_204637_560264_FB016225)
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 01:37:45AM +0200, Hauke Mehrtens wrote:
> This adds support for linux-next next-20130802.
>=20
> It is based on top of Solomon's "Enable cw1200 on >=3D2.6.34" patch serie=
s.
>=20
> Changes since v1:
>  * use Johannes patch to backport sysfs
>  * add support for next-20130802
>  * fix build if arch_phys_wc_add() is already in the kernel
>  * some additional patches

Thanks, applied and pushed!

  Luis

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPYjAAoJEKwtdpJg+MHGl6oP/RTlBBve14jzlY8l7oG/ZDzt
YxG1W6Aik0E0I5ctVZr3gwc5yDw18f4ENxoIjzOb6zID7eUP9Xeuu5gafU1l9K+F
Fpr2PeVAEr8WsqjJC/BlIAz635cZsyYV0ZV44LwNmJyDuF88wg44KpmipWFCnDFq
taIsgDMZlffzn/UYwzAyqpTbJuiJqSBsmRNjwTbwvZcFeVyDpvU7hHiTgQJ+y2g5
V9H1AkSvANUwfGAuaYi5SPm2PUxITGSx1B2jBXfJNidOHKilJ1N//G+Q/NG2e28D
UAQO3zYUwILKIj5pp0OHt1W5kVw/0u78/DZmCiC9IqDa56q9TjHX1ejPe5XJQ0my
xnfa4m9SKoJJ1SBAIff47+qezAphnuuARqeoz0aw0CDJ8SAJSthXFiYxD4fOYWF6
XuLpkVSFk80/8R9AoWd87fmnzdSUqRTOc5Hidh7dZyA7BysxH62NmXy5VIKrDLkn
muVWLkBtFZ//jnCGEtIGoBfVRZHFWQMG1Qygc0XoIobiZnNlHnkYic8aBxtXxIyT
vfdooZrQ1p6yu0R1UlHXNC82SXFpZEm2MTdKfwLeUgLW87LMsSEReWjdtrVNMct+
Cinz/sT55nUuAN6BEY56XoBThZoZxZQ/ZlmLXFN189AFA9dWvQfaYSzoLBhwD8NC
HdWUXx9nvxOSUf9wO9mz
=4IqE
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
