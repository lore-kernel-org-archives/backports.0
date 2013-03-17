Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59417 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932418Ab3CQVnk (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 17:43:40 -0400
Message-ID: <1363556604.3937.285.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#703142: compatibility with alx ?
From: Ben Hutchings <ben@decadent.org.uk>
To: backports@vger.kernel.org
Cc: 703142@bugs.debian.org,
	=?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
Date: Sun, 17 Mar 2013 21:43:24 +0000
In-Reply-To: <1363544257.3937.278.camel@deadeye.wl.decadent.org.uk>
References: <20130317144603.GA4850@stt008.linux.site>
	 <1363532310.3937.266.camel@deadeye.wl.decadent.org.uk>
	 <20130317152428.GA4940@stt008.linux.site>
	 <1363544257.3937.278.camel@deadeye.wl.decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gjsHfV6bj1ljXmlcHoaO"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--=-gjsHfV6bj1ljXmlcHoaO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Re-sending to the correct list address.]

On Sun, 2013-03-17 at 16:24 +0100, Camale=C3=B3n wrote:
> El 2013-03-17 a las 14:58 +0000, Ben Hutchings escribi=C3=B3:
>=20
> > On Sun, 2013-03-17 at 15:46 +0100, Camale=C3=B3n wrote:
>=20
> (...)
>=20
> > > Using Debian's stock network driver is not an option for me (full rep=
ort=20
> > > available here=C2=B2) so I have to try with the latests drivers but n=
ow that=20
> > > "compat-drivers" are compiled the generated modules cannot be loaded.=
=20
> > >=20
> > > Is there any by-pass for this?=20
> > >=20
> > > =C2=B9http://marc.info/?t=3D136351034300002&r=3D1&w=3D2
> > > =C2=B2http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D664767
> >=20
> > Talk to the compat-drivers developers.
>=20
> To be sincere, I don't think that's a user's role.
>=20
> I don't know what's going on with these drivers but if they are not=20
> supported by Debian at all it would be better for all of us (plain=20
> users and developers) to simply say it so to avoid wasting time and=20
> resources.

I would like to support them, in fact more than that I would like to
integrate them into official packages.  But there is no way we can
support an OOT module that defines symbols that we might need to add for
our own backports.  As it is 'compat' will ironically cause
incompatibility with Debian's own kernel upgrades.

Compat developers: please add a prefix (not 'compat', that one's already
taken!) to all the symbols exported by the 'compat' module.  Just
#define'ing the function/variable name before declaring them should
avoid the need for any changes to the drivers using it.

Ben.

--=20
Ben Hutchings
Usenet is essentially a HUGE group of people passing notes in class.
                      - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette=
'

--=-gjsHfV6bj1ljXmlcHoaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUUY4/Oe/yOyVhhEJAQpHHg/+OE7L5B1OgpvE5Go1qhuLcBh2OmS+S+qa
UC3+KVGHZ30kQH5JFE+CuN2rC/hFZhUMsN5smya9nftbb+E08LSaoOBrSvaNRg/N
uHlxFmiAyQX0xQrcsjFP+/afyMmW+F+ACzOI9DvFGaUy//IPgW6LblSpBWe4fXXs
kzy0S3Mj0P9waqiZUl3t9/9ngOwvnetVOjW3EavZG9BqT9Jum+k3yTgLkxaZdKWm
+pmE7qa4Tn3D7SutrOr3Gy3E7k5VfYj5G2J1AMjxZrU4wpe9uK+GC0KElNcfPgSv
WNNXeqVfgZfELOqDV5c9eoJjQ2wblDfaeBj79dNKaTng2I2/ajazGAw55zm8eaQb
TGa9HRt5Sbidf4GRay4EeFIK9ZsL8sbhoSM8nm9hm3E3mqvwloML0OnJz2Bxk5Ca
PgM3ilH35CfsBCmN6qZ/P3krLLw91qTnHPs22BnjWCmRcQ0RTKZiMTPMGSYqH7MF
Q2yxxjSBr1f8m4Z+mwBoKIoIPcQbxgi8Z42B8wDtPiW/3gcUjU3q+iwNNsJV1lmf
dac96kFw1CrrTU7YlrcR4cGHzXA1OeXmRcOWXw+DOMsPMwh6mTRt4VQYwLbpcx5l
BPiB3ftssGwNWK/4PZcZN6Y1seZ4wRWfSYACcAG1K7bLzniSwetIM5Rv5smHO/Wc
mXXEacRBp1o=
=cIz+
-----END PGP SIGNATURE-----

--=-gjsHfV6bj1ljXmlcHoaO--
