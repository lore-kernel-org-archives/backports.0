Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:29196
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754486AbaDKUG1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 16:06:27 -0400
Date: Fri, 11 Apr 2014 15:26:19 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	Harrison Lee <harrisonl@tme-inc.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
Message-ID: <20140411192619.GA16958@shaftnet.org> (sfid-20140411_220630_825925_4A02376B)
References: <20140409191225.GA10560@kroah.com>
 <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
 <20140409202224.GA12953@kroah.com>
 <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
 <20140409210613.GA14392@kroah.com>
 <s5heh15pr18.wl%tiwai@suse.de>
 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
 <006d01cf5591$694ee230$3beca690$@com>
 <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
 <1397241908.4643.1.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1397241908.4643.1.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2014 at 08:45:08PM +0200, Johannes Berg wrote:
> Now, I'm all for dropping support if it really makes a difference, and
> we might want to drop them from the ckmake tests to reduce the pain, but
> I'm not entirely sure we should wholesale remove things if there are
> still users for them out there.

Speaking as an end-user of compat-wireless, compat-drivers, and later=20
backports, I used them because I was stuck using a nominally-outdated,=20
heavily-patched vendor-supplied kernel for an SoC/board that wasn't=20
[well] supported by the mainline kernel.

To make things worse, I was trying to get a driver for the cw1200 family=20
mainlined.  It finally made it into 3.11, but at the time, the bills=20
were being paid by supporting clients that were stuck on 2.6.28, 2.6.35=20
and 3.0, which coincidentally were what I was using to develop/test the=20
driver at the time of the 3.11 release.

I no longer have any skin in the game (I've moved on to mostly=20
microcontroller work) but please, don't drop support for older kernels
if the only reason is to save release-time checks, or worse, "just=20
because"

My $0.02,

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iD8DBQFTSEHbPuLgii2759ARAuGiAKCMcwWhqzKEjhD+74aJ1R90wiAJUQCfSU6+
yY3qwMNcFtx582VM656Yg6I=
=HLCV
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
