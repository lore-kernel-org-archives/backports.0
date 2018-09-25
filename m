Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:17182 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeIZBWN (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 25 Sep 2018 21:22:13 -0400
Subject: Re: Subject: [PATCH] add support for pci_alloc_irq_vectors
To: Omer Dagan <omer.dagan@tandemg.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <c2cb21f7-ff19-db8a-faa6-61ef0804ffd8@hauke-m.de> (sfid-20180925_211318_530150_C2D0EF8E)
Date: Tue, 25 Sep 2018 21:13:06 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZXTFUde7cdNI16etpt7ZIFoLVoYOIrEhg"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZXTFUde7cdNI16etpt7ZIFoLVoYOIrEhg
Content-Type: multipart/mixed; boundary="CAQhMsrthr0KicUR6frdSGGKkNACt0NC8";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Omer Dagan <omer.dagan@tandemg.com>, "mcgrof@kernel.org"
 <mcgrof@kernel.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <c2cb21f7-ff19-db8a-faa6-61ef0804ffd8@hauke-m.de>
Subject: Re: Subject: [PATCH] add support for pci_alloc_irq_vectors
References: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>

--CAQhMsrthr0KicUR6frdSGGKkNACt0NC8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/25/2018 09:59 AM, Omer Dagan wrote:
> The following patch adds support for the 'pci_alloc_irq_vectors' functi=
on,
> it does not implement the functionality as implemented in later kernels=

> but just provides a wrapper around the deprecate dfunctions implemented=

> previouslly

Thank you for this patch, I was too lazy to backport this and made
WIL6210 depend on kernel >=3D 4.8, so this can be removed with your patch=
=2E

> Subject: [PATCH] add support for pci_alloc_irq_vectors
>=20
> =A0 =A0 add support for function in kernels under 4.8
> =A0 =A0 function is a wrapper around 'pci_enable_msi_block' or
> =A0 =A0 'pci_enable_msi_range' depending on the kernel version
> =A0 =A0 since it is a wrapper around these functions and they
> =A0 =A0 are defined in 3.14 there was a need to add dependency in the
> =A0 =A0 Makefile
> =A0 =A0 the min\max number of interrupts was overridden to always use t=
he
> =A0 =A0 max number of interrupts which seems correct since it was not
> =A0 =A0 supported in the old APIs
>=20
> Signed-off-by: Omer Dagan <omer.dagan@tandemg.com>
>=20
> diff --git a/backport/backport-include/linux/pci.h
> b/backport/backport-include/linux/pci.h
> index 67ac40fc..531f5a47 100644
> --- a/backport/backport-include/linux/pci.h
> +++ b/backport/backport-include/linux/pci.h
> @@ -134,6 +134,25 @@ static inline int pci_vfs_assigned(struct pci_dev =
*dev)
> =A0
> =A0#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
> =A0
> +#if LINUX_VERSION_IS_LESS(4,8,0)
> +#define pci_alloc_irq_vectors LINUX_BACKPORT(pci_alloc_irq_vectors)
> +#ifdef CONFIG_PCI_MSI
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +unsigned int max_vecs, unsigned int flags);
> +#else
> +static inline int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned
> int min_vecs,
> +unsigned int max_vecs, unsigned int flags)
> +{ return -ENOSYS; }
> +#endif
> +#endif
> +
> +#if LINUX_VERSION_IS_LESS(4,8,0)
> +#define pci_free_irq_vectors LINUX_BACKPORT(pci_free_irq_vectors)
> +static inline void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +}
> +#endif
> +
> =A0#if LINUX_VERSION_IS_LESS(3,14,0)
> =A0#define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
> =A0#ifdef CONFIG_PCI_MSI
> diff --git a/backport/compat/Makefile b/backport/compat/Makefile
> index ac70aaf8..52ad69ea 100644
> --- a/backport/compat/Makefile
> +++ b/backport/compat/Makefile
> @@ -34,7 +34,7 @@ compat-$(CPTCFG_KERNEL_4_4) +=3D backport-4.4.o
> =A0compat-$(CPTCFG_KERNEL_4_5) +=3D backport-4.5.o
> =A0compat-$(CPTCFG_KERNEL_4_6) +=3D backport-4.6.o
> =A0compat-$(CPTCFG_KERNEL_4_7) +=3D backport-4.7.o
> -compat-$(CPTCFG_KERNEL_4_8) +=3D backport-4.8.o
> +compat-$(CPTCFG_KERNEL_4_8) +=3D backport-4.8.o backport-3.14.o

