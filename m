Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:25450 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeIWUOe (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 16:14:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 711DF41917
        for <backports@vger.kernel.org>; Sun, 23 Sep 2018 16:16:55 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id DTHteWc_6ueD for <backports@vger.kernel.org>;
        Sun, 23 Sep 2018 16:16:54 +0200 (CEST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
Message-ID: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de> (sfid-20180923_161658_834557_1648CD51)
Date: Sun, 23 Sep 2018 16:16:53 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HlZwrppUqJ7bHDUJK06sqRTXwSHjadS13"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HlZwrppUqJ7bHDUJK06sqRTXwSHjadS13
Content-Type: multipart/mixed; boundary="KGUk4e02woi0I3cRX0trnZ64f3YgRNboX";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
Subject: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "

--KGUk4e02woi0I3cRX0trnZ64f3YgRNboX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I tried to compile backports against kernel 4.18 and 4.19-rc4 (header
files from Ubuntu) and ran into this problem when it wants to link the
kernel:

  LD [M]
/home/hauke/compat-wireless/backports-4.19-rc4-1/drivers/net/wireless/rea=
ltek/rtlwifi/rtl_usb.o
  Building modules, stage 2.
scripts/Makefile.lib:10: *** Recursive variable 'KBUILD_CFLAGS'
references itself (eventually).  Stop.
Makefile:1507: recipe for target 'modules' failed
make[4]: *** [modules] Error 2
Makefile.build:6: recipe for target 'modules' failed
make[3]: *** [modules] Error 2
Makefile.real:88: recipe for target 'modules' failed
make[2]: *** [modules] Error 2
Makefile:40: recipe for target 'modules' failed
make[1]: *** [modules] Error 2
Makefile:30: recipe for target 'default' failed
make: *** [default] Error 2


Did someone also saw this problem?

Hauke


--KGUk4e02woi0I3cRX0trnZ64f3YgRNboX--

--HlZwrppUqJ7bHDUJK06sqRTXwSHjadS13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlunoFUACgkQ8bdnhZyy
68eY1gf9GdkBOr540vAqTB0v2A82pnz5OMyeeyu4V4SBAckelhs0h62kKIlHwaTq
h7Nd+P40RwAMhHUNBNMPLfAKtQoIJyqyC8k5qzvfNDHhunK466sLFowyPX2ZvM/e
uherWvRMT/7ClH+Gm8Ki20FHXhGl8rTM6913xaeT0N/b9J0ap+IperbHxLck1pcH
MvYhf0PlxooqjzU2wfUpc5v8LIkoDoOPMJrz//xPd+9sX3eXdTrGA2WvKbf6ReEC
jVBGP8CSapZr5uyssNR/0LrjhRz/8NF2RBc5EmQvfvEyR6monkENWI4HpS9DNbgM
uRC7vrcYHLuqAas4v++AxDJ0olVYJg==
=sTzR
-----END PGP SIGNATURE-----

--HlZwrppUqJ7bHDUJK06sqRTXwSHjadS13--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
