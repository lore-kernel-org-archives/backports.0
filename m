Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62300 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab3H1Ayw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 20:54:52 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5550138pdj.40
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 17:54:52 -0700 (PDT)
Date: Tue, 27 Aug 2013 18:04:13 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: ww_mutex compile warning
Message-ID: <20130828010411.GB22651@garbanzo.do-not-panic.com> (sfid-20130828_025457_635637_C7BCE042)
References: <520E02B8.5040305@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
In-Reply-To: <520E02B8.5040305@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 12:45:12PM +0200, Hauke Mehrtens wrote:
> Hi Luis,
>=20
> The empty implementations of owner_running() and mutex_spin_on_owner()
> in backport/compat/kernel/ww_mutex.c should return something (one an in,
> one an bool), but they don't. That causes a compile warning about a
> missing return statement with kernel 3.9. I do not understand that code,
> could you please have a look into that.

Sure here's the fix, I'll submit. Thanks for reporting this.

  Luis

diff --git a/backport/compat/kernel/ww_mutex.c b/backport/compat/kernel/ww_=
mutex.c
index 257c2a4..204ac8f 100644
--- a/backport/compat/kernel/ww_mutex.c
+++ b/backport/compat/kernel/ww_mutex.c
@@ -206,10 +206,12 @@ static void mspin_unlock(struct mspin_node **lock, st=
ruct mspin_node *node)
=20
 static inline bool owner_running(struct mutex *lock, struct task_struct *o=
wner)
 {
+	return false;
 }
=20
 int mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 {
+	return 1;
 }
=20
 static inline int mutex_can_spin_on_owner(struct mutex *lock)

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHUyLAAoJEKwtdpJg+MHG1QEP/jDUUkiuFvNYqGjMFcauU0mv
m+cNPBtE6hfSTO/qrYDuOnAKytxLRvQPghLFlb339Vkj6V24EhEvD6xzojBnXE2W
hAVkpseTbjPH/wfKg5hu128SYwO2+ro117ulAIWORG6p1lMXF4eml9UlfftDjV5F
zsgtNc9p5kiKP/Y4u0lJnKavuDgc0FaeURBAJPzi0/XCF0A9T33FRmUrRLqVMy5K
3pk6lP2ZSReOuy8AtGBMsvmETmwmCTqWdJIt7n0YCNPBY2IxVdbkrSXDkeiguppc
It6eKJNFPKNKNoCuQ+5iG9zQK7WEQwVj8Di57VowW9NabdT4MRH3OuBpML9mMr7V
uOhesQwnBJlHWaINwiQfSMMFtJxUasLYoWuDeeUAIN8ihYSBbPvVEQVrYxoCKPaJ
9Rzi2/HDfRd9LnFIsjhns8DrME0R6QFwRfKRm50E5Xl8aXo26C/RpyxJFNzSKSIB
VhBN9tmmcRvOqeKUyjycqfzX9KqtBYQVtsU+3nW+5X7SOrFC9meegby26+EBq9Ae
jgc0IXT/9Xz7N6H3vYTT/zJ775decm61O1wqp3+gYe6h1awk1LNfTlxfcQogsWBc
IvUgY1u2SzaYS0zJu/j6S0NiRrbmxAeUa3EG26TUvU55/8wWTE5PBacgaxCbT7Hl
BblGqvvKIFuA4BaWjTiG
=snd7
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
