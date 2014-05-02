Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50967 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaEBBj4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:39:56 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so4544183pab.37
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:39:55 -0700 (PDT)
Date: Thu, 1 May 2014 18:39:48 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Aaron Hamilton <aaron@logicdatasystems.net>
Cc: backports@vger.kernel.org
Subject: Re: 3.14-1 Compile Problem for 2.6.39.4 Kernel
Message-ID: <20140502013948.GH957@garbanzo.do-not-panic.com> (sfid-20140502_033958_139894_5C31E9DC)
References: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2014 at 02:39:11AM -0700, Aaron Hamilton wrote:
> In trying to compile backports-3.14-1 with a 2.6.39.4 kernel, I get
> the following compilation errors:
>=20
> backport-include/linux/compat.h:18: error: expected ';', ',' or ')'
> before '*' token
>=20
> If I comment out line 18 in compat.h which just reads "extern int
> compat_put_timespec(const struct timespec*, void __user *)", then I
> get past that error.
>=20
> Next, things get stuck on compat/crypto-ccm.c on lines 250 and 255,
> stating "too few arguments to function 'scatterwalk_map'" and "too few
> arguments to function 'scatterwalk_unmap'".
>=20
> My kernel headers indicate this function takes two parameters and I
> can't find anything in backports that specify otherwise. Am I missing
> something?

Yeah odd, I see what you are seeing but then I looked at upstream
v3.14.2 code and see only one argument.

The commit that caused this change:

mcgrof@ergon ~/linux-stable (git::linux-3.14.y)$ git describe --contains f0=
dfc0b0
v3.4-rc1~174^2~50

So its been there for a while now, so surprised we haven't had to
resolve this earlier, we also don't have patches that modify this so
its a bit unclear how this has happened. The backports file versions
does have:

BACKPORTS_VERSION=3D"v3.14-1-0-g369d49a"
BACKPORTED_KERNEL_VERSION=3D"v3.14-0-g455c6fd"
BACKPORTED_KERNEL_NAME=3D"Linux"

And v3.14-0-g455c6fd is =3D=3D v3.14

The upstream code for v3.14 on crypto/ccm.c has scatterwalk_map() with
one argument. What we do is copy it over directly from the upstream
source the only patch we have to modify it is within the backports
git tree we use patches/backport-adjustments/crypto-ccm.patch, this
however does not touch scatterwalk_map() usage...

This *should* have triggered a compile failure when we had tested this..
Going to run another test now.

  Luis

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYvdkAAoJEKwtdpJg+MHGmyUP/Aru+B9V34FZNj+zQU3KOO0Z
blT8rlf3Vr2w7f7VHwByQUJPq3GcK2c9/Ldc8pTrRa7R6hrocPfIdoqT1T1aYI1B
dUfjXtwUNFBtWpm29tw5prI9QFmq+STrGZiBXkHptt8Ud9fla8v4X6EV53HiX/xJ
5tYyQMTTkUVklCn+Tb933b8zwnBccjoTeHOIHX03t8VIzPE3zKLR2PO99Ksg27u1
6B1pSy348KSsvoPnXjYW455Yap+aZGLR7HLPaDmpx+jDthx0wZshQZ5O6Hb57lou
MhHbhWwVruZB8kXSAqBkvSsFbVyDbeZ81NcOHXxCdaCGonMxyiYsS2zifVZQzpU5
Z+78aoimlxmPgPGrhWEJHqfeAl3RmW1Ju6A1quMO5ArdXmc2hMuhadiXZ5W1wu3E
uLyFUOpRIDL9H4qK3bhtq/U/Iz+0awblval80Ap4X6DL+elgbOTyvtIxjm4HEk2Y
ojYFLHuTF/VZMNLMHo0kuPGODG8hZzGZ1Pel3SRl+SFdd+wExx+otiyyWsGMadWL
voxYDtFf+84sA1SdtOaWgxG98I12IIcVCyYnJ20fpkbLDdSWwrDzFpMdx8JhEHPk
Bapwe5fdnNjemJm2RX0iEeDDL0L+Ma06v9+UmXKfFc0rOmdT989PiJDJsY9IPQDZ
2VWNT4QJjrANfIXfO5f9
=TvJv
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
