Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:45728 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbeJAEiy (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Oct 2018 00:38:54 -0400
Subject: Re: [PATCH] add support for pci_alloc_irq_vectors
To: Omer Dagan <omer.dagan@tandemg.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>
 <c2cb21f7-ff19-db8a-faa6-61ef0804ffd8@hauke-m.de>
 <AM0PR02MB365025326A06C3B60C28036093150@AM0PR02MB3650.eurprd02.prod.outlook.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <0757f4e8-027d-5a7e-8403-19ec1c6cd3a5@hauke-m.de> (sfid-20181001_000424_432086_3EF83D27)
Date: Mon, 1 Oct 2018 00:04:01 +0200
MIME-Version: 1.0
In-Reply-To: <AM0PR02MB365025326A06C3B60C28036093150@AM0PR02MB3650.eurprd02.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e7r3MnD4Jf1oafkoPtbd8CsPdfpPGOXhn"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e7r3MnD4Jf1oafkoPtbd8CsPdfpPGOXhn
Content-Type: multipart/mixed; boundary="rYUCDV4MRqdcezkdtnVn1Z5uScKJciYpc";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Omer Dagan <omer.dagan@tandemg.com>, "mcgrof@kernel.org"
 <mcgrof@kernel.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <0757f4e8-027d-5a7e-8403-19ec1c6cd3a5@hauke-m.de>
Subject: Re: [PATCH] add support for pci_alloc_irq_vectors
References: <AM0PR02MB36506A5694D9DEFB288445F093160@AM0PR02MB3650.eurprd02.prod.outlook.com>
 <c2cb21f7-ff19-db8a-faa6-61ef0804ffd8@hauke-m.de>
 <AM0PR02MB365025326A06C3B60C28036093150@AM0PR02MB3650.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB365025326A06C3B60C28036093150@AM0PR02MB3650.eurprd02.prod.outlook.com>

--rYUCDV4MRqdcezkdtnVn1Z5uScKJciYpc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Omer,

On 09/26/2018 09:29 AM, Omer Dagan wrote:
> Hi Hauke=A0
> I removed the Makefile dependency - you are correct there was no need
> for that
> the whitespace issue was not intentional -=A0corrected in this=A0patch =


You should use whitespace to do some indention. I do not know if you
missed then or if your mail program removed them. I would suggest to
send the patches with "git send-email".

It also looks like your mail is blocked by the mailling list, probably
because it uses html mail.


Hauke

>=20
> from: Omer Dagan <omer.dagan@tandemg.com>
> Date: Sun, 16 Sep 2018 17:25:11 +0300
> Subject: [PATCH] add support for pci_alloc_irq_vectors
>=20
> =A0 =A0 add support for function in kernels under 4.8
> =A0 =A0 function is a wrapper around 'pci_enable_msi_block' or
> =A0 =A0 'pci_enable_msi_range' depending on the kernel version
> =A0 =A0 the min\max number of interrupts was overridden to always use t=
he
> =A0 =A0 max number of interrupts which seems correct since it was not
> =A0 =A0 supported in the old APIs
>=20
> Signed-off-by: Omer Dagan <omer.dagan@tandemg.com>
> ---
> =A0backport/backport-include/linux/pci.h | 19 +++++++++++++++++++
> =A0backport/compat/backport-4.8.c=A0 =A0 =A0 =A0 | 25 +++++++++++++++++=
++++++++
> =A02 files changed, 44 insertions(+)
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
> diff --git a/backport/compat/backport-4.8.c b/backport/compat/backport-=
4.8.c
> index 7d056444..706bd067 100644
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
> +res =3D pci_enable_msi_block(dev, msi_nvect);
> +if (res =3D=3D 0) {
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




--rYUCDV4MRqdcezkdtnVn1Z5uScKJciYpc--

--e7r3MnD4Jf1oafkoPtbd8CsPdfpPGOXhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAluxSFIACgkQ8bdnhZyy
68eUjgf/a058XF+gTkVCwAalDEtX2C8DPW4IuA6YMeHz5cfZQV4Kx8msPc3511S2
FFTxgeu7kFTLHVCWzVG6umXBwr4/YPUEsAVMWzgXc6PyHZusQAIbJP0+eu+883vK
dQMdxZkIVn1CkaGcBr2aO2cTLfhbqanNPddrQZxYiDvyK2XwHA95maexORkIuvJl
5+JpDgCdCjSzBQ2n6unUa+vi8YF1F9ETRcHe94rQ9YP7TLVhuXL/Nc4MWFv08HNF
hBzL9VP9QnvayFTevJsf2iv4buiy00PBnDMVokza/VMyMJDeG88byPcqZRacWyYR
bvRkmCpJ0Dr0t9R1pvPniwvKovojkQ==
=mk6K
-----END PGP SIGNATURE-----

--e7r3MnD4Jf1oafkoPtbd8CsPdfpPGOXhn--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
