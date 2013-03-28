Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <noelamac@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130328111250.GA4671@stt008.linux.site>
References: <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
	<CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
	<CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
	<20130327175711.GA8794@stt008.linux.site>
	<CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
	<CAB=NE6W6Ey8iU1vs=XfA7Or0wF=Qh6Gu8zF-DxMatgk-V+wdkQ@mail.gmail.com>
	<CAKprTDFJet+m7RmkZt5uyf=FMyEYciCYUahEcCC6_ukRQ2pjgw@mail.gmail.com>
	<CAB=NE6VzvVkFvGaudZHQTM5R3s05QV5Jw23wZ_DLxkNf00Utdg@mail.gmail.com>
	<20130328104030.GA4602@stt008.linux.site>
	<CAB=NE6V=AnTabh3p_yY+GmzPo-+GLAdzEBTQMm4VN1xUuVm_sw@mail.gmail.com>
	<20130328111250.GA4671@stt008.linux.site>
Date: Thu, 28 Mar 2013 17:24:18 +0100
Message-ID: <CAKprTDGZAzLMGTYw0sY+oW+T3uX8WNh98oXkjcX+Cf5LEwYTHA@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

2013/3/28 Camale=F3n <noelamac@gmail.com>:

(...)

> Thanks for the explanation. Now awaiting for "git clone" ends its job.

Okay, I managed to install the generated kernel:

root@stt300:/home/hpc03/wireless-testing# uname -r
3.9.0-rc4

But it seems no brcmsmac modules was created:

root@stt300:/home/hpc03/wireless-testing# modprobe brcmsmac
FATAL: Module brcmsmac not found.

If I try a manual compilation, it creates no modules:

root@stt300:/home/hpc03/wireless-testing# LANG=3DPOSIX make -C
/lib/modules/`uname -r`/build
M=3D/home/hpc03/wireless-testing/drivers/net/wireless/brcm80211/brcmsmac/
make: Entering directory `/home/hpc03/wireless-testing'
  Building modules, stage 2.
  MODPOST 0 modules
make: Leaving directory `/home/hpc03/wireless-testing'

I'm for sure missing something obvious :-)

P.S. Removing the rest of the CC.

Greetings,

--=20
Camale=F3n
