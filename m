Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:53908 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeISD0z (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 18 Sep 2018 23:26:55 -0400
Subject: Re: 0079-netdev-destructor.cocci very slow
To: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: cocci@systeme.lip6.fr
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 <1537262543.2957.19.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de> (sfid-20180918_235317_308662_EF559460)
Date: Tue, 18 Sep 2018 23:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <1537262543.2957.19.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4sIwEkrDIJqvFUAW6pMEhOQQB4US4Zxvq"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sIwEkrDIJqvFUAW6pMEhOQQB4US4Zxvq
Content-Type: multipart/mixed; boundary="I5DxYjWQjjOzUddiCt5MnCkE15WljdP09";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: cocci@systeme.lip6.fr
Message-ID: <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de>
Subject: Re: 0079-netdev-destructor.cocci very slow
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
 <1537262543.2957.19.camel@sipsolutions.net>
In-Reply-To: <1537262543.2957.19.camel@sipsolutions.net>

--I5DxYjWQjjOzUddiCt5MnCkE15WljdP09
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/18/2018 11:22 AM, Johannes Berg wrote:
> On Mon, 2018-09-17 at 23:55 +0200, Hauke Mehrtens wrote:
>> The 0079-netdev-destructor.cocci spatch in backports is very slow for
>> me. For bigger files I get a warning that it takes over to 15 seconds =
to
>> apply it to just one file, for the complete backports tree it takes ov=
er
>> an hour to apply.
>>
>> This is the patch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.gi=
t/tree/patches/0079-netdev-destructor.cocci
>>
>> When I remove the <-- --> in the first rule, it is applied in some
>> seconds on the complete tree, so an speed improvement of about 100
>> times, but it is not working correctly any more. ;-)
>>
>> Is this normal or how can I improve the spatch to be faster? I am usin=
g
>> coccinelle 1.0.7 build with default configure arguments against the
>> libraries from Debian stable.
>=20
> We've had this discussion before :-)
> I think we determined that it was normal.
>=20
>> If this is normal I should probably try to reduce the number of files =
it
>> tries to apply this against in gentree.py before spatch gets started.
>=20
> spatch should already try that internally, but perhaps with some extra
> knowledge we can do a better job ...
>=20
> johannes
>=20
Hi Johannes,

Yes we talked about this topic some months ago in IRC.
If there is really no better solution, then I will grep in all files for
needs_free_netdev and priv_destructor and only apply this to the files
which are matching. This list should be pretty short.

It looks like coccinelle already does such a grep when I remove the <--
--> from the patch, because this is about 100 times faster.

Hauke


--I5DxYjWQjjOzUddiCt5MnCkE15WljdP09--

--4sIwEkrDIJqvFUAW6pMEhOQQB4US4Zxvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluhc5AACgkQ8bdnhZyy
68dO0wf+IZ1aLBtAx8zRVxsJ2DJMbdFXQplaaGAbOw1y74gxyN9N8qJAP+m4EcCi
Y9IjswsNaSTfZq1nEnzy8aR9ltZg/MJykftecGkhepJVjUdy/I1cmj308JUtxeD9
Y76d+s06qJCbaHZHT4wZd2Hne81gIc6gekxudpsV03HdaUvmu7j5OYm5REjG7v87
f57LAYMTmV64Ffevq7wT7cMRtfVW/kM0GAod143Esw0U90tk4PWhAuXPPB/myA8x
3Y/fy18tCZDowl34qUSx4ten6+Xgd3KeyRUW6A3QChIgdsltghq22Nw//yCdLnje
3mJ8pwGi0z3zyz27a888i9xyHQAZOw==
=gYxR
-----END PGP SIGNATURE-----

--4sIwEkrDIJqvFUAW6pMEhOQQB4US4Zxvq--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