I think this change is wrong.

> =A0compat-$(CPTCFG_KERNEL_4_10) +=3D backport-4.10.o
> =A0compat-$(CPTCFG_KERNEL_4_12) +=3D backport-4.12.o
> =A0
> diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-=
4.8.c
> index 7d056444..53ebe1d4 100644
> --- a/backport/compat/backport-4.8.c
> +++ b/backport/compat/backport-4.8.c
> @@ -9,6 +9,7 @@
> =A0 */
> =A0#include <linux/usb.h>
> =A0#include <linux/usb/cdc.h>
> +#include <linux/pci.h>
> =A0
> =A0int cdc_parse_cdc_header(struct usb_cdc_parsed_header *hdr,
> =A0struct usb_interface *intf,
> @@ -144,3 +145,27 @@ next_desc:
> =A0return cnt;
> =A0}
> =A0EXPORT_SYMBOL_GPL(cdc_parse_cdc_header);
> +
> +#if LINUX_VERSION_IS_LESS(4,8,0)
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +unsigned int max_vecs, unsigned int flags)
> +{
> +int res;
> +int msi_nvect =3D max_vecs;
> +
> +if (max_vecs < min_vecs)
> +return -ERANGE;
> +
> +#if LINUX_VERSION_IS_LESS(3,15,0)
> +=A0 =A0 res =3D pci_enable_msi_block(dev, msi_nvect);
> +=A0 =A0 if (res =3D=3D 0) {
> +return msi_nvect;
> +}
> +#else
> +res =3D pci_enable_msi_range(dev, msi_nvect, msi_nvect);
> +return msi_nvect;
> +#endif /*LINUX_VERSION_IS_LESS(3,15,0)*/
> +return -ENOSPC;
> +}
> +EXPORT_SYMBOL(pci_alloc_irq_vectors);
> +#endif /*LINUX_VERSION_IS_LESS(4,8,0)*/
> --=A0
> 2.17.1
>=20

It looks like most trailing withe spaces are gone, was this intended?

Hauke


--CAQhMsrthr0KicUR6frdSGGKkNACt0NC8--

--ZXTFUde7cdNI16etpt7ZIFoLVoYOIrEhg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluqiMUACgkQ8bdnhZyy
68elzgf/TlbUwFoCKZt/cydn2V0naDu118Qe7ya6uEZSH7VUzMjbumrwo0GGn6pV
5cVnTThLUJ+3sGkOlW6/1YnHXLSj3M6aqQymB5cqnR4alMW8JBtWAQI/vIQHOh9Q
rRUaNaNHrWZA1dwdSX7EedBT4czjAGTXLePZ/QLG0Zs8tULUgw8bbVFCxLhnSh8h
1WVWkZrbDOcHaNatBG9aW0U5P8hnEgqHE8d71ND7Kj7jmGahBEqniKdJgCvA5GZz
qViLnAprWsqq4eUvvrxR9eHSgQyGEeR66I5iDDzKTDxiI6N+SnX2bJiifRJgyQGZ
IkmP3409O5W2e7UZf0xt+S5ppOP7yw==
=EnYI
-----END PGP SIGNATURE-----

--ZXTFUde7cdNI16etpt7ZIFoLVoYOIrEhg--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
