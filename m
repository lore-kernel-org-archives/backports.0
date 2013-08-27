Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34049 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab3H0Sqo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:46:44 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so5241927pbb.0
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:46:44 -0700 (PDT)
Date: Tue, 27 Aug 2013 11:56:05 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Solomon Peachy <pizza@shaftnet.org>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH] backports:  Actually export the 2.6.34 sdio compat
 symbols
Message-ID: <20130827185603.GC7485@garbanzo.do-not-panic.com> (sfid-20130827_204646_564038_F11B7C0E)
References: <1377219993-3517-1-git-send-email-pizza@shaftnet.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
In-Reply-To: <1377219993-3517-1-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2013 at 09:06:33PM -0400, Solomon Peachy wrote:
> sdio_get_host_pm_caps() and sdio_set_host_pm_flags() were defined
> in compat-2.6.34 but not actually exported for other modules to use.
>=20
> The cw1200 driver needs sdio_set_host_pm_flags() properly exported.
>=20
> Signed-off-by: Solomon Peachy <pizza@shaftnet.org>

Thanks, applied and pushed!

  Luis

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHPZDAAoJEKwtdpJg+MHGqeAQAJj9Y2SXfm4GaPpq9vrQnvZg
Qtmcv94d0R2Ky92aIPEL8qTNyGta0zpbG4STpUu0Jmcfacp7oIGtKesZLtfyVZZC
COEPXRdVZPaScQ1TEvmg1jkST9Rxq3YLMdit9PuF6A1TZ5ZZRl5DGZRsFDQR8cnw
mfZCI/6I8uHSsn+iB2wblJFuGwVaUX74z3vXwApRIUQPfIBpJy7Uv1uvlxNhNTin
UV8+h2G+8QALC1nuMavcDret3+gVgwKTLvrKZ3wY3EN7S174NlGCqq4YzO+qRS9J
2JMIRMoiz6psn+8HjE+/b5MnBNdPEWWyxZ3N1R7y+/ofgwiKFmnsVcE/20v5iNGw
K/jTqjdiSDJoZT7ElT1yyGc/JC1byUGb796qh0rfiLy/eHAJ0qGml2xEjj4+26NG
Jup/Ghk8KYpFyKaLiCHKdR19NklRFWZ3yq/jtBYz7ff5FKBw0w/QEP0WvpGQvT8g
MGyfHcuJXRj7PmfAXDt5Q1HeEI/sFaOYPXTqhk8cpbMSpvufFkKILJ6QX4XksTeY
4+1exJFGVoWSLI+QbsfpQ3LE/3nvXm5J+NAB6gffSgSo9lM6pYvYZwNHPAJ0/E5N
0a7fKSJOhr90TkuIT4UAGCa2itDiW4C2gBjjKhKjgw3NT7SOHcScHwCSgXPAmpsv
Ag4x+GMHVWZvz/GA4VH2
=y6tJ
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
