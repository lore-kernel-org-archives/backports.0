Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ben@decadent.org.uk>
Message-ID: <1363790495.31336.51.camel@deadeye.wl.decadent.org.uk>
Subject: Re: Bug#703142: compatibility with alx ?
From: Ben Hutchings <ben@decadent.org.uk>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, 703142@bugs.debian.org,
	=?ISO-8859-1?Q?Camale=F3n?=
	 <noelamac@gmail.com>
Date: Wed, 20 Mar 2013 14:41:35 +0000
In-Reply-To: <CAB=NE6UPgjOXi7wWBmA5XVHY8MMcf6KwqSWxWViM6kiJYpV0tA@mail.gmail.com>
References: <20130317144603.GA4850@stt008.linux.site>
	 <1363532310.3937.266.camel@deadeye.wl.decadent.org.uk>
	 <20130317152428.GA4940@stt008.linux.site>
	 <1363544257.3937.278.camel@deadeye.wl.decadent.org.uk>
	 <1363556604.3937.285.camel@deadeye.wl.decadent.org.uk>
	 <CAB=NE6UPgjOXi7wWBmA5XVHY8MMcf6KwqSWxWViM6kiJYpV0tA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-VnFagVaRJoGBiQZ3xdks"
Mime-Version: 1.0
List-ID: <backports@vger.kernel.org>


--=-VnFagVaRJoGBiQZ3xdks
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2013-03-20 at 02:07 -0700, Luis R. Rodriguez wrote:
> On Sun, Mar 17, 2013 at 2:43 PM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> > [Re-sending to the correct list address.]
> >
> > On Sun, 2013-03-17 at 16:24 +0100, Camale=C3=B3n wrote:
> >> El 2013-03-17 a las 14:58 +0000, Ben Hutchings escribi=C3=B3:
> >>
> >> > On Sun, 2013-03-17 at 15:46 +0100, Camale=C3=B3n wrote:
> >>
> >> (...)
> >>
> >> > > Using Debian's stock network driver is not an option for me (full =
report
> >> > > available here=C2=B2) so I have to try with the latests drivers bu=
t now that
> >> > > "compat-drivers" are compiled the generated modules cannot be load=
ed.
> >> > >
> >> > > Is there any by-pass for this?
> >> > >
> >> > > =C2=B9http://marc.info/?t=3D136351034300002&r=3D1&w=3D2
> >> > > =C2=B2http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D664767
> >> >
> >> > Talk to the compat-drivers developers.
> >>
> >> To be sincere, I don't think that's a user's role.
> >>
> >> I don't know what's going on with these drivers but if they are not
> >> supported by Debian at all it would be better for all of us (plain
> >> users and developers) to simply say it so to avoid wasting time and
> >> resources.
> >
> > I would like to support them, in fact more than that I would like to
> > integrate them into official packages.  But there is no way we can
> > support an OOT module that defines symbols that we might need to add fo=
r
> > our own backports.  As it is 'compat' will ironically cause
> > incompatibility with Debian's own kernel upgrades.
> >
> > Compat developers: please add a prefix (not 'compat', that one's alread=
y
> > taken!)
>=20
> We have been using compat_ for a while now to prefix a lot of our
> symbols without clashes for the 32-64 compat stuff, but sure -- we can
> use something else to help with any theoretical issues. Surprised
> Debian of all distributions would frankly have been affected given
> RHEL / SUSE didn't, but its OK, lets deal with it.

The conflict that just showed up in Debian involved the 'i2c_bit_algo'
symbol which had no symbol prefix in 'compat'.  We updated the in-tree
DRM drivers from 3.4.32 and started exporting the symbol from
i2c-algo-bit itself.

I hadn't noticed that you already used the 'compat_' prefix for some
exported symbols and I'm not aware of any current conflict with the
32-bit compatibility layer, but it seems plausible that it could happen
in future.

Ben.

> > to all the symbols exported by the 'compat' module.  Just
> > #define'ing the function/variable name before declaring them should
> > avoid the need for any changes to the drivers using it.
>=20
> How about backport_ ? Patches coming up.
>=20
>   Luis
>=20

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                            - Robert Coveyo=
u

--=-VnFagVaRJoGBiQZ3xdks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUUnKn+e/yOyVhhEJAQpR6hAAq7hIGO452VY5FQDNtRNBjbaA7/7Fc6Fb
yww9NggPT3eV8O2sMbR+O+nbXPKBspcY5MppX0c0mDa2hifbJn8i5TphZ8/GwTum
R0C247MCCEH1Cv1ORB8owVRBwy/9WqrpWfG0RBfl2f2Ix3Ygxn7UHgyhqkVCnJ3i
NdTVKygUoqQCcnHv0BWi+WHJZEbR1rK/j+Tr35Gc6vZiRSkYWXTYlHUrFfqtAMU4
v+7dOqyK+Cj8JmbyGlpInLj9PYPw7U0Wdz8NA/HSj1ir/bKk5/4NByLhlWIN4XmM
Wn8Szy+L9zu7QwZs33AMx0BLdoiARnkJ2H0QtlqWvbWXIljpH2ysZZRW1SAlAK8/
v3mVijhPkES8NuYBcXLAaa+yI+M6zC4/ecbCGGaHTRKmjNaZh3aCzligHwTpS7JR
voW2eg3NTjC+YyBqZE0kiIIKj7NL1VX02qA79H0ont4g/qDTj6BcRIHa97PBNFIw
uX07xHqA2dMfKgS+wl5Ma1/bikh+awyoIMbyULoTjpnitrb+dnWR51rO3eM2REu6
sm3zLoY9IqFrXNvFV9Vn0VeMz0p6toK2DMQjN8ZkvBg6GVYFGW9hui0agdwPXVuT
mQMzo3uUL55wZah/Ova/IAPfNF5j9sSd+jB6Ts/g68I8GbBkDp1jLyhHBaazNfI4
+nFN5kb0/ts=
=CPcP
-----END PGP SIGNATURE-----

--=-VnFagVaRJoGBiQZ3xdks--
