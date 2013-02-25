Return-Path: <goldenstranger@yahoo.com>
References: <1361616101.52110.YahooMailNeo@web124704.mail.ne1.yahoo.com> <5129FD42.5020202@hauke-m.de>
Message-ID: <1361788546.95773.YahooMailNeo@web124704.mail.ne1.yahoo.com>
Date: Mon, 25 Feb 2013 02:35:46 -0800 (PST)
From: Walter Goldens <goldenstranger@yahoo.com>
Reply-To: Walter Goldens <goldenstranger@yahoo.com>
Subject: Re: compat-wireless/drivers - slew of warnings and issues (older kernel)
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Luis R. Rodriguez" <mcgrof@gmail.com>,
  "backports@vger.kernel.org" <backports@vger.kernel.org>
In-Reply-To: <5129FD42.5020202@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <backports@vger.kernel.org>

Hi Hauke=0A=0ATo answer your questions. The compat-drivers I'm quoting is 3=
.7.6.1-stable and from the daily build tars (2.20.13).=0AGCC version is 4.2=
.3=0A=0AC-D compiles, but as noted with a tonne of warnings. We have severa=
l servers with specific purposes running 2.6.24 kernels and I decided to tr=
y a C-D on them.=0AI guess the question now is, do we drop support for c-wi=
reless/drivers for 2.6.24 - 2.6.29(?) and bump the minimum kernel to a 2.6.=
30?=0A=0AWalter=0A=0A=0A=0A=0A=0A----- Original Message -----=0AFrom: Hauke=
 Mehrtens <hauke@hauke-m.de>=0ATo: Walter Goldens <goldenstranger@yahoo.com=
>=0ACc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>; =
Luis R. Rodriguez <mcgrof@gmail.com>; "backports@vger.kernel.org" <backport=
s@vger.kernel.org>=0ASent: Sunday, February 24, 2013 1:45 PM=0ASubject: Re:=
 compat-wireless/drivers - slew of warnings and issues (older kernel)=0A=0A=
On 02/23/2013 11:41 AM, Walter Goldens wrote:=0A> A recent (stable) compat-=
wireless/drivers compilation exhibited a great deal of warnings on an older=
 kernel (2.6.24=C2=A0 to 2.6.30 I think). Is 2.6.24 still supported?=0A=0AW=
hat version of compat-drivers are you using?=0AWhat version of gcc are your=
 using?=0A=0ASome parts of compat-drivers are still compiling against kerne=
l 2.6.24,=0Abut I would not recommend using a so old kernel. I haven't done=
 run time=0Atestes with 2.6.24 for a long time.=0A=0A> Also, there was an i=
ssue with 50-compat_firmware.rules. Ubuntu 8.04 looks for it at /lib/udev/r=
ules.d/ which gave me severe problems with firmware loading and system free=
zes. I had to copy/symlink 50-compat_firmware.rules from /lib/udev/rules.d/=
 to /etc/udev/rules.d/.=0A=0ACould you provide a patch for this, I do not h=
ave a ubuntu 8.04=0Ainstallation any more, this is pretty old.=0A=0A> Warni=
ng log (partial). It compiles, but warnings galore. Is anyone up for backpo=
rting?=0A> =0A>=C2=A0  CC [M]=C2=A0 /drivers/net/wireless/rt2x00/rt2x00dev.=
o=0A> /include/net/cfg80211.h: In function =E2=80=98wiphy_name=E2=80=99:=0A=
> /include/net/cfg80211.h:2676: warning: passing argument 1 of =E2=80=98dev=
_name=E2=80=99 discards qualifiers from pointer target type=0A=0AI do not g=
et these warnings when compiling compat-drivers-3.8 against=0Akernel 2.6.30=
. There are some other warnings with gcc 4.7 therefor I=0Aused "export KCFL=
AGS=3D"-Wno-unused-but-set-variable"" with these old=0Akernels, newer kerne=
l versions already do this in the main Makefile.=0A=0AHauke=0A
