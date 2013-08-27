Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:65325 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3H0Stz (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:49:55 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so5202975pbc.22
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:49:55 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:59:16 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [RFC] remove support for kernel 2.6.24
Message-ID: <20130827185915.GE7485@garbanzo.do-not-panic.com> (sfid-20130827_205005_383957_13423C59)
References: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net>
 <CAB=NE6VBhHkfFPd-kBKfscy2P=EVQ7jNevYQ5nVU2y_aFsCP-Q@mail.gmail.com>
 <1377618602.20012.10.camel@jlt4.sipsolutions.net>
 <CAB=NE6X8je5=box6DzH0bz2k4NWCvN9a_oZ7XSARLOGmQYiuhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
In-Reply-To: <CAB=NE6X8je5=box6DzH0bz2k4NWCvN9a_oZ7XSARLOGmQYiuhA@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 08:50:56AM -0700, Luis R. Rodriguez wrote:
> On Tue, Aug 27, 2013 at 8:50 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Tue, 2013-08-27 at 08:48 -0700, Luis R. Rodriguez wrote:
> >> On Fri, Aug 23, 2013 at 4:43 AM, Johannes Berg
> >> <johannes@sipsolutions.net> wrote:
> >> > From: Johannes Berg <johannes.berg@intel.com>
> >> >
> >> > By requiring 2.6.25 we can get rid of quite a lot of backport work.
> >> > 2.6.25 was released more than five years ago (April 2011) and wasn't
> >> > a long-term kernel either, so there's little point in supporting it
> >> > now.
> >> >
> >> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> >>
> >> I'm fine with this, please feel free to send as patch form unless you
> >> want me to just accept it as is, I'd test compile it before
> >> integration into the public tree.
> >
> > I think it's ok, the [rfc] was more for the fact of removing it rather
> > than the contents.
>=20
> OK I'll apply then, thanks.

Applied and pushed.

  Luis

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPcDAAoJEKwtdpJg+MHGiQIP+waniV2gkx1zbDNSgIdLqhMh
76M769+8gjMMhj9/kF9Mc97Lqed2/ztr6+sBppT+AciGI1ncelvgP2Fk14APhRwv
glnzxOJ1vs8jrj0fkLkxEmtOj3m500UWXMab4quJEHydyyN6Ydp/PbpM79sluNzq
HLUDCgUPz/YL36DENCGLFNdteiS640+FD5jL22j2l4jRmxw51dwSIE2IlEpIOYzm
uvdrpy2O4NsqsKHgpABMrJiPfoRL4T6T8C2VLMhJRmylIfKRD02ER1jqi+5Uzf6Y
sIiMYLlT4UhFW9oC+xqhz2VVYx0tW1FQm19hL8GN/jj4WlC1zs3cA+wsl20ukob6
Nqkmta++E8crGnnwHhYkSY/wUwZU1EZmCbAifMVEpCFvblGxbeoxpgVGXSdD3LRJ
CX1itzQu/VMeROUnu0p3EeKx400twZMKaYlA12FvF4elPNmVxKl4S+bvqCrKNJ8Y
SwTi2dJWbU6neGbxtVOYL3R2cSiRlomTRzmMmAUpQk30Gwp5fnAPfx4MgK56gXRw
pbLrHWeE1+EeZJB5gl67+h3P7Ir12cf6GCPFolI210+ZauFkEq4Jp/sOCmD9g6Ei
sHLX+HAwBXa9aQUvHA0cnaFMt+bmzfsnzANPyRtymJTNBLyEsjcAFG/w08aJ/y5b
iehcmOt13q9zCtgQj5iK
=FH5X
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
