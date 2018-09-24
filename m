Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:22578 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbeIYCVu (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 24 Sep 2018 22:21:50 -0400
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-2-hauke@hauke-m.de>
 <1537786129.1707.28.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <d0826daa-5ea1-7d54-4122-a78fb9fd05b6@hauke-m.de> (sfid-20180924_221756_701077_FDA5E8E5)
Date: Mon, 24 Sep 2018 22:17:48 +0200
MIME-Version: 1.0
In-Reply-To: <1537786129.1707.28.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VajEi3zJtldacQ1qK68AnntGYpRSaCJ7i"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VajEi3zJtldacQ1qK68AnntGYpRSaCJ7i
Content-Type: multipart/mixed; boundary="YJJIynuhP6PJzj9S641MkUQt6IElG2izL";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <d0826daa-5ea1-7d54-4122-a78fb9fd05b6@hauke-m.de>
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-2-hauke@hauke-m.de>
 <1537786129.1707.28.camel@sipsolutions.net>
In-Reply-To: <1537786129.1707.28.camel@sipsolutions.net>

--YJJIynuhP6PJzj9S641MkUQt6IElG2izL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/24/2018 12:48 PM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
>> Use the versions shipped with the kernel instead.
>> bcma and ssb didn't change much in the last few years, most of the
>> changes were related to code only used on embedded devices. Removing
>> this reduces the number of parts we have to backport. b43, b43legacy a=
nd
>> brcmsmac work well with the in kernel version.
>=20
> Looks like this broke b43 at least up to around 3.12:
>=20
> b43/main.c:5331:25: error: =E2=80=98struct ssb_sprom=E2=80=99 has no me=
mber named =E2=80=98dev_id=E2=80=99
>=20
> ssb: sprom: add dev_id field for value overriding standard ID
>=20
> 3.16, actually. I think I'll revert this.
>=20
> johannes
>=20

Ok, no problem then we will stay with bcma and ssb.

With kernel < 4.0 it was expected to cause some problems.

Hauke


--YJJIynuhP6PJzj9S641MkUQt6IElG2izL--

--VajEi3zJtldacQ1qK68AnntGYpRSaCJ7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlupRmwACgkQ8bdnhZyy
68eFdAf/c13H3ORJF9EqftZfeMl+La7nZVxqd5yQiM7NghGgkXaQZ1HXE253+xoC
AtUUtT27vtPJiN7kIyJ07vb8S0/8iSZXpOHn2HYISTsu5xulaBQtylb8rVxu8e3H
3kez8VsnKKBoGYcBh0sKG2JBZrQPWzpBbv3nbXLVgef3UQHvVx3WPfUUHgwLjFlR
ShI/5t/WacMYKi4li1xkMjot/V6kg+QXnfxtzcirpXlM/ZJXZrCXwJOIGYHYxJOn
scIAqwQ8fyxgNhgLK68ihkP9X4YLlOXqLyffbiuMhS15+sohFQy5W2u4stDeNKgr
mkysBOostCK+RhX31BYj0XzooUV97g==
=m0kD
-----END PGP SIGNATURE-----

--VajEi3zJtldacQ1qK68AnntGYpRSaCJ7i--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
