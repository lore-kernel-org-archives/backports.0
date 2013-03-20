Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54472 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab3CTRp0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 Mar 2013 13:45:26 -0400
Message-ID: <1363801516.31336.68.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#703142: compatibility with alx ?
From: Ben Hutchings <ben@decadent.org.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, 703142@bugs.debian.org,
	=?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
Date: Wed, 20 Mar 2013 17:45:16 +0000
In-Reply-To: <CAB=NE6UZ+RvFHyzUhSwzATnkd9gAGa0EKDQD+U9vxVM8FSvLrA@mail.gmail.com>
References: <20130317144603.GA4850@stt008.linux.site>
	 <1363532310.3937.266.camel@deadeye.wl.decadent.org.uk>
	 <20130317152428.GA4940@stt008.linux.site>
	 <1363544257.3937.278.camel@deadeye.wl.decadent.org.uk>
	 <1363556604.3937.285.camel@deadeye.wl.decadent.org.uk>
	 <CAB=NE6UPgjOXi7wWBmA5XVHY8MMcf6KwqSWxWViM6kiJYpV0tA@mail.gmail.com>
	 <1363790495.31336.51.camel@deadeye.wl.decadent.org.uk>
	 <CAB=NE6UZ+RvFHyzUhSwzATnkd9gAGa0EKDQD+U9vxVM8FSvLrA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-82wcdZkfZ3c22FRTNjoc"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--=-82wcdZkfZ3c22FRTNjoc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-03-20 at 08:50 -0700, Luis R. Rodriguez wrote:
> On Wed, Mar 20, 2013 at 7:41 AM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> > On Wed, 2013-03-20 at 02:07 -0700, Luis R. Rodriguez wrote:
[...]
> >> We have been using compat_ for a while now to prefix a lot of our
> >> symbols without clashes for the 32-64 compat stuff, but sure -- we can
> >> use something else to help with any theoretical issues. Surprised
> >> Debian of all distributions would frankly have been affected given
> >> RHEL / SUSE didn't, but its OK, lets deal with it.
> >
> > The conflict that just showed up in Debian involved the 'i2c_bit_algo'
> > symbol which had no symbol prefix in 'compat'.  We updated the in-tree
> > DRM drivers from 3.4.32 and started exporting the symbol from
> > i2c-algo-bit itself.
> >
> > I hadn't noticed that you already used the 'compat_' prefix for some
> > exported symbols and I'm not aware of any current conflict with the
> > 32-bit compatibility layer, but it seems plausible that it could happen
> > in future.
>=20
> Sure, let me know what you think of the proposed posted changes.

All looked fine to me, but I'm not that familiar with the compat-drivers
code base.

Ben.

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                            - Robert Coveyo=
u

--=-82wcdZkfZ3c22FRTNjoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUUn1rOe/yOyVhhEJAQqS6BAAzjixq/GqX7PS+CvwRcXBrwVd79IMyOrV
vt9G79Ts605ezuh7240AwFGs/GeQZmS4JDhpIHlg6aY+BY4tyz5GXIpdC61p/MIZ
VHFllNXsFTunwU+vEsVFzKqq1uIQGVcrucJegRSBdjlPKW/2Phl0hI5HHjtdfaN2
lIZ7chB1GbFTkKVkjaYTLSf7OmnvJTxFEQKpUpq43SzJAAN4yvYGnZZJKaP25hOs
4uv11BgEXUoCChSvTwMxPtoFWfrOJDv7sNikgcoLLwR67wMkgcHvy6IUljWVT42t
sKmN945wZJaRcMjrLvTKvKoXdsy+cfr7Ljg4G+9b2k2OKlrw9nAVziBzsOltG2wO
sVDaiZZ8d8IAwd4XvuqmAWxexrNQWs6kkQKa6KuRBxBY6UiyEfzGP8Mz0IbHZW7P
AUf3EyJXaahhvzjtniKj6yjFjHTlCz2ehvMr5QavOfBD/LPFPL8NLu8wplzuwYbN
cJ5Axykma5iZExBfQYlMFoelmrIJl0011eWryukW1LQxge5qwUHqpGo9hN+nxlND
C4e/V0McJinX961vNGZDY4FGqO52kfmKJuMKPKDwygJMCkFqiEvJ4cRGqzVtHVHn
nqbSkjoTZKEYWhuIk/v6a8BqVnVUoSdzMg2cV1x7SPv4sIPP9PpVVwfke7uN6qjz
MW0/q3xAJC8=
=n0sb
-----END PGP SIGNATURE-----

--=-82wcdZkfZ3c22FRTNjoc--
