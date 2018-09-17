Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:64714 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIRDJN (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:09:13 -0400
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: aspriel@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        John Crispin <john@phrozen.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: .coredump spatch
Message-ID: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de> (sfid-20180917_234005_259044_844723B8)
Date: Mon, 17 Sep 2018 23:39:55 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fQdELXVNnkmMm95T0cgn3AFYuqbvKLWLf"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fQdELXVNnkmMm95T0cgn3AFYuqbvKLWLf
Content-Type: multipart/mixed; boundary="GPjI3iiII7iTsHdzIRs1POw2TG6cyIyfQ";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: aspriel@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
 John Crispin <john@phrozen.org>
Message-ID: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
Subject: .coredump spatch

--GPjI3iiII7iTsHdzIRs1POw2TG6cyIyfQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

The device structure now has this .coredump member which is also used by
some wireless drivers, see here for example:
https://git.kernel.org/linus/8e072168f75ebce85b96cbcefea2b10ddbd5913f

I tried to create a spatch for this, but I failed to match the driver
member because it is embedded inside an other structure, it looks like
this for example:

static struct pci_driver brcmf_pciedrvr =3D {
=2E...
	.driver.coredump =3D brcmf_dev_coredump,
};

I would like to convert this to this:

static struct pci_driver brcmf_pciedrvr =3D {
=2E...
#if LINUX_VERSION_IS_GEQ(4,16,0)
	.driver.coredump =3D brcmf_dev_coredump,
#endif
};

Hauke


--GPjI3iiII7iTsHdzIRs1POw2TG6cyIyfQ--

--fQdELXVNnkmMm95T0cgn3AFYuqbvKLWLf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlugHy8ACgkQ8bdnhZyy
68cQ1gf/XnFcfbwQWniudK4HGC69a7w69i7lMnX5+HuJbX6oKXVZ2cZF/rvSAqjk
+gdaWxh+YSVUcekpG9aqtB1o486wvJkxhNbZR69vECjdNTqNYnZcBorByzYZnPsl
WZRQZ72R3KZVJf2XEk5vUPGJZ7a1eKQtTzECaZP1wETrlOQYdqXVR9UG6paIxd2N
HXFYADzS/RNGq+h+C/yLWqPIqtD4NrEQws8AXTTlliRk4N7Yz/Vv1DuA6X3O7DFW
FPT0AIEYJqNDaPudk8KV5h3hq+erGWE5F8IFgqC7kVy3H0RJo9zy2Ar9atgigKXN
Q3oo/TMfWZPYXR5f1w4Lw0isbqr/7A==
=oGjj
-----END PGP SIGNATURE-----

--fQdELXVNnkmMm95T0cgn3AFYuqbvKLWLf--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
