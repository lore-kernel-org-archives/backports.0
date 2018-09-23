Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:18606 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIXCWs (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 22:22:48 -0400
Subject: Re: [PATCH 06/10] dependencies: make hostap and atmel depend on
 kernel >= 4.18
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-7-hauke@hauke-m.de>
 <1537733820.1707.10.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <78f873b0-6053-731a-dfab-37186d262005@hauke-m.de> (sfid-20180923_222405_234143_FE031CF9)
Date: Sun, 23 Sep 2018 22:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <1537733820.1707.10.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vk22d6c6JECVihiJF4dNfAVWyY8j3t1Ke"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vk22d6c6JECVihiJF4dNfAVWyY8j3t1Ke
Content-Type: multipart/mixed; boundary="IcBQXvqHjLC2JpXFBVNGLheujxBYCYfIK";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <78f873b0-6053-731a-dfab-37186d262005@hauke-m.de>
Subject: Re: [PATCH 06/10] dependencies: make hostap and atmel depend on
 kernel >= 4.18
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-7-hauke@hauke-m.de>
 <1537733820.1707.10.camel@sipsolutions.net>
In-Reply-To: <1537733820.1707.10.camel@sipsolutions.net>

--IcBQXvqHjLC2JpXFBVNGLheujxBYCYfIK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/23/2018 10:17 PM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
>> The hostap and atmel wireless driver now make use of the
>> proc_create_single_data() function which can not easily be backported.=

>> As these drivers are not used too often just deactivate them on older
>> kernel versions for now.
>=20
> It should be pretty easy to backport based on proc_create_data(), which=

> has been around since 2.6.26?
>=20
> johannes

One of the upstream commits is this:
https://git.kernel.org/linus/d51269592c327fcfe8ec80fd169a84f8dc0de73b

The problem is that these function also get some data so we would have
to provide the data and the show function pointer and store it
somewhere. Most of the proc structures are also private so we can not
easily abuse some unused member.

The affected drivers are anyway not used much any more.

Hauke


--IcBQXvqHjLC2JpXFBVNGLheujxBYCYfIK--

--Vk22d6c6JECVihiJF4dNfAVWyY8j3t1Ke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlun9l0ACgkQ8bdnhZyy
68eISQgApNmwT2q947StLMojtE/rmLY6y1P3ClBWeNfgQD7nuSLcAVKq4HSEIHy6
Fff7Xi+PCPozo0KblhuO2mXiyf52RRZIitHCBcGjnCvsVUuNqW4Rv1X+noWCZ7/i
Q5koCXCCS5nnN+ngCEXv346prdznCZKucYPCVmUE6rePvV1AAlPod93PQjHxaqf1
FJOV1aKnBhGSBl0X+xw8I5/Extnewj/2PEh0zgkQ7+4UE2pKGdpMjEiqCuBrGRDU
eC/kvHoD828ck2IjwFEQIyxbWkGYbkMcwEhJtmg6WsEbL8zEspE7berUdD39idYs
lrHkVFn8KYpzB06oqKRmwUUz/ss3pQ==
=n/UV
-----END PGP SIGNATURE-----

--Vk22d6c6JECVihiJF4dNfAVWyY8j3t1Ke--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
