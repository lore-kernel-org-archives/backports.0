Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:44036 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbeIYCcA (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 24 Sep 2018 22:32:00 -0400
Subject: Re: [PATCH 00/10] backports: misc fixes to improve support of 4.19
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <1537776741.1707.24.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <defcd01d-5146-4c58-1317-26fd90dcea5d@hauke-m.de> (sfid-20180924_222805_061855_8907BF37)
Date: Mon, 24 Sep 2018 22:27:57 +0200
MIME-Version: 1.0
In-Reply-To: <1537776741.1707.24.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g01w3V9KdzD3TKJUJcYuXoBAlnWX6eJHJ"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g01w3V9KdzD3TKJUJcYuXoBAlnWX6eJHJ
Content-Type: multipart/mixed; boundary="9mxksjmbMbfYJybPEffdhZTs9A8yqSgxI";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, john@phrozen.org
Message-ID: <defcd01d-5146-4c58-1317-26fd90dcea5d@hauke-m.de>
Subject: Re: [PATCH 00/10] backports: misc fixes to improve support of 4.19
References: <20180923174535.16198-1-hauke@hauke-m.de>
 <1537776741.1707.24.camel@sipsolutions.net>
In-Reply-To: <1537776741.1707.24.camel@sipsolutions.net>

--9mxksjmbMbfYJybPEffdhZTs9A8yqSgxI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/24/2018 10:12 AM, Johannes Berg wrote:
> I applied pretty much everything, but the result isn't looking so
> great...

Thanks for applying the patches.

> But that's sort of looking only perhaps? 3.10-4.2 fail on skcipher
> backport, which was pretty much always doomed given the crypto API
> complexity ...

If it is only needed for the drivers using lib80211, I think we can make
them depend on kernel >=3D 4.2.

Did you test compile it on drvbp1.linux-foundation.org, or do I have to
update the installed kernel versions there?

Hauke


--9mxksjmbMbfYJybPEffdhZTs9A8yqSgxI--

--g01w3V9KdzD3TKJUJcYuXoBAlnWX6eJHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlupSM0ACgkQ8bdnhZyy
68cx+ggA5eNcw8yZ7IZ6LOS+lBZz65Nw1xF41RfybXrgscRHRrBjolqpzccnzJS4
XDaGKY10GWV3nVxfVaPa1Tx8k/qRDj2A6hX+YzRmQBgFTXGqViPIIog95QSHcSZ9
hThLvsBb/yzqdC1JtubnMR3JuF0+KU1ht7gFfZk+OdsaS7TudNXZNtg7qEXdEAjC
/3tF8gxpjiYKoDjWJcBuOWA2ySg3hxHrCCpln4xHmthtKDU+6X4m40KXSZaCXnTX
13NDtI2u2usutJdQPzZ5c3ndMxKE12txj+uiIYXOaU0L5bm5Gx2BLObXp28sajzz
EIRCF4XyB/RXgWLk6+C5sFS8jC1Caw==
=PpCw
-----END PGP SIGNATURE-----

--g01w3V9KdzD3TKJUJcYuXoBAlnWX6eJHJ--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
