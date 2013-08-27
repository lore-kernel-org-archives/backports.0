Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:42804
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752430Ab3H0Xhd (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 19:37:33 -0400
Date: Tue, 27 Aug 2013 19:35:19 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
Subject: Re: kernel version management
Message-ID: <20130827233518.GA30297@shaftnet.org> (sfid-20130828_013735_697925_CD60D09D)
References: <1377630791.20012.12.camel@jlt4.sipsolutions.net>
 <521D0C11.6090402@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <521D0C11.6090402@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 10:29:05PM +0200, Hauke Mehrtens wrote:
> When you look at the users of old backports no one cares about using a
> supported kernel version. One group are the desktop users which are
> using Ubuntu, Debian, or some RedHat kernel, these kernels are based on
> 2.6.32 or some 3.X version. The other big group are the embedded
> developers which are using any random kernel version with many patches
> for some specific SoC in it. They do not care about security updates.

For what it's worth, this meshes with my experience as well.  I'd even=20
go so far as to say that the latter group is the more significant.

Whatever kernel a random SoC vendor ships is what will be used until the=20
end of time.  Encouraging board vendors to upgrade their software stack=20
to use to newer kernels is a battle that needs to be fought with the SoC=20
folks (not even considering crap like binary-only drivers), and it'll=20
subsequently trickle down to the folks craking out boards.  The=20
devicetree migration is a great help here, but it won't do anything to=20
migrate the legacy platforms out there..

One particular battle I fought less than a year ago involved someone=20
unwilling to move from a 2.6.13 (!) kernel, even though I told them in=20
no uncertain terms that it would cost them an order of magnitude more=20
money to backport a wifi driver (and mac80211 etc) to that 2.6.13 kernel=20
than it would be to port their meagre handful of custom drivers to a=20
modern long-term 3.0/3.2 kernel.

And this was a network-exposed system too.  ${deity}-only knows how many=20
security holes were in their even-more-ancient userspace.

> The bigger maintenance problem I currently see is the adding for more
> and more subsystems. The GPU drivers for example are taking about 30% of
> the time when adding support for a new linux next version.

=2E..Especially when you consider that the GPU/DRM stuff also requires=20
updated userspace in order to do anything meaningful -- which is another=20
big speedbump.

I personally think it's a mistake to drop support for older kernels=20
because of the pain of porting GPU stuffs.  I'm beginning to really miss=20
the simple "compat-wireless" days...

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSHTe2PuLgii2759ARAuUEAJ46y/GdiRQVjEgBbH3JsKA9atTzVQCgpKwK
02E5ACyl2OpCDJ6PIFe4fMU=
=P7X6
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
