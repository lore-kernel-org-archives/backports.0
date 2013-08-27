Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60480 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3H0Stc (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:49:32 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so5236721pdj.36
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:49:32 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:58:53 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backport: backport device_move() properly
Message-ID: <20130827185852.GD7485@garbanzo.do-not-panic.com> (sfid-20130827_204934_352726_5BD83743)
References: <1377253699-31896-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
In-Reply-To: <1377253699-31896-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 12:28:19PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> This was causing conflicts again when updating against
> wireless-next, so instead of adjusting the patches just
> provide a proper static inline backport.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPbsAAoJEKwtdpJg+MHGobEQAJeI4vycRr26G/IVsq795V0G
8G7lRQWxjIAjY6rN9wKRE5YLfvAgWwicSusOZV/oFFqOd6lYljKIdAqm7gtYpeKQ
yy0kw2CfxDtRP1/hUrO1HF6RmGCF98JHAgBX+nV9asjWZNx8892eJOFezyAYDLwO
L1cAv88lHfFAzpCojcik/vasbzM98Imcg2cJy5fDTIWrw+RjOG8j/p+RklQw2I+M
CPSc+WAZ7h2tqvw3rwxxypurn0qo6lRXJIeVuypVexAR1BhipcxphWaNfgAk5viP
4zjolDGV4QCGwja+VtzLy+SrngbmxHMFMyugsOSfALTxF/AHgfc+f73OwUFOzFfm
7q1C45u3UxENt8G9lJi9jxt/gZZBkKHOHRvDq5idKg0z2Nhr4y9HWkZC4KDwFfCQ
I0LB+Xznh+J7aW5BCPbLOWzwyv4SYqfQ5jcTw2EQ9dM7yqyKHHmXoN/wevFOf5/f
TQvH+ByGCLmD4KzKQ/dKTVnrdP66tOejkfO1fLVQJa+CC9TJewOHJwQ0KXCLQf4Q
i2gwtkE+TapcFoKI47Mv+u665ZGCXnShT5/UPikBAMPh9kzVx/9iEFr6jbvLHA8c
KtfnO71yXZqr85VIUObITjlvXURFn/oSi/sIbf3kl1+kPB/Rl61CeGoDnwJNaGL3
CRf/PNQMSSjArHZDEYXU
=8DSO
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
