Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:46738 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeIWTuW (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 15:50:22 -0400
Subject: Re: [PATCH] backport: add ktime_get_raw_ts64() backport for < 3.19
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
References: <20180920162622.30203-1-luca@coelho.fi>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4cb197ca-9ae6-18b9-ec7a-59eb893d96dd@hauke-m.de> (sfid-20180923_155252_112914_9FA2928C)
Date: Sun, 23 Sep 2018 15:52:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180920162622.30203-1-luca@coelho.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LJhEAK1huxmZTkq7khya92FlHNhMH1mLi"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LJhEAK1huxmZTkq7khya92FlHNhMH1mLi
Content-Type: multipart/mixed; boundary="RFpMyz4pIetm5NTiStQHeoZ6G41ien0N7";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Message-ID: <4cb197ca-9ae6-18b9-ec7a-59eb893d96dd@hauke-m.de>
Subject: Re: [PATCH] backport: add ktime_get_raw_ts64() backport for < 3.19
References: <20180920162622.30203-1-luca@coelho.fi>
In-Reply-To: <20180920162622.30203-1-luca@coelho.fi>

--RFpMyz4pIetm5NTiStQHeoZ6G41ien0N7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/20/2018 06:26 PM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> The getrawmonotonic64() function that is used by the
> ktime_get_raw_ts64() backport was only introduced in 3.19.  To fix
> compilation with earlier kernels, do the convertion from
> getrawmonotonic() manually if the kernel is < 3.19.
>=20
> Additionally, add timespec_to_timespec64() that we need for this
> conversion (and which was only introduced in 4.15).
>=20
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/linux/timekeeping.h | 29 +++++++++++++++++++=

>  1 file changed, 29 insertions(+)
>=20
> diff --git a/backport/backport-include/linux/timekeeping.h b/backport/b=
ackport-include/linux/timekeeping.h
> index aebb00ca366b..56fca5759b8e 100644
> --- a/backport/backport-include/linux/timekeeping.h
> +++ b/backport/backport-include/linux/timekeeping.h
> @@ -55,11 +55,40 @@ static inline void ktime_get_ts64(struct timespec64=
 *ts)
>  }
>  #endif
> =20
> +#if LINUX_VERSION_IS_LESS(3,19,0)
> +/* This was introduced in 4.15, but we only need it in the
> + * ktime_get_raw_ts64 backport() for < 3.19.

timespec_to_timespec64() was already added in 3.17, see
https://elixir.bootlin.com/linux/v3.17.8/ident/timespec_to_timespec64

> + */
> +#if __BITS_PER_LONG =3D=3D 64
> +static inline struct timespec64 timespec_to_timespec64(const struct ti=
mespec ts)
> +{
> +	return *(const struct timespec64 *)&ts;
> +}
> +
> +#else
> +static inline struct timespec64 timespec_to_timespec64(const struct ti=
mespec ts)
> +{
> +	struct timespec64 ret;
> +
> +	ret.tv_sec =3D ts.tv_sec;
> +	ret.tv_nsec =3D ts.tv_nsec;
> +	return ret;
> +}
> +#endif
> +#endif /* < 3.19 */
> +


--RFpMyz4pIetm5NTiStQHeoZ6G41ien0N7--

--LJhEAK1huxmZTkq7khya92FlHNhMH1mLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlunmqoACgkQ8bdnhZyy
68diGwf9GOZeWs0gJ+vJHjeTzp+9cAZr9JEsgz5A9CJCvrLq1z3DVoGwH5QzCynv
ZuaQvljHkhNtscXXj3nkseCBNPeDriBikoJquEniuQJOuY5fd8KUTpei2IkZUVC6
r21jammjkcV3uMm6rbH4380YDW+r5VMfMFZeoMFzHL/eimin5W8jmEzbFDSfynsT
OQqxQfxw6bB+YbHIoyQ6zVIlryfWhKKyot4GF0YGAOG1MGfMxMgs7/oYb9gLVkK4
8P7WvDonOyqD6cY2c7t8mSyzXnNNC6OW/mtWXI03Dyk2U4fkej2nZvbIs5fTsVdH
or9LF9wGFQuSuNA1094VKrO1E+O4Ng==
=FF7b
-----END PGP SIGNATURE-----

--LJhEAK1huxmZTkq7khya92FlHNhMH1mLi--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
