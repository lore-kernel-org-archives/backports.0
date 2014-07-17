Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56964 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaGQUX1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Jul 2014 16:23:27 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so3752786pdi.39
        for <backports@vger.kernel.org>; Thu, 17 Jul 2014 13:23:27 -0700 (PDT)
Date: Thu, 17 Jul 2014 13:23:22 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH] backports: include gpio consumer.h
Message-ID: <20140717202322.GV1390@garbanzo.do-not-panic.com> (sfid-20140717_222330_122288_A4E87382)
References: <1404999110-13791-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
In-Reply-To: <1404999110-13791-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 03:31:50PM +0200, Stefan Assmann wrote:
> While doing a make allmodconfig I noticed the following:
>   CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: l=
inux/gpio/consumer.h: No such file or directory
>=20
> Including the header fixes the error.
>=20
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>

Applied and pushed, thanks!

  Luis

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyDC6AAoJEKwtdpJg+MHGKDIP/A9H98hAWz/Nph1cRsE9O27T
rVUwB14E8pPxucFxIwINblaXzPcdeBbEwF+uOQX3TG4GiY9+xcB68N7H4BV5MUid
muwPxrtcA+KtCnrZwjtwomtqeDMy7p+noi3rIecmZL8Od2b8dykWL5cRiWM4ZA9n
tho0LmKU8TrPKpiumYy5q6VhLP3YPCW1zQUnabHIHObXhwTOR/2YBoLpdxgeD9Qy
mR4AmltPU/jAYNnof+P2OyXA/GQn0qnFUR7jXfCyiFztaApzAnbQriDY4dYE9j9T
wsujWPrmjln25g7FMuEnvtS7kn8uq/G1WXIC4gXFr3XmcWxfhR3UzYyjY3IUZ6MH
FvKtD/4VBXBnLmkxgNPcJipb92hBniOJLmPpgoWIMWgRRxk/z6SwdtgGwl7VOrNK
kfGRzHdcQwj34LRtbRY562s82AoLAyn1CN9PTJl1Oj22fgP7izpqt3uVAEKmNK9U
TExipzLDP7LV6xgy+ulI4xQnZRBVtbnnNzg3QM0OcuQjtheKyjr70RjtZh8qSWkX
40mNE8VrJgcgtqaaZWPRddRZq1QLEPXodu1Bsi+yrcq/zB1v9w38y1upCHH3vLrb
ef7vv8Ofnrx9nnQ4MkgH53TyeEzsoXoAA4k6lWBYYz0wfQBXCt46i/7QGiyBds+Z
hQrkJ/IzpkZC7UINkSM5
=/T+I
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
