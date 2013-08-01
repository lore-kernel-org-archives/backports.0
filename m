Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:51089
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932083Ab3HAThF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 15:37:05 -0400
Date: Thu, 1 Aug 2013 15:36:59 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cross compile backports?
Message-ID: <20130801193658.GE10904@shaftnet.org> (sfid-20130801_213710_342646_61476415)
References: <1375338204-2021-8-git-send-email-sujith@msujith.org>
 <1375370826-1387-1-git-send-email-sujith@msujith.org>
 <51FA8ECD.7070401@lenbrook.com>
 <20130801174749.GC10904@shaftnet.org>
 <CAB=NE6XqfKeddOSu=my3JOZDvg7nQtacZU6o4VeZXTZSLAAEnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
In-Reply-To: <CAB=NE6XqfKeddOSu=my3JOZDvg7nQtacZU6o4VeZXTZSLAAEnQ@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2013 at 12:03:08PM -0700, Luis R. Rodriguez wrote:
> https://backports.wiki.kernel.org/index.php/Documentation#Cross_compiling
>=20
> Patches welcome to help improve the cross compile install target.

I'm thinking the right way to proceed is that if CROSS_COMPILE is set,=20
simply skip all of the stuff that is only relevant for local systems. =20
(That and respecting a prefix for the udev rules)

I'll post a patch or two to that effect tonight.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iD8DBQFR+rjaPuLgii2759ARAroHAJ9pow+CVWXZ0srZxbMnC8/ZHrtaHACgojM7
SxetYMphucVh4ns8HdjXM28=
=4zBt
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
