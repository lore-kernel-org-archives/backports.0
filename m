Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:45250
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750874Ab3HQE0Y (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 00:26:24 -0400
Received: from stuffed.shaftnet.org (localhost [127.0.0.1])
	by stuffed.shaftnet.org (8.14.7/8.14.7) with ESMTP id r7H4QNS6003011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <backports@vger.kernel.org>; Sat, 17 Aug 2013 00:26:23 -0400
Received: (from pizza@localhost)
	by stuffed.shaftnet.org (8.14.7/8.14.7/Submit) id r7H4QNFJ003010
	for backports@vger.kernel.org; Sat, 17 Aug 2013 00:26:23 -0400
Date: Sat, 17 Aug 2013 00:26:23 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Subject: Re: [PATCH 3/4] backports: cw1200 utilizes kthreads for <= 2.6.35
Message-ID: <20130817042623.GA29133@shaftnet.org> (sfid-20130817_062626_685215_92A488F2)
References: <1376713383-2624-1-git-send-email-pizza@shaftnet.org>
 <1376713383-2624-3-git-send-email-pizza@shaftnet.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <1376713383-2624-3-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2013 at 12:23:02AM -0400, Solomon Peachy wrote:
> The new workqueue APIs in 2.6.36 allowed us to scrap the old kthread work=
er
> that had been used; unfortunately the backported API isn't complete so
> in order to support older kernels, resurrect this patch.

Please ignore this patch; I accidentally committed the wrong file in my=20
tree.  I think it's time I go to bed.

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSDvtvPuLgii2759ARAndhAJ0Q/0GEMYDuLmzGIbZ6kc1KOU13ygCgyRPu
sOv40sMp+h8X78DrIEdlUF4=
=65Ua
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
