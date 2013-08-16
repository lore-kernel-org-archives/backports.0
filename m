Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:52878
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755014Ab3HPLrf (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 07:47:35 -0400
Date: Fri, 16 Aug 2013 07:47:27 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with
 kernels < 3.2
Message-ID: <20130816114726.GC28867@shaftnet.org> (sfid-20130816_134737_463247_27BD626C)
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org>
 <1376571357-16506-2-git-send-email-pizza@shaftnet.org>
 <20130816030715.GB9574@garbanzo.do-not-panic.com>
 <520E012F.6020108@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
In-Reply-To: <520E012F.6020108@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 12:38:39PM +0200, Hauke Mehrtens wrote:
> I just compile tested cw1200 against many kernel versions and I always
> get an error of a missing symbol for kernel <=3D 3.9:
>=20
> WARNING: "get_random_int"
> [/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.4.56/drivers/net/wireless/cw1200/=
cw1200_core.ko]
> undefined!

Argh, it wasn't an exported symbol in older kernels.  (How did=20
this ever work for me on my 3.4 testbed?)

Hmm.  Rather than patching cw1200 to use get_random_bytes(),=20
would it make more sense to add a backported version of this to=20
compat-3.8 instead?

> I deactivate compiling against older kernels than 3.6.39 because that
> caused some other problems like starting with 3.6.37 and missing
> hw_features in 2.6.38:
>=20
>     drivers/net/wireless/cw1200/bh.c: In function =E2=80=98cw1200_registe=
r_bh=E2=80=99:
>     drivers/net/wireless/cw1200/bh.c:62:72: error: =E2=80=98WQ_CPU_INTENS=
IVE=E2=80=99
> undeclared (first use in this function)
>     drivers/net/wireless/cw1200/bh.c:62:72: note: each undeclared
> identifier is reported only once for each function it appears in
>     make[7]: *** [/drivers/net/wireless/cw1200/bh.o] Error 1

IIRC this was actually defined in 2.6.36. I have another patch (stripped=20
via the mainlining effort) that implements this functionality via=20
kthreads for <=3D2.6.35 kernels.  (Given that the new workqueue semantics=
=20
were backported, I'd hoped to retire this patch...)

I'll go through the 'ckmake' process, and post any necessary patches to=20
get cw1200 to cleanly build at least as far back as 2.6.35.

Cheers,

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org
Delray Beach, FL                          ^^ (email/xmpp) ^^
Quidquid latine dictum sit, altum viditur.

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iD8DBQFSDhFOPuLgii2759ARAl06AKCp6zAjgrisRGau7FhNsZPzis0tTQCgllpu
mpVu1W6FT/7PHyr7IIClz9c=
=HViB
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
