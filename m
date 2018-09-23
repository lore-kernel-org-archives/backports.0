Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:22498 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeIWS15 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 14:27:57 -0400
Subject: Re: [PATCH 13/14] backport: convert int led activate op to void when
 needed
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
References: <20180920112842.27198-1-luca@coelho.fi>
 <20180920112842.27198-14-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1aadb207-75fa-83e6-d838-2ac878b1c7c8@hauke-m.de> (sfid-20180923_143040_010174_F7A14CE4)
Date: Sun, 23 Sep 2018 14:30:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180920112842.27198-14-luca@coelho.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mb1Fzg2vLWXZFas1f9YxZiYgzzuMECfH4"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mb1Fzg2vLWXZFas1f9YxZiYgzzuMECfH4
Content-Type: multipart/mixed; boundary="LQo1442NaeUJJTmhJ5lrl3mZTuXTg8RcI";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Message-ID: <1aadb207-75fa-83e6-d838-2ac878b1c7c8@hauke-m.de>
Subject: Re: [PATCH 13/14] backport: convert int led activate op to void when
 needed
References: <20180920112842.27198-1-luca@coelho.fi>
 <20180920112842.27198-14-luca@coelho.fi>
In-Reply-To: <20180920112842.27198-14-luca@coelho.fi>

--LQo1442NaeUJJTmhJ5lrl3mZTuXTg8RcI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/20/2018 01:28 PM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> In kernel v4.19-rc1, the activate op in struct led_trigger, changed
> from void to int.  To solve this, add a semantic patch to insert a
> wrapper function that returns void and calls the function that returns
> int.
>=20
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  patches/led_activate.cocci | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 patches/led_activate.cocci
>=20
> diff --git a/patches/led_activate.cocci b/patches/led_activate.cocci
> new file mode 100644
> index 000000000000..df8211d29462
> --- /dev/null
> +++ b/patches/led_activate.cocci
> @@ -0,0 +1,24 @@
> +@act@
> +identifier activate_fn, p;
> +identifier m =3D~ "rx_led|tx_led|assoc_led|radio_led|tpt_led";
> +fresh identifier activate_fn_wrap =3D "bp_" ## activate_fn;
> +@@
> +<...
> ++#if LINUX_VERSION_IS_GEQ(4,19,0)
> +p->m.activate =3D activate_fn;
> ++#else
> ++p->m.activate =3D activate_fn_wrap;
> ++#endif
> +...>

Please use <+--- ---+> here it improves the speed by some magnitudes.

> +
> +@@
> +identifier act.activate_fn;
> +identifier act.activate_fn_wrap;
> +@@
> +int activate_fn(...) {...}
> ++#if LINUX_VERSION_IS_LESS(4,19,0)
> ++static void activate_fn_wrap(struct led_classdev *led_cdev)
> ++{
> ++	activate_fn(led_cdev);
> ++}
> ++#endif
>=20



--LQo1442NaeUJJTmhJ5lrl3mZTuXTg8RcI--

--Mb1Fzg2vLWXZFas1f9YxZiYgzzuMECfH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlunh2kACgkQ8bdnhZyy
68fwLwgA5lUtOhuvrwacGufTQ2j2d3K+1kN34yOfi5DBfuw/mIOho27LZTpkzVjv
O1Q6NtIhaahh17cK15iVFD79BtK+11UAphldeBiF86mfjHbrQqKN3gH+ggA4dGRQ
ViaRksIM9T+Z6s+WHbxunJkJ8CGq/lJ/zDPsmJHkEijTkECFMi4Y8zvtk6aSvtBm
2qn3CeDj5U6xJvaP3crQLiqej6LU/K1ir7wDkZHMB6O4KJXfpti1ZdK2dJxR0+13
dp55NThVaV9i47pv/NtciRs8jxlOIgpUv4v6d/wIUFZAUzS6hoMekcnvjzcGSx7i
GFRTsPtxz4qO5AzWWRRuQAGPOgYEJg==
=V/Fj
-----END PGP SIGNATURE-----

--Mb1Fzg2vLWXZFas1f9YxZiYgzzuMECfH4--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
