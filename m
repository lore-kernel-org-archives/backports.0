Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:22758 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeIWUMj (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 16:12:39 -0400
Subject: Re: [PATCH 00/14] backport: updates for 4.19
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
References: <20180920112842.27198-1-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <60c22894-4313-fb34-598c-208b8e78b830@hauke-m.de> (sfid-20180923_161503_937138_D6B3C880)
Date: Sun, 23 Sep 2018 16:14:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t9L9S0OyDVsyyT3tE72kNBSdedFxYWCj3"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t9L9S0OyDVsyyT3tE72kNBSdedFxYWCj3
Content-Type: multipart/mixed; boundary="Um7ltqW8naX0JiEiObUBXeajxgjDeXOqS";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Message-ID: <60c22894-4313-fb34-598c-208b8e78b830@hauke-m.de>
Subject: Re: [PATCH 00/14] backport: updates for 4.19
References: <20180920112842.27198-1-luca@coelho.fi>
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>

--Um7ltqW8naX0JiEiObUBXeajxgjDeXOqS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/20/2018 01:28 PM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> Hi,
>=20
> I finally found the time to go through the backports I had made for
> our internal tree and send them upstream.

Thank you for the patches. I had some comments, but in general they look
good.

> We've compile tested this on some old kernels, but the list is far
> from being comprehensive.
Which kernel versions do you support internally?

I tested this with some kernel versions and saw many problems with < 4.0
but I do not really care about them any more. The problems where mostly
not caused by these patches.

> Please review.
>=20
> Cheers,
> Luca.
>=20
>=20
> Johannes Berg (1):
>   backports: improve skb->xmit_more handling
>=20
> Luca Coelho (12):
>   backport: fix compilation with IPV6 not set
>   backport: introduce match_string() for kernels < 4.6
>   backport: add patch to ignore iwlwifi removal on < 3.14 kernels
>   backport: convert tree section names to ascii
>   backport: add rhashtable-types.h
>   backport: remove duplicate leds.h inclusion from backport-4.5.c
>   backport: prevent unused subclass variable warning in < 3.18
>   backport: make ktime_get_boottime_seconds() non-inline
>   backport: update u64_stats_init() to a new version in kernels < 4.2
>   backport: update lib-rhashtable.c
>   backport: convert int led activate op to void when needed
>   backports: add __alloc_bucket_spinlocks() for < 4.19
>=20
> Shahar S Matityahu (1):
>   backports: add wait_event_killable_timeout backport support
>=20
>  backport/backport-include/linux/netdevice.h   | 10 ++++++
>  backport/backport-include/linux/skbuff.h      |  9 ++++++
>  backport/backport-include/linux/spinlock.h    | 32 +++++++++++++++++++=

>  backport/backport-include/linux/string.h      |  4 +++
>  backport/backport-include/linux/timekeeping.h |  5 +--
>  backport/backport-include/linux/wait.h        | 15 +++++++++
>  backport/compat/Kconfig                       |  1 +
>  backport/compat/Makefile                      |  1 +
>  backport/compat/backport-4.18.c               | 11 +++++++
>  backport/compat/backport-4.4.c                |  6 ++++
>  backport/compat/backport-4.5.c                |  1 -
>  backport/compat/backport-4.6.c                | 26 +++++++++++++++
>  devel/git-tracker.py                          |  2 ++
>  .../0059-skb_xmit_more/skb_no_xmit_more.cocci | 10 ++----
>  patches/iwlwifi-pci-device-removal.patch      | 24 ++++++++++++++
>  patches/led_activate.cocci                    | 24 ++++++++++++++
>  patches/lib-rhashtable.patch                  | 14 ++++++++
>  17 files changed, 183 insertions(+), 12 deletions(-)
>  create mode 100644 backport/compat/backport-4.18.c
>  create mode 100644 patches/iwlwifi-pci-device-removal.patch
>  create mode 100644 patches/led_activate.cocci
>  create mode 100644 patches/lib-rhashtable.patch
>=20



--Um7ltqW8naX0JiEiObUBXeajxgjDeXOqS--

--t9L9S0OyDVsyyT3tE72kNBSdedFxYWCj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlunn98ACgkQ8bdnhZyy
68deXQgA5FQDsJhaOtx8oDoTZwzl6nrrrinEUBWHZVgAVh1vkHOWogxBK1dythep
RjsH8n1iGBFdurCJN9gyPustx2XdGFhiGMl5GfQm0W7dSuHinGf/SCEGtWgSMYne
OOrpWUPpX1cyWw+6+/0/GErBm62m9C04xlnm4gi8M4gKUHyVpQh2ShiFamML23a4
iMnWKldyKMoEiHk4fhVGVDJ2oD/MZM3OZaE2kX1Q69sZ4wgXQ1sZMTdX8aWeQUed
rDYQCScvSVKa1EELCf3q5VmWZQrbYz5bs+ZYm/Xo3sz8VRFwi/F28zhuTlo3VMjg
UQB7V8DTNpid6nu8OacoapJvUxmYJw==
=6fZp
-----END PGP SIGNATURE-----

--t9L9S0OyDVsyyT3tE72kNBSdedFxYWCj3--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
