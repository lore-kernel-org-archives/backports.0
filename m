Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6X6-0ELebcYt=72oGfgHa36SdyUDHeu1DQuZDxrjA5uJw@mail.gmail.com>
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
	<510EB634.3080704@hauke-m.de>
	<CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
	<511AB1B3.7090909@hauke-m.de>
	<CAFub=KTNR2ag=KB-MbdoHr-ROjs85kKaQTMYoLv6A4Bmpt-pnQ@mail.gmail.com>
	<CAB=NE6X6-0ELebcYt=72oGfgHa36SdyUDHeu1DQuZDxrjA5uJw@mail.gmail.com>
Date: Tue, 12 Mar 2013 14:12:15 +0200
Message-ID: <CAFub=KRfAsohiy3U9gAsjY=nfsPCreTboYhiZ=NcJqp+x07=5w@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Add possibility to build every subsystem separately
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

> I read this thread when I got back from the mountains and agreed with
> Hauke's recommendation.
>
>   Luis

Can you clarify what does $BT, BT=3DTrue achieve? It looks like it was
some kind of switch to enable/disable BT but I can't be sure.

On the other part, Hauke first suggested a different thing and then another=
 way.

Should we enable all by default and --disable the unwanted ones or
should we disable and print a usage by default and add --enable
switches to enable subsystems?

Thanks :)


--=20
Ozan =C3=87a=C4=9Flayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
