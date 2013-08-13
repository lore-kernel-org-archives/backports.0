Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56418 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab3HMBSD (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 12 Aug 2013 21:18:03 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4208739pdi.33
        for <backports@vger.kernel.org>; Mon, 12 Aug 2013 18:18:01 -0700 (PDT)
Date: Mon, 12 Aug 2013 18:27:01 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Phillip Moss <phillipmoss12@yahoo.es>
Cc: backports@vger.kernel.org
Subject: Re: Signal loss rtl8723ae wifi driver
Message-ID: <20130813012701.GD6439@garbanzo.do-not-panic.com> (sfid-20130813_031810_728687_539370FF)
References: <1375972465.52410.YahooMailBasic@web171402.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
In-Reply-To: <1375972465.52410.YahooMailBasic@web171402.mail.ir2.yahoo.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2013 at 03:34:25PM +0100, Phillip Moss wrote:
> Hi all,
> I have a rtl8723ae wifi card on my laptop. When connecting to any wifi
> Access Point the wifi signal fluctuates from full strength to very
> low.  In order to connect and stay connected I must be no farther than
> two meters from my router otherwise I get disconnected.  I have tried
> the kernel driver on multiple distros as well as the vendor drivers
> for older kernel versions. All seem to have the same problem. The card
> works ok on Windows 7 with vendor drivers. I have also tried compiling
> backports-3.10-rc1-2 with no luck.  During a signal loss period I get
> no logs but if I take the laptop too far from the AP dmesg reports:

You should report this on the linux-wireless mailing list and Cc the
maintainers, specially if using a more up to date release of the
driver.

  Luis

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSCYtkAAoJEKwtdpJg+MHGZmoP/jkzlkJHtcStm6pXgpw17OR/
+8gTNtx/GzajZWIbCck2l+toOyZH39sR8FzeNvDbn6Mucyqoxhg6XA0bRvTyfbZp
7I8Z9iA/hfSjT8W4EpEP2QuKLNxASGHECpaBDc3J7cX1IwH3Nh9SWfKe7vMOpa7J
kjuHbIxmZg6ojRTw/P7xcUYaQTznS11DOgH2yBzN4xoxtzajBEfScXYJwJ2/i1mw
2zt7xNz2FKnw5ncGgbX1srzqor5JYrmEsX+SxbkC6ZuskXa7bl7sdLcHRXdBnn77
lww0b/gvDLCuEiiFb5mXFDku13XyOwDBfgvKzunhY35PXRXWwEt3BxOMmBSKdX/d
kZe2df62TVc/ymL0jVZfX+Ac85892fRsKdgxrSUBNtnELkBUvmdpTS77c1jyKQG5
V1FmCuaNA+i3+2zc4/1NM+ceTmGMUdVvEZStCf04J39dV0L2ctDJSAKUweOvj7uB
8/OIf8FACFgM30VB75w2E/8jAGdqn/wwJV47op/vAB+Cw30/4pFCFh+ydJ+XnbNT
QzoEGcFLnAEFXyTlsR7ovlPhRT4TieRjebnKoxVyvjTOKDSuqBeofNrWi9+vVfCG
hT40XL3MC/BKlvazI3Mnz6VrKr7Wqr80KI0CROrTg39xdiD+Fl+PR9FpvH8D1hJY
Ti/AWWWfbgGwDK9uUI2c
=PlsF
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
