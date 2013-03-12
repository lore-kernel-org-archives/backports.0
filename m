Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <rodrigue@qca.qualcomm.com>
Date: Tue, 12 Mar 2013 13:36:38 -0700
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozancag@gmail.com>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Hauke Mehrtens
	<hauke@hauke-m.de>, <backports@vger.kernel.org>, <mcgrof@kernel.org>
Subject: Re: [PATCH] compat-drivers: Add possibility to build every
 subsystem separately
Message-ID: <20130312203638.GJ32416@pogo>
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
 <510EB634.3080704@hauke-m.de>
 <CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
 <511AB1B3.7090909@hauke-m.de>
 <CAFub=KTNR2ag=KB-MbdoHr-ROjs85kKaQTMYoLv6A4Bmpt-pnQ@mail.gmail.com>
 <CAB=NE6X6-0ELebcYt=72oGfgHa36SdyUDHeu1DQuZDxrjA5uJw@mail.gmail.com>
 <CAFub=KRfAsohiy3U9gAsjY=nfsPCreTboYhiZ=NcJqp+x07=5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAFub=KRfAsohiy3U9gAsjY=nfsPCreTboYhiZ=NcJqp+x07=5w@mail.gmail.com>
Return-Path: rodrigue@qca.qualcomm.com
List-ID: <backports@vger.kernel.org>

On Tue, Mar 12, 2013 at 02:12:15PM +0200, Ozan Çağlayan wrote:
> > I read this thread when I got back from the mountains and agreed with
> > Hauke's recommendation.
> >
> >   Luis
> 
> Can you clarify what does $BT, BT=True achieve? It looks like it was
> some kind of switch to enable/disable BT but I can't be sure.

Yeah that's legacy junk, nuke it at your liking.

> On the other part, Hauke first suggested a different thing and then another
> way.

I think the concern was to not build everything on the stock
vanilla release.

> Should we enable all by default and --disable the unwanted ones or
> should we disable and print a usage by default and add --enable
> switches to enable subsystems?

How about something very simple:

  * Enable all by default

  * Use Kconfig to allow us to select 4 subsystems:
    - Ethernet
    - WiFi
    - Bluetooth
    - DRM

This way we'd keep the logic easy for an initial implementation
to support Kconfig (scripts/kconfig/mconf.c) and then build on
top of it to expand specifics.

  Luis
