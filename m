Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:11942 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIXCRY (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 22:17:24 -0400
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-2-hauke@hauke-m.de>
 <1537733414.1707.8.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6ced1780-6f69-9ee3-f81c-6d740b382b49@hauke-m.de> (sfid-20180923_221841_800301_4F504111)
Date: Sun, 23 Sep 2018 22:18:34 +0200
MIME-Version: 1.0
In-Reply-To: <1537733414.1707.8.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S6lOsjRfxpWWoU323Hcxt1hJ6jQ5cVuqS"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S6lOsjRfxpWWoU323Hcxt1hJ6jQ5cVuqS
Content-Type: multipart/mixed; boundary="OOKbHmdHFjxkfnmtqeMIst7fZiZibf8yD";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <6ced1780-6f69-9ee3-f81c-6d740b382b49@hauke-m.de>
Subject: Re: [PATCH 01/10] backports: Remove ssb and bcma
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-2-hauke@hauke-m.de>
 <1537733414.1707.8.camel@sipsolutions.net>
In-Reply-To: <1537733414.1707.8.camel@sipsolutions.net>

--OOKbHmdHFjxkfnmtqeMIst7fZiZibf8yD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/23/2018 10:10 PM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
>> Use the versions shipped with the kernel instead.
>> bcma and ssb didn't change much in the last few years, most of the
>> changes were related to code only used on embedded devices. Removing
>> this reduces the number of parts we have to backport. b43, b43legacy a=
nd
>> brcmsmac work well with the in kernel version.
>=20
>>  patches/0051-no-wakeup_path/ssb.patch              | 12 -----------
>>  patches/0069-remove-of_irq/bcma.patch              | 24 -------------=
---------
>>  11 files changed, 23 insertions(+), 80 deletions(-)
>=20
> Is that really worth it?
>=20
> johannes

There are sometimes some changes needed because of ssb and bmca, like
of_dma_configure() getting one additional parameter now. To reduce the
effort I just want to get rid of this.
In OpenWrt we take this from the mainline kernel anyway as it is build
in for some Broadcom SoCs.

Hauke


--OOKbHmdHFjxkfnmtqeMIst7fZiZibf8yD--

--S6lOsjRfxpWWoU323Hcxt1hJ6jQ5cVuqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlun9RoACgkQ8bdnhZyy
68fvrAf+JVm93D49mDCBGJdXCeWlTJxD//gd86FnIe8v9uHppKlZrD+QYoX1LtZZ
M34va4afoYbQkZcrgBmIn78JQ9toCErP5nA8MOTQiFlH7o3Owvpch35f3AZbys5G
n2mYuPvG0MeW1TZ1FRZW+RUtws7K6LIvWXaXYOBrSFKc6lvJKdUXU+TEi+oC5pBk
7VbilUIqjrl/6KyWzLl3c0zCvJU56pqtDenUtazQAk5YrWV/cCmiiI5K4Neq8/1f
kDB5H2hWCRcnwynjbOsggdgaal7BzwbsJ2v9oStRsBmiHijNNa5M0cjDsg6w6ov8
zOV8F5n1z2baTIfiVik5BASF1NR5MQ==
=Jwk+
-----END PGP SIGNATURE-----

--S6lOsjRfxpWWoU323Hcxt1hJ6jQ5cVuqS--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
