Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:57804 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeIZC7q (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 25 Sep 2018 22:59:46 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8E59A41A6F
        for <backports@vger.kernel.org>; Tue, 25 Sep 2018 22:50:22 +0200 (CEST)
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id a-fmFapyVbEk for <backports@vger.kernel.org>;
        Tue, 25 Sep 2018 22:50:21 +0200 (CEST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: backports-4.19-rc5-1 released
Message-ID: <3e70e3c3-ad52-5005-0354-31f25a9a3378@hauke-m.de> (sfid-20180925_225025_615547_5743766B)
Date: Tue, 25 Sep 2018 22:50:17 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jyqshpoeKu209m9EPRRmFhz2oLALcp1e4"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jyqshpoeKu209m9EPRRmFhz2oLALcp1e4
Content-Type: multipart/mixed; boundary="p99ozo6axk1KZL975d1Hi2kmnSRwyFRtA";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <3e70e3c3-ad52-5005-0354-31f25a9a3378@hauke-m.de>
Subject: backports-4.19-rc5-1 released

--p99ozo6axk1KZL975d1Hi2kmnSRwyFRtA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

backports-4.19-rc5 was released. This is based on Linux 4.19-rc5.

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/backports/stabl=
e/v4.19-rc5/backports-4.19-rc5-1.tar.xz

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

This release should compile on most kernel versions, we still have some
problems on older kernel versions, probably some configurations will
also work on older kernel versions, but not everything will work.

Huge thanks for Johannes and Luca for their great work.

Hauke


--p99ozo6axk1KZL975d1Hi2kmnSRwyFRtA--

--jyqshpoeKu209m9EPRRmFhz2oLALcp1e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluqn4kACgkQ8bdnhZyy
68c0Swf/cR76E1a3MikCSVBHA/itF849K7REFkyz5lJSAccWbRfvfXumk3OGWzjw
8iE8OYcvGJAbP0QhJBhZw9zfVv27BPqDQdWuAo1Dmf+KkaFT/JnmorCbxZ6h8YZa
Pfy07ViGvfhamNKlUJ5LXl/WuQECRPv9pkAAO8XnzAQTByqbu2MnaqimLVihp2gp
AxQcLOItnpSnO4XeBLjr4l5Z3p8FosVEa3nspxFon6MGelTRwFF3pOXoejjYyHTw
zEU9MUfz2St2Hb/ebZtVu5H+Ex8MRsw7KNQJhkeqSJipGaTUPSUO7dZDi21j9Nhu
hXYHeM51JgICmUsyReamH4jTL3aZIw==
=wYuY
-----END PGP SIGNATURE-----

--jyqshpoeKu209m9EPRRmFhz2oLALcp1e4--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
