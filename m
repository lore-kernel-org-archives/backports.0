Return-path: <omer.efrat@tandemg.com>
From: Omer Efrat <omer.efrat@tandemg.com>
To: Hauke Mehrtens <hauke@hauke-m.de>, "backports@vger.kernel.org"
	<backports@vger.kernel.org>
CC: "aspriel@gmail.com" <aspriel@gmail.com>, Johannes Berg
	<johannes@sipsolutions.net>, John Crispin <john@phrozen.org>
Subject: Re: .coredump spatch
Date: Tue, 18 Sep 2018 06:28:07 +0000
Message-ID:
 <VI1PR02MB3631D220BDE0C139F4369F769A1D0@VI1PR02MB3631.eurprd02.prod.outlook.com>
References: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
In-Reply-To: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <backports@vger.kernel.org>
Message-ID: <20180918062807.U3lcjd6WTda1JGhlORXhJxcCk-AVtbMz3z-FwkoCaPg@z>

On Tue, Sep 18, 2018, Hauke Mehrtens wrote:

> The device structure now has this .coredump member which is also used by
> some wireless drivers, see here for example:
> https://git.kernel.org/linus/8e072168f75ebce85b96cbcefea2b10ddbd5913f
>=20
> I tried to create a spatch for this, but I failed to match the driver
> member because it is embedded inside an other structure, it looks like
> this for example:
>=20
> static struct pci_driver brcmf_pciedrvr =3D {
> ....
>         .driver.coredump =3D brcmf_dev_coredump,
> };
>=20
> I would like to convert this to this:
>=20
> static struct pci_driver brcmf_pciedrvr =3D {
> ....
> #if LINUX_VERSION_IS_GEQ(4,16,0)
>         .driver.coredump =3D brcmf_dev_coredump,
> #endif
> };
>=20
> Hauke

I think you should have a look at 0075-ndo-stats-64.cocci for a good refere=
nce.

Omer.=
