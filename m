Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:52872
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751136Ab3IJX1V (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 10 Sep 2013 19:27:21 -0400
Date: Tue, 10 Sep 2013 19:27:12 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Removing of GPU drivers from backports
Message-ID: <20130910232712.GC14238@shaftnet.org> (sfid-20130911_012723_471426_414C9AF7)
References: <522C9ADF.1020809@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
In-Reply-To: <522C9ADF.1020809@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 05:42:23PM +0200, Hauke Mehrtens wrote:
> As we do not have that big constant man power I am for removing the GPU
> drivers to make it easier to add support for a new linux next versions.
> Most of the users are using backports to get a recent wireless driver
> for their desktop Linux or their (old) Linux on an embedded device.

For what it's worth, I agree.

I simply don't understand who the target audience is for the GPU/DRM=20
driver backports; unlike the wireless/network drivers, the GPU/DRM=20
subsystem generally requires equally updated userspace in order to take=20
advantage of the newer stuff, and that has its own morass of=20
dependencies.

I don't understand the point of backported regulator drivers either;=20
those tend to be part of the core board support package for a given=20
hardware/SoC design and as such isn't something that's going to be=20
retrofitted into an existing design running an older kernel; and if=20
you're going to be bringing up a new board from scratch, why not use the=20
latest kernel to begin with?

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSL6rQPuLgii2759ARAr1gAJ9OhO+Z4vJ9B1QReMBLVSQBLibo5QCfTRIK
1TXkGaoebH/bbIyH4ANKzVc=
=77pj
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
