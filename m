Return-path: <backports-owner@vger.kernel.org>
Received: from mail01.echostar.com ([139.85.4.20]:60925 "EHLO
	chapzsmtp1.echostar.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752472AbaJ0Njv (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 27 Oct 2014 09:39:51 -0400
Received: from mail.echostar.com (unknown [10.182.50.88])
	by Websense Email Security Gateway with ESMTPS id E5DE983E0E0BE
	for <backports@vger.kernel.org>; Mon, 27 Oct 2014 07:39:49 -0600 (MDT)
From: "Paramahamsa, Viplav" <Viplav.Paramaham@slingmedia.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "Raikar, Yatish" <yatishjnr@slingmedia.com>
Subject: Backports - v3.18-rc1 build problems
Date: Mon, 27 Oct 2014 13:39:49 +0000
Message-ID: <65B68BAF3C31D54B9A10B0592C9E025B9050D73C@CHWPIEXC10.SATS.CORP> (sfid-20141027_143956_837201_77781662)
Content-Type: multipart/mixed;
	boundary="_002_65B68BAF3C31D54B9A10B0592C9E025B9050D73CCHWPIEXC10SATSC_"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

--_002_65B68BAF3C31D54B9A10B0592C9E025B9050D73CCHWPIEXC10SATSC_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am facing build problems wi=
th latest release of backports - v3.18-rc1.

I am trying to cross compile with Freescale's LTIB. These are the details o=
f the platform on which I am trying to build:
Linux kernel version : 2.6.35
ARCH : ARM
Freescale BSP : L2.6.35_1.1.0_130130

This is the build command I am using : make CROSS_COMPILE=3D/opt/freescale/=
usr/local/gcc-4.4.4-glibc-2.11.1-multilib-1.0/arm-fsl-linux-gnueabi/bin/arm=
-none-linux-gnueabi- ARCH=3Darm KLIB=3D ${TOP}/rootfs/lib/modules/2.6.35.3-=
571-gcca29a0/ KLIB_BUILD=3D ${TOP}/rpm/BUILD/linux/

PFA file which has compilation errors I am getting.
I tried fixing these. But I was getting more errors in compat-3.x.x.c file =
compilation.

I am able to successfully compile an older version of backports - 3.10.17.

Please suggest how can I fix these errors. Is there any patch I need to app=
ly to get rid of these? If yes, can you please provide the link for the sam=
e.

Regards,
Viplav


--_002_65B68BAF3C31D54B9A10B0592C9E025B9050D73CCHWPIEXC10SATSC_
Content-Type: text/plain; name="v3.18-rc1_Build_errors.txt"
Content-Description: v3.18-rc1_Build_errors.txt
Content-Disposition: attachment; filename="v3.18-rc1_Build_errors.txt";
	size=1036; creation-date="Mon, 27 Oct 2014 12:31:07 GMT";
	modification-date="Mon, 27 Oct 2014 12:31:07 GMT"
Content-Transfer-Encoding: base64

Q0MgW01dICAvaG9tZS92aXBsYXYvYmFja3BvcnRzL2JhY2twb3J0cy0zLjE4LXJjMS0xL2NvbXBh
dC9tYWluLm8NCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS92aXBsYXYvYmFja3BvcnRzL2Jh
Y2twb3J0cy0zLjE4LXJjMS0xL2JhY2twb3J0LWluY2x1ZGUvbGludXgva2VybmVsLmg6OSwNCiAg
ICAgICAgICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L2NhY2hlLmg6NCwNCiAgICAgICAgICAg
ICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L3RpbWUuaDo3LA0KICAgICAgICAgICAgICAgICBmcm9t
IGluY2x1ZGUvbGludXgvc3RhdC5oOjYwLA0KICAgICAgICAgICAgICAgICBmcm9tIGluY2x1ZGUv
bGludXgvbW9kdWxlLmg6MTAsDQogICAgICAgICAgICAgICAgIGZyb20gL2hvbWUvdmlwbGF2L2Jh
Y2twb3J0cy9iYWNrcG9ydHMtMy4xOC1yYzEtMS9iYWNrcG9ydC1pbmNsdWRlL2xpbnV4L21vZHVs
ZS5oOjMsDQogICAgICAgICAgICAgICAgIGZyb20gL2hvbWUvdmlwbGF2L2JhY2twb3J0cy9iYWNr
cG9ydHMtMy4xOC1yYzEtMS9jb21wYXQvbWFpbi5jOjE6DQovaG9tZS92aXBsYXYvYmFja3BvcnRz
L2JhY2twb3J0cy0zLjE4LXJjMS0xL2JhY2twb3J0LWluY2x1ZGUvbGludXgvcHJpbnRrLmg6NToz
MTogZXJyb3I6IGxpbnV4L3ByaW50ay5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQptYWtl
WzZdOiAqKiogWy9ob21lL3ZpcGxhdi9iYWNrcG9ydHMvYmFja3BvcnRzLTMuMTgtcmMxLTEvY29t
cGF0L21haW4ub10gRXJyb3IgMQ0KbWFrZVs1XTogKioqIFsvaG9tZS92aXBsYXYvYmFja3BvcnRz
L2JhY2twb3J0cy0zLjE4LXJjMS0xL2NvbXBhdF0gRXJyb3IgMg0KbWFrZVs0XTogKioqIFtfbW9k
dWxlXy9ob21lL3ZpcGxhdi9iYWNrcG9ydHMvYmFja3BvcnRzLTMuMTgtcmMxLTFdIEVycm9yIDIN
Cm1ha2VbM106ICoqKiBbbW9kdWxlc10gRXJyb3IgMg0KbWFrZVsyXTogKioqIFttb2R1bGVzXSBF
cnJvciAyDQptYWtlWzFdOiAqKiogW21vZHVsZXNdIEVycm9yIDINCm1ha2U6ICoqKiBbZGVmYXVs
dF0gRXJyb3IgMg==

--_002_65B68BAF3C31D54B9A10B0592C9E025B9050D73CCHWPIEXC10SATSC_--
