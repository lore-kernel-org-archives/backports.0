Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37204 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab3H0WQo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 18:16:44 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so5350525pad.23
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 15:16:44 -0700 (PDT)
Date: Tue, 27 Aug 2013 15:26:05 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backport: simplify #ifdefs in pci-aspm.h
Message-ID: <20130827222604.GA22651@garbanzo.do-not-panic.com> (sfid-20130828_001646_884955_F2AE2EE3)
References: <1377630060-14855-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <1377630060-14855-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 09:01:00PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Just use #else instead of two conditionals.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied and pushed, thanks!

  Luis

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHSd8AAoJEKwtdpJg+MHGLgoQAJnSkKcO+CCXXd6Ytd2W66N3
3BjjdT1SjYfyNKkD1A6AvhHZqdPBBCj6fMtPIhxNk1Z/gQ+J/KQZqJWG9glMKqMF
ro1Z1zkFdEhUtR8WmEdm190R9sfTLxkNVa22ZuCZUrJvZ2YP2qL2SnQZ+E49zi9/
VVL8K00FlSl0KeH4/IFsL17MPSa0STLN8jO3gt0c8/hMLC8gHtfyQ7FYMCJQPueV
5U54oetZt49nThQUhv9CrP8HPk7NTtnkg71wxbCNO9aa40+SJEYT4qRdhweDCiyY
sYQKIMBqU0/K5XnKkXuFSgVUPDuz1X6NPa5S2jzlIQkzBmCuBrgmEyR0vUyj7gjn
wlmcYihzGMTdWwCwbqV2Sx1GGpR8ffVKQD4uQN9Nncj6egX/tGwdZv6QjDs6rYTG
k37cBw1Wpqv+4Dd6TG+gFe8mvmV8oWdicCPt6hkKKkyFiiN/oEAA3aqsZEHeMJRB
uybXluryjDrL+Fyju59D0iaTX6crIEmNRN8JSUiAIyOe6c/yFX87Y/luTwZAqNOn
aZSg0av2eq9/Sf34N60Ax2ep+qdp3ufsAnf+14EFqHvXR3WEbWfuN5xltIc4f0+8
62dBRqYgE773ydRIC3n5UhNZ6rfvqAAmVBGX03RDBrrC+B3+F0kEYOUPkF9BJghs
/0hf4O+Q5eHb52JOrDw3
=jEq9
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
