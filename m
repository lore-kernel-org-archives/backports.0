Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:32894 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIRDYr (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:24:47 -0400
Cc: cocci@systeme.lip6.fr
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: 0079-netdev-destructor.cocci very slow
Message-ID: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de> (sfid-20180917_235548_596100_F1A753F4)
Date: Mon, 17 Sep 2018 23:55:25 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JfJiqqp9vwVTxiVdo4iF5uafvLzwBJSmX"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JfJiqqp9vwVTxiVdo4iF5uafvLzwBJSmX
Content-Type: multipart/mixed; boundary="qfE7jrv5pW5ffLpxnldqZF91pGJvdKnxz";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: cocci@systeme.lip6.fr
Message-ID: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
Subject: 0079-netdev-destructor.cocci very slow

--qfE7jrv5pW5ffLpxnldqZF91pGJvdKnxz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

The 0079-netdev-destructor.cocci spatch in backports is very slow for
me. For bigger files I get a warning that it takes over to 15 seconds to
apply it to just one file, for the complete backports tree it takes over
an hour to apply.

This is the patch:
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/t=
ree/patches/0079-netdev-destructor.cocci

When I remove the <-- --> in the first rule, it is applied in some
seconds on the complete tree, so an speed improvement of about 100
times, but it is not working correctly any more. ;-)

Is this normal or how can I improve the spatch to be faster? I am using
coccinelle 1.0.7 build with default configure arguments against the
libraries from Debian stable.

If this is normal I should probably try to reduce the number of files it
tries to apply this against in gentree.py before spatch gets started.

Hauke


--qfE7jrv5pW5ffLpxnldqZF91pGJvdKnxz--

--JfJiqqp9vwVTxiVdo4iF5uafvLzwBJSmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlugIs0ACgkQ8bdnhZyy
68fNDwf/WpeGhTUd8V9INmO+yE4UEYwOehsPvkNRJMD0zmNIH2ggqmnjgjHqXSEU
8NGcRgm6OIsOx7bCOjxYR7nD3fDMgvos8Ua00jHj5kk3KL+zo7lsWt3+Q4JXWWXd
fI7xGYjCYua1YUv+QpTa/t4l9yV25KyOqPWhlEMps7yCz1x2bpVyVV8pvcwmPrrh
A8uXIgl9IrT87/PDmKcIr389+9jwDhF8ImOQnJ3HFCt0eqKerihkxBXDMjKchqfx
iQfQVipyh03Ba9MhPZUV0qhNnbygG3aZKpm5J8hbEMp8G5aLv1AUFv5wH3ZACBbS
WYgew73iny5+r0Q7uzkaZRF5CV+gPg==
=JlNx
-----END PGP SIGNATURE-----

--JfJiqqp9vwVTxiVdo4iF5uafvLzwBJSmX--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
