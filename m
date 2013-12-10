Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:37686 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3LJJjr (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 10 Dec 2013 04:39:47 -0500
Received: by mail-we0-f172.google.com with SMTP id w62so4751447wes.17
        for <backports@vger.kernel.org>; Tue, 10 Dec 2013 01:39:46 -0800 (PST)
Date: Tue, 10 Dec 2013 10:39:43 +0100
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Daniel Schultze <kinglag@gmail.com>
Cc: backports@vger.kernel.org
Subject: Re: menuconfig
Message-ID: <20131210093943.GA16978@cerro.do-not-panic.com> (sfid-20131210_103951_210814_A7DC787C)
References: <CAEsx0Y_RwZSks_EqBYY7XxUgiRaX4qP-yrSK4Lx4Mbdi1iqNtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
In-Reply-To: <CAEsx0Y_RwZSks_EqBYY7XxUgiRaX4qP-yrSK4Lx4Mbdi1iqNtQ@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 03:12:55PM -0800, Daniel Schultze wrote:
> Hello Developers,
>=20
> I'm trying to use backports for its updated Bluetooth drivers on
> Kernel 2.6.31. When I make menu config in LTIB the line for Bluetooth
> support does not appear, however when I make menuconfig for the host
> the line for Bluetooth appears,=20

I am unfamiliar with LTIB and its unclear what you mean by running=20
'in LTIB' and then 'for the host'. I take it LTIB lets you package
of kernel and by 'in LTIB' you mean for the target kernel /
architecture. By 'for the host' I take it you mean -- on the local
build machine, not the target kernel. If I deciphered your issue
then be sure to read this documentation:

https://backports.wiki.kernel.org/index.php/Documentation#Cross_compiling

Also since you are using LTIB and if you succeed it seems worthwhile
if you can add an LTIB section to the documentation unless the existing
documentation already suffices, but it seems there is a section already
for LTIB:

https://backports.wiki.kernel.org/index.php/Documentation#Cross_compile_wit=
h_Freescale.27s_LTIB

Please cross check against that.

> I'm using the same source archive from
> backports-3.13-rc2-1 and I also tried backports-3.11.8-1 with the same
> result. What should I check to make the Bluetooth line appear?

In general if you don't see the entry it means your target kernel's
configuration does not meet the requirements needed to enable the
backported driver / feature. Check its dependencies just as you
would for a normal kernel.

  Luis

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSpuFfAAoJELt3oFG5aZ5LrqoQAJz7MDe69eaN+hJj7utruXKo
Z73N0AsANP3g1jETa7Qw7YGYlZ+hPwp/EIvS6V9Hlo6R6T5U7fHe2aPGzOnvXfU4
ueuiv/16jP1QINKl+XrM9pc28WZWqQdr1VocfpqSh+We+WYTbVx1lrU5KeHr+h5p
5Ri3NLbHLUdfzFr1ZGfqlIg1pKQv4TjuoRXcbyjQR79x9Sq69NqdX1n4xMToM1Bb
BijVYfcsh3SyQrp2wn8LsEJEDMBxXe8bTS5u5AQq9ka16tjpvztxXkNgEZWkqWvb
2V0DoOR7usxwlqHfkhVvf3ATWC8x5TSx0Jqm8sQJfcucvFyVTBnoTxFiJN7491LW
i62TjBDftP/fykqKMPljlCQ4pTirZqy8dfpPT2cJfMGy0ll5uAwRkOADDQZUHYza
rut2A+bGN4JFcpCjl8RFjQgA6x/j9HR6AC+ktpdjZsDSD12R/yZ7w6ZXT0AO9YBl
GtSS5L74V+59pvDlx4z9KUUui/7ArzBSMGoMazZlvwe6OCPTA8BFWrKMbbJGqB+8
ckeWf8+O0k+Td59AT0/tfIC9pWD7m2GggMRnhgeydckXRc+OzYX3uARg8eDB4BOu
WoYpp8ZOGX8tLhaz8QODkcMEZDQqGvQ854qmtSgQ3Byd0rAcsEsLh/5jHe8IMucq
sLR43mSTMwLI/jDWM0bx
=7omF
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
