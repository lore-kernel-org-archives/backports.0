Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:48015
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab3HOM7g (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Aug 2013 08:59:36 -0400
Date: Thu, 15 Aug 2013 08:59:31 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH 2/2] backports:  Add patch for cw1200_sdio with kernels <
 3.2
Message-ID: <20130815125931.GA15940@shaftnet.org> (sfid-20130815_145937_770029_0079EC3D)
References: <1375367966-10863-1-git-send-email-pizza@shaftnet.org>
 <1375367966-10863-2-git-send-email-pizza@shaftnet.org>
 <520CBDF1.7020406@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
In-Reply-To: <520CBDF1.7020406@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 01:39:29PM +0200, Hauke Mehrtens wrote:
> Please move this patch to
> patches/collateral-evolutions/network/75-cw1200-sdio-quirk/cw1200.patch

Done!  And the new patch set should be arriving shortly.

> I can not say anything to the content of this patch, but otherwise these
> two patches are looking good.

I rewrote the patch comments that explain why this patch is necessary.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iD8DBQFSDNCzPuLgii2759ARAqhVAKD18/00m/eSlsnYnJCyxS+I+JTJXQCg5x2H
JW45ALMkbVgH3yhClUSfBOg=
=uxma
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
