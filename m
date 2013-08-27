Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43406 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab3H0SuT (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:50:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so5194731pab.41
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:50:18 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:59:39 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: remove alx patch for < 2.6.24
Message-ID: <20130827185939.GF7485@garbanzo.do-not-panic.com> (sfid-20130827_205021_065401_E9D70B23)
References: <1377257314-1065-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
In-Reply-To: <1377257314-1065-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 01:28:34PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Since we don't support kernels before 2.6.24 anymore
> there's no need to carry this patch.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPcaAAoJEKwtdpJg+MHGPbwP/Rdn+2FTDKxbXgNbfgKHx9CO
HYDjrUKe9dshGxP7ZhTo7OZfw9+LRe3a+IJmD4bBaxrtyfkolfD3JC+ECbymgqL3
1TcqnzbSlLxOX6TkxOb4SFJUboej7ZpcrE1W5OTfi3OrtfJAEhRFGLj7CCCoVyEH
DKfPJqoOE2nsTz5/3AC1cUdySQ4xvPVrLrNoZTT/07ZYQos/+E2Cr8SKMRAhDOra
4Xl8tPLJRSRBAd45uMxOvZEjV1Z9C9/OFdTKAUXkJ9sL3KE8P4XHUmDFaXHKM7mF
gcqQ6+TQYaW8mF5iOFbQgtP7nsNCHG/+9P/FYiEgoKdC9M8/yuOgfhGfoD0FMYbx
h6Jr6K3PuBh61aispegTQ3dtSF9ST25JYuxy2qKmHNd15tYpSLCcxKdoOw0hoB/4
5onuUyJjojU5kWIzM5v4tbv/Bbe+uJkHKUsV9OaWQEsEzTLccEkGt2wFTYnziNHu
gxVpaVYZnn3+f9sKgPZt1rtBbmuSFNqQNLxje2LcCgemg0tQgtL74fgaEJ08FW6w
dSjdcF2pOzxLEEIvaepQD7fRwc1wMQ47BoR67U+ycM5gHRXKLQf5B46LcpOU3UIx
8hM0OeIXDeOcjmMxo6RIROPm8iurl/DIzgsC+6nQaVslJbcNdwOP0CWfr9ewR7dp
iCuf2C+pxo7Z0jIKZ1Cn
=1PAW
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
