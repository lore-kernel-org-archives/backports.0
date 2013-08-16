Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37454 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3HPCyg (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Aug 2013 22:54:36 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so1491106pbc.29
        for <backports@vger.kernel.org>; Thu, 15 Aug 2013 19:54:35 -0700 (PDT)
Date: Thu, 15 Aug 2013 20:03:39 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH v3 00/10] backports: add wwan device drivers
Message-ID: <20130816030337.GA9574@garbanzo.do-not-panic.com> (sfid-20130816_045438_990958_F5D0BB5A)
References: <520CCC15.1090603@fh-kl.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <520CCC15.1090603@fh-kl.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 02:39:49PM +0200, Patrick Ziegler wrote:
> This adds wwan drivers for mobile broadband devices.
> Patches 1 to 8 add missing stuff required for the wwan drivers.
> Patch 9 adds device drivers.
>=20
> Changes v2:
> - cosmetic changes
> - remove pci function when pci was not configured
>=20
> Changes v3:
> - remove needless CONFIG_USB check
> - new defconfig for wwan device drivers
>=20
> Patrick Ziegler (10):
>   backports: fix build errors for old kernel versions without PCI
>     support
>   backports: add eth_prepare_mac_addr_change() and
>     eth_commit_mac_addr_change()
>   backports: define PM_EVENT_AUTO
>   backports: add usb_translate_errors()
>   backports: add usb_endpoint_maxp()
>   backports: update enum usb_device_speed with USB_SPEED_SUPER
>   backports: include headers directly if math64 header is missing
>   backports: define phys_addr_t for ARM on kernel version < 2.6.25
>   backports: add wwan device drivers
>   backports: add defconfig for wwan device drivers

Awesome, thanks applied and pushed!

  Luis

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDZaJAAoJEKwtdpJg+MHGC3YQAKamsQxsapL9PCaJ58Qq5v3y
Tn74XRr8AzXDbdYkxugSCJ9E25eZH5tMIUwFY7CXTfx2ep3SOrmY8MDsoo7K5LaE
HqTWFJZeGmmz4WhxmlSivx+Qy0gUAS9CejXD9nPOyD1XSQCCMGFVVYIOnwMb0b07
TQ3nDQXbQP4LNLraSCHEuske+r8y2IRKhJJxydcv0rxhCE5s1sHYFQJWWJeOnaw3
59kOnbfgXIpEKNpg1ugGsRptqf2ZMiEDHSY5OPyySXmyEMRmbXDiucQg+nkJxE3V
G8ilhO2SeP0N9lKsHkVv5lfINPzvUJ5NszqpoN7gktnEeCh3XSCQJzsYvf+xgCjl
6QnxW2VasCDrVteEpyV26YqoU6Ch+Fqw2EdByrHR1qUnmeyrUfpY5SlL/0DbiqBJ
Yr/E8Wly9nIxce3JrGXEvXjsVZUwD0FhEqbvw8nw9+7C0HkXDvubq4Rd+bzzzTZA
eh72SxegniaCEc6YDpffwThXE+AqARE+5bZK5BcxJlKi4EGw4SNeJQOMeTHmM/uN
YU7T5KetXKzo3gOgv2TovwMiEHpncnXCJH5TLCDYHcq7zyarx6dBMf4GIdPUgUTD
br1tfL6xWrP62tlMjwG/wbf0Na6UX1sUW2ThcRcjebtx9v8H/lSB5+HjHvpQKztR
nbLeaj2QCkCg3bHF6rFr
=Rj4o
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
