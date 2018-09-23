Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:39792 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbeIXCfD (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 22:35:03 -0400
Subject: Re: [PATCH 05/10] dependencies: Make WIL6210 depend on kernel >= 4.8
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-6-hauke@hauke-m.de>
 <1537733544.1707.9.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8643b128-a100-50da-7860-680d99340cef@hauke-m.de> (sfid-20180923_223618_799840_2DC48609)
Date: Sun, 23 Sep 2018 22:36:07 +0200
MIME-Version: 1.0
In-Reply-To: <1537733544.1707.9.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wn6u3mRXeU9dFKXbKCV6aOhqzW7FmzqS5"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wn6u3mRXeU9dFKXbKCV6aOhqzW7FmzqS5
Content-Type: multipart/mixed; boundary="ST3hdcsPRh6F8vH2EVfC5Lct0BXGB04bZ";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <8643b128-a100-50da-7860-680d99340cef@hauke-m.de>
Subject: Re: [PATCH 05/10] dependencies: Make WIL6210 depend on kernel >= 4.8
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <20180923174535.16198-6-hauke@hauke-m.de>
 <1537733544.1707.9.camel@sipsolutions.net>
In-Reply-To: <1537733544.1707.9.camel@sipsolutions.net>

--ST3hdcsPRh6F8vH2EVfC5Lct0BXGB04bZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/23/2018 10:12 PM, Johannes Berg wrote:
> On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
>> The WIL6210 driver now uses pci_alloc_irq_vectors() which is only
>> available in kernel >=3D 4.8, only build this driver against such kern=
el
>> versions.
>=20
> From the description of the function, it seems like it should be pretty=

> simple to backport?
>=20
> johannes

I haven't tried to backport this.
If someone wants to do it I would be happy.

Hauke




--ST3hdcsPRh6F8vH2EVfC5Lct0BXGB04bZ--

--Wn6u3mRXeU9dFKXbKCV6aOhqzW7FmzqS5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlun+TcACgkQ8bdnhZyy
68ew2ggAnl/SGiU5VIRgeJ9q06DySTqQS5fuQOa0KPwqLhDr7f6KFQEt0silO4Kp
JMnL6OROZHta/Ha6ulTRh8Z6yxuFAqs8UH0NQRyNZFmjWs2E3QnYqqW++qN/Xt+b
a+hfKwiPOlPOPvOaCSOn1A9Z1pp4Wjq1yM6wcyPk25kLXfnmkKFvaQkDddXfoiYm
bjvzC7ZHFYzVXPYtCEmchZ6jgeBVhwG7ZFrZ27iDvg7mzkwlMYbIRtCfuioZN1o0
2M3poVFXVM+PFQdC1VZY2jg7clATi4JSjJD4pTZ/Aw0w6GOuxQ/vTV71gxFsy8e2
/5IStZnY6wvTK6fjk0suEODoGVOp0w==
=/CI8
-----END PGP SIGNATURE-----

--Wn6u3mRXeU9dFKXbKCV6aOhqzW7FmzqS5--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
