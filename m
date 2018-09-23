Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:44984 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIXCry (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 22:47:54 -0400
Subject: Re: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
To: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
 <1537733001.1707.5.camel@sipsolutions.net>
 <1537733344.1707.7.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1f853fa4-0915-c5a9-f168-1d618aa36804@hauke-m.de> (sfid-20180923_224906_759871_3C53D5D7)
Date: Sun, 23 Sep 2018 22:48:58 +0200
MIME-Version: 1.0
In-Reply-To: <1537733344.1707.7.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e12VfJfqMHon3Z5eHALW9wh1BDU3y1eiQ"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e12VfJfqMHon3Z5eHALW9wh1BDU3y1eiQ
Content-Type: multipart/mixed; boundary="xQCoFG2c3oRZzcon0uT7Cuk4tLH9NI6Jh";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <1f853fa4-0915-c5a9-f168-1d618aa36804@hauke-m.de>
Subject: Re: kernel 4.18+ build problem "Recursive variable 'KBUILD_CFLAGS' "
References: <32c2c52e-d3a0-e961-6040-1a34997a7a1f@hauke-m.de>
 <1537733001.1707.5.camel@sipsolutions.net>
 <1537733344.1707.7.camel@sipsolutions.net>
In-Reply-To: <1537733344.1707.7.camel@sipsolutions.net>

--xQCoFG2c3oRZzcon0uT7Cuk4tLH9NI6Jh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/23/2018 10:09 PM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 22:03 +0200, Johannes Berg wrote:
>> On Sun, 2018-09-23 at 16:16 +0200, Hauke Mehrtens wrote:
>>> Hi,
>>>
>>> I tried to compile backports against kernel 4.18 and 4.19-rc4 (header=

>>> files from Ubuntu) and ran into this problem when it wants to link th=
e
>>> kernel:
>>>
>>>   LD [M]
>>> /home/hauke/compat-wireless/backports-4.19-rc4-1/drivers/net/wireless=
/realtek/rtlwifi/rtl_usb.o
>>>   Building modules, stage 2.
>>> scripts/Makefile.lib:10: *** Recursive variable 'KBUILD_CFLAGS'
>>> references itself (eventually).  Stop.
>>
>> Hmm. I vaguely remember something like that with our driver, but can't=

>> find it now? I also remember trying to fix it in the upstream kernel .=
=2E.
>=20
> Hmm. Well, I can't find any changes from me upstream in this area, so
> either I didn't succeed or it didn't get applied. I also can't find a
> public record of a patch, so I guess I didn't succeed?
>=20
> Seems simple enough though, just make cc-option :=3D instead of =3D in
> scripts/Kbuild.include? Or maybe not, dunno.
>=20
> johannes

This works for me, will you add a patch?

Hauke



--xQCoFG2c3oRZzcon0uT7Cuk4tLH9NI6Jh--

--e12VfJfqMHon3Z5eHALW9wh1BDU3y1eiQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlun/DoACgkQ8bdnhZyy
68fEpggAxfblkV/6e1dHrvEaXeBnitFaV0OsarNbG2bb5oQlgy/M23InHyDxywhk
Knvnv8r75R9NgivNfa1TLnJj64H3F6Qud9V2SOBvq154rl96ZZF52m0KIT6AE9GR
ZUWWjrnW0RpPPEccBISYd7eN3MDTuD3cCMzGG0zIPOZinVcuv9Kj+4M9YNTLpiD4
0WOpVc/2SkyLyp3NpH1GZTdoePMpdva13OKQs08uG8yblvu/lWQBgkRrbXL5rYuH
7kdYcfDznq+lWHmXeT4BEV1O39233ml9ariOLD20TZKiFtwMICT2aJymAOpdqxUT
jZCl5vlzNhoTaMe6u7c58+np56xccw==
=IZCv
-----END PGP SIGNATURE-----

--e12VfJfqMHon3Z5eHALW9wh1BDU3y1eiQ--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
