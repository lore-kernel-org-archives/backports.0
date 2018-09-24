Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:37772 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeIYCYC (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 24 Sep 2018 22:24:02 -0400
Subject: Re: [PATCH 08/10] patches: remove .coredump from struct driver for
 kernel < 4.16
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-9-hauke@hauke-m.de>
 <1537778165.1707.26.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <77307628-5584-e5d1-255e-b730c201dc91@hauke-m.de> (sfid-20180924_222008_724380_AFC26448)
Date: Mon, 24 Sep 2018 22:20:03 +0200
MIME-Version: 1.0
In-Reply-To: <1537778165.1707.26.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hBgMThyxnYqAnpqkYwx6lai7VvxoZqz5O"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hBgMThyxnYqAnpqkYwx6lai7VvxoZqz5O
Content-Type: multipart/mixed; boundary="1vwiAYpxzSlCHnOZcLNZ5H0pGWCeXqvgG";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <77307628-5584-e5d1-255e-b730c201dc91@hauke-m.de>
Subject: Re: [PATCH 08/10] patches: remove .coredump from struct driver for
 kernel < 4.16
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-9-hauke@hauke-m.de>
 <1537778165.1707.26.camel@sipsolutions.net>
In-Reply-To: <1537778165.1707.26.camel@sipsolutions.net>

--1vwiAYpxzSlCHnOZcLNZ5H0pGWCeXqvgG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/24/2018 10:36 AM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
>> Kernel 4.16 added a new .coredump member to the driver structure which=

>> can be implemented by drivers. Remove this member on older kernel
>> versions as they do not support this feature.
>=20
> Note that this isn't sufficient.
>=20
> On 4.16, the return value was int, now it's void. I'll change this patc=
h
> to be for < 4.17, but if somebody wants to submit an spatch to fix up
> the difference that would work too.
>=20
> johannes
>=20
Thanks for fixing this, I didn't noticed that this changed between 4.16
and 4.17. I think it is ok to only provide this on kernel >=3D 4.17, this=

is an not essential feature and 4.16 is not a long term kernel.

Hauke


--1vwiAYpxzSlCHnOZcLNZ5H0pGWCeXqvgG--

--hBgMThyxnYqAnpqkYwx6lai7VvxoZqz5O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlupRvMACgkQ8bdnhZyy
68ebzAf9E3oA05e99UQeETZ6yd6HiITqsfS6RX/vuUn7eSyb0aIUY64GVDu9BIXM
DcEcVdMSLzGZKZizvBTDg6o/1kc1fJPQmD0JMB/TAbBNIfIQRpU2bMq9/4vMioi7
+6Ixq1YXPnkCJWimG/Nx3Kmz/Nw3tGAmz+8sIpVVdkSNSQYO+nYWfwAGSIyegaB7
LU+d1HMTNxXIh7VFpD362oF/xxdAmnChcFE2K/x4m1u60kWIQkyDWIBxzh0mLnKZ
QPLstEHvKlRraqFa8Rf2l9oKIKrpv9bIX4/tKtir2ywrWgpodYRwUZ0K7YueA1hy
xt3+RQMJuwwNiLpJp7jA1WDhELR0nA==
=R/Fy
-----END PGP SIGNATURE-----

--hBgMThyxnYqAnpqkYwx6lai7VvxoZqz5O--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
