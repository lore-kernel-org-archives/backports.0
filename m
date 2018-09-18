Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:8318 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbeISDXt (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 18 Sep 2018 23:23:49 -0400
Subject: Re: .coredump spatch
To: Omer Efrat <omer.efrat@tandemg.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "aspriel@gmail.com" <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Crispin <john@phrozen.org>
References: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
 <VI1PR02MB3631D220BDE0C139F4369F769A1D0@VI1PR02MB3631.eurprd02.prod.outlook.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <d37718aa-2741-09c4-d012-d8efff7c9066@hauke-m.de> (sfid-20180918_234918_050556_921C5593)
Date: Tue, 18 Sep 2018 23:49:08 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR02MB3631D220BDE0C139F4369F769A1D0@VI1PR02MB3631.eurprd02.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qKCgHvd4tXAGer1NYhNUqPGzJ22qrfhf1"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKCgHvd4tXAGer1NYhNUqPGzJ22qrfhf1
Content-Type: multipart/mixed; boundary="SPstjRfdlaMjEjsGqHoIUvGR15yE00Mj0";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Omer Efrat <omer.efrat@tandemg.com>,
 "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "aspriel@gmail.com" <aspriel@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, John Crispin <john@phrozen.org>
Message-ID: <d37718aa-2741-09c4-d012-d8efff7c9066@hauke-m.de>
Subject: Re: .coredump spatch
References: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
 <VI1PR02MB3631D220BDE0C139F4369F769A1D0@VI1PR02MB3631.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB3631D220BDE0C139F4369F769A1D0@VI1PR02MB3631.eurprd02.prod.outlook.com>

--SPstjRfdlaMjEjsGqHoIUvGR15yE00Mj0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/18/2018 08:28 AM, Omer Efrat wrote:
> On Tue, Sep 18, 2018, Hauke Mehrtens wrote:
>=20
>> The device structure now has this .coredump member which is also used =
by
>> some wireless drivers, see here for example:
>> https://git.kernel.org/linus/8e072168f75ebce85b96cbcefea2b10ddbd5913f
>>
>> I tried to create a spatch for this, but I failed to match the driver
>> member because it is embedded inside an other structure, it looks like=

>> this for example:
>>
>> static struct pci_driver brcmf_pciedrvr =3D {
>> ....
>>         .driver.coredump =3D brcmf_dev_coredump,
>> };
>>
>> I would like to convert this to this:
>>
>> static struct pci_driver brcmf_pciedrvr =3D {
>> ....
>> #if LINUX_VERSION_IS_GEQ(4,16,0)
>>         .driver.coredump =3D brcmf_dev_coredump,
>> #endif
>> };
>>
>> Hauke
>=20
> I think you should have a look at 0075-ndo-stats-64.cocci for a good re=
ference.
>=20
> Omer.
>=20
Hi Omer,

Thanks for the hint, but I already tried something like that.
The suggested code looks like this:

struct net_device_ops OPS@p =3D {
+#if LINUX_VERSION_IS_GEQ(4,11,0)
	.ndo_get_stats64 =3D stats64_fn,
+#else
+	.ndo_get_stats64 =3D stats64_fn_wrap,
+#endif
};

This directly uses a member of a structure, but the .coredump is in a
structure which is embedded in a different structure like this:

struct pci_driver {
=2E..
	struct device_driver	driver;
=2E..
};

struct device_driver {
=2E..
	void (*coredump) (struct device *dev);
=2E..
};

Hauke


--SPstjRfdlaMjEjsGqHoIUvGR15yE00Mj0--

--qKCgHvd4tXAGer1NYhNUqPGzJ22qrfhf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluhctcACgkQ8bdnhZyy
68dC2wgAlq4Sx3sZg5VyMVaHUEk//b6iwX3uqb5mqwTdZcVIdnguQ/F0v4gmuJ8s
M7NnTBhC/NkE+56r09U+2zGn1GlKnPWr9bZ1L/yRbsLCkPDfX4cvWjl95MGCDUbj
QA9a6QdgBHAL893PCkU2ra5ik/xhxXCvuvjygi6KkBISHk6Kvd4Kxch9dwtEp4Oy
Ytcs18kI8zCAwvk1HmI5fG5/kVeDgxV93Cp3NwLgJs7pU4SZbHw4JYa5sgzLaboP
CSPGgo1gOQks9seNtVuHL3vtURxRPT5mHul9PlNxX6KD57mrWOFMuDQEwHGCLZC7
pBfnGOFAVynZQZ6f+lU1DJfJdxS4+w==
=vd2v
-----END PGP SIGNATURE-----

--qKCgHvd4tXAGer1NYhNUqPGzJ22qrfhf1--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
