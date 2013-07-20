Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:43076
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753456Ab3GTMxp (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 20 Jul 2013 08:53:45 -0400
Received: from stuffed.shaftnet.org (localhost [127.0.0.1])
	by stuffed.shaftnet.org (8.14.7/8.14.5) with ESMTP id r6KCRAlq025674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <backports@vger.kernel.org>; Sat, 20 Jul 2013 08:27:10 -0400
Received: (from pizza@localhost)
	by stuffed.shaftnet.org (8.14.7/8.14.7/Submit) id r6KCR82C025672
	for backports@vger.kernel.org; Sat, 20 Jul 2013 08:27:08 -0400
Date: Sat, 20 Jul 2013 08:27:08 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Subject: cw1200 and older kernels (newbie question)
Message-ID: <20130720122708.GA24056@shaftnet.org> (sfid-20130720_145348_911274_05E18D76)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As part of the cw1200 mainlining effort, I stripped two chunks out of=20
the cw1200 driver that only had relevance relevance for older kernels:

1) Workaround for a hardware SDIO bug (needed for < 3.2)
   * Formal SDIO-level quirk mainlined in 3.2-rc
   * Absence results in device hang with 512-byte SDIO transfers.
2) Support for kernels < 2.6.36
   * Driver utilizes the new workqueue API introduced in 2.6.36, taking
     advantage of new semantics/features (WQ_HIGHPRI + WQ_CPU_INTENSIVE)
   * With older kernels we need a dedicated kthread

Backports has an implementation of the new workqueue API, but it is=20
expressed in terms of the old API, which is inadequate for the cw1200's=20
needs.

Perhaps it's a lack of sufficient sleep, but I haven't quite wrapped my=20
head around how the bakports stuff is put together; it's radically=20
different that compat-wireless, which had nice orderly patch=20
directories.  :)

Any advice on how I should proceed here?  I want to do this the=20
RightWay, but I don't know what that is yet -- Should I just=20
add these two patches to the backports tree under patches/unified-drivers?

(The code chunks in question are wrapped with LINUX_VERSION_CODE tests,=20
 so they function fine on newer kernels)

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iD8DBQFR6oIcPuLgii2759ARAjPxAKDElbm+yxJPy/8cPl6nCKQInXsoOQCeOieU
UIiepXTqVpIuuhyqiBQLxRE=
=pwY1
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
