Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:45780
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750882Ab3HQEeg (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 00:34:36 -0400
Received: from stuffed.shaftnet.org (localhost [127.0.0.1])
	by stuffed.shaftnet.org (8.14.7/8.14.7) with ESMTP id r7H4YZO8003526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <backports@vger.kernel.org>; Sat, 17 Aug 2013 00:34:35 -0400
Received: (from pizza@localhost)
	by stuffed.shaftnet.org (8.14.7/8.14.7/Submit) id r7H4YZVT003525
	for backports@vger.kernel.org; Sat, 17 Aug 2013 00:34:35 -0400
Date: Sat, 17 Aug 2013 00:34:35 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Subject: Re: [PATCH 3/4] backports: cw1200 utilizes kthreads for <= 2.6.35
Message-ID: <20130817043435.GB29133@shaftnet.org> (sfid-20130817_063438_217586_61A4F2A3)
References: <1376713383-2624-1-git-send-email-pizza@shaftnet.org>
 <1376713383-2624-3-git-send-email-pizza@shaftnet.org>
 <20130817042623.GA29133@shaftnet.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <20130817042623.GA29133@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2013 at 12:26:23AM -0400, Solomon Peachy wrote:
> On Sat, Aug 17, 2013 at 12:23:02AM -0400, Solomon Peachy wrote:
> > The new workqueue APIs in 2.6.36 allowed us to scrap the old kthread wo=
rker
> > that had been used; unfortunately the backported API isn't complete so
> > in order to support older kernels, resurrect this patch.
>=20
> Please ignore this patch; I accidentally committed the wrong file in my=
=20
> tree.  I think it's time I go to bed.

=2E.. I just double-faked myself out.  I was mistaken; this patch is=20
indeed correct.  Sorry about that.  I'm turning this off before I make=20
any more boneheaded mistakes.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSDv1bPuLgii2759ARAjP0AKDxpn8NVKEqZ77KQMt/YoBwhiMKewCgkpnI
RguOokFhHnuIF/5y/4zrIJs=
=u1hA
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
